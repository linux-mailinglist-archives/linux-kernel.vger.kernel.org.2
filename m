Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA274428C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKBHqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKBHqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:46:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22EB1604AC;
        Tue,  2 Nov 2021 07:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635839037;
        bh=2lR87jpds7vwGsdHpPE4zcWOhY3f2Kkc40UJ46z74iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWoWHZj5EaUt8AVu/COMuX4+kZNe6EEgDiWvK4gBs2rDDweiHlBsJbS9ubOafW/6F
         bwRQndfDFwJEwugn3n/O5Z5bvBDMKyuD4NzafCg71H+og6jKUJEDPjQ8vQJ5maqsu9
         2x8bJcxuMp1Lf6H48/bNQFgXaw1b1E6CzkvCNAJg=
Date:   Tue, 2 Nov 2021 08:43:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in
 atomic context
Message-ID: <YYDsONxzm0ucjC1g@kroah.com>
References: <20211101142732.5638-1-fmdefrancesco@gmail.com>
 <YYAFK83uzfBn03D/@kroah.com>
 <2458707.yljdXZV4jf@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2458707.yljdXZV4jf@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 05:43:08PM +0100, Fabio M. De Francesco wrote:
> On Monday, November 1, 2021 4:18:03 PM CET Greg Kroah-Hartman wrote:
> > On Mon, Nov 01, 2021 at 03:27:32PM +0100, Fabio M. De Francesco wrote:
> > > Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> > > report_del_sta_event(). This function is called while holding spinlocks,
> > > therefore it is not allowed to sleep. With the GFP_ATOMIC type flag, the
> > > allocation is high priority and must not sleep.
> > > 
> > > This issue is detected by Smatch which emits the following warning:
> > > "drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 report_del_sta_event()
> > > warn: sleeping in atomic context".
> > > 
> > > After the change, the post-commit hook output the following message:
> > > "CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
> > > kzalloc(sizeof(struct cmd_obj)...)".
> > > 
> > > According to the above "CHECK", use the preferred style in the first
> > > kzalloc().
> > > 
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > > v1->v2: Fix an overlooked error due to an incorrect copy-paste
> > > 	of the sizeof() operator.
> > 
> > What commit does this fix?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Sorry, Greg. Please let me know if I understand correctly what you are asking 
> for...
> 
> In v1 I introduced a silly error while copy-pasting "sizeof()" and then I 
> fixed it in v2.
>   
> I think that you mean that I should reword the list of changes from v1 
> because I'm not explaining properly why I submitted v2.
>   
> Is my understanding correct? If so, I have no problem in submitting v3. 

Sorry, no, I mean what commit in the kernel tree is this patch "fixing"?

You should have a "Fixes: " tag in the signed-off-by area of the
changelog so that we know where the problem you are resolving here
originated.

thanks,

greg k-h
