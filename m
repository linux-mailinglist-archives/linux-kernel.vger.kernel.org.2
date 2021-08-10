Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070293E7BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbhHJPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbhHJPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:16:07 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D295EC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:15:45 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o185so29233994oih.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uP3G9fAQelefnbjKqVOLVLItIxyhItAZLKTn+hyWiyk=;
        b=kDUlMLGl9DDuug7mStwAVHeMIPPPtKAByTRP+vLkhUcU5j0EXwR69Pqdx7LoKLS8bQ
         JhEF1iFn62Wcs5AdZF/yUgnBuhmFhTRFkC4z7AVerNliEDGgTIApZ9dCH6Tjo08qg46Q
         FZyaAHyoxs0RdikkMzmTWH4t7XfG2XITNb7n4dKot2XuSb26rqjvkzjuYWtv/lHi8Nj/
         xuGtzbzMd9+lhJHTXF/yMcPRXNgbdkFLTbaWmlB33sZky9dCbT+EwjnGma3Bwv3s+nmg
         flyr2xiBw31SyddsfhG0DbVmTEV8jj3sxm85zkecXno7qCFBGhPuTKCCgU5FrxtgIqBK
         3nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uP3G9fAQelefnbjKqVOLVLItIxyhItAZLKTn+hyWiyk=;
        b=oDnehaRGoNWW20oOpF/PATInULx8QtbyIm//GPwktf4xf51du1b9GKMA7/9hE0z4Bx
         e7Y3jnwHdzJKpxc7quDoXPwf/jX4cF3jeOkl6sTCgp3krieXcRozv0CdLckqYbU2MWHX
         UaQTpZzqp+Pkzei/rg2hhdUOGo8C5N6SlgOr3hX0HVfv+vm72l7KI9K9OCyaAZWThLhr
         DidwB1DVC4gbsB8NOng/BjCl/v/lM5n6R7CAZ2Oqo1XsrW9Gz9PAwnQBQkV5X26j5gYw
         oR8no+FVpGkZuahqyrMDXLtpmzyL+0lZdSzn01eVR7EKnG8GHh2ARSmu/42/6g+Gwx7o
         1dNA==
X-Gm-Message-State: AOAM530CwiQ0DWqApzLqWxVyMggKDaH4xMSfSQJzO7OIkC//3wHjLohC
        QVnYyf4qYXnER9nM856kho4=
X-Google-Smtp-Source: ABdhPJy/D250lt77oFjrZsSrO1Yc9eq/MFfToHMu63BjYx3DsLMp5YbBPXH9jrP1ZdGtzNZfaJCL0Q==
X-Received: by 2002:a05:6808:10d:: with SMTP id b13mr3991011oie.79.1628608545239;
        Tue, 10 Aug 2021 08:15:45 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id k13sm3037868oik.40.2021.08.10.08.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 08:15:39 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH -next] staging: r8188eu: Use GFP_ATOMIC under spin lock
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org
References: <20210810125314.2182112-1-yangyingliang@huawei.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <d3356688-98e9-ddaf-592b-751a753a8f4a@lwfinger.net>
Date:   Tue, 10 Aug 2021 10:15:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810125314.2182112-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 7:53 AM, Yang Yingliang wrote:
> A spin lock is taken in __nat25_db_network_insert() and
> update_BCNTIM() is called under spin lock so we should
> use GFP_ATOMIC in both place.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/staging/r8188eu/core/rtw_ap.c     | 2 +-
>   drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
> index ad37f1f02ee2..0586e4a4cbcb 100644
> --- a/drivers/staging/r8188eu/core/rtw_ap.c
> +++ b/drivers/staging/r8188eu/core/rtw_ap.c
> @@ -98,7 +98,7 @@ static void update_BCNTIM(struct adapter *padapter)
>   		}
>   
>   		if (remainder_ielen > 0) {
> -			pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_KERNEL);
> +			pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_ATOMIC);
>   			if (pbackup_remainder_ie && premainder_ie)
>   				memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
>   		}
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 28f0452d6ccb..e3ff059ce224 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -394,7 +394,7 @@ static void __nat25_db_network_insert(struct adapter *priv,
>   		}
>   		db = db->next_hash;
>   	}
> -	db = kmalloc(sizeof(*db), GFP_KERNEL);
> +	db = kmalloc(sizeof(*db), GFP_ATOMIC);
>   	if (!db) {
>   		spin_unlock_bh(&priv->br_ext_lock);
>   		return;
> 

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

