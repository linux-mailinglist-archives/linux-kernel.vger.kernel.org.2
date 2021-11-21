Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B601745856A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 18:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhKUR1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 12:27:19 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49726
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238442AbhKUR1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 12:27:19 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9AEC43F0EA
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637515452;
        bh=C44TFo8JxPdM2eUinnKvaXNLXVNdYVKAzbpzrRKKHKk=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=HJBXJGOYH42swqS8g/mg3NpapHt+iltD2TouSRbfbMDPUC++JZT6VEkGLdr7NDUkl
         VDRZM1oA19uQoyx/Mu0GOWfGSdJaLvpwVmEJzdp6yodNQXWH9LO7b3fqHEaAjknfSj
         r4MlUXzIO85jlyjaZ/45ujGbdYWanNS9VHzBqdhn2eHsYxMGeLmOg7Adsih8Z4WKIE
         KYQGVXuyYFzvher9qkSDX6lpBrZBnr3EA1cUQSVSJtQzstFTc1Dr0q0oIMnciv9X/6
         /Vy1R3fa0Bmen5T8xX0xhjSzfcnYn+pAIm5QJ60ZKGrlGlhbEFW6DQpqrZFp3ybp0F
         n3D9GPSwMu2wg==
Received: by mail-lf1-f72.google.com with SMTP id x17-20020a0565123f9100b003ff593b7c65so10361082lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 09:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C44TFo8JxPdM2eUinnKvaXNLXVNdYVKAzbpzrRKKHKk=;
        b=WGuyuWa7wuQQkfXJe7VcN9rAL0KgzUIQxWMN0yR909912Z3Z/AiOkNVLprZ02Rw/+y
         9CncwCLvx1bRi0+hG3u/5mdZ1LExRr3XG5ZpyjrD34XTQQZGlu8xvuFTB8ToNecjFk5J
         5RugmigXWC7tWgs0nsB5AhOgreB0Do2eDk8RaE6tMgvR8S5APfB6b/fKps2LeZlEd7c1
         iFrtgZNXqczactflo/XzJ6lmObaCTYflPCyQnJ8S/8jvFoPNoRL8DgdkrT0Uw2vgp2YQ
         8IT5pCddQ6erOuUf4MEalwhkSuQuKrQQQ3/FraeDkobo6FWLKMl9xGVzg+K9O1PCOeqd
         a/EA==
X-Gm-Message-State: AOAM531e6NnQhltMmM066Cpk0xsY46rXy5ycCqihebjaFR6ga3ZHKuwH
        RVDQ96uuzYeOUybf7k1zDI4Pqz/ccWqNbWs9rcChZbhkOjDv9S7tTaN3ahd2gPghM/9wuswfpYK
        aG7Bi68KW9JPrbk0aezo+W/f3CSCA1oYzVUIzFgcc2A==
X-Received: by 2002:a05:6512:150c:: with SMTP id bq12mr47862932lfb.628.1637515451552;
        Sun, 21 Nov 2021 09:24:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxA3eYwToqKzDYJiKtG9lz9teUUb/nMfDtS5bw4e8HgOIZIKfqUi4kB+gaSTJrYMCLvpv+HRg==
X-Received: by 2002:a05:6512:150c:: with SMTP id bq12mr47862915lfb.628.1637515451408;
        Sun, 21 Nov 2021 09:24:11 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o22sm699541lfu.274.2021.11.21.09.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 09:24:10 -0800 (PST)
Message-ID: <d1bbf5a0-7120-4991-0bb6-7094e238c2a3@canonical.com>
Date:   Sun, 21 Nov 2021 18:24:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 4/6] riscv: dts: sifive unmatched: Expose the FU740
 core supply regulator
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
 <5ab111e71e88d545d7f03233f10b6d84ef3d6c21.1637362542.git.plr.vincent@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <5ab111e71e88d545d7f03233f10b6d84ef3d6c21.1637362542.git.plr.vincent@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2021 23:55, Vincent Pelletier wrote:
> Provides monitoring of core voltage and current:
> tps544b20-i2c-0-1e
> Adapter: i2c-ocores
> vout1:       906.00 mV
> temp1:        -40.0°C  (high = +125.0°C, crit = +150.0°C)
> iout1:         5.06 A  (max = +20.00 A, crit max = +26.00 A)
> 
> Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> 
> ---
> Note: checkpatch.pl complains about undocumented devicetree binding,
> which is fixed by:
>   https://lore.kernel.org/linux-devicetree/20211116110207.68494-1-krzysztof.kozlowski@canonical.com/T/#u
> 
> Changes since v2:
> - Fix end-of-commit-message separator so change lists do not end up in them.
> Changes since v1:
> - Added missing "ti," prefix in compatible string.
> - Remove trailing "." on subject line.
> - Rename tree node.
> ---
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
