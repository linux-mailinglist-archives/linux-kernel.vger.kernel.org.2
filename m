Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B29401924
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbhIFJpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241595AbhIFJpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:45:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B85B46069E;
        Mon,  6 Sep 2021 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630921479;
        bh=URzFpDiRAvqj9TyRQWt1sJXc0kGU7HlFj/iPTlLyjsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUNuBrRWIQRZx6p82foUKLcl7NTyK6xjTdrnrJaiF4ALvbbbkzKX/B0HRuT6+38FB
         KR22VEkY6+xW7ydwDZRp+sm0qUw1++aIv7UG19+wXW36g4FpKvRDhWJ8nJidVkF8I4
         5r9EBVLmADNCp1lFJIauGO/mHhTu9pcQBudlbujk=
Date:   Mon, 6 Sep 2021 11:44:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix type mismacth
Message-ID: <YTXjBCZvdTeutTZX@kroah.com>
References: <20210905205216.24831-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210905205216.24831-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 11:52:16PM +0300, Pavel Skripkin wrote:
> smatch says:
> rtw_cmd.c:1165 rtw_setassocsta_cmd() warn: struct type mismatch 'set_stakey_rsp vs set_assocsta_rsp'
> 
> Since psetassocsta_rsp has struct set_stakey_rsp * type, it looks like
> copy-paste failure. This error didn't cause any bugs, because
> sizeof(struct set_assocsta_parm) > sizeof(struct set_stakey_rsp), but
> there is no reason for allocation extra unused memory
> 
> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index fee4208dacba..afe6c7fa594d 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1162,7 +1162,7 @@ u8 rtw_setassocsta_cmd(struct adapter  *padapter, u8 *mac_addr)
>  		goto exit;
>  	}
>  
> -	psetassocsta_rsp = kzalloc(sizeof(struct set_assocsta_rsp), GFP_ATOMIC);
> +	psetassocsta_rsp = kzalloc(sizeof(struct set_stakey_rsp), GFP_ATOMIC);

Best way to fix this is to use the variable in the call itself, like:
	psetassocsta_rsp = kzalloc(sizeof(*psetassocsta_rsp), GFP_ATOMIC);

But as Dan said, this looks odd overall, please make sure that the code
is correct here.

thanks,

greg k-h
