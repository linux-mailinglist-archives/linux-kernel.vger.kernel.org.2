Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F810452F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhKPKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:40:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56816
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234115AbhKPKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:39:58 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 81D993F499
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637059020;
        bh=Rs8pRAwylSdVZbUXUVB02RWUHaE1gIerW6xLTR92IXQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=RcVR/YuRr7BZlfllK18uvvUlqsjunJKnG08LryAyj5oO0S4kNDQ8DgXhffvHKGo2Z
         Lc5RAj0GbarzYTt3x7brSHTzR5pdr+5AQDy3Bd7RHEQxtqs4IHXEev4o9gHEFWpKNm
         iNUkWb6FmMQm/2hUCLCcSo3BcgeWIs66h9QUenrX7sVZBwDkxrIjqAiQKP0M/qULlU
         Ej7PrjtIAXwwWvCCkHja53+TV+5cgFKEQGj0IF4wYP7vh8O3UygtAugO7Eo5JHxyRF
         UTe6zfoYLp7jqxoFU2hZsUEXnLeEc9u3XP4rGXeDGk3nm2jUw/6GFLKLmKMhMdHs3h
         VRHJo8ReLu/IQ==
Received: by mail-lf1-f71.google.com with SMTP id q26-20020ac2515a000000b0040adfeb8132so2167383lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rs8pRAwylSdVZbUXUVB02RWUHaE1gIerW6xLTR92IXQ=;
        b=M7OPMoYdPf3u4oOYOdjPBfKteiWELfqPy7GMxZtf9X4Zvqe29xj270HtUgfxovNVSP
         rxDL5rE8HThFHiHBh/AbNCY3c3xykguL52YV2wg7x5rIyfi7OR3f8+/H5/uS+RGHSylu
         /xM9pbrJ5LxNsShhwfk3WZzfa8O4fQGyrMgHSKBO0Invew3VyVWmA/0gCMTyoEC80iZG
         zy7QGUKQhyYp7Htx3558su8FY1EuLfeuTuaEtVQosWcpehYhZWRe9ixbJtMI0BOxU6cs
         bEInM3Vh85uAtT0iTNs06i6JaOXzixAIETkXU8DZ0iwLgDJgnzFbIBJwi9Kf9B/TBWYX
         EHIA==
X-Gm-Message-State: AOAM5309dJvaV2y6ZWqy3RduSQ9IPPa1SyMADphmHfMmYjQLe2u1u7MM
        fER1Iz3N+VcOzRkqErs94rvCSOOtNt8WQOdI1OXmoaB9DCXyv4QwdyD4C/OrS1p0AGbk/79m3Bh
        msASAgCXK8aaD7sTk8OgIwaIB4eox4n+kjSRfcvwOtw==
X-Received: by 2002:a2e:8e38:: with SMTP id r24mr5827482ljk.450.1637059020003;
        Tue, 16 Nov 2021 02:37:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI5ZHM+AIMN6ts+F4NnPm2rE+VPGifbLdwRRS/m4kJ8bR1uXC0Zpc1MJ201Ku2BEErQMkUVQ==
X-Received: by 2002:a2e:8e38:: with SMTP id r24mr5827458ljk.450.1637059019797;
        Tue, 16 Nov 2021 02:36:59 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d19sm1722714lfv.74.2021.11.16.02.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:36:59 -0800 (PST)
Message-ID: <7f5f11a0-44bf-17ee-379b-b6cf1103bf8b@canonical.com>
Date:   Tue, 16 Nov 2021 11:36:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Name gpio lines.
Content-Language: en-US
To:     Vincent Pelletier <plr.vincent@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2021 01:52, Vincent Pelletier wrote:
> Follow the pin descriptions given in the version 3 of the board schematics.
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Please do not end the subject line with a dot.


Best regards,
Krzysztof
