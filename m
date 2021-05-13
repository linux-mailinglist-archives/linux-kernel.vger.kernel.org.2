Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81A37F043
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhEMAOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242992AbhEMAIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:08:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FF94611F0;
        Thu, 13 May 2021 00:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620864446;
        bh=24R24Rv/5s/FYQFsygQTGuMbS5mHRX+N/jGv9R0gjZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iOyDKeioYQQXWFwXp70+Z87M3vG9d1wMmg1X9PjmACMFBJufW+6qemzEhqokue5pu
         zyW/7zYwq2+s6LSNIETVRdTYgEdBfrtm2PJzp8bRTPb5zue1CFSLAGpGfp143jzEBw
         t1B9DHcAMTynwnhqktD2ZpDPv6fLdI8XW/x4opZo=
Date:   Wed, 12 May 2021 17:07:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     glittao@gmail.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm/slub: use stackdepot to save stack trace in objects
Message-Id: <20210512170725.de759a49cb116e5d4c303925@linux-foundation.org>
In-Reply-To: <f9dd0692-e490-56ce-3cd8-b99aea559e79@suse.cz>
References: <20210414163434.4376-1-glittao@gmail.com>
        <20210509214603.d2a5faaa3fe0d71c3517cb36@linux-foundation.org>
        <f9dd0692-e490-56ce-3cd8-b99aea559e79@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 16:33:50 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 5/10/21 6:46 AM, Andrew Morton wrote:
> > On Wed, 14 Apr 2021 18:34:34 +0200 glittao@gmail.com wrote:
> > 
> >> Many stack traces are similar so there are many similar arrays.
> >> Stackdepot saves each unique stack only once.
> >> 
> >> Replace field addrs in struct track with depot_stack_handle_t handle.
> >> Use stackdepot to save stack trace.
> >> 
> >> The benefits are smaller memory overhead and possibility to aggregate
> >> per-cache statistics in the future using the stackdepot handle
> >> instead of matching stacks manually.
> > 
> > Which tree was this prepared against?  5.12's kmem_obj_info() is
> > significantly different from the version you were working on.
> 
> It was based on -next at the time of submission, which contained patch in Paul's
> tree that expands kmem_obj_info to print also free call stack [1] so that also
> needs to be switched to stackdepot to work.

OK, sorry, I should have checked.

> > Please take a look, redo, retest and resend?  Thanks.
> 
> I expected [1] to be in 5.13-rc1, but as Paul explained to me, it's queued for
> 5.14. So if we (Oliver) rebase on current -next, can you queue it in the section
> of mmotm series that goes after -next?

I grabbed this version and queued it after the linux-next patches,
thanks.

