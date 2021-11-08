Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B63D449AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbhKHRpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:45:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232449AbhKHRpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:45:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1193E61989;
        Mon,  8 Nov 2021 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1636393367;
        bh=aDP0JNZLneMa+fhhHDwEjiYQDIZ3O9kp6R7AQNfFBFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ka736QNrH5TeG6ihYfwD3Xp+ZOyH9vWoX444P2RHbWrs4G2/MbxhgdmDgfivT57y3
         FnJ2UixIBR8LjiWYt6tOAdPF4aneBeukrwITqM3qAT2PD8jL02kTmTqkNHR5sw1JCL
         q4Qj0mrGOyN4TtSI3zWTOYEBRcAELAjEp5WJ67ig=
Date:   Mon, 8 Nov 2021 09:42:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re:
 vfs-keep-inodes-with-page-cache-off-the-inode-shrinker-lru.patch
Message-Id: <20211108094245.6e3bc66d7cc5ce5196115058@linux-foundation.org>
In-Reply-To: <YYlI40bWhtbKMwrz@cmpxchg.org>
References: <YYlI40bWhtbKMwrz@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 10:57:23 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Hi Andrew,
> 
> I promised to give this patch some more testing exposure while it sits
> in -mm. We've been steadily rolling this version of the change to our
> fleet over the last months and it's currently on 20% of FB servers. We
> have not noticed crashes or performance regressions because of it.
> (The other 80% is running a previous version of the patch.)
> 
> The comment in 'series' says "extra cycle" but that was 5.15 :-) Do
> you think we can get it merged into 5.16?
> 
> Just to reiterate, without the patch, there is very broad production
> breakage for FB beyond reduced cache effectiveness. Yes, we lose cache
> pages prematurely. But a bigger problem is that we lose nonresident
> info we store in the inodes. This defeats thrash detection, which in
> turn defeats psi and central reclaim deciscion making. The downstream
> effects of this are quite severe and widespread:
> 
> - memory prioity inversion between containers
> - failure to offload cold memory to swap with proactive reclaim
> - breakdown of container health monitoring and userspace OOM killing
> 
> I'm not exaggerating when I say we can't reliably operate our fleet
> without this patch. We've had to carry variants of it for two years
> now. It'd be great to get this fixed upstream.

Cool, thanks for the update.  I'll sent it Linuswards this week.
