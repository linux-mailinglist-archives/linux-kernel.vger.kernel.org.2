Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA7452FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhKPLIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:08:07 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42494
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234740AbhKPLH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:07:26 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7A0493F1AD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637060667;
        bh=bd/U/oRwjQmdvpZocDSS6S8UbyaPfaAFv6cbOhCrjwk=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=lhJzfvve+52ddVzNah2DKS4ZqG775igkvfgKtHZaqEVBnWDyfxabXJl3l45b6wSeY
         rbl/RHnACejr1Nb31WjRuXQ6TSCcMnaitN3/yCdCg+ThiMc5c6k6nqNW3R0EBbwEnj
         quhR3xGrcvNdP4So2vYs8s+39+o3Fp07graFpM/EYlz4Cr6brfgxzl8FlARnsCJe1R
         1Gxo51YNm+WPRucnuMVTjAbnDJ3gjj4Y/eRceyuqVkiDF/NRdioQfcON3T8ybYUo2H
         1N4I3mfiy3pYQzwebnMLZMsf47nTd9+T1Ig1qalnwvZtsZP1ZmN9rvOG+Syghnc5zR
         TjnhKV466/w9A==
Received: by mail-lf1-f69.google.com with SMTP id x17-20020a0565123f9100b003ff593b7c65so8056923lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bd/U/oRwjQmdvpZocDSS6S8UbyaPfaAFv6cbOhCrjwk=;
        b=QPKyDzEtRsT6QzF7RnfpPMaRc/b3Nu+s1rkXUt00hdqvnlzAMd1YLTAuA8XhL7/P5f
         q5/wqC4ltTXrHdzUFM9EggwkmkPzP02eeYUi3m3t5Ywj9wNERA1fF6/ONw/NTMjfa+aa
         y7IpUMHbNSvBQEcu5kQXhU7jirBDhDJe5jAm91bXI1Qqtm3KAi2Ple6y9Lu1Zjve8uMJ
         xhdHFdmVGfKM6fyJUo3NZgZk8x9DKXJsXi2Hex0XDt6kIwX1tnpIF5ioaUKS1UqqEU93
         kJcKqP01quDiId+a0SKaq6ClehC2wOBXOtDkGvrMfasKRL210reGzjvBhVpS7hkp9HYm
         GzCw==
X-Gm-Message-State: AOAM533U2Po8zRqOLP7qt0+x4J2KMXMfEAcY0izuXldLSAjoGl78XJ+K
        f/1vtHXv4fmsXM3bPrDp8rlLPkiMdBAfIrKCEX6gDb915DOOYZouCRqmaOlhcIxOVTRoeZCj6B+
        wlKry0g+TIHtG26c6jdq4E7ntJ9JBfYJL4itiGckBRw==
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr6002333ljj.506.1637060666823;
        Tue, 16 Nov 2021 03:04:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3ZYxUSFJRJ5iP/OKHvrIDa1zcy8UEUVBHT/gsOdQTDQkeqm/SrTdZ4qxtY7sZdQaUPhlyxA==
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr6002284ljj.506.1637060666538;
        Tue, 16 Nov 2021 03:04:26 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id b22sm1915106lfv.20.2021.11.16.03.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:04:26 -0800 (PST)
Message-ID: <842021c3-b199-8917-6354-93b396c2541a@canonical.com>
Date:   Tue, 16 Nov 2021 12:04:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Link the tmp451 with its
 power supply.
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
 <d04daf5956ad61496188c7aee3d2eb958e34d7d2.1637023980.git.plr.vincent@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <d04daf5956ad61496188c7aee3d2eb958e34d7d2.1637023980.git.plr.vincent@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2021 01:53, Vincent Pelletier wrote:
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

This needs commit description, explaining what are you doing and why.

> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index bd6e90288c8a..73c1e4adf650 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -59,6 +59,7 @@ tps544b20@1e {
>  	temperature-sensor@4c {
>  		compatible = "ti,tmp451";
>  		reg = <0x4c>;
> +		vcc-supply = <&vdd_bpro>;
>  		interrupt-parent = <&gpio>;
>  		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
>  	};
> 


Best regards,
Krzysztof
