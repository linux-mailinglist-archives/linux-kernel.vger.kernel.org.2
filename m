Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A410E360F11
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhDOPfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:35:04 -0400
Received: from foss.arm.com ([217.140.110.172]:49480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233289AbhDOPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:35:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70502106F;
        Thu, 15 Apr 2021 08:34:37 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C0F13FA35;
        Thu, 15 Apr 2021 08:34:35 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs hotplug-rollback
In-Reply-To: <YHhb99iRHXcxD2/e@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org> <20210310150109.259726371@infradead.org> <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me> <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net> <87r1jfmn8d.mognet@arm.com> <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net> <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net> <87a6pzmxec.mognet@arm.com> <YHhb99iRHXcxD2/e@hirez.programming.kicks-ass.net>
Date:   Thu, 15 Apr 2021 16:34:30 +0100
Message-ID: <877dl3muih.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/21 17:29, Peter Zijlstra wrote:
> On Thu, Apr 15, 2021 at 03:32:11PM +0100, Valentin Schneider wrote:
>> I'd word that "is enabled below sched_cpu_activate()", since
>> sched_cpu_deactivate() is now out of the picture.
>
> I are confused (again!). Did you mean to say something like: 'is enabled
> below SCHED_AP_ACTIVE' ?

Something like this yes; wording is hard.
