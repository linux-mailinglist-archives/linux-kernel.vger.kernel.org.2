Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EA0331507
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCHRjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:39:39 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:46918 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCHRjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:39:35 -0500
Received: by mail-io1-f43.google.com with SMTP id u8so10781980ior.13;
        Mon, 08 Mar 2021 09:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QV/gGUWQlfatQCF8Amei4pxhyh/mjamw4c8youDtPsU=;
        b=RH+6koNZHqTA3IcP/kAG41p5IeeH+r4mw7YhwD2uKR0p5e7UnngHI6TniNFeW0XRkJ
         fR1FoNcBHcaIe/Q19K1UDPYxEa6FBie6nQ/46InLF1h9STgk55vIDk5IDVYCOiNBbz5G
         soHHdOYGBVHYLuFM/NOxLQINIPaGBEuXSNE0XhYDmYueu9V0E+QUfnbwQM7nLTfJNzCa
         WQRrBpthpWIUFKnhSPSIeovwAx3zCMd2wPs4nhlHLqb3srsFFUC5eDR4ALQ5qkuRZZfV
         MTftDse+ntIBdMkhqL7UL8dSpL/f3sdMTgRL0TrVV2kYbltwsZk0tsEauXMNuNBHRZA3
         EwQg==
X-Gm-Message-State: AOAM530pGytupbObG6Zh9ZUeag581AZhzWARDbf/7yTBtkORyeqr5ghY
        Tx0pXv0TXjf0619Xji7Q/w==
X-Google-Smtp-Source: ABdhPJwW9JRZb2wJgXTvWrzN5HCjz5CVjkiSnJK3Lp9/1Ng3/IHt59S5AG7r9xHXGUAG56GAkyd3BQ==
X-Received: by 2002:a5d:9e18:: with SMTP id h24mr10253715ioh.80.1615225174595;
        Mon, 08 Mar 2021 09:39:34 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j17sm6354375iok.37.2021.03.08.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:39:33 -0800 (PST)
Received: (nullmailer pid 2679600 invoked by uid 1000);
        Mon, 08 Mar 2021 17:39:32 -0000
Date:   Mon, 8 Mar 2021 10:39:32 -0700
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings/timer: ingenic: Add compatible strings
 for JZ4760(B)
Message-ID: <20210308173932.GA2679461@robh.at.kernel.org>
References: <20210307171553.72591-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307171553.72591-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Mar 2021 17:15:51 +0000, Paul Cercueil wrote:
> Add compatible strings to support the system timer, clocksource, OST,
> watchdog and PWM blocks of the JZ4760 and JZ4760B SoCs.
> 
> Newer SoCs which behave like the JZ4760 or JZ4760B now see their
> compatible string require a fallback compatible string that corresponds
> to one of these two SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/timer/ingenic,tcu.yaml           | 28 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/timer/ingenic,tcu.yaml:62:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/timer/ingenic,tcu.yaml:201:17: [warning] wrong indentation: expected 18 but found 16 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/ingenic,tcu.example.dt.yaml: timer@10002000: timer@e0:compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4770-ost'] is too short
	'ingenic,jz4770-ost' is not one of ['ingenic,jz4725b-ost', 'ingenic,jz4760b-ost']
	'ingenic,jz4760-ost' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml

See https://patchwork.ozlabs.org/patch/1448709

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
