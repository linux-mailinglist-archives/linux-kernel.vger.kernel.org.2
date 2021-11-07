Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A304472DF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 13:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhKGMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 07:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230407AbhKGMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 07:41:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 376DA613D2;
        Sun,  7 Nov 2021 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636288718;
        bh=vSH59rVTniKLVbg3URBrx5HZor/CIpFHOaU81MXiMuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w2IjrSXmY23OCPvWiRxW6LABBUnw8RNuDBL4VPuvO88UCIMoS85N6O6GoKorf34h9
         I7B8OugFqpOqZkYkJJEHDHdKwCJ0d81izSP+As8e4x1KBGzYwXda3G7Nm2KTSG60Dm
         g+0eH4MDhEL8kwRkTRRFUZbc/xFB3G6u9bnEsAH8=
Date:   Sun, 7 Nov 2021 13:38:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in
 atomic context
Message-ID: <YYfIywQ3AqrWbi8z@kroah.com>
References: <20211101191847.6749-1-fmdefrancesco@gmail.com>
 <2389191.WthrnW1hFq@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2389191.WthrnW1hFq@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 12:43:51PM +0100, Fabio M. De Francesco wrote:
> On Monday, November 1, 2021 8:18:47 PM CET Fabio M. De Francesco wrote:
> > Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> > report_del_sta_event(). This function is called while holding spinlocks,
> > therefore it is not allowed to sleep. With the GFP_ATOMIC type flag, the
> > allocation is high priority and must not sleep.
> > 
> > This issue is detected by Smatch which emits the following warning:
> > "drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 report_del_sta_event()
> > warn: sleeping in atomic context".
> > 
> > After the change, the post-commit hook output the following message:
> > "CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
> > kzalloc(sizeof(struct cmd_obj)...)".
> > 
> > According to the above "CHECK", use the preferred style in the first
> > kzalloc().
> > 
> > Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() and 
> kzalloc()")
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v2->v3: Add the "Fixes:" tag, as requested by Greg Kroah-Hartman.
> > 
> > v1->v2: Fix an error that I introduced with an incorrect copy-paste
> >         of the sizeof() operator.
> > 
> >  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Hello Greg,
> 
> I've noticed that you have already applied recent changes to drivers/staging  
> up to the patches of November 6th, but my patch is not among them. 

I have applied patches that are not targeted for 5.16-final, yes.

> This patch has already been acked by Larry and I'm not sure if I should send 
> a v4 with his "Acked-by" tag or if you can add it by yourself when applying 
> to your tree.
> 
> Please let me know if there is something that prevents this patch to be 
> applied. I have no problem in changing / adding whatever it is needed.

Nothing needs to be done, I am waiting for 5.16-rc1 to be released
before I pick up this patch, and others that will be targeted for
5.16-final.  Only then will I queue them up, as the automated email you
should have gotten when you submitted the patch said would happen.

Just relax, there is no rush here :)

thanks,

greg k-h
