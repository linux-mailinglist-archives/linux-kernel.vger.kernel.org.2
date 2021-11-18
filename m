Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D4D4555CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 08:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243396AbhKRHjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 02:39:33 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49180
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241249AbhKRHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 02:39:32 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB81C3F199
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 07:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637220988;
        bh=kZfxEbilwBn/d5y9NL7OpM5HcRJhMuj9iFneWlhPdsE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=RZUNqYrky2sNTgzqfuylSF2f2IOW/opI/va7TLR+akkVq6eJyX50CjfiT3qL3yzOp
         sw39epA1gee3dtur0fulOiRJi8gxbrSk39zqpp6HMSe8F0BZ/kicZM/GeLsUQFr3rz
         xEbjFHI6WMObVbf3jkUykNaaX1dsd5exlRsCKey49xM7p/vx+klikTk8WMKdXcfMJM
         vqYnPfH9INq2QH0mD1BIQ6paQ5xGbnvol07SOuMLKzVjPVaSdaVsVjkaNv3S6ehO1p
         cT3dK/BQFmSGlhBNKtLBSFKhiZlql6HT5SkBhM+2MtE2ahZR7L3xTpTlwCn/EU0oPx
         U6OPiSy8jS/JQ==
Received: by mail-lf1-f71.google.com with SMTP id h40-20020a0565123ca800b00402514d959fso3390283lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 23:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kZfxEbilwBn/d5y9NL7OpM5HcRJhMuj9iFneWlhPdsE=;
        b=R1TsqFgj2JjQ4TafqX+SZp+oLhetEIIWu2qyPd1TRT7PBQUpXKZXZHXeuOgEl1YzYk
         LgOBpR1mL1bbdjwCdVeUhxcF+8lRaltq8ZLNhUNxbFbUsTEZm/bMLmaOqn33RaGDq2K3
         YwBHAe6p5ckdFIl0hBld7/huymr0ydunsOWh6kZceeGI+IGGiZ0mL+8My13XWrvV7ybs
         wuwwogCAVzBqkBZnDdHvqxxxLQL5JYlQ4LEVrSMxXCaOaV0Zuc2XMEq09dCdvjk4xvsI
         Lp3GmjxIV4eRMdzWtPW4UPM/Op6hCHObmOd0dsIBTGQIOKmVYcEthfhNraIZMFuBJQ2z
         HNJA==
X-Gm-Message-State: AOAM532sUQrPyWvLENDTSdsAvKjXC6qeEDp9nNH5Wx1h564b4wD1x6lC
        2h4LDwgX5MVoOjv4wj6OJAH1crZ/pATgpxpqprWEq5fe+rVunrk7kE87QMIXBW4PB/IbxagFl+S
        FCzvZ8w4vdl7klgkh4fmG7PYDCcuZORnY4Ow8J27S7g==
X-Received: by 2002:a19:c352:: with SMTP id t79mr22313569lff.251.1637220988095;
        Wed, 17 Nov 2021 23:36:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQH1+8oLlBKcleLxNK3PiKENnza5x+0fbcgFpZgMxlLoO3nPht/KHHH184cH2xtFCldWHXww==
X-Received: by 2002:a19:c352:: with SMTP id t79mr22313543lff.251.1637220987859;
        Wed, 17 Nov 2021 23:36:27 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id k14sm242277lfu.210.2021.11.17.23.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 23:36:27 -0800 (PST)
Message-ID: <f5bdd108-155d-0426-77e6-841994953719@canonical.com>
Date:   Thu, 18 Nov 2021 08:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] nfc: st-nci: Fix potential buffer overflows in
 EVT_TRANSACTION
Content-Language: en-US
To:     Jordy Zomer <jordy@pwning.systems>, linux-kernel@vger.kernel.org
Cc:     wengjianfeng <wengjianfeng@yulong.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20211117171554.2731340-1-jordy@pwning.systems>
 <20211118070202.2739158-1-jordy@pwning.systems>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211118070202.2739158-1-jordy@pwning.systems>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2021 08:02, Jordy Zomer wrote:
> It appears that there are some buffer overflows in EVT_TRANSACTION.
> This happens because the length parameters that are passed to memcpy
> come directly from skb->data and are not guarded in any way.
> 
> It would be nice if someone can review and test this patch because
> I don't own the hardware :)

Thanks for your patch.
You mentioned that there are buffer overflows but you do not own the
hardware. How do you know these overflow exist? How did you detect them?

> 
> EDIT: Changed comment style and double newlines



Please add changelog after --- separators so it does not clutter the
commit log with unrelated "EDIT".

> 
> Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> ---
>  drivers/nfc/st-nci/se.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
> index 7764b1a4c3cf..8e2ac8a3d199 100644
> --- a/drivers/nfc/st-nci/se.c
> +++ b/drivers/nfc/st-nci/se.c
> @@ -335,6 +335,11 @@ static int st_nci_hci_connectivity_event_received(struct nci_dev *ndev,
>  			return -ENOMEM;
>  
>  		transaction->aid_len = skb->data[1];
> +
> +		/* Checking if the length of the AID is valid */
> +		if (transaction->aid_len > sizeof(transaction->aid))
> +			return -EINVAL;

I am thinking whether the check should be before memory allocation - to
save on useless memory allocation in case of error, but make the code
less obvious with referring to skb->data[1] twice.

> +
>  		memcpy(transaction->aid, &skb->data[2], transaction->aid_len);
>  
>  		/* Check next byte is PARAMETERS tag (82) */
> @@ -343,6 +348,16 @@ static int st_nci_hci_connectivity_event_received(struct nci_dev *ndev,
>  			return -EPROTO;
>  
>  		transaction->params_len = skb->data[transaction->aid_len + 3];
> +
> +		/*
> +		 * check if the length of the parameters is valid
> +		 * we can't use sizeof(transaction->params) because it's
> +		 * a flexible array member so we have to check if params_len
> +		 * is bigger than the space allocated for the array
> +		 */
> +		if (transaction->params_len > ((skb->len - 2) - sizeof(struct nfc_evt_transaction)))
> +			return -EINVAL;

The current comment is long and actually not explaining how you get "-2"
and sizeof, so how about:
"Total size is allocated (skb->len - 2) minus fixed array members)"

In general the code looks ok, although I cannot provide tests.


> +
>  		memcpy(transaction->params, skb->data +
>  		       transaction->aid_len + 4, transaction->params_len);
>  
> 


Best regards,
Krzysztof
