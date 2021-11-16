Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF89452F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhKPKri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:47:38 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41972
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234039AbhKPKrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:47:37 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E01193FFE6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637059479;
        bh=HNvZ1tf4tqT4mDgVZbm+N3k8Io7A/bebwGQCK1l5BZ0=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=vTDiw06NhQZHs2H6DaBOTGe9FxhW0VlB9VdPJ+BA0Vvr4RZX6aZ6eJF5/e00k77Df
         H3p2z+VzIwDrcrvQ6BsgzR9paSioLmbf0MheBeaizr04PhwAJE6kMsez8O49x6LEob
         07wrZrloDUXkaFsqZwkItuD2469tfGSr8k+hNikdd30D7VSVFCgbjGjYAse5ol9C5g
         NuhGvyKg7F/sQtkMjaBHWlSx5YlPqMMCxnozjWEF4jUFmI7QhYV0dhVnc/kIEoc6Ll
         NckywGSpAkIGhlH/QSGwskJ4BC8+w/XHSUfsXJInWanq4qAqrEGArJ2+M11YOYknpV
         khpLA1LQLKd3g==
Received: by mail-lf1-f70.google.com with SMTP id z1-20020a056512308100b003ff78e6402bso7989642lfd.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HNvZ1tf4tqT4mDgVZbm+N3k8Io7A/bebwGQCK1l5BZ0=;
        b=eawVYAsVulqpSKA6gESrtyDCpfw0jc//o4m1y5+RJ0jreUgCWUPdLfEk1nwWibXpS4
         rqs7P7ZRJGp6pIL/t52x4x78IHQCesWsG+aYGjWJrTqUfr5cZHOmc3dyGh2ZnC7YpRe3
         pcgjhr8sc4kveFKQtk19ovND63JTHtP7hK8o6XyiPHv/IXaYZisIlQD6Ostt2iYI+F/Z
         Zmvz6jxkgJUXyR5If3qJ16fEJM2gWKDQGaNcm7G9ZlHw5by1WFhXySKT9FUmx8qLjihO
         27myka/pxPJ7RuT1JTy6UgMXAwqDYm2lHMkGBf85eYdQYN9dB9GK5QmAEVb/dhWxFNeg
         /89Q==
X-Gm-Message-State: AOAM530g+FUhSxHOgXTGagTrTa1bztA632dRojhAMONlVo+GSdFcjVbL
        JJmGVPrMAM3jd6XCCdTV481TU5yz1FhR0NWmnKy2MplkGSJUE3rM8FFbpPMZW+nN4djRA4T1ppB
        EZUeWJOD5L5h1xlrIw5kxoWFcCXrV7v9aVBYHivPJag==
X-Received: by 2002:a05:651c:1506:: with SMTP id e6mr6017418ljf.41.1637059479357;
        Tue, 16 Nov 2021 02:44:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyD2/brVwmP+fxPjmH64gkeCFja1QsZELxsviHR6oPBbUhLXYbkGo8De6w06v59AluCYYjESw==
X-Received: by 2002:a05:651c:1506:: with SMTP id e6mr6017398ljf.41.1637059479149;
        Tue, 16 Nov 2021 02:44:39 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id e19sm1782137ljn.82.2021.11.16.02.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:44:38 -0800 (PST)
Message-ID: <886518b4-de22-2443-286d-8135eeaa2ad1@canonical.com>
Date:   Tue, 16 Nov 2021 11:44:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Expose the FU740 core
 supply regulator.
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
 <0879c5b0c72b9bf6bf71f880def166f8804f41c7.1637023980.git.plr.vincent@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <0879c5b0c72b9bf6bf71f880def166f8804f41c7.1637023980.git.plr.vincent@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2021 01:52, Vincent Pelletier wrote:
> Provides monitoring of core voltage and current:
> tps544b20-i2c-0-1e
> Adapter: i2c-ocores
> vout1:       906.00 mV
> temp1:        -40.0°C  (high = +125.0°C, crit = +150.0°C)
> iout1:         5.06 A  (max = +20.00 A, crit max = +26.00 A)
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> 
> --
> Note for review: this patch has one warning from checkpatch.pl:
>   WARNING: DT compatible string "tps544b20" appears un-documented -- check ./Documentation/devicetree/bindings/
>   #32: FILE: arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts:55:
>   +               compatible = "tps544b20";
> This chip is handled by the existing pmbus module, and there is indeed no
> matching entry in Documentation/devicetree/bindings/hwmon/pmbus. I am not
> especially knowledgeable about this chip, I only know it is used by this
> board, so I am not sure I can do the best job in putting such a file
> together.
> If needed I can git it a try.

It's not required. I can try adding it.

> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 270360b258b7..e327831d0d48 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -51,6 +51,11 @@ &uart1 {
>  &i2c0 {
>  	status = "okay";
>  
> +	tps544b20@1e {

Node name should be a generic class of a device. This is a DC-DC
converter, so I suppose we should name it "regulator"?

> +		compatible = "tps544b20";
> +		reg = <0x1e>;
> +	};
> +
>  	temperature-sensor@4c {
>  		compatible = "ti,tmp451";
>  		reg = <0x4c>;
> 


Best regards,
Krzysztof
