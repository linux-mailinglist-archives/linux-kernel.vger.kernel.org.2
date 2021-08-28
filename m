Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFE13FA4D0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhH1Jp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhH1Jp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:45:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50F2260ED3;
        Sat, 28 Aug 2021 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630143877;
        bh=6KXHEFTldR58KIsMPXI+PdwLyLFXMO5pNa86tpdq5u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMfaZ1j7XnSZwb5TbKoVkqMupaby5sHKVkFJYpfLaEhJIdOXWSv+an62yOUxNOlob
         IO13Y2Aj4CT3Qj4kvUUZeUH4OURVUSCqvbupDP4s6tsuHV5MBgUSq2Y4w9NP8A6g1B
         MOTNe51P+3IT0lWtRz0zppIYPZSWKRGd7aloI5VI=
Date:   Sat, 28 Aug 2021 11:44:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] staging: r8188eu: fix sparse warnings
Message-ID: <YSoFgUT5+5nwJOo7@kroah.com>
References: <cover.1629563318.git.aakashhemadri123@gmail.com>
 <20210828085017.d5l63yrxkaxqgpgu@xps.yggdrasil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828085017.d5l63yrxkaxqgpgu@xps.yggdrasil>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 02:20:17PM +0530, Aakash Hemadri wrote:
> On 21/08/23 10:30PM, Aakash Hemadri wrote:
> > Hi,
> > 	This patch series fixes some sparse warnings in rtw_br_ext.c
> > 
> > Changes in v3 -> v4
> > - Added this changelog, as requested by Greg's patch bot
> > 
> > Changes in v2 -> v3
> > - Fixed incorrect usage/removal of endian swaps and checks
> > 
> > Changes in v1 -> v2
> > - Split patch
> > 
> > Aakash Hemadri (5):
> >   staging: r8188eu: restricted __be16 degrades to int
> >   staging: r8188eu: cast to restricted __be32
> >   staging: r8188eu: incorrect type in csum_ipv6_magic
> >   staging: r8188eu: restricted __be16 degrades to int
> >   staging: r8188eu: incorrect type in assignment
> > 
> >  drivers/staging/r8188eu/core/rtw_br_ext.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > 
> > base-commit: 093991aaadf0fbb34184fa37a46e7a157da3f386
> > -- 
> > 2.32.0
> >
> 
> Hello greg, if there are any issues with the patchset do let me know,
> Larry & Philip acked the previous ver of this patch.
> 
> I'd rather not add noise to the ml unnecessarily.
> Also this patchset doesn't apply cleanly to the current staging-testing
> I can resend fixing that if that's the issue.

Please fix up and resend, my staging review queue is empty.

thanks,

greg k-h
