Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9A03AB4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhFQNdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231654AbhFQNdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:33:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C81D6044F;
        Thu, 17 Jun 2021 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623936695;
        bh=u0qd6O0XohK2blFPQxVjvBt/wYTUHl/fZzzKtLhEk7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gsmcnqVxOrJtKmRUja/eV6hZhh9xFUtY4FQU7G4cPnZWA3Z/MNAN+W/ur6Sazs6VL
         sI+R36fTde9mqKcZZjB3PQ48qhcdWlLZDRrZmLa7XrNtiXCzhJQkbaodqG+fs60A/h
         06kGpw4YNvtfIm0YJD5yKXkPtL4igREkK3VE7RgY=
Date:   Thu, 17 Jun 2021 15:31:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH] usb: xhci-mtk: allow multiple Start-Split in a microframe
Message-ID: <YMtOtC1j2DouJ9Is@kroah.com>
References: <1623895911-29259-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623895911-29259-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:11:51AM +0800, Chunfeng Yun wrote:
> This patch is used to relax bandwidth schedule by allowing multiple
> Start-Split in the same microframe.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/host/xhci-mtk-sch.c | 16 ----------------
>  drivers/usb/host/xhci-mtk.h     |  2 --
>  2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
> index c07411d9b16f..149a0f4a6ec4 100644
> --- a/drivers/usb/host/xhci-mtk-sch.c
> +++ b/drivers/usb/host/xhci-mtk-sch.c
> @@ -470,11 +470,9 @@ static int check_fs_bus_bw(struct mu3h_sch_ep_info *sch_ep, int offset)
>  
>  static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
>  {
> -	struct mu3h_sch_tt *tt = sch_ep->sch_tt;
>  	u32 extra_cs_count;
>  	u32 start_ss, last_ss;
>  	u32 start_cs, last_cs;
> -	int i;
>  
>  	if (!sch_ep->sch_tt)
>  		return 0;
> @@ -491,10 +489,6 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
>  		if (!(start_ss == 7 || last_ss < 6))
>  			return -ESCH_SS_Y6;
>  
> -		for (i = 0; i < sch_ep->cs_count; i++)
> -			if (test_bit(offset + i, tt->ss_bit_map))
> -				return -ESCH_SS_OVERLAP;
> -
>  	} else {
>  		u32 cs_count = DIV_ROUND_UP(sch_ep->maxpkt, FS_PAYLOAD_MAX);
>  
> @@ -521,9 +515,6 @@ static int check_sch_tt(struct mu3h_sch_ep_info *sch_ep, u32 offset)
>  		if (cs_count > 7)
>  			cs_count = 7; /* HW limit */
>  
> -		if (test_bit(offset, tt->ss_bit_map))
> -			return -ESCH_SS_OVERLAP;
> -
>  		sch_ep->cs_count = cs_count;
>  		/* one for ss, the other for idle */
>  		sch_ep->num_budget_microframes = cs_count + 2;
> @@ -558,13 +549,6 @@ static void update_sch_tt(struct mu3h_sch_ep_info *sch_ep, bool used)
>  	for (i = 0; i < num_esit; i++) {
>  		base = sch_ep->offset + i * sch_ep->esit;
>  
> -		for (j = 0; j < bits; j++) {

Now that bits is no longer used, we get a build warning.

Can you fix this patch and resend it?

thanks,

greg k-h
