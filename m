Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA819429261
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbhJKOow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:44:52 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59844
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241978AbhJKOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:44:18 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C36A63FFF0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633963337;
        bh=AoXkKdPc50NjSPLw27+j/N8Av0BiVK6rZpmczmLnEM0=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=UNgdrKHzV7Zdkzkgye4GHtI5vqwBGftSFBT1Cbd+xwpvSPSDS1ebTWQta5JwDFzH5
         SSGm8ZEZ0NbaS7gmSate7Tl0LJW/nLHYYX4EdaJK6mqK1H/SRzjVhm036ITOnGG2hM
         ONq0I0xDIeHRX77pVSiGShAamAyFzhtqD4twuHomWRE1gPQ5jocv6z4JbZ/4Hm2m3W
         tCSHVBIhDsOmuKD2zkrBcVFFfFc6jfakVQi0gw+33NOn251pGUMQOFM7/epRibWkRp
         c+fJFCMlmi5MdiEmyF/Q8mCVU8YmkjNkUObodSBs6i07C5K3yJrLAYBPZ7WLIWC22L
         49Pc1za/UJBLA==
Received: by mail-lf1-f69.google.com with SMTP id d2-20020a0565123d0200b003fd6a0a5403so8570967lfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AoXkKdPc50NjSPLw27+j/N8Av0BiVK6rZpmczmLnEM0=;
        b=AHHzp3tZBPzd04D1UZwGrN4iTRwZ2c8kkCmwMUyUSzuyXzNPs695ADkYNAlEiHjH9J
         H4MuaD7WZeWVguTZFkillz3XjadYvKhL3zeSu51en1LBsMfb88yY8Jydjy69kPCVWTDl
         QYQrZamN3K24JOc3vjsUg4whfnJzLH+liZZmO3ctkIGqo0AnhNzF92tUiVE9/qQVYblk
         2KzV/PMh2JUFvTXZdgVnssCqI1Jy5W/8nmZYjEAz23RpeL6V8PAxrOI6z6reTastfszC
         UcpyVZWfNLKN80pdc4RmMbdwks8zUmpowzsz/Ml2Iv3qFRRvWyitD4ATFWVBQzwt6Jh2
         GzRA==
X-Gm-Message-State: AOAM5338X4YRSSnzFuuBoheRE7xxTlB2sUmGEqgZrps8Hiup4qUOKEr8
        kO0DtWyL+TsBXCeNSmz6UKqpS4MboWt9c47UNkm8zUrY7meJaJ+c2VcKJIciNuzvG2X6EipUSuu
        ruWUDHyWAewgUjhhOj9mDdCAN4yiGaXLYf+D6RvsBGQ==
X-Received: by 2002:a05:6512:2143:: with SMTP id s3mr3975446lfr.451.1633963336891;
        Mon, 11 Oct 2021 07:42:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6C5CiMHBYXhStZdUpN9ywy+Iz1BO+sH+SuCmHSgG0aTeSfmV0rE0BIJ5Bf4A/wVV1ffC7gw==
X-Received: by 2002:a05:6512:2143:: with SMTP id s3mr3975418lfr.451.1633963336668;
        Mon, 11 Oct 2021 07:42:16 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r14sm750676lfe.13.2021.10.11.07.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 07:42:16 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 2/5] riscv: dts: sifive: fix Unleashed board
 compatible
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
 <20210920130248.145058-2-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <bd0e7803-c234-6cc8-ae08-c3af255fa638@canonical.com>
Date:   Mon, 11 Oct 2021 16:42:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920130248.145058-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 15:02, Krzysztof Kozlowski wrote:
> Add missing sifive,fu540 compatible to fix dtbs_check warnings:
> 
>   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml: /: compatible: 'oneOf' conditional failed, one must be fixed:
>   ['sifive,hifive-unleashed-a00', 'sifive,fu540-c000'] is too short
>   'sifive,hifive-unleashed-a00' is not one of ['sifive,hifive-unmatched-a00']
>   'sifive,fu740-c000' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Anyone maintains RISC-V boards? I got no replies for the first patch,
then for the second version and finally for the resend.

If no one is interested, I'll pick it up.

Best regards,
Krzysztof
