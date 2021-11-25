Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE65845E018
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349017AbhKYSAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347496AbhKYR6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:58:41 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DCDC06139E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:46:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o13so13232110wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dM0J3dt4h4ce+/bgfr0sMjPnODp/xXDrf+z2T+vwycw=;
        b=gTcKSPijPldqPZjUR1xv1M8OlenayFzHvHVkdCH2AuHUauJGb4Amaau5sI5W6lCM0t
         XQqRBOBugqIiHFXuu0lrsRMUiGYI3puVNtqtAcI7v4o1GEQzbcThZxtfoFsRkFo8cgJe
         dyznqZcqpMbTvdPSOzvq6R7sM0LcmKwyZPZ3oWkWhnN8PWbGtkmDDd1Eqs/21z2RwWf+
         ix+N3v0PQgbXLxvEj7qjVq/sLtg+rAG/TgYDADOJu+opufagAxPL3Z6neQ5Ge+P8m5Gk
         O8fnO8GkTfFRU9+g6Wn4xmGnl9U0SJoMMojxlbVOzbwTNeozhvjqMv1bBGHsbIG6EzgS
         XNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dM0J3dt4h4ce+/bgfr0sMjPnODp/xXDrf+z2T+vwycw=;
        b=Mk8wQmA78kwEFKlqL/fV7SD6lf605YYXPUJNymIgvCDFrfnfxCJJQOZJdyLmkFSar3
         /MYZbZNR7RdF3tghPAssrGX6EQqJPsEyRSHwRuJdQs4OhxnNWarv5InG+1snBjKvXmGU
         u42+cyQIfFv6cJ9gYgtNoiMQ/1lAKi7wGZDjsBrjiq0kZZ4IA6NWFqMt2OB+P6OsEOxD
         pF/y0SjVEjidxHZK5Rp7+qRzLIu50z3ZPcRV8B7G9+Os1fok1O4Rqd9Jf9UC+FOtmy9J
         jIoIhNHdmIc2TUMeWqGVAVVT/tJiZ0U0/1MTeBo3zIbo8i4rgf8zHNf5N2LeL83Llij6
         FDWA==
X-Gm-Message-State: AOAM5318fEoWUC/lfnzoHKH2LA2lQs57tFpqbTr95i7jBMiePKolGNUE
        63hBf4EMx2g6IPFE5miiYNsMTcR65fQ=
X-Google-Smtp-Source: ABdhPJy/iuzlqLMiHvcr8Cn+q8aZPl1M2nZ/wh516j1zxq5qbmV0b1BongNTIxje03OvujwUAiccGQ==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr8834873wrm.470.1637862406958;
        Thu, 25 Nov 2021 09:46:46 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::7311? ([2a02:8108:96c0:3b88::7311])
        by smtp.gmail.com with ESMTPSA id m7sm3457414wml.38.2021.11.25.09.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 09:46:46 -0800 (PST)
Message-ID: <7a090a98-b3ae-fe40-84c2-dbbebc85731f@gmail.com>
Date:   Thu, 25 Nov 2021 18:46:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 3/4] staging: r8188eu: remove _ps_close_RF
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211125164745.8188-1-martin@kaiser.cx>
 <20211125164745.8188-4-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211125164745.8188-4-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 17:47, Martin Kaiser wrote:
> The _ps_close_RF is empty. Remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 995ea4a55435..0b1aaa162c21 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -850,12 +850,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
>   	return status;
>   }
>   
> -static void _ps_close_RF(struct adapter *adapt)
> -{
> -	/* here call with bRegSSPwrLvl 1, bRegSSPwrLvl 2 needs to be verified */
> -	/* phy_SsPwrSwitch92CU(adapt, rf_off, 1); */
> -}
> -
>   static void CardDisableRTL8188EU(struct adapter *Adapter)
>   {
>   	u8 val8;
> @@ -921,9 +915,7 @@ u32 rtl8188eu_hal_deinit(struct adapter *Adapter)
>   	rtw_write32(Adapter, REG_HIMRE_88E, IMR_DISABLED_88E);
>   
>   	DBG_88E("bkeepfwalive(%x)\n", Adapter->pwrctrlpriv.bkeepfwalive);
> -	if (Adapter->pwrctrlpriv.bkeepfwalive) {
> -		_ps_close_RF(Adapter);
> -	} else {
> +	if (!Adapter->pwrctrlpriv.bkeepfwalive) {
>   		if (Adapter->hw_init_completed) {
>   			CardDisableRTL8188EU(Adapter);
>   		}
> 

Reviewed-by: Michael Straube <straube.linux@gmail.com>
