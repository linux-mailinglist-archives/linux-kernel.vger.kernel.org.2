Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC932624B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhBZMHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZMHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:07:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31B4864E85;
        Fri, 26 Feb 2021 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614341209;
        bh=qRTRg+Ld1JvWeMc0olIaD6Tm+zb/5qtWSSfoEhnQEC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvGNyIN4O2RQfLtsNLJNBpTtgzJmKKoCEooXcKepz4kiyHOoLUziEn22HCgGiN0nP
         i3pTPTXpw2lVDZcOIebficIYrr1MUCf9QBzfiAcNj2IK7Qj5KSXs4nLCvngCPbsox4
         RdpxlHQh7K/n0uAjto/Or+M7Y5PUw5pcgBeqZA/s=
Date:   Fri, 26 Feb 2021 13:06:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Gibson <leegib@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix possible buffer overflow in
 _rtl92e_wx_set_scan
Message-ID: <YDjkVqPzcU6Z5zbK@kroah.com>
References: <20210226114829.316980-1-leegib@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226114829.316980-1-leegib@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:48:29AM +0000, Lee Gibson wrote:
> Function _rtl92e_wx_set_scan calls memcpy without checking the length.
> A user could control that length and trigger a buffer overflow.
> Fix by checking the length is within the maximum allowed size.
> 
> Signed-off-by: Lee Gibson <leegib@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index 16bcee13f64b..2acc4f314732 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -406,6 +406,9 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
>  		struct iw_scan_req *req = (struct iw_scan_req *)b;
>  
>  		if (req->essid_len) {
> +			if (req->essid_len > IW_ESSID_MAX_SIZE)
> +				req->essid_len = IW_ESSID_MAX_SIZE;
> +

How about using the "pattern" the other wireless drivers use of:

		int len = min((int)req->essid_len, IW_ESSID_MAX_SIZE);

instead?

thanks,

greg k-h
