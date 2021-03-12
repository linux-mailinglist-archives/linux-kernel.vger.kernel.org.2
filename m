Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436AB3393E6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhCLQvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:51:47 -0500
Received: from mx1.riseup.net ([198.252.153.129]:37674 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232223AbhCLQvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:51:31 -0500
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DxsKH07rczFf3H;
        Fri, 12 Mar 2021 08:51:31 -0800 (PST)
X-Riseup-User-ID: 30F91BD6FE2D1994E812B5146635713A56934EEBD1EEDA3C714890724AC65A78
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4DxsKG2BZXz1y6h;
        Fri, 12 Mar 2021 08:51:30 -0800 (PST)
Subject: Re: [PATCH v4] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210311233823.20325-1-jnewsome@torproject.org>
 <20210312164119.GC27820@redhat.com>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <24b32f84-c2d9-3b14-0e7b-a56d719a4a1d@torproject.org>
Date:   Fri, 12 Mar 2021 10:51:29 -0600
MIME-Version: 1.0
In-Reply-To: <20210312164119.GC27820@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/12/21 10:41, Oleg Nesterov wrote:
> On 03/11, Jim Newsome wrote:
>> +
>> +	if (target && is_effectively_child(wo, ptrace, target)) {
>> +		retval = wait_consider_task(wo, ptrace, target);
> No, this is not right... You need to check target->ptrace != 0.

Shoot; got lost in the shuffle. Sorry about that and thanks for catching!

> I know that Eric suggests to not use thread_group_leader() and I won't argue
> even if I don't really agree.
>
> Up to you, but to me something like
>
> 	do_wait_pid()
> 	{
> 		target = pid_task(wo->wo_pid, PIDTYPE_PID);
>
> 		if (!target)
> 			return 0;
>
> 		if (thread_group_leader(target) &&
> 		    is_effectively_child(wo, 0, target) {
> 			...			
> 		}
>
> 		if (target->ptrace &&
> 		    is_effectively_child(wo, 1, target) {
> 			...
> 		}
>
> 		return 0;
>
> 	}
>
> looks more simple/clean.

I like that a little better too. I'll go this way since Eric seemed Ok
with either way.

If we do that then it might make sense to move the `thread_group_leader`
filter into `is_effectively_child`, but maybe that obscures what the
latter is doing too much. It'd at least have to be renamed, and I'm not
sure of a clear name that'd capture exactly what it's doing. Maybe
`is_valid_waitee`?

If I don't hear anything I'll just go with how you've already proposed.

v5 coming in a bit. I'll drop your (Oleg's) reviewed-by since it's
changed substantially since then.

