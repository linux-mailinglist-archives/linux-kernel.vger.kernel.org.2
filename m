Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96023386B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbhEQUf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbhEQUfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:35:23 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E6C061573;
        Mon, 17 May 2021 13:34:05 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id h7so3171879qvs.12;
        Mon, 17 May 2021 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZxYJhTuM2LR07AUba1x1umGGRXOkQsAno3p7Ab7UDtI=;
        b=K4hTWOrvhYSxkFOXjGlNnlb1np9ZZdlEjAiyZWxAIPdJJE1JTnXoXGA1GlpvscCDEg
         CypLl+Soj7ZlizZV/i0oV7ooCJUdUdNsjE7q+qEehJAnnZ858Dg9oWP3JhLI6U6BBwc0
         FxcGGVaxbooOsDPdysss/JLMgfP+f6GY8Iw+C+D+T6nznilyIh+hhs8x/KyWtTR8flta
         YVGQFauXN0cCK3eY/9Vchhxldac41XBaZmkWuB4NVt7OojPKdVPMVqEwkZC8Tm78yJcG
         cUSOMc5+B9M5ru6EjtrxgqNc/HufyXaxv4LlDNMJiCULRIV8W69xesCfuua+U9YGTvWQ
         wFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZxYJhTuM2LR07AUba1x1umGGRXOkQsAno3p7Ab7UDtI=;
        b=GzNBfHXjncAdyHeFc7U8b+HWUWDqq5YTpxPWwtRpYCwuMsLa9F0E7/ysoYw5LuzrHA
         n8Zdd9AMwDJFSaUlMVHZpYW/tpFt8H95mAIIKa+r4may1g8lsTecgwY5E6tO6MaaK5+2
         hDU6cYStfCu+4ZZwgMm3t1rypUnxlcASd1TJiVfTrPZPdZQR0r83yMUiflQgTe109eVq
         b29tzfhNE/9C66RWMse5mdI+JasAO+ZPSmpzdIcEyByXvMu5FTzmFA4l6tW0poFnmV8v
         kp2WXSts/kTMBtAGbaYqDL3jC5u2BtCusBxi/EgAXKsWLiq0mSce+mUpsCIRbRSXVUD1
         YE2Q==
X-Gm-Message-State: AOAM530JJ3fNyjbRFxkLY3hoeW04a9RE06dF5sdg/ECTWEuZma7R3Uep
        biykiCuTb1HwkoQKhQCnFoaEUbZRTTg=
X-Google-Smtp-Source: ABdhPJxXDD9sg2F9fb/HUA86Sm3Lc7DoFByJMnFcUpoGHe7g4MwnuYf2eWKkhVRFvS2m7yf7Bnx3ow==
X-Received: by 2002:ad4:5f87:: with SMTP id jp7mr1586579qvb.46.1621283644817;
        Mon, 17 May 2021 13:34:04 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o26sm11206336qkm.4.2021.05.17.13.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:34:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 17 May 2021 13:34:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] staging: rtl8188eu: use safe iterator in
 rtw_acl_remove_sta
Message-ID: <20210517203403.GD3620180@roeck-us.net>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210517201826.25150-1-martin@kaiser.cx>
 <20210517201826.25150-4-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517201826.25150-4-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:18:24PM +0200, Martin Kaiser wrote:
> Use list_for_each_entry_safe, we may delete list items while iterating
> over the list.
> 
> Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
>  - use list_for_each_entry_safe
> 
>  drivers/staging/rtl8188eu/core/rtw_ap.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
> index 6d7c96f1aa42..d297d5301153 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_ap.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
> @@ -1068,8 +1068,8 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
>  
>  int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
>  {
> -	struct list_head *plist, *phead;
> -	struct rtw_wlan_acl_node *paclnode;
> +	struct list_head *phead;
> +	struct rtw_wlan_acl_node *paclnode, *temp;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
>  	struct __queue *pacl_node_q = &pacl_list->acl_node_q;
> @@ -1079,9 +1079,7 @@ int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
>  	spin_lock_bh(&pacl_node_q->lock);
>  
>  	phead = get_list_head(pacl_node_q);
> -	list_for_each(plist, phead) {
> -		paclnode = list_entry(plist, struct rtw_wlan_acl_node, list);
> -
> +	list_for_each_entry_safe(paclnode, temp, phead, list) {
>  		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
>  			if (paclnode->valid) {
>  				paclnode->valid = false;
> -- 
> 2.20.1
> 
