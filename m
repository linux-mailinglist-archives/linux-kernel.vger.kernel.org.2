Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78805336876
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhCKAPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:15:02 -0500
Received: from mx1.riseup.net ([198.252.153.129]:45844 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhCKAOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:14:49 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DwqFf6MpczDr7f;
        Wed, 10 Mar 2021 16:14:46 -0800 (PST)
X-Riseup-User-ID: 43F2163302C5606AA3D2042CD277FE5A858B1735C3F7A0046289050BAA082231
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4DwqFd4LpSz5vNY;
        Wed, 10 Mar 2021 16:14:45 -0800 (PST)
Subject: Re: [PATCH v3] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210309203919.15920-1-jnewsome@torproject.org>
 <m1blbqmy2u.fsf@fess.ebiederm.org>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <4d9006b4-b65a-6ce0-b367-971f29de1f21@torproject.org>
Date:   Wed, 10 Mar 2021 18:14:44 -0600
MIME-Version: 1.0
In-Reply-To: <m1blbqmy2u.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 16:40, Eric W. Biederman wrote:
>> +// Optimization for waiting on PIDTYPE_PID. No need to iterate
through child
>> +// and tracee lists to find the target task.
>
> Minor nit:  C++ style comments look very out of place in this file
>             which uses old school C /* */ comment delimiters for
>             all of it's block comments.

Will do

>> +static int do_wait_pid(struct wait_opts *wo)
>> +{
>> +	struct task_struct *target = pid_task(wo->wo_pid, PIDTYPE_PID);
>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is subtle change in behavior.
> 
> Today on the task->children list we only place thread group leaders.

Shouldn't we allow waiting on clone children if __WALL or __WCLONE is set?

This is already checked later in `eligible_child`, called from
`wait_consider_task`, so I *think* the current form should already do
the right thing. Now I'm confused though how the general path (through
`do_wait_thread`) works if clone children aren't on the task->children
list...?

(In any case it seems this will need another version with at least an
explanatory comment here)

Thanks!
-Jim
