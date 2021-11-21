Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C28B458571
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbhKUR2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:28:20 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33168
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236367AbhKUR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:28:10 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 01EF73F1B0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637515504;
        bh=kZq5pPsma0owINBv5hr75ENNQJHBAu3bptY+ZTWWILM=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=DkrOKqkCgqPe8G+3/RueiefdRcI3DazxJIdMq9Mzp/gnG6pYn/Jw5yaKlgkhaGPoh
         uwJEa9BCnP2x3W2QBGk/nq9mmpnZe5vvmehA9J2hAK36kCAAwt8C4SthKLO2BjKjR0
         KDWCZV5yDZyVH0dqiQKGLkvc+Bbn7TGaRAa5sKkI2vPTwDPkQVaVENV8jofE4TPevE
         bw8aOKSIhBmsztKfdJi5Q1eNcPtGuLtsR4D5gL82c482qUELrTOBx7SlZEOIrjlLzu
         yolUTEtOaW3yLFLNt8TD23yxNb118EL1LH39Eucj5wXL9aJi6ufBe30SZODQmu/EJb
         Tg2wr0JVurdmg==
Received: by mail-lf1-f69.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso10302180lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kZq5pPsma0owINBv5hr75ENNQJHBAu3bptY+ZTWWILM=;
        b=Ygm/kmJ8frZjLx4MjyYMOuux9FKrBhaWaRjCbERmY44AX026Xz6QVjznuYiGj4eJq2
         4McaXEd5f//BHK1EFFsLCxfbCDSe8+YGtNZYUFyHtlzOiGHoxQPBQkpV5Yux3/soBpZ4
         NHO+o7hxSVGvf+o8pVrpzl/oNLRgI8UbGEsAiafG9HCREhEavA5Sp1qGJgmlh+wovmov
         UCbSxUNzzHN0LyV0TCwkneOajSJm8pTgQui19Bs0AlQQ8XcPkWx1+pDmEQCKFdr/4D7b
         tUqKL81TxGmdUd8kBn/6HyGdVsaLLsfKm7nG/TLwrpvb6+M4PKa5rmjp5FQaNlH+yVuC
         xCuQ==
X-Gm-Message-State: AOAM530xEcPvX4enkLiRtGEdNV67X9z8ZtrhgGpqmBC2+aSdRkilEO8l
        XcirWphJ309eEzmMO1PBKun6d6HmMTwK3xGwAB2fsPI6q+bY1agfirCT2zrYogRcmGvZW0olTse
        av2rc1bsyggx+DOddHQypdnFi/hHPCzE5ZVPBtyg0GA==
X-Received: by 2002:a05:651c:1548:: with SMTP id y8mr45618977ljp.458.1637515503066;
        Sun, 21 Nov 2021 09:25:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2f8OnhQj9sQ62rbV2mdM7eBIr9lOMtV63HTcWuDmQo4H5u0BxfwIDpl7Rc0NkZyH5hM5VIw==
X-Received: by 2002:a05:651c:1548:: with SMTP id y8mr45618947ljp.458.1637515502822;
        Sun, 21 Nov 2021 09:25:02 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id c1sm633211ljr.111.2021.11.21.09.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 09:25:02 -0800 (PST)
Message-ID: <3b627657-b2ed-13bd-f97e-363cc734da00@canonical.com>
Date:   Sun, 21 Nov 2021 18:25:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 6/6] riscv: dts: sifive unmatched: Link the tmp451 with
 its power supply
Content-Language: en-US
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
References: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
 <ab42d60d325249d805d99db1c3981dd1fe9422eb.1637362542.git.plr.vincent@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <ab42d60d325249d805d99db1c3981dd1fe9422eb.1637362542.git.plr.vincent@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2021 23:55, Vincent Pelletier wrote:
> Fixes the following probe warning:
>   lm90 0-004c: Looking up vcc-supply from device tree
>   lm90 0-004c: Looking up vcc-supply property in node /soc/i2c@10030000/temperature-sensor@4c failed
>   lm90 0-004c: supply vcc not found, using dummy regulator
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> 
> ---
> Changes since v2:
> - Fix end-of-commit-message separator so change lists do not end up in them.
> Changes since v1:
> - Remove trailing "." on subject line.
> - Added a commit description.
> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 1 +
>  1 file changed, 1 insertion(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
