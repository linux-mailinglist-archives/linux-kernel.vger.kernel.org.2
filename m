Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF6D39DEE3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFGOhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGOhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:37:35 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D300C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 07:35:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so16926599otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JnWc4hZy6HsZ9yLQ2zdw21ozzI2+jnp7lDj4gZtsXVU=;
        b=gsApnxTnqRrMwXHASRDwpyiFJRnZIX2k3Dg64NAk1XjiUO7nPZBs5L3ecVjUhNwNUm
         REjYv9dNoc7zJfRGFF/mYhzUd0HtoSUGl6rppKtO3/m58kRsVixGp56H44/QxO/YNRVr
         r8TxiK4ClBE/Tf1kA4ieDaY6bUcXMgyUBAS/fxiC6Z9lFzKOCGjCtlkJJ533dCba++lG
         Mqe0qp3dZBvy5KGCG/FT/Uz/lYrD3K7PluGAmUkG6nt9FyDFGiDMMl9PkqaLbou01ose
         XHeS9vLBalETLvJemtq5XS53VIb5+gghG3MyMAgt9bT1dEY20fbrOuBOz/FhjTzc3OrH
         dBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JnWc4hZy6HsZ9yLQ2zdw21ozzI2+jnp7lDj4gZtsXVU=;
        b=hfC46UOugb1iU0BJ0GZNJCWbz8pvuxW3myiYTZ29xAscl7GFnfNfwLLkrfBE2VCLRq
         5N82S9E9jcWhBZ8S8AxgybJryluTKkQeJAFxoosbusWWXxI2WjHRx6YRHsXKJ4+gr/Un
         nF7OSv1kh9B3j5s6d6QbODs/KcM6DFQiEitgxkjTv9J+phwv73hKPdDQzYgK2wsysFCv
         1WpTqi03J9mLZA7ETZZi56YbNfvDoCGj7CzhSOenxg+H0tONn8+MFoxlRb1FlEYrk2UN
         7jjRLj8uzdJLBaQHxGBD57dhpp1PtmeU5M2YbJlEH+j+7n8AnGw3SLKblLKlrBGhm2n/
         +L0A==
X-Gm-Message-State: AOAM531q5L3AoPPK/kCNFa094eQ4YapWYIRcmt4m7KA+FdwrXZrZRhIm
        gG2PB+SrVASRD2sMASvmrxg=
X-Google-Smtp-Source: ABdhPJzVx4pEJ6G974PWppNTn+ZgzhbSCe79Ip6wOlLlBFg78OKqminiyPG15QBvPTnfI+Fk26CKyQ==
X-Received: by 2002:a05:6830:1011:: with SMTP id a17mr5558708otp.14.1623076535008;
        Mon, 07 Jun 2021 07:35:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7sm894356oip.56.2021.06.07.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:35:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 7 Jun 2021 07:35:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: use list_for_each_safe in loops
 deleting iterated items
Message-ID: <20210607143532.GA1956328@roeck-us.net>
References: <20210607134618.11237-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607134618.11237-1-fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 03:46:18PM +0200, Fabio Aiuto wrote:
> Fix some beautified loops over linked lists.
> Use list_for_each_safe on loops which could delete
> objects in the list.
> 
> Fixes: b3cd518c5abd ("staging: rtl8723bs: Use list iterators and helpers")
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c        | 18 +++++++++---------
>  drivers/staging/rtl8723bs/core/rtw_mlme.c      |  4 ++--
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c  |  4 ++--
>  drivers/staging/rtl8723bs/core/rtw_sta_mgt.c   |  4 ++--
>  drivers/staging/rtl8723bs/core/rtw_xmit.c      | 18 +++++++++---------
>  drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c |  4 ++--
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  4 ++--
>  7 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 98b1bec67999..23bbdf084631 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -174,7 +174,7 @@ u8 chk_sta_is_alive(struct sta_info *psta)
>  
>  void expire_timeout_chk(struct adapter *padapter)
>  {
> -	struct list_head	*phead, *plist;
> +	struct list_head *phead, *plist, *tmp;
>  	u8 updated = false;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
> @@ -186,7 +186,7 @@ void expire_timeout_chk(struct adapter *padapter)
>  
>  	phead = &pstapriv->auth_list;
>  	/* check auth_queue */
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, tmp, phead) {
>  		psta = list_entry(plist, struct sta_info, auth_list);
>  
>  		if (psta->expire_to > 0) {
> @@ -211,7 +211,7 @@ void expire_timeout_chk(struct adapter *padapter)
>  
>  	phead = &pstapriv->asoc_list;
>  	/* check asoc_queue */
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, tmp, phead) {
>  		psta = list_entry(plist, struct sta_info, asoc_list);
>  		if (chk_sta_is_alive(psta) || !psta->expire_to) {
>  			psta->expire_to = pstapriv->expire_to;
> @@ -1243,7 +1243,7 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
>  
>  void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
>  {
> -	struct list_head	*plist, *phead;
> +	struct list_head *plist, *phead, *tmp;
>  	struct rtw_wlan_acl_node *paclnode;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
> @@ -1253,7 +1253,7 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
>  	spin_lock_bh(&(pacl_node_q->lock));
>  
>  	phead = get_list_head(pacl_node_q);
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, tmp, phead) {
>  		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
>  
>  		if (
> @@ -1940,7 +1940,7 @@ u8 ap_free_sta(
>  
>  void rtw_sta_flush(struct adapter *padapter)
>  {
> -	struct list_head	*phead, *plist;
> +	struct list_head *phead, *plist, *tmp;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> @@ -1953,7 +1953,7 @@ void rtw_sta_flush(struct adapter *padapter)
>  	spin_lock_bh(&pstapriv->asoc_list_lock);
>  	phead = &pstapriv->asoc_list;
>  	/* free sta asoc_queue */
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, tmp, phead) {
>  		psta = list_entry(plist, struct sta_info, asoc_list);
>  
>  		list_del_init(&psta->asoc_list);
> @@ -2132,7 +2132,7 @@ void start_ap_mode(struct adapter *padapter)
>  
>  void stop_ap_mode(struct adapter *padapter)
>  {
> -	struct list_head	*phead, *plist;
> +	struct list_head *phead, *plist, *tmp;
>  	struct rtw_wlan_acl_node *paclnode;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
> @@ -2156,7 +2156,7 @@ void stop_ap_mode(struct adapter *padapter)
>  	/* for ACL */
>  	spin_lock_bh(&(pacl_node_q->lock));
>  	phead = get_list_head(pacl_node_q);
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, tmp, phead) {
>  		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
>  
>  		if (paclnode->valid) {
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 7bd9e3a4f345..158f92d4d882 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -260,7 +260,7 @@ struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
>  
>  void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
>  {
> -	struct list_head *phead, *plist;
> +	struct list_head *phead, *plist, *tmp;
>  	struct wlan_network *pnetwork;
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct __queue *scanned_queue = &pmlmepriv->scanned_queue;
> @@ -268,7 +268,7 @@ void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
>  	spin_lock_bh(&scanned_queue->lock);
>  
>  	phead = get_list_head(scanned_queue);
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, tmp, phead) {
>  
>  		pnetwork = list_entry(plist, struct wlan_network, list);
>  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 2b95a49ab469..0f50c2576356 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -6058,7 +6058,7 @@ u8 h2c_msg_hdl(struct adapter *padapter, unsigned char *pbuf)
>  u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf)
>  {
>  	struct sta_info *psta_bmc;
> -	struct list_head	*xmitframe_plist, *xmitframe_phead;
> +	struct list_head *xmitframe_plist, *xmitframe_phead, *tmp;
>  	struct xmit_frame *pxmitframe = NULL;
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
>  	struct sta_priv  *pstapriv = &padapter->stapriv;
> @@ -6075,7 +6075,7 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf)
>  		spin_lock_bh(&pxmitpriv->lock);
>  
>  		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
> -		list_for_each(xmitframe_plist, xmitframe_phead) {
> +		list_for_each_safe(xmitframe_plist, tmp, xmitframe_phead) {
>  			pxmitframe = list_entry(xmitframe_plist,
>  						struct xmit_frame, list);
>  
> diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> index fa164d25f4eb..67ca219f95bf 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> @@ -423,7 +423,7 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
>  /*  free all stainfo which in sta_hash[all] */
>  void rtw_free_all_stainfo(struct adapter *padapter)
>  {
> -	struct list_head	*plist, *phead;
> +	struct list_head *plist, *phead, *tmp;
>  	s32	index;
>  	struct sta_info *psta = NULL;
>  	struct	sta_priv *pstapriv = &padapter->stapriv;
> @@ -436,7 +436,7 @@ void rtw_free_all_stainfo(struct adapter *padapter)
>  
>  	for (index = 0; index < NUM_STA; index++) {
>  		phead = &(pstapriv->sta_hash[index]);
> -		list_for_each(plist, phead) {
> +		list_for_each_safe(plist, tmp, phead) {
>  			psta = list_entry(plist, struct sta_info, hash_list);
>  
>  			if (pbcmc_stainfo != psta)
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index e37c4ba50d6d..0562fa6c1255 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -1723,13 +1723,13 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
>  
>  void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pframequeue)
>  {
> -	struct list_head	*plist, *phead;
> +	struct list_head *plist, *phead, *tmp;
>  	struct	xmit_frame	*pxmitframe;
>  
>  	spin_lock_bh(&pframequeue->lock);
>  
>  	phead = get_list_head(pframequeue);
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, tmp, phead) {
>  		pxmitframe = list_entry(plist, struct xmit_frame, list);
>  
>  		rtw_free_xmitframe(pxmitpriv, pxmitframe);
> @@ -2122,7 +2122,7 @@ signed int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct x
>  static void dequeue_xmitframes_to_sleeping_queue(struct adapter *padapter, struct sta_info *psta, struct __queue *pframequeue)
>  {
>  	signed int ret;
> -	struct list_head	*plist, *phead;
> +	struct list_head *plist, *phead, *tmp;
>  	u8 ac_index;
>  	struct tx_servq	*ptxservq;
>  	struct pkt_attrib	*pattrib;
> @@ -2130,7 +2130,7 @@ static void dequeue_xmitframes_to_sleeping_queue(struct adapter *padapter, struc
>  	struct hw_xmit *phwxmits =  padapter->xmitpriv.hwxmits;
>  
>  	phead = get_list_head(pframequeue);
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, tmp, phead) {
>  		pxmitframe = list_entry(plist, struct xmit_frame, list);
>  
>  		pattrib = &pxmitframe->attrib;
> @@ -2191,7 +2191,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
>  {
>  	u8 update_mask = 0, wmmps_ac = 0;
>  	struct sta_info *psta_bmc;
> -	struct list_head	*xmitframe_plist, *xmitframe_phead;
> +	struct list_head *xmitframe_plist, *xmitframe_phead, *tmp;
>  	struct xmit_frame *pxmitframe = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -2201,7 +2201,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
>  	spin_lock_bh(&pxmitpriv->lock);
>  
>  	xmitframe_phead = get_list_head(&psta->sleep_q);
> -	list_for_each(xmitframe_plist, xmitframe_phead) {
> +	list_for_each_safe(xmitframe_plist, tmp, xmitframe_phead) {
>  		pxmitframe = list_entry(xmitframe_plist, struct xmit_frame,
>  					list);
>  
> @@ -2272,7 +2272,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
>  
>  	if ((pstapriv->sta_dz_bitmap&0xfffe) == 0x0) { /* no any sta in ps mode */
>  		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
> -		list_for_each(xmitframe_plist, xmitframe_phead) {
> +		list_for_each_safe(xmitframe_plist, tmp, xmitframe_phead) {
>  			pxmitframe = list_entry(xmitframe_plist,
>  						struct xmit_frame, list);
>  
> @@ -2308,7 +2308,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
>  void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *psta)
>  {
>  	u8 wmmps_ac = 0;
> -	struct list_head	*xmitframe_plist, *xmitframe_phead;
> +	struct list_head *xmitframe_plist, *xmitframe_phead, *tmp;
>  	struct xmit_frame *pxmitframe = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -2316,7 +2316,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
>  	spin_lock_bh(&pxmitpriv->lock);
>  
>  	xmitframe_phead = get_list_head(&psta->sleep_q);
> -	list_for_each(xmitframe_plist, xmitframe_phead) {
> +	list_for_each_safe(xmitframe_plist, tmp, xmitframe_phead) {
>  		pxmitframe = list_entry(xmitframe_plist, struct xmit_frame,
>  					list);
>  
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> index ec9f275cbc7e..a05d43b716ee 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> @@ -178,7 +178,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
>  	struct hw_xmit *hwxmits, *phwxmit;
>  	u8 idx, hwentry;
>  	struct tx_servq *ptxservq;
> -	struct list_head *sta_plist, *sta_phead, *frame_plist, *frame_phead;
> +	struct list_head *sta_plist, *sta_phead, *frame_plist, *frame_phead, *tmp;
>  	struct xmit_frame *pxmitframe;
>  	struct __queue *pframe_queue;
>  	struct xmit_buf *pxmitbuf;
> @@ -225,7 +225,7 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
>  		sta_phead = get_list_head(phwxmit->sta_queue);
>  		/* because stop_sta_xmit may delete sta_plist at any time */
>  		/* so we should add lock here, or while loop can not exit */
> -		list_for_each(sta_plist, sta_phead) {
> +		list_for_each_safe(sta_plist, tmp, sta_phead) {
>  			ptxservq = list_entry(sta_plist, struct tx_servq,
>  					      tx_pending);
>  
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 9a6e47877c4e..c10146428757 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -2453,7 +2453,7 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
>  				    struct station_del_parameters *params)
>  {
>  	int ret = 0;
> -	struct list_head	*phead, *plist;
> +	struct list_head *phead, *plist, *tmp;
>  	u8 updated = false;
>  	struct sta_info *psta = NULL;
>  	struct adapter *padapter = rtw_netdev_priv(ndev);
> @@ -2483,7 +2483,7 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
>  
>  	phead = &pstapriv->asoc_list;
>  	/* check asoc_queue */
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, tmp, phead) {
>  		psta = list_entry(plist, struct sta_info, asoc_list);
>  
>  		if (!memcmp((u8 *)mac, psta->hwaddr, ETH_ALEN)) {
> -- 
> 2.20.1
> 
