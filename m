Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706E43DA182
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhG2Ksp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:48:45 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:48364
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232135AbhG2Ksm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:48:42 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id C2B8E3F07F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555718;
        bh=hgYfV6PUzr4ibh1B07XnMBlFCdNWiJgFxyAVIqgM0RM=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=KRZyP2gDSUmqw8kvPRhesGRnMUTU7taqCUHSHZrMv5JTzw+FfzV2zc7p98OszwmoS
         P6aTySHDMK7Hr9VsektJaNQ7ZK+F0ny0faDRVyAJmtliO8Tu/P+ugJ8YVI1IJiapIO
         /VOqX4ijoXA2YEltmcExO0PhTE/WiXmGI5NqJu8W0s7yKkr3GfRo/5oSz3nsWLP10B
         T/PbpQ7li48nZocE90cTQI9XAMWUP2oqDDDOQjZnqlmTuAFQuRMk3fcV9hfozmclRv
         b7m/FqUI/FGTzJ6UmH6j9jIbHUAzthDf+HR2nmUrM30lRGsJn2NE/WEndfQffOHso9
         RuQQN1vOlGDZw==
Received: by mail-ej1-f71.google.com with SMTP id g21-20020a1709061e15b029052292d7c3b4so1840902ejj.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hgYfV6PUzr4ibh1B07XnMBlFCdNWiJgFxyAVIqgM0RM=;
        b=lhAymCxDxqFg7cdVXkKrtmVG57cKaJgea1iCB8Rl+o93sa0Xpk/IvUbFLLnsEsmm2q
         KaEX/1t2VdRvD5JMqJzXlvI8uJPj4pP/y8j0bvcfCn80YdSPHFGI5gBrSQiyfwcORO82
         ufYz9yy6wi8Z29TFwgtjPdo37wVsxL8rj2pSsCMM+/FTgGLvcaKUPRu8vLXTB3y2+ClL
         WmddPix2e8XfrlVCzLxL3y/HxAcpZqxjFzVqalstTdM5+Dwbi3Ql5tWLa9M1uREKZEOf
         N6UWjDWMNYYUgYIfnFUtVCFnxGGZ1hoOSWR6PURQ+GVmvb84LmTaieJlTXgjupr5VP1Y
         yDbA==
X-Gm-Message-State: AOAM531aKI3UUuUBqZX5UEOI1zg7IszyJEUT7j2C0iMw6DLKyUcxmXHP
        ciPidJsXrrBs9xBarLOdheh9585z5/rDCA7Q38ICl49IZSFE8jNnBDDFvvQKZ/fb1N0OtJ5W62f
        kwB1e7LioRwWLSQAxMJZh3qx90fS5n8+n6MXu8Cl2QA==
X-Received: by 2002:a05:6402:1546:: with SMTP id p6mr5320728edx.206.1627555718148;
        Thu, 29 Jul 2021 03:48:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY4QAn1JOv7y3Pw7jEkKTFfdNWaTLg8KUKIcj9ag9xPZRr+U6cjAwxcWvt9Mt8ejiQhrR1PQ==
X-Received: by 2002:a05:6402:1546:: with SMTP id p6mr5320717edx.206.1627555718025;
        Thu, 29 Jul 2021 03:48:38 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id a35sm1053304edf.80.2021.07.29.03.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 03:48:37 -0700 (PDT)
Subject: Re: [PATCH 11/12] nfc: mrvl: constify several pointers
To:     Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
 <20210729104022.47761-12-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <fc52cc72-b9e2-4b30-5dcb-ec50b828f957@canonical.com>
Date:   Thu, 29 Jul 2021 12:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210729104022.47761-12-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2021 12:40, Krzysztof Kozlowski wrote:
> Several functions do not modify pointed data so arguments and local
> variables can be const for correctness and safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/nfc/nfcmrvl/fw_dnld.c | 16 +++++++++-------
>  drivers/nfc/nfcmrvl/i2c.c     |  2 +-
>  drivers/nfc/nfcmrvl/main.c    |  2 +-
>  drivers/nfc/nfcmrvl/nfcmrvl.h |  2 +-
>  drivers/nfc/nfcmrvl/spi.c     |  4 ++--
>  drivers/nfc/nfcmrvl/uart.c    |  2 +-
>  6 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
> index aaccb8b76b3e..edac56b01fd1 100644
> --- a/drivers/nfc/nfcmrvl/fw_dnld.c
> +++ b/drivers/nfc/nfcmrvl/fw_dnld.c
> @@ -129,7 +129,7 @@ static void fw_dnld_timeout(struct timer_list *t)
>  }
>  
>  static int process_state_reset(struct nfcmrvl_private *priv,
> -			       struct sk_buff *skb)
> +			       const struct sk_buff *skb)
>  {
>  	if (sizeof(nci_pattern_core_reset_ntf) != skb->len ||
>  	    memcmp(skb->data, nci_pattern_core_reset_ntf,
> @@ -145,7 +145,8 @@ static int process_state_reset(struct nfcmrvl_private *priv,
>  	return 0;
>  }
>  
> -static int process_state_init(struct nfcmrvl_private *priv, struct sk_buff *skb)
> +static int process_state_init(struct nfcmrvl_private *priv,
> +			      const struct sk_buff *skb)
>  {
>  	struct nci_core_set_config_cmd cmd;
>  
> @@ -175,7 +176,7 @@ static void create_lc(struct nfcmrvl_private *priv)
>  }
>  
>  static int process_state_set_ref_clock(struct nfcmrvl_private *priv,
> -				       struct sk_buff *skb)
> +				       const struct sk_buff *skb)
>  {
>  	struct nci_core_set_config_cmd cmd;
>  
> @@ -221,7 +222,7 @@ static int process_state_set_ref_clock(struct nfcmrvl_private *priv,
>  }
>  
>  static int process_state_set_hi_config(struct nfcmrvl_private *priv,
> -				       struct sk_buff *skb)
> +				       const struct sk_buff *skb)
>  {
>  	if (sizeof(nci_pattern_core_set_config_rsp) != skb->len ||
>  	    memcmp(skb->data, nci_pattern_core_set_config_rsp, skb->len))
> @@ -232,7 +233,7 @@ static int process_state_set_hi_config(struct nfcmrvl_private *priv,
>  }
>  
>  static int process_state_open_lc(struct nfcmrvl_private *priv,
> -				 struct sk_buff *skb)
> +				 const struct sk_buff *skb)
>  {
>  	if (sizeof(nci_pattern_core_conn_create_rsp) >= skb->len ||
>  	    memcmp(skb->data, nci_pattern_core_conn_create_rsp,
> @@ -347,7 +348,7 @@ static int process_state_fw_dnld(struct nfcmrvl_private *priv,
>  }
>  
>  static int process_state_close_lc(struct nfcmrvl_private *priv,
> -				  struct sk_buff *skb)
> +				  const struct sk_buff *skb)
>  {
>  	if (sizeof(nci_pattern_core_conn_close_rsp) != skb->len ||
>  	    memcmp(skb->data, nci_pattern_core_conn_close_rsp, skb->len))
> @@ -358,7 +359,8 @@ static int process_state_close_lc(struct nfcmrvl_private *priv,
>  	return 0;
>  }
>  
> -static int process_state_boot(struct nfcmrvl_private *priv, struct sk_buff *skb)
> +static int process_state_boot(struct nfcmrvl_private *priv,
> +			      const struct sk_buff *skb)
>  {
>  	if (sizeof(nci_pattern_proprietary_boot_rsp) != skb->len ||
>  	    memcmp(skb->data, nci_pattern_proprietary_boot_rsp, skb->len))
> diff --git a/drivers/nfc/nfcmrvl/i2c.c b/drivers/nfc/nfcmrvl/i2c.c
> index 59a529e72d96..6e659e77c8a2 100644
> --- a/drivers/nfc/nfcmrvl/i2c.c
> +++ b/drivers/nfc/nfcmrvl/i2c.c
> @@ -182,8 +182,8 @@ static int nfcmrvl_i2c_parse_dt(struct device_node *node,
>  static int nfcmrvl_i2c_probe(struct i2c_client *client,
>  			     const struct i2c_device_id *id)
>  {
> +	const struct nfcmrvl_platform_data *pdata;
>  	struct nfcmrvl_i2c_drv_data *drv_data;
> -	struct nfcmrvl_platform_data *pdata;
>  	struct nfcmrvl_platform_data config;
>  	int ret;
>  
> diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
> index 6e9e7ce8792c..d8e48bdaf652 100644
> --- a/drivers/nfc/nfcmrvl/main.c
> +++ b/drivers/nfc/nfcmrvl/main.c
> @@ -93,7 +93,7 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
>  				void *drv_data,
>  				struct nfcmrvl_if_ops *ops,
>  				struct device *dev,
> -				struct nfcmrvl_platform_data *pdata)
> +				const struct nfcmrvl_platform_data *pdata)
>  {
>  	struct nfcmrvl_private *priv;
>  	int rc;
> diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
> index a715543bc9bf..84fafa95965e 100644
> --- a/drivers/nfc/nfcmrvl/nfcmrvl.h
> +++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
> @@ -94,7 +94,7 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
>  				void *drv_data,
>  				struct nfcmrvl_if_ops *ops,
>  				struct device *dev,
> -				struct nfcmrvl_platform_data *pdata);
> +				const struct nfcmrvl_platform_data *pdata);
>  
>  
>  void nfcmrvl_chip_reset(struct nfcmrvl_private *priv);
> diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
> index 66696321c645..7b015bb33fc9 100644
> --- a/drivers/nfc/nfcmrvl/spi.c
> +++ b/drivers/nfc/nfcmrvl/spi.c
> @@ -106,7 +106,7 @@ static struct nfcmrvl_if_ops spi_ops = {
>  	.nci_update_config = nfcmrvl_spi_nci_update_config,
>  };
>  
> -static int nfcmrvl_spi_parse_dt(struct device_node *node,
> +static int nfcmrvl_spi_parse_dt(const struct device_node *node,
>  				struct nfcmrvl_platform_data *pdata)

This one is not correct (yet) as it depends on changes in OF/IRQ. I just
found compile configuration which triggers here warning.

Please skip this one patch.


Best regards,
Krzysztof
