Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C398944677C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhKERDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:03:44 -0400
Received: from foss.arm.com ([217.140.110.172]:33676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231475AbhKERDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:03:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD9791042;
        Fri,  5 Nov 2021 10:01:02 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 506CA3F7F5;
        Fri,  5 Nov 2021 10:01:01 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH 1/4] stop_machine: Move cpu_stop_done into stop_machine.h
In-Reply-To: <20211104145713.4419-2-laoar.shao@gmail.com>
References: <20211104145713.4419-1-laoar.shao@gmail.com> <20211104145713.4419-2-laoar.shao@gmail.com>
Date:   Fri, 05 Nov 2021 17:00:58 +0000
Message-ID: <87bl2ytu45.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/21 14:57, Yafang Shao wrote:
> Move struct cpu_stop_done into the stop_machine.h, then it can be resued
> by the functions outside of stop_maichine.c.
>

The nr_todo & ret faff is only required for multi_stop scenarios, which
isn't your use-case. AFAICT you don't need to export this, you just need a
struct completion somewhere (and maybe a ret, but I'm not even sure about
that).
