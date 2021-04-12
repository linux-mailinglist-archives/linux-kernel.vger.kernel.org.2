Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AED835C29A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbhDLJqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239861AbhDLJbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:31:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D9B16120B;
        Mon, 12 Apr 2021 09:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618219877;
        bh=KFyKD4Fg+N+TvNqJOb+mIemp9paR8DOXakCsnemb9XY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6gCbW6mvQDZpUGpIRg7p1fKvDiz+EN4TDLZ5CvhHI90uzE2pugP+sl6WmkdV8bj8
         llLeBGMJuD6jN+octzWZAVOO4iy2P+KAsIlALHkk6JIQ78cPbf5Q4E+drTcUmw4Zfp
         DYxkpx7VSRshgM7S8lCLpVWp1fT2kBHz3f6rZh8c=
Date:   Mon, 12 Apr 2021 11:31:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: Remove variable
 set but not used
Message-ID: <YHQTY4fGJfsdSjXL@kroah.com>
References: <20210411174143.31618-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411174143.31618-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 07:41:43PM +0200, Fabio M. De Francesco wrote:
> Remove variable "int ret" which is instantiated but not used.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index f48186a89fa1..30055de66239 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -902,7 +902,6 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
>  				   int rate)
>  {
>  	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
> -	int ret;
>  	unsigned long flags;
>  	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
>  	u8 queue_index = tcb_desc->queue_index;
> -- 
> 2.31.1
> 
> 

Did you test-build this patch?
