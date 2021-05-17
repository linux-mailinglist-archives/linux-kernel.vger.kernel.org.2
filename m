Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D6386B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbhEQUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhEQUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:34:35 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD2C061573;
        Mon, 17 May 2021 13:33:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a2so7143653qkh.11;
        Mon, 17 May 2021 13:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SFC+rYe0zaR/WVxTaatYntEqRqeQts9HjOc00HhAjT8=;
        b=BXjPaJ+KF2p68/R5wLNrYhoLA6R53ICumLEJqqm7BFTcD/gjYlolaXSZZHfJC03GgD
         XkaYjkPNr0mawJymbppU2IkmgazdcP1EtCTcVUkif/FgIizGiKf6c8lMt4z+2NyNSmR5
         FdcjfvsCjPcBs13tZdVaZ8ONd2tnjlhGJEKe/yv2jrWi7aVZVAtw2O0XPcGREsKpRsSX
         wKOFfpJr7I86N5kpDYFoN8H9mzB9eJUQyhS99P4ycle6J9glCJ+U8dVRbcdOx4OqG4gZ
         fe/03OaPMEnwJWBfFtZ0c5ZxdlyKw9UdoVp8kLpx4kN/M4khPVtKuCeTKho8UcsWXFb4
         RsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SFC+rYe0zaR/WVxTaatYntEqRqeQts9HjOc00HhAjT8=;
        b=px6GeO8SPh7fc80J3VhArscs2MikhYQKs5rFi25QuvAJODN5j7ZM1fpDLUuG7aB393
         FOG0FM3AiFJB8FNT6qpJKac4Oh8tBejo9qEAZq1BFMbAaKuNTVXU894Y5KyMrewKx7Ym
         I2Q7+g8LhkrhpthveyoSk2/Vng3hf50E22mg4/taBx2oeji0Ue9yu07f11OD90tNRRJj
         qIXlyZ6Ly5iHojl3ST+hjJca6iS3eblwJxj7sKgd5/9zL5ebQ3orSOfbw+CuV+ZSpf3t
         mEHip6/+0B/mZvnEA23YJhiQyUohOuz7M1sqW8s3mhLBIQhl/6ZN9oEowt/Qp51VNBn9
         nw+g==
X-Gm-Message-State: AOAM532GfRWRTkFAOsKAHRxBfyvZM0ozwbcqOY46H2uqc9k6lmlufnHr
        ADY+iURr0epuwQv5IIrFUDQ=
X-Google-Smtp-Source: ABdhPJw2L4LYtFCWNUte6JIJohS94Wd4Y9j4vGnNMmZtdxVCaDLZudyNH1eau1ry/ldh/F/bDmqltg==
X-Received: by 2002:a37:6891:: with SMTP id d139mr1781264qkc.466.1621283596594;
        Mon, 17 May 2021 13:33:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t203sm11202276qke.83.2021.05.17.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:33:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 17 May 2021 13:33:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] staging: rtl8188eu: use safe iterator in
 expire_timeout_chk
Message-ID: <20210517203314.GC3620180@roeck-us.net>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210517201826.25150-1-martin@kaiser.cx>
 <20210517201826.25150-3-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517201826.25150-3-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:18:23PM +0200, Martin Kaiser wrote:
> In the first loop in expire_timeout_chk, we may call rtw_free_stainfo and
> remove an entry from auth_list.
> 
> In the second loop, we may call list_del_init on our list.
> 
> Use list_for_each_entry_safe for both loops.
> 
> Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
>  - use list_for_each_entry_safe
>  - update both loops (I forgot the 2nd loop in v1)
> 
>  drivers/staging/rtl8188eu/core/rtw_ap.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
> index ca9a321c4921..6d7c96f1aa42 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_ap.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
> @@ -164,9 +164,9 @@ static u8 chk_sta_is_alive(struct sta_info *psta)
>  
>  void expire_timeout_chk(struct adapter *padapter)
>  {
> -	struct list_head *phead, *plist;
> +	struct list_head *phead;
>  	u8 updated = 0;
> -	struct sta_info *psta = NULL;
> +	struct sta_info *psta, *temp;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	u8 chk_alive_num = 0;
>  	char chk_alive_list[NUM_STA];
> @@ -176,9 +176,7 @@ void expire_timeout_chk(struct adapter *padapter)
>  
>  	phead = &pstapriv->auth_list;
>  	/* check auth_queue */
> -	list_for_each(plist, phead) {
> -		psta = list_entry(plist, struct sta_info, auth_list);
> -
> +	list_for_each_entry_safe(psta, temp, phead, auth_list) {
>  		if (psta->expire_to > 0) {
>  			psta->expire_to--;
>  			if (psta->expire_to == 0) {
> @@ -206,9 +204,7 @@ void expire_timeout_chk(struct adapter *padapter)
>  
>  	phead = &pstapriv->asoc_list;
>  	/* check asoc_queue */
> -	list_for_each(plist, phead) {
> -		psta = list_entry(plist, struct sta_info, asoc_list);
> -
> +	list_for_each_entry_safe(psta, temp, phead, asoc_list) {
>  		if (chk_sta_is_alive(psta) || !psta->expire_to) {
>  			psta->expire_to = pstapriv->expire_to;
>  			psta->keep_alive_trycnt = 0;
> -- 
> 2.20.1
> 
