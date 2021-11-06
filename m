Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1AD446D41
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 10:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhKFJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 05:44:56 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34294
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233867AbhKFJoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 05:44:55 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 316833F1BD
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636191728;
        bh=oHIMF5vm63INX76yENLAXaXOgfiRcvd21upqxiMZbgA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TJ45SVBvZDwDq5whhmm0DAdiIl7N8vw1rTbf712sbtd5N9NU+7Xl2HQS5o8eB15ak
         6I7DRnxE7n5QXSpZdThlO4DBn9at0a5cZ1XFoEEZ0M6yP5WJydU8c2+hnsPddciLjC
         CJGjQVytYTtfoKD1doyxCzghqZWXXkdQWtmJuXDCiG2+9zDViZB8evcb17PTMgKwcY
         TG6J71kb6u+85GFvalOvqFErrtySjFxN3T/1t9BTFcAYgoQwyL1aK0YytAj2pJ6B2R
         C6HZM3zr/CYaIFk143G4iHuBnWKGmI88Cqf608ekPs4Idv8TGnagZ48VI4mkhSspUN
         hErO1NsyS2E3w==
Received: by mail-lj1-f199.google.com with SMTP id f6-20020a2e9e86000000b00211349f9ce3so3628265ljk.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 02:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oHIMF5vm63INX76yENLAXaXOgfiRcvd21upqxiMZbgA=;
        b=CcaErtCnrUwmKazubRqxm1MU28VMvnH4mI4LARm3qABIThNs9lF/ms2KbSUW9PDM1D
         BbFFUWp2XsRDBnFVropTjXb6X/28FJp6nwXPz0vc4AVcrCD8vE/VceWt3K0z00M4SlBy
         GD/qM08oEE+4hLT4TwcjENUu4r8rRamgI0V+uFlP8wYUZRuwGdHqeAKgO8B0FIs2gShw
         1n5GeQa80XYIQPKEGr1lare45YMU3DzkgP02NXiFRQ5CVbVZqGeAVKYiRzj3vWw9vZ29
         IwoF4G5FHgE9nkmlBsD8UqpF9UuJdAoFHGFP3vdvis4G/fXW6AqLREOcgFwVEqQ2anPp
         b9tg==
X-Gm-Message-State: AOAM5305QNztoS+6kGQ5vNMNvprkpSSMvDOA7tygKfmfgCv8rxp3Eu5y
        zOmDuh5L7Jov0+jLlGbe/THGbOcR2PO0keVPQicmsPEceUmNxeCCHm4Mc9Nd82CZ8WgJWZlea+Q
        Q7mhj20/9q+iXRK7sNq6BNdy7V+K+EnMWr9jeTYAzTA==
X-Received: by 2002:a2e:9a52:: with SMTP id k18mr1658720ljj.23.1636191727644;
        Sat, 06 Nov 2021 02:42:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSp3RAq8SoWMnQf3gGetJnhwQtF1t97foXtiyH1KVkH7SeW3r6T2n8Xhqgd4Sa7sdti2k0oA==
X-Received: by 2002:a2e:9a52:: with SMTP id k18mr1658693ljj.23.1636191727383;
        Sat, 06 Nov 2021 02:42:07 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g17sm40030lfv.157.2021.11.06.02.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Nov 2021 02:42:07 -0700 (PDT)
Message-ID: <7a67262f-c824-df23-40dd-2e54041f3ec3@canonical.com>
Date:   Sat, 6 Nov 2021 10:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] nfc: pn533: Fix double free when
 pn533_fill_fragment_skbs() fails
Content-Language: en-US
To:     Chengfeng Ye <cyeaa@connect.ust.hk>, davem@davemloft.net,
        kuba@kernel.org, wengjianfeng@yulong.com, dan.carpenter@oracle.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211105133636.31282-1-cyeaa@connect.ust.hk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211105133636.31282-1-cyeaa@connect.ust.hk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2021 14:36, Chengfeng Ye wrote:
> skb is already freed by dev_kfree_skb in pn533_fill_fragment_skbs,
> but follow error handler branch when pn533_fill_fragment_skbs()
> fails, skb is freed again, results in double free issue. Fix this
> by not free skb in error path of pn533_fill_fragment_skbs.
> 
> Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
> ---
>  drivers/nfc/pn533/pn533.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks good, thanks:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Please do not forget about fixes tag. Here it is trickier because
pn533_fill_fragment_skbs() usage was introduced in two commits:

Fixes: 963a82e07d4e ("NFC: pn533: Split large Tx frames in chunks")
Fixes: 93ad42020c2d ("NFC: pn533: Target mode Tx fragmentation support")
Cc: <stable@vger.kernel.org>

Best regards,
Krzysztof
