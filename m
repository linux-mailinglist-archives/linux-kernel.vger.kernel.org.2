Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE93AC5E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhFRIXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:23:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47087 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhFRIXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:23:05 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lu9kF-00066q-D1
        for linux-kernel@vger.kernel.org; Fri, 18 Jun 2021 08:20:55 +0000
Received: by mail-ed1-f72.google.com with SMTP id i19-20020a05640200d3b02903948b71f25cso1069823edu.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/K0H906YUUKfdepwlReDstttzt/rZTiSrnXu1rsGl4=;
        b=FQOBar0/4npg6wY5ia+5Gz01dKicJXPxVp3sSYAxmx/qXfzILSL614ybVFP6bcxbjh
         t4pJXEzvTSSFMKJTgizt6zapvGEw39+Rgv6hjIBQSOD8cGUo/NteqM4bGkUQ1Md1Vih+
         h/V6HcNwFuS8lruWqZRz7qhxmOcoRB2TIhzEVANtT5eHxhWa6skvEy9y0fyqEZ8jUNhE
         X9jmWzHhO1cNg1yeRjLXKmqy98e/q07BtF8X/tYKDW0JEzrzdmVuHr0tfRyVGrNcBY2p
         m4/3fXoOAoJBLhtv6wWBz+8vAcRekDmLUJu0vGHexuzDHrzZuvYfeRTkqeKbdp5iOMYG
         LHlw==
X-Gm-Message-State: AOAM531BWFJc4tNxfEd77bVNy8WTnLX/xvsJNO6JYB8LeZ60DhDH2HEf
        UMFJBQpybPV+XSvkBren3+qhFzQBdV57tp17tMGUFIzXDM9SBVZ04yQNnHve2cBEdYLPJVEBanG
        f4dehff6yT+PIZuqj3CDvhCztLVJRwxGkJwXJdmm51g==
X-Received: by 2002:aa7:d799:: with SMTP id s25mr2326476edq.161.1624004455076;
        Fri, 18 Jun 2021 01:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/I7P0xXP0OFvYW9YaIccS4kemIdCdzd2LI7F/6hxbx946RKljIW2c8ALFC5WoxW7v5BggJw==
X-Received: by 2002:aa7:d799:: with SMTP id s25mr2326465edq.161.1624004454904;
        Fri, 18 Jun 2021 01:20:54 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id ci4sm704168ejc.110.2021.06.18.01.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 01:20:54 -0700 (PDT)
Subject: Re: [PATCH] NFC: nxp-nci: remove unnecessary label
To:     samirweng1979 <samirweng1979@163.com>, charles.gorand@effinnov.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210618074456.17544-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <99c12036-5444-b41b-165b-9f6a1812810e@canonical.com>
Date:   Fri, 18 Jun 2021 10:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618074456.17544-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2021 09:44, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> Label chunk_exit is unnecessary, so we delete it and
> directly return -ENOMEM.

There is no plural here, no collective "we". Please, use simple statements:
"Remove unnecessary label chunk_exit and return directly."

You could add here the explanation for question "why doing this?", e.g.
"Simplify the code by removing unnecessary label chunk_exit and
returning directly."

> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> ---
>  drivers/nfc/nxp-nci/firmware.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nfc/nxp-nci/firmware.c b/drivers/nfc/nxp-nci/firmware.c
> index dae0c80..119bf30 100644
> --- a/drivers/nfc/nxp-nci/firmware.c
> +++ b/drivers/nfc/nxp-nci/firmware.c
> @@ -95,10 +95,8 @@ static int nxp_nci_fw_send_chunk(struct nxp_nci_info *info)
>  	int r;
>  
>  	skb = nci_skb_alloc(info->ndev, info->max_payload, GFP_KERNEL);
> -	if (!skb) {
> -		r = -ENOMEM;
> -		goto chunk_exit;
> -	}
> +	if (!skb)
> +		return -ENOMEM;
>  
>  	chunk_len = info->max_payload - NXP_NCI_FW_HDR_LEN - NXP_NCI_FW_CRC_LEN;
>  	remaining_len = fw_info->frame_size - fw_info->written;
> @@ -124,7 +122,6 @@ static int nxp_nci_fw_send_chunk(struct nxp_nci_info *info)
>  
>  	kfree_skb(skb);
>  
> -chunk_exit:
>  	return r;
>  }
>  
> 


Best regards,
Krzysztof
