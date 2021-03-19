Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467ED342692
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhCST5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCST4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:56:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E00C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nnFWmARFGJLPv7OxDsJyeioJi7c0cvxA/6JhBnPTXYA=; b=pL0xgcTNEEknMo8DvX6DqCKxMV
        t6G+EGpYE24VKtbCbAe6N8POorbwT5XjxSA1VIB4QDGELm+U7dIbQ5VOg8hSmFPJhNPC40QoN6ZR4
        yfSJv6kfzWjjPyeUQWkSW7iqdTN1pZUxJkUgWENC1xOwXUpzoLlzcg7WCD1C8/SsOnu3gZ2aN7Xrd
        ChphsqZ228swFo0+pwdkZYrn11dIzyw/CA6WH//JpaVBTsdUUGhnpL6ozZdg+gkeGCfv+aDdj/KHa
        5ORyEgE79+AAQKsbaZEKJPXqBv5PRW1K23IMziAXJ8NrkIZJodgzv+Xj5PlrHedQim1o6JGq2Bo2B
        o2HLyJWg==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNLEW-001VD0-5z; Fri, 19 Mar 2021 19:56:33 +0000
Date:   Fri, 19 Mar 2021 12:56:32 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, insafonov@gmail.com,
        dan.carpenter@oracle.com, yepeilin.cs@gmail.com,
        dinghao.liu@zju.edu.cn, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: rtl8188eu: Fix couple of typos
In-Reply-To: <20210319193414.10393-1-unixbhaskar@gmail.com>
Message-ID: <5dd2e438-e854-493c-5c8d-18f9121cb82@bombadil.infradead.org>
References: <20210319193414.10393-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_125632_246823_BE975A8F 
X-CRM114-Status: GOOD (  11.44  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote: > > s/pasive/passive/
    > s/varable/variable/ > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
    Acked-by: Randy Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/pasive/passive/
> s/varable/variable/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> Changes from V1:
>  Randy's suggestion incorporated.
>
> drivers/staging/rtl8188eu/core/rtw_mlme.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> index f87dd71934c3..b6ac5b8915b1 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> @@ -37,7 +37,7 @@ int rtw_init_mlme_priv(struct adapter *padapter)
> 	pmlmepriv->pscanned = NULL;
> 	pmlmepriv->fw_state = 0;
> 	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
> -	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
> +	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: passive. Maybe someday we should rename this variable to "active_mode" (Jeff) */
>
> 	spin_lock_init(&pmlmepriv->lock);
> 	_rtw_init_queue(&pmlmepriv->free_bss_pool);
> --
> 2.26.2
>
>
