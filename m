Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B0386B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbhEQUgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244107AbhEQUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:36:19 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39F6C061760;
        Mon, 17 May 2021 13:35:02 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f18so7165124qko.7;
        Mon, 17 May 2021 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DlOHftoPJAIDqKYNCpELpr/+FFDFNrEUZOzIYh/N+48=;
        b=rtcsyO1W8VOUY1C18xZXuZz/zP8WtUobARoeoZdlZec45I1rXS3WffE18Jy9jid5rQ
         htRk6NnESSmOrq68Gi1VHN8xSsG3GPYlV9s+cKiH5tbGzfR4o0FPAimWIPL1YHwKavTY
         x7gvAfzWn+OGFjMP8gOunkWFcWdNZ5qVvTThwuc+C0ErmU6+znc+DlwuXdKxH4V9KDtI
         gIDWeHJb2z+g591SUwbT3zUo3FAqJZhIMVDJCydm1ifXdH4RjNoSeAdL7pi7Bjj9zUP2
         kxNRWZvEQzeP3q5h62+2bVDl8GaLolBRUcn9oWTEhg+QWO7eTviZ3qkp9T//PYOg/IIE
         Fokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DlOHftoPJAIDqKYNCpELpr/+FFDFNrEUZOzIYh/N+48=;
        b=OteomjTGGKRQsaJmuGDgxcULTVcxldI1xDs+xFKleA19ZDEk3SVFJlfASTX7d/gL5E
         A4MHUxvqssXCj8J7UhKDEXg3spIPVr0l+C7Ar2U2po3t1biWpnKo2wLQJZ+Z/sDG6RaK
         EBeRaCKMH3ZFoVite2USpiF/p+bfXOF3idF2gxkDwxwGXEO1isVdkPgRoyXP8rwtuCMy
         b6U+oOmlfheAR/WcpeprGqU+J6buB36isvJ9DPPlAIcQM+/K/Nk9oXoUOLK0oOvqFrWN
         k6EwN3/u85kIcTAG6C4+SVLR4ucZGXNmkA7qLYZFTiUwwqpxelzOMTKX76HMLtFDN6ru
         BANg==
X-Gm-Message-State: AOAM532NPlUoRztCNtUDuJMid8HHWOnC4IvMbEjo0fav4HpoB7moSDGZ
        dPhnt/Sgu1L8VfukiibDChp1SJAyboQ=
X-Google-Smtp-Source: ABdhPJwaUoYh1yhVa/qGVHhw4JI9qg07hFPkZgk72IrqdmZ2uHt9b4sIurfMRPYybylgJ7pUEdTwzA==
X-Received: by 2002:a05:620a:13a6:: with SMTP id m6mr1778169qki.370.1621283702237;
        Mon, 17 May 2021 13:35:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j29sm11046651qtv.6.2021.05.17.13.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:35:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 17 May 2021 13:35:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] staging: rtl8188eu: use safe iterator in
 rtw_free_xmitframe_queue
Message-ID: <20210517203500.GF3620180@roeck-us.net>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210517201826.25150-1-martin@kaiser.cx>
 <20210517201826.25150-6-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517201826.25150-6-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:18:26PM +0200, Martin Kaiser wrote:
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
>  drivers/staging/rtl8188eu/core/rtw_xmit.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> index 3763d188b892..dcc29a74612d 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> @@ -1329,17 +1329,15 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
>  
>  void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pframequeue)
>  {
> -	struct list_head *plist, *phead;
> -	struct	xmit_frame	*pxmitframe;
> +	struct list_head *phead;
> +	struct	xmit_frame	*pxmitframe, *temp;
>  
>  	spin_lock_bh(&pframequeue->lock);
>  
>  	phead = get_list_head(pframequeue);
> -	list_for_each(plist, phead) {
> -		pxmitframe = list_entry(plist, struct xmit_frame, list);
> -
> +	list_for_each_entry_safe(pxmitframe, temp, phead, list)
>  		rtw_free_xmitframe(pxmitpriv, pxmitframe);
> -	}
> +
>  	spin_unlock_bh(&pframequeue->lock);
>  }
>  
> -- 
> 2.20.1
> 
