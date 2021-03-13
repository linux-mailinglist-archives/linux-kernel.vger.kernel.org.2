Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F93339B58
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 03:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhCMCmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 21:42:32 -0500
Received: from mx1.riseup.net ([198.252.153.129]:35140 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232942AbhCMCmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:42:09 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Dy6Qm0y1XzDqJX;
        Fri, 12 Mar 2021 18:42:08 -0800 (PST)
X-Riseup-User-ID: 5D2D9247A40E03F110C09010B328F2A336A05F0CE260C9B67D6A95788597D0CC
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Dy6Ql0NNXz5wG9;
        Fri, 12 Mar 2021 18:42:06 -0800 (PST)
Subject: Re: [PATCH v5] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210312173855.24843-1-jnewsome@torproject.org>
 <20210312102207.a347e38db375226a78cc37bf@linux-foundation.org>
 <ccfef0d5-c419-0a8d-cf75-9642e9d11f94@torproject.org>
 <20210312104718.0685c3902fd0d22915aeacc6@linux-foundation.org>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <0c6ab8f1-9102-9fd0-a848-04c826a4d957@torproject.org>
Date:   Fri, 12 Mar 2021 20:42:06 -0600
MIME-Version: 1.0
In-Reply-To: <20210312104718.0685c3902fd0d22915aeacc6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the micro-benchmark results. I ended up reworking it to use
google's benchmark tool [1]. For each N I timed how long it took to fork
a new child and then immediately wait on it, while already having N
other children. (Initially I tried to vfork, but that didn't play nicely
with the benchmark tool)

[1] https://github.com/google/benchmark

Without the patch:

./bench_waitpid
2021-03-12T20:03:57-06:00
Running ./bench_waitpid
Run on (4 X 2693.88 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 4096 KiB (x4)
  L3 Unified 16384 KiB (x4)
Load Average: 0.48, 0.16, 0.06
----------------------------------------------------------
Benchmark                Time             CPU   Iterations
----------------------------------------------------------
BM_WaitPid/1        313354 ns        74754 ns         8575
BM_WaitPid/10       305954 ns        72424 ns         7977
BM_WaitPid/100      323126 ns        83368 ns         7861
BM_WaitPid/500      324479 ns        99071 ns         6541
BM_WaitPid/1000     377143 ns       178590 ns         3260
BM_WaitPid/5000     816597 ns       803919 ns          849
BM_WaitPid/8000    1282339 ns      1268179 ns          548

For example, this means that for a process that already has 5000
children, forking and then immediately calling waitpid on 5001st took an
average of 179 microsecs. The O(n) implementation starts getting
noticeably slower with around 100 children.

With the patch:

$ ./bench_waitpid
2021-03-12T20:19:52-06:00
Running ./bench_waitpid
Run on (4 X 2693.88 MHz CPU s)
CPU Caches:
  L1 Data 32 KiB (x4)
  L1 Instruction 32 KiB (x4)
  L2 Unified 4096 KiB (x4)
  L3 Unified 16384 KiB (x4)
Load Average: 1.39, 0.49, 0.18
----------------------------------------------------------
Benchmark                Time             CPU   Iterations
----------------------------------------------------------
BM_WaitPid/1        305501 ns        74028 ns         9261
BM_WaitPid/10       309644 ns        74916 ns         8838
BM_WaitPid/100      319457 ns        77193 ns         8717
BM_WaitPid/500      306929 ns        73863 ns         8327
BM_WaitPid/1000     310849 ns        74848 ns         8458
BM_WaitPid/5000     329324 ns        79386 ns         9123
BM_WaitPid/8000     317991 ns        77889 ns         7526

As expected, the cost is about the same as the baseline for a small
number of children, and stays about the same as the # of children increase.

Source:

#include <sys/times.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>

#include "benchmark/benchmark.h"

static void BM_WaitPid(benchmark::State& state) {
    int num_children = state.range(0);

    // Create num_children
    std::vector<pid_t> children;
    children.reserve(num_children);
    for (int i = 0; i < num_children; ++i) {
        pid_t forkrv = fork();
        if (forkrv < 0) {
            perror("fork");
            exit(1);
        }
        if (forkrv == 0) {
            // child
            exit(0);
        }
        children.push_back(forkrv);
    }

    // The body of this loop is what gets timed.
    for (auto _ : state) {
        pid_t forkrv = fork();
        if (forkrv < 0) {
            perror("fork");
            exit(1);
        }
        if (forkrv == 0) {
            // child
            exit(0);
        }
        if (waitpid(forkrv, NULL, 0) < 0) {
            perror("waitpid");
            exit(1);
        }
    }

    // Tear down the other children
    for (pid_t child : children) {
        if (waitpid(child, NULL, 0) < 0) {
            perror("waitpid");
            exit(1);
        }
    }
}
// Register the function as a benchmark
BENCHMARK(BM_WaitPid)->Arg(1)->Arg(10)->Arg(100)->Arg(500)->Arg(1000)->Arg(5000)->Arg(8000);
// Run the benchmark
BENCHMARK_MAIN();
