Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643AA437185
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 08:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhJVGF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 02:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhJVGF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:05:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9C0E610CF;
        Fri, 22 Oct 2021 06:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634882620;
        bh=JzgnnT1vFNgovNqLd0ix+p3ErAjwejA4YDXOJPW46DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gP4eMK/D/5vCVwIvgd2zAttaYuMFnHtCLmZpd1H506OMwbnAOo/VXsYOw34oPxeSb
         Wk4A28bCoQy/XAVs2Xhb1xoB9DcJj2t68x8gK/qAQRpS5Nh+jMzzKCre3XevUKSdRN
         aTAKYkAI9E4YWXy6V9UTCnHQ+J0UUl3KOXJa+tgk=
Date:   Fri, 22 Oct 2021 08:03:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        fmdefrancesco@gmail.com, marcocesati@gmail.com,
        straube.linux@gmail.com, philippesdixon@gmail.com,
        manuelpalenzuelamerino@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, mike.rapoport@gmail.com,
        kushalkotharitest@googlegroups.com,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH 4/4] staging: rtl8723bs: core: Remove unnecessary blank
 lines
Message-ID: <YXJUNy0VXEwxeBe+@kroah.com>
References: <cover.1634845504.git.kushalkothari285@gmail.com>
 <f6d2ba1d544c70519bad5c04f012cba0214b379a.1634845504.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6d2ba1d544c70519bad5c04f012cba0214b379a.1634845504.git.kushalkothari285@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 01:27:53AM +0530, Kushal Kothari wrote:
> Remove useless blank lines
> 
> Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index fce3256cc275..690e4627663c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -316,8 +316,6 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
>  	return _SUCCESS;
>  }
>  
> -
> -
>  int rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
>  {
>  	int res = _FAIL;
> @@ -367,7 +365,6 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)
>  	kfree(pcmd);
>  }
>  
> -
>  void rtw_stop_cmd_thread(struct adapter *adapter)
>  {
>  	if (adapter->cmdThread &&
> @@ -735,8 +732,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
>  	}
>  	/* for ies is fix buf size */
>  	t_len = sizeof(struct wlan_bssid_ex);
> -
> -
> +	

Please do not add new whitespace errors :(

Always run your patches through checkpatch.pl to ensure this.

thanks,

greg k-h
