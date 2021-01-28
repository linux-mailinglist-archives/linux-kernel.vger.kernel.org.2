Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB398307FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhA1Uwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhA1UwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:52:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9702264DE0;
        Thu, 28 Jan 2021 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611867090;
        bh=xphOtEftTu7lP4Gys6R2t4vfQ/b/ea8bPkcZ8sh133c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KlgaJcRLccaM7VL4bcABB0YaqCKnbY+UbV6gSJA9KmbWUFjH+gCAJU6O6GQ8IxJfT
         Zz9iSrJVr+vVASFSL6F+L5CuZR0UsIKNZLc/M4lk6rzdGMnKAxLgeKJyO58nxx12Zf
         41FdYmQu5hBDGWph414x+bE9JsmYSwL3lX+YLHAI=
Date:   Thu, 28 Jan 2021 12:51:29 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Colin King <colin.king@canonical.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/zswap: fix potential uninitialized pointer
 read on tmp
Message-Id: <20210128125129.27dd2042b8d04b28c45ad7c0@linux-foundation.org>
In-Reply-To: <2dee1f77-863b-e7aa-a3d2-bb4591d4f720@suse.cz>
References: <20210128141728.639030-1-colin.king@canonical.com>
        <2dee1f77-863b-e7aa-a3d2-bb4591d4f720@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 16:18:23 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 1/28/21 3:17 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > In the case where zpool_can_sleep_mapped(pool) returns 0
> > then tmp is not allocated and tmp is then an uninitialized
> > pointer. Later if entry is null, tmp is freed, hence free'ing
> > an uninitialized pointer. Fix this by ensuring tmp is initialized
> > to NULL.
> > 
> > Addresses-Coverity: ("Uninitialized pointer read")
> > Fixes: 908aa806dba0 ("mm/zswap: fix potential memory leak")
> 
> That's a linux-next hash, patch is in mmotm [1] *) You know what it means...
> 
> *) actually it's not there, yet it is in -next. What's going on?
> 
> [1]
> https://ozlabs.org/~akpm/mmotm/broken-out/mm-zswap-fix-potential-memory-leak.patch

The containing file was renamed to
https://ozlabs.org/~akpm/mmotm/broken-out/mm-zswap-add-the-flag-can_sleep_mapped-fix-2.patch,
since it's a fix against mm-zswap-add-the-flag-can_sleep_mapped.patch.

And this patch's containing file will of course be
mm-zswap-add-the-flag-can_sleep_mapped-fix-3.patch.

