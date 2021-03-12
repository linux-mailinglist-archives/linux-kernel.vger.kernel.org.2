Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12703398D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhCLVFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 16:05:35 -0500
Received: from mx1.riseup.net ([198.252.153.129]:53714 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234964AbhCLVFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 16:05:18 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Dxyy607lPzDs7k;
        Fri, 12 Mar 2021 13:05:17 -0800 (PST)
X-Riseup-User-ID: A2BFFF25D9BFEAD604F30614484E4852CBFFA42F7BAFECCE6B0CB8AA2237842D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Dxyy516Z8z5wGj;
        Fri, 12 Mar 2021 13:05:17 -0800 (PST)
Subject: Re: [PATCH v5] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210312173855.24843-1-jnewsome@torproject.org>
 <m1k0qcglol.fsf@fess.ebiederm.org>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <d7f5d5fa-87ed-c95a-eca2-44e750b6e78d@torproject.org>
Date:   Fri, 12 Mar 2021 15:05:16 -0600
MIME-Version: 1.0
In-Reply-To: <m1k0qcglol.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 14:29, Eric W. Biederman wrote:
> When I looked at this a second time it became apparent that using
> pid_task twice should actually be faster as it removes a dependent load
> caused by thread_group_leader, and replaces it by accessing two adjacent
> pointers in the same cache line.
> 
> I know the algorithmic improvement is the main advantage, but removing
> 60ns or so for a dependent load can't hurt.
> 
> Plus I think using the two pid types really makes it clear that one
> is always a process and the other is always potentially a thread.
> 
> /*
>  * Optimization for waiting on PIDTYPE_PID. No need to iterate through child
>  * and tracee lists to find the target task.
>  */
> static int do_wait_pid(struct wait_opts *wo)
> {
> 	bool ptrace;
> 	struct task_struct *target;
> 	int retval;
> 
> 	ptrace = false;
> 	target = pid_task(wo->wo_pid, PIDTYPE_TGID);
> 	if (target && is_effectively_child(wo, ptrace, target)) {
> 		retval = wait_consider_task(wo, ptrace, target);
> 		if (retval)
> 			return retval;
> 	}
> 
> 	ptrace = true;
> 	target = pid_task(wo->wo_pid, PIDTYPE_PID);
> 	if (target && target->ptrace &&
>             is_effectively_child(wo, ptrace, target)) {
> 		retval = wait_consider_task(wo, ptrace, target);
> 		if (retval)
> 			return retval;
> 	}
> 
> 	return 0;
> }

I'm fine with either way.

Part of what made my earlier version with the double-lookup a bit
awkward was only doing the second lookup if the first lookup failed. I'm
happy to take your word though that making the second lookup conditional
is unnecessary or even detrimental :). It did cross my mind that it
might not be a very consistent branch for a branch-predictor, but I also
figured pid_task's synchronization might outweigh that.
