Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188B933F7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhCQR60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:58:26 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49838 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhCQR6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:58:03 -0400
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4F0yYg62S8zDq5t;
        Wed, 17 Mar 2021 10:57:59 -0700 (PDT)
X-Riseup-User-ID: 487B31A3D438057A218EAC41BBF3B94F15A17880E66A950D5E7ED1686F2F24E3
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4F0yYg28mzz5wGw;
        Wed, 17 Mar 2021 10:57:59 -0700 (PDT)
To:     Peter Oskolkov <posk@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Rob Jansen <rob.g.jansen@nrl.navy.mil>,
        Ryan Wails <ryan.wails@nrl.navy.mil>
From:   Jim Newsome <jnewsome@torproject.org>
Subject: Re: [RFC PATCH 0/3 v3] futex/sched: introduce FUTEX_SWAP operation
Organization: The Tor Project
Message-ID: <c85541c4-6ae5-8898-8044-99e403335f48@torproject.org>
Date:   Wed, 17 Mar 2021 12:57:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not well versed in this part of the kernel (ok, any part, really),
but I wanted to chime in from a user perspective that I'm very
interested in this functionality.

We (Rob + Ryan + I, cc'd) are currently developing the second generation
of the Shadow simulator <https://shadow.github.io/>, which is used by
various researchers and the Tor Project. In this new architecture,
simulated network-application processes (such as tor, browsers, and web
servers) are each run as a native OS process, started by forking and
exec'ing its unmodified binary. We are interested in supporting large
simulations (e.g. 50k+ processes), and expect them to take on the order
of hours or even days to execute, so scalability and performance matters.

We've prototyped two mechanisms for controlling these simulated
processes, and a third hybrid mechanism that combines the two. I've
mentioned one of these (ptrace) in another thread ("do_wait: make
PIDTYPE_PID case O(1) instead of O(n)"). The other mechanism is to use
an LD_PRELOAD'd shim that implements the libc interface, and
communicates with Shadow via a syscall-like API over IPC.

So far the most performant version we've tried of this IPC is with a bit
of shared memory and a pair of semaphores. It looks much like the
example in Peter's proposal:

> a. T1: futex-wake T2, futex-wait
> b. T2: wakes, does what it has been woken to do
> c. T2: futex-wake T1, futex-wait

We've been able to get the switching costs down using CPU pinning and
SCHED_FIFO. Each physical CPU spends most of its time swapping back and
forth between a Shadow worker thread and an emulated process. Even so,
the new architecture is so far slower than the first generation of
Shadow, which multiplexes the simulated processes into its own handful
of OS processes (but is complex and fragile).

> With FUTEX_SWAP, steps a and c above can be reduced to one futex
> operation that runs 5-10 times faster.

IIUC the proposed primitives could let us further improve performance,
and perhaps drop some of the complexity of attempting to control the
scheduler via pinning and SCHED_FIFO.
