Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314823820A0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 21:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhEPT0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhEPT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 15:26:08 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4527BC061573;
        Sun, 16 May 2021 12:24:53 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u1so2124471qvg.11;
        Sun, 16 May 2021 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0TGwNjsGKm/LEKBNwkdX1PTEJhiJkYnKeiNijmSSLlQ=;
        b=Lj3/Qc2/bO0m3yHFXZp1IpZPMO6eL0eU6Cxaq4RZN0Z+ApwCNY8FLgvw8UKXd4hAZv
         db1VwsA06sh8PqpNtvp40ukwzoG4NGu8Q7zW5rr+YVJSXMtrcvLoex3q5rsTEBOyk/EU
         fKyj8a+v3k/9CwM4Y6g4vAOaus1QjKaWwTHr/oR9izarDrwkSv/FVSXj4scXz8HAHqlW
         +5wZ86g6DEkM7yxxUI9wiut9LQiOMEA7I+N+a/u1B/rnfBM+rWFhF8CNTzMx+Xqt35HM
         xGLWYGiy5ZKMAstD+a9OvT/WcinHSLB1IkdtctOs0GS0aIVM2bY/l+tOV/gcY11pvFu7
         v60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0TGwNjsGKm/LEKBNwkdX1PTEJhiJkYnKeiNijmSSLlQ=;
        b=SC2DK9pErNDeoVZOvHV6ASlHdNnlChyenL2go831VUmqZhgWBB/EV0PsIWKnelEAAJ
         OuCYBUwqAkk1ITWJFSvHnYL6yFB11TU+ekzMO1PmE/d0VzKpHXlnGnRs2yspzKofITAZ
         1BV7ndXiomqdHR7Qygr6yQiHuYvA4OxxqUPbJ0SCXLGucwD7aWzmm2OWbzYVPRk5zp0x
         wKL3JCkrvRCn/Bfr05T4mR9DMSTKd86ATlXboDGEG3AEirEgMND8aZ3soROMwMPPvlYY
         kDmVznPsBoQZEDuQyxBaxnpgKpplTQHSiHssRRjEsHLw/k+oNJrgAqboeQFV7FHjMK9b
         I0AQ==
X-Gm-Message-State: AOAM531yGoTRaZGz+poobFLaQxAfr6sqEnpLbQZtMFMoci+ng+VIOZci
        FDGF0ekhwt0TJN+uvLdC8E4=
X-Google-Smtp-Source: ABdhPJzQMESBEPOPGqGcZuAk/n/Z5wakVcQuS2AbCIoKkSasknrB2xPn30KY0qRxW4wozzoGqQM+6w==
X-Received: by 2002:a0c:ec88:: with SMTP id u8mr15688566qvo.25.1621193092543;
        Sun, 16 May 2021 12:24:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6sm8710644qkk.130.2021.05.16.12.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 12:24:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 May 2021 12:24:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] staging: rtl8188eu: use safe iterator in
 rtw_sta_flush
Message-ID: <20210516192450.GE2126643@roeck-us.net>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210516160613.30489-5-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516160613.30489-5-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 06:06:12PM +0200, Martin Kaiser wrote:
> Use list_for_each_safe, we may delete list items while iterating over
> the list.
> 
> Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> compile-tested only
> 
>  drivers/staging/rtl8188eu/core/rtw_ap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
> index 601974df4114..8ffafc7eb316 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_ap.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
> @@ -1579,7 +1579,7 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
>  
>  int rtw_sta_flush(struct adapter *padapter)
>  {
> -	struct list_head *phead, *plist;
> +	struct list_head *phead, *plist, *temp;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> @@ -1594,7 +1594,7 @@ int rtw_sta_flush(struct adapter *padapter)
>  	spin_lock_bh(&pstapriv->asoc_list_lock);
>  	phead = &pstapriv->asoc_list;
>  	/* free sta asoc_queue */
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, temp, phead) {
>  		psta = list_entry(plist, struct sta_info, asoc_list);
>  
>  		list_del_init(&psta->asoc_list);
> -- 
> 2.20.1
> 
