Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF65333023
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhCIUmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:42:25 -0500
Received: from mx1.riseup.net ([198.252.153.129]:43536 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231864AbhCIUmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:42:03 -0500
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Dw6Zg43B6zDxYR;
        Tue,  9 Mar 2021 12:42:03 -0800 (PST)
X-Riseup-User-ID: 6E80CF5FC8EBBAAF70C42356D782147E33F6E50F79F7ED969E5F47FC70B30D58
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Dw6Zf6Zppz1y6Q;
        Tue,  9 Mar 2021 12:42:02 -0800 (PST)
Subject: Re: [PATCH v2] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
References: <20210309161548.18786-1-jnewsome@torproject.org>
 <20210309171539.GA32475@redhat.com>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project
Message-ID: <7f5508ef-dbaa-fe5c-9826-cce0122eb2f8@torproject.org>
Date:   Tue, 9 Mar 2021 14:42:00 -0600
MIME-Version: 1.0
In-Reply-To: <20210309171539.GA32475@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 11:15, Oleg Nesterov wrote:
> Jim,
>
> Thanks, the patch looks good to me. Yet I think you need to send V3 even
> if I personally do not care ;) Please consider ./scripts/checkpatch.pl,
> it reports all the coding-style problems I was going to mention.

Thanks! I'd thought clang-format with the included configuration would
be sufficient, but apparently not :)

> Both if's use "int retval", to me it would be better to declare this variable
> at the start of do_wait_pid(). But again, I won't insist this is up to you.
My usual inclination is to avoid uninitialized variables and prefer
putting them in tighter scopes. I don't think it's really much of an
issue in this relatively short function though; happy to go with the
prevailing style.
> I am wondering if something like
>
> 	static inline bool is_parent(struct task_struct *tsk, struct task_struct *p, int flags)
> 	{
> 		return	tsk == p || !(flags & __WNOTHREAD)) && same_thread_group(tsk, p);
> 	}
>
> makes any sense to make do_wait_pid() more clear... probably not.

Yeah, I lean slightly towards the extra level of indirection not being
worth the deduplication.

I made a couple other small changes as well:

* No need for do_wait_pid to take the parameter `tsk` since it's only
ever called with `current`

* With that change, the declaration of `tsk` in `do_wait` can be moved
into a tighter scope of where it's used in the loop.

v3: https://lkml.org/lkml/2021/3/9/1134

