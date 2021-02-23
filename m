Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28E32317C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhBWTfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:35:00 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46617 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhBWTey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:34:54 -0500
Received: by mail-oi1-f179.google.com with SMTP id f3so18812138oiw.13;
        Tue, 23 Feb 2021 11:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Jd0iJwzzoy2OV01YxLUppnxWSo+h7hTXkFr7aHmltkk=;
        b=IEDQbE4qPCLyKDZSeq8Mvld04gQbVnrZSonBfeTM1MgqLNEI6hK/wddNk9LQPCvBI6
         lxnOltQPxLM24qTvoB0b8r2yrIKoztEQ9qCyiBzDOUjsD1qwEMVh/A5vwKmh5xNwIKXK
         ykTlNXblVD3HKYtTd9sbqcf6GUoe9B/uge8T6RiJe3eBqP9I4MrVyKJhgjV7uO0THO9y
         Zv8o7h25YIvk5eTISQmDEfem6k6rENPCtOCWy2qDZhF4VbgPEUEPTgC/YRAvlXsTaSXQ
         YLMdyxTBYCRq0xHntd7DpXqiAEwRExeSbe0LI5ePkqOEVPkKL1JnBuLcit/wKLDU/ha/
         b/sw==
X-Gm-Message-State: AOAM533hYw5HiBjUTCbv/gDSso1s+6FrE5e8IgUV9K0mf6bHuqeIbTQ9
        qe/yHkBkMjLmvw0QVbWQ78EJcyw1Og==
X-Google-Smtp-Source: ABdhPJy1jssNdKq9KMlLx33dO0mbsh9DPwl9N6mfsOaL+GaoxMUl57imtSClS4z55ss1nOpkGacR2g==
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr257519oik.150.1614108852913;
        Tue, 23 Feb 2021 11:34:12 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q25sm4528236ota.16.2021.02.23.11.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:34:11 -0800 (PST)
Received: (nullmailer pid 4116104 invoked by uid 1000);
        Tue, 23 Feb 2021 19:34:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     soc@kernel.org, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, w@1wt.eu,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20210223061830.1913700-2-daniel@0x0f.com>
References: <20210223061830.1913700-1-daniel@0x0f.com> <20210223061830.1913700-2-daniel@0x0f.com>
Subject: Re: [PATCH 1/8] dt-bindings: clk: mstar msc313 cpupll binding description
Date:   Tue, 23 Feb 2021 13:34:10 -0600
Message-Id: <1614108850.540354.4116103.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 15:18:23 +0900, Daniel Palmer wrote:
> Add a binding description for the MStar/SigmaStar CPU PLL block.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../bindings/clock/mstar,msc313-cpupll.yaml   | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.example.dts:19:18: fatal error: dt-bindings/clock/mstar-msc313-mpll.h: No such file or directory
   19 |         #include <dt-bindings/clock/mstar-msc313-mpll.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1443402

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

