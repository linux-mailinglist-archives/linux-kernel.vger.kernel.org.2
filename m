Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE174098C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhIMQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236979AbhIMQTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:19:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AADA60EE5;
        Mon, 13 Sep 2021 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631549886;
        bh=rJMsrnQNM4V/ZM9eTs/LduMrJob3pRjAi6xGqx/5sCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPf44SZnWjqq6xIiyWeQgrK8K40B0vJuOQi/I9tVqhy/1tXMkowOq1iFRdcNvkvb4
         /bhZ7qZbj+Z3Vb1fZwQqeJekjQ5gmjJtQ0xAmWrbNNrEn33Nkdgl0mZ4XAJWYbq7g8
         C12Hn94QqHenMT2Q03jTnSjA/gJntUePYA4mooUE=
Date:   Mon, 13 Sep 2021 18:18:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v2] staging: r8188eu: core: remove duplicate structure
Message-ID: <YT95vK3omIGEfnbu@kroah.com>
References: <YTr5bFrc1C4CUqZU@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTr5bFrc1C4CUqZU@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 11:51:32AM +0530, Saurav Girepunje wrote:
> Remove duplicate structure mlme_handler. struct action_handler and
> mlme_handler both are having same member. Replace mlme_handler with
> action_handler.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
> 
> ChangeLog V2:
> 
> - Replace the struct mlme_handler by action_handler.
> 
> ChangeLog V1:
> 
> -Remove duplicate structure mlme_handler and action_handler. Both
>  structure are having same member. Replace it with mlme_action_handler.
> 
> 
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 6 +++---
>  drivers/staging/r8188eu/include/rtw_mlme_ext.h | 6 ------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index f314f55997bf..499eda43fd69 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -11,7 +11,7 @@
>  #include "../include/mlme_osdep.h"
>  #include "../include/recv_osdep.h"
> 
> -static struct mlme_handler mlme_sta_tbl[] = {
> +static struct action_handler mlme_sta_tbl[] = {
>  	{WIFI_ASSOCREQ,		"OnAssocReq",	&OnAssocReq},
>  	{WIFI_ASSOCRSP,		"OnAssocRsp",	&OnAssocRsp},
>  	{WIFI_REASSOCREQ,	"OnReAssocReq",	&OnAssocReq},
> @@ -391,7 +391,7 @@ void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
>  	}
>  }
> 
> -static void _mgt_dispatcher(struct adapter *padapter, struct mlme_handler *ptable, struct recv_frame *precv_frame)
> +static void _mgt_dispatcher(struct adapter *padapter, struct action_handler *ptable, struct recv_frame *precv_frame)
>  {
>  	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  	u8 *pframe = precv_frame->rx_data;
> @@ -408,7 +408,7 @@ static void _mgt_dispatcher(struct adapter *padapter, struct mlme_handler *ptabl
>  void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
>  {
>  	int index;
> -	struct mlme_handler *ptable;
> +	struct action_handler *ptable;
>  #ifdef CONFIG_88EU_AP_MODE
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  #endif /* CONFIG_88EU_AP_MODE */
> diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> index d2f4d3ce7b90..6175abbc5029 100644
> --- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> +++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> @@ -213,12 +213,6 @@ enum SCAN_STATE {
>  	SCAN_STATE_MAX,
>  };
> 
> -struct mlme_handler {
> -	unsigned int   num;
> -	char *str;
> -	unsigned int (*func)(struct adapter *adapt, struct recv_frame *frame);
> -};
> -
>  struct action_handler {
>  	unsigned int   num;
>  	char* str;
> --
> 2.32.0
> 
>

Does not apply to my tree :(
