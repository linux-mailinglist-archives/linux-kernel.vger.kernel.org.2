Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC5A3DE912
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhHCI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:59:32 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:35448
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234418AbhHCI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:59:31 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 479B73F351;
        Tue,  3 Aug 2021 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627981159;
        bh=zELCh9ra4UtYmy8Y/TSDhcIk1+Y5vnqIJaopipf2xoM=;
        h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=mk5/jUjgrFamS0emhuW53jEmFb2QGZ/KvZLj/NnG0jCUJsIWVADqJYCNMesejSHas
         JKBXs85FCPu3LcgKABvju+XwOR6Elt1Pn7VtzmtyutxTJHu7QbkaYnB4KCMrBSoA6f
         ZVDZ+wjOlp7ks5h4weupB2P6YnBpV3NeQgwPvNBeQjSaEabruYIyAzGOztKPvLImzv
         WZYhUOv+gT6nGKVT4LCVtEFtwfBdvNGt+McRJrmysKxSMakehCu4vK9OfNVmaZHhnk
         35U1PFLBcYGgZ/M2zxEO/CqhaJVTLQJEsVm/RX562FvCIdRBo5WrxK6cv4CJCtbXLL
         XGzOI1wy9sYzQ==
Subject: NAK: [PATCH][next] staging: r8188eu: Fix spelling mistake "Cancle" ->
 "Cancel"
From:   Colin Ian King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210803085331.320859-1-colin.king@canonical.com>
Message-ID: <ff4ad2de-6db7-1ff3-1e4b-4d4fd4eaf122@canonical.com>
Date:   Tue, 3 Aug 2021 09:59:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803085331.320859-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2021 09:53, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in a RT_TRACE message and a comment. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index a6d62074289f..a2c1e03e874f 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -1243,11 +1243,10 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>  					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("adhoc mode, fw_state:%x", get_fwstate(pmlmepriv)));
>  				}
>  
> -			/* s5. Cancle assoc_timer */
> +			/* s5. Cancel assoc_timer */
>  			_cancel_timer(&pmlmepriv->assoc_timer, &timer_cancelled);
>  
> -			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("Cancle assoc_timer\n"));
> -
> +			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cancel assoc_timer\n"));
>  		} else {
>  			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_joinbss_event_callback err: fw_state:%x", get_fwstate(pmlmepriv)));
>  			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
> 

NAK. I've found a bunch more typos in this driver, I'll send a V2
including this fix.

Colin
