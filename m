Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349BE3E0968
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbhHDUdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbhHDUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:33:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521EFC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 13:33:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e5so4353213pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=9jQSxiBXPSYpBentqMXnvaUC1NOgte9Rxg3a1FtMxcw=;
        b=hcPMacNw6WfolBanCxdZGJZN/LfXdr/RCeSdcdBwAFgjwqJ+ERyixtB2YmseRY7wc7
         POjN/DXg/PCRTfT0TmhvBXMn2hjWRvP0t89+yoC+R4m2fPg+a79dAaUwSy8g6eX4n8DT
         57B+WgktPz73q0fRcWRjAYnN8urAP+yhedwkzI7LRUuFmSy1NqWC6ofiEWONs453lo9s
         vtDydrpRXqEICilI5IGgE9B5YaqROsTaQOWEnCk31feag0LSbZhvMr5wu9sdTb2uj/u7
         Oz8aph2WKKr2bY5Fi5Km1MHF2ZbzyWFzjdMDsNS4IjQ5o9ApF71pSIvxnw2zpGnfuoZp
         cecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=9jQSxiBXPSYpBentqMXnvaUC1NOgte9Rxg3a1FtMxcw=;
        b=AdpRK+rdQXO8lOcMu6acAjVNXmO8oFv1nPynOXGCD+ud6mgnLJtN3ADiklnQucq4fS
         /xGJs4wN6L50cWfbhF3iux16NQRj26fuW1EBO67IfJOHoeexjU9Zw5PbwHZ0cXasGjVo
         fni9Uuc2VpO/2rbrTV4AmzopQHuVTlYMekS1ZllZnLQEK+RO9IX6Rn1Yh19OsHfyaxJ7
         2drxb49YtWSuvU+h3Q//NX9DbE4WEljEgMnLspdgb/qpkfnE/WdSP3oJhfksR/v6HoZf
         XrLmxbYCvr3lHBkoYoU3rvVZuegC7iWiTcYrRmxE90atmh8o8CDGzAPjYRvhSABte+Nr
         vVlQ==
X-Gm-Message-State: AOAM532KNd5/jpY9GGUHvk5oIB6vkpYlp3zMBeNx4yrj+W8wSE/gTFjZ
        hOj0ZmCY0W5SwXEfPTuWn/x/N3b4pQlYYA==
X-Google-Smtp-Source: ABdhPJzLGzAMkXce7rZjO9cIkPd20NGu7qwRzflC1x3fa+aiv6t02p5ioOEgezqi0ugBfFdGI4C6kQ==
X-Received: by 2002:a17:90a:8b07:: with SMTP id y7mr11220401pjn.133.1628109200707;
        Wed, 04 Aug 2021 13:33:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i1sm3864881pfo.37.2021.08.04.13.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:33:20 -0700 (PDT)
Date:   Wed, 04 Aug 2021 13:33:20 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Aug 2021 13:23:27 PDT (-0700)
Subject:     Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
In-Reply-To: <CAEUhbmUg0DX__jSzjm1X_eCiHnkjHVXeq7CYLbW4xpydPS1G3g@mail.gmail.com>
CC:     drew@beagleboard.org, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        michael.zhu@starfivetech.com, tekkamanninja@gmail.com,
        jack.zhu@starfivetech.com, leyfoon.tan@starfivetech.com,
        geert@linux-m68k.org, kernel@esmil.dk, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bmeng.cn@gmail.com
Message-ID: <mhng-a2fd6094-0ae8-4f7b-9dee-fd71b85b29f1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 19:17:23 PDT (-0700), bmeng.cn@gmail.com wrote:
> On Tue, Jul 13, 2021 at 2:34 PM Drew Fustini <drew@beagleboard.org> wrote:
>>
>> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
>> BeagleV Starlight JH7100 board [2].
>>
>> [1] https://github.com/starfive-tech/beaglev_doc
>> [2] https://github.com/beagleboard/beaglev-starlight
>>
>> Signed-off-by: Drew Fustini <drew@beagleboard.org>
>> ---
>> v4 changes:
>> - removed JH7100 SoC revision number after discussion with Geert
>>
>> v3 changes:
>> - added revision number for the board and soc after question from Palmer
>>
>> v2 changes:
>> - removed "items:" entry that only had "const: starfive,jh7100"
>> - correct typo in Description:
>>
>> Results of running checks:
>>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
>>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
>>     CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
>>     DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
>>     SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
>>     DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
>>     CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
>>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
>>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
>>     SYNC    include/config/auto.conf.cmd
>>     UPD     include/config/kernel.release
>>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dtb
>>     DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
>>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
>>     DTC     arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
>>     CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
>>     CHECK   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
>>     CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
>>
>> The dts file is from vendor repo and is being cleaned up right now in
>> preperation for submitting to the mailing list:
>> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
>>
>>  .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
>>
>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Thanks.  This is on for-next, as Rob suggested taking it via the RISC-V 
tree.
