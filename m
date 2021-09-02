Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EDC3FF49D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbhIBUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233953AbhIBUIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:08:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0C4D61054;
        Thu,  2 Sep 2021 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1630613238;
        bh=tYscjmV/SE2cy2KDjyzy3g/X52Wea0qDq3fqBKNWuNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fTN3VPWRc735zfdP8tmfBQ+IoD2+ouXDmfcS1GpRnSsLD6sPWlFA7fwRC9opsgP/l
         MGJ7XqoniolqgL3JDviY0gMQ43Kb10rOnrLYEhQIyXrHjdXp40ga0iq1g+ZWsXXuqj
         nuRUi37nOOmbbazpdZTPAbVuFHZmHRrGeIDEv+Z0=
Date:   Thu, 2 Sep 2021 13:07:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-Id: <20210902130718.2a3f03fc6cf87d190d7c9e34@linux-foundation.org>
In-Reply-To: <20210831164546.t7b6ksblzhsmm6jr@linutronix.de>
References: <20210805160019.1137-1-mgorman@techsingularity.net>
        <20210805160019.1137-2-mgorman@techsingularity.net>
        <20210831164546.t7b6ksblzhsmm6jr@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 18:45:46 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2021-08-05 17:00:19 [+0100], Mel Gorman wrote:
> >  mm/vmstat.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> 
> The version in RT also covered the functions
>   __count_vm_event()
>   __count_vm_events()
> 
> in include/linux/vmstat.h. Were they dropped by mistake or on purpose? 
> 

?
