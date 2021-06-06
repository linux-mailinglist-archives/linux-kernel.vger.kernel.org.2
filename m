Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7739CDDB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFFHPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhFFHPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:15:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAAA5611ED;
        Sun,  6 Jun 2021 07:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622963620;
        bh=kKgXqMKBbdsOTgX+oRuQSkCNMTlozOMRdBF9GdCe0Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXnJZroJEikwRaj2EjCXxM6FL0JA5dAOcoFuuVzVZUQ1uHDYIWpV/TQmvV4vJET+B
         N1vijX9LU8JBq1fp3Lsbbmp2jUvxgMlvMQPFdsEtwWKDj5dRqQLix6S2/CAS3OXoff
         G3nP4obr0z/Krs7QXTEBUAiTmXFcK+kobD7PxoFU=
Date:   Sun, 6 Jun 2021 09:13:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix uninitialized variable
Message-ID: <YLx1oWQAFPYIFRkF@kroah.com>
References: <20210606070021.116284-1-wlooi@ucalgary.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606070021.116284-1-wlooi@ucalgary.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 12:00:21AM -0700, Wenli Looi wrote:
> Uninitialized struct with invalid pointer causes BUG and prevents access
> point from working. Access point works once I apply this patch.
> 
> https://forum.armbian.com/topic/14727-wifi-ap-kernel-bug-in-kernel-5444/
> has more details.
> 
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 2fb80b6eb..7308e1185 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -2384,7 +2384,7 @@ void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame,
>  	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
>  
>  	{
> -		struct station_info sinfo;
> +		struct station_info sinfo = {};

What caused this bug to show up?  Did it happen from some other commit?

Are you sure that all of the fields are being cleared properly here,
what about any "holes" in the structure?

thanks,
greg k-h
