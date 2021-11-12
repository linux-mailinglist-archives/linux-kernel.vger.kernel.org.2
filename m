Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4610444E7DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhKLNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:51:42 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38761 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhKLNvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:51:33 -0500
Received: by mail-ot1-f46.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so13934011otj.5;
        Fri, 12 Nov 2021 05:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WQK9uphCv3UqMNHXFevGvc1TPzVvNPsEoMAOfgKyR0E=;
        b=mxBELAELn7bHw2+O9u79WIeVHhR/0Gj4Y0rR75MKg6KiRdh9L0wN92vdBUbk1/KJK0
         qKwqgHK6FGyppgu8OlY9v/QnaMjI8uQNGOOX36llx97899AnrS+1kbYE3huMBqIEgBYx
         R9MrpuooYDO1CLuH6McNOUAeuM+UHufbdMhL38g3uGPU45NmLhZQ/p5ux6ZSDyvVu7ZE
         XkHGRlhFGVzQmu0koG9Slflq0SooopWC6F0bn/QQqUmGIzOZGZtUHth6sP+Zfx0K1enF
         J2wchha4wIdi/7NL8j3B+BB1LgCeRql6iLj2y8z6Lmge+kjCWEWXODKO2aBYiLWVAxWY
         p+OA==
X-Gm-Message-State: AOAM5331Dg/e81XE1mWH4KYDKjVEk6k66Gcj1epDXqs1MhRhJ9nnlvPH
        FHgXTf8rrpux0wL6fBZgQg==
X-Google-Smtp-Source: ABdhPJyjL6RBeUcIQD1pg9YXnyVNK5PtzjG8QnbrBxrS5E8PDSYjXFchDOtLDFgVOaGFxTsy60AdCw==
X-Received: by 2002:a9d:490e:: with SMTP id e14mr12298378otf.194.1636724922259;
        Fri, 12 Nov 2021 05:48:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p62sm1296055oif.43.2021.11.12.05.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:48:41 -0800 (PST)
Received: (nullmailer pid 2463373 invoked by uid 1000);
        Fri, 12 Nov 2021 13:48:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     michal.simek@xilinx.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211112084605.230253-1-shubhrajyoti.datta@xilinx.com>
References: <20211112084605.230253-1-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v2] dt-bindings: mailbox: zynqmp_ipi: convert to yaml
Date:   Fri, 12 Nov 2021 07:48:37 -0600
Message-Id: <1636724917.148234.2463372.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 14:16:05 +0530, Shubhrajyoti Datta wrote:
> Convert the ipi doc to yaml.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2:
> Fix the warnings reported by Rob
> 
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.txt       | 127 ------------------
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  63 +++++++++
>  2 files changed, 63 insertions(+), 127 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1554211


zynqmp_ipi: '#address-cells', '#size-cells', 'mailbox@ff990400', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dt.yaml

