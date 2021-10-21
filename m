Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E347435DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhJUJXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:23:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44312
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231153AbhJUJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:23:41 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 097333FFE2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634808085;
        bh=1sNRxX5xVMTzDEASC0BUbYbJBe1HHP47v7+0z03lnfo=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=YneWpf1ep//udN5NfAwLI9N1f2xIdS8J2nOI0VTGtq9khVQ0vSxh5dGbMXV13A5Gx
         9S8FehcKqacgTfUlXELIcWKgyA/caJsG8DPDxwG6kagfjEMXDuISHXO5eAFbyL+E4T
         QJCGHBDSbG0aJPpRphHZzVAv0xTGdMA6Ai410Qdrd6BCH5gCjJ2xUXWPlOJg7MTkLk
         Ktx46rglhSFeTbsGw5aG2+lEps9oMPvflnvDym8mjEQW0A5dQgM9kCuKei0xTX0gTn
         Qs4Rk/8XXcf/XNFuUV9cJJRPwzvvS54j+HnBvoCZIyzZo/uS14qVECTRQV7+HkRM7q
         rj/YLvgQ5bI+A==
Received: by mail-lf1-f70.google.com with SMTP id m16-20020a056512115000b003fdb79f743fso4393707lfg.16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1sNRxX5xVMTzDEASC0BUbYbJBe1HHP47v7+0z03lnfo=;
        b=2edQfAbcIIz0impq8pWQpOJP8ANgRIbKj9I1fR3N6gXihuiH3/RC5bN1X/tQ7OVyUS
         rTwgQdjf514VX1MLSTksRkZDoCktF7P3PJkVAmzuMWuTRPTcG9IfHISTO7KL4o5Ex9UW
         598IEhph0ZVjOYFf3hC59zDw6Bdv6o1uSwuqKwstwuWFYjqRD9shhe6udAivNfsnHBxj
         PxZr460erICj6arKCz/2bVR4HO/W2oMn/+AniaEAk5vIrfNS9Oyqn0ie6cxyu/aL3XKO
         gI7Q1l/8jfCobkLlZ4I2zWyasI6OWMkEFO6BYoZ+I7qnmGJnDOBqTVSnD0PUSPyyu8/4
         hd2Q==
X-Gm-Message-State: AOAM5328eBeYYMUEU9BxL+Eu7L00GbPAY6fovJQPr4uoiuTzu2J/vy9V
        AWR/rnHwRf4WS570UApVZ0KZtNSy8hiPmqDrOXQ1eQJVG9X9V4YQeOJeZXtQ2U1ayVpihwRc/H5
        8z5LL2BsOL29BNwGtszBu9E5VUI4iXT4og9DCj9uIZA==
X-Received: by 2002:a05:6512:3191:: with SMTP id i17mr4275619lfe.485.1634808084546;
        Thu, 21 Oct 2021 02:21:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTR7ZwqF7Ps9LYNUTgrRaJOZAqjlnwW/OzBDYFs9a7D6ppfeTaGTCufWcfkbF8WyTuRBmdmw==
X-Received: by 2002:a05:6512:3191:: with SMTP id i17mr4275606lfe.485.1634808084404;
        Thu, 21 Oct 2021 02:21:24 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bq8sm413345lfb.32.2021.10.21.02.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 02:21:23 -0700 (PDT)
Subject: Re: [PATCH] memory: mtk-smi: Use ARRAY_SIZE to define
 MTK_SMI_CLK_NR_MAX
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     yong.wu@mediatek.com, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211015151557.510726-1-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b6090131-9098-4a9a-7dfa-ba7eae977558@canonical.com>
Date:   Thu, 21 Oct 2021 11:21:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015151557.510726-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2021 17:15, AngeloGioacchino Del Regno wrote:
> This definition is tied to the number of SMI common clocks (the array
> mtk_smi_common_clks): improve the definition by using the ARRAY_SIZE
> macro instead. That will also reduce room for mistakes when updating
> the aforementioned array in the future.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/memory/mtk-smi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Thanks for the patch. I sent mtk-smi pull request some time ago and it
is late in the cycle, so this might need to wait for next cycle. I'll
keep it in my queue.

Best regards,
Krzysztof
