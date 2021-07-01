Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6493B92BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhGAOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:06:17 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:41658 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhGAOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:06:16 -0400
Received: by mail-il1-f182.google.com with SMTP id s11so5191379ilt.8;
        Thu, 01 Jul 2021 07:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bBAtbGxea4Uyvv49nbdyK4xv/8gJ5gfZXo1vPratG8A=;
        b=dTQnbTtnEJ/vh4S3MJRFpPhGJo/FMqpxK3speEo/bkf8lukIUXfpCR/CQF2hoUoM1q
         rYyI0iyL2oEiOCPI48VtNpUER2Ut5BD4BFZ8gv5mzfh5CYYrj8zxmdf/x0dYz8IBVjXQ
         Mgxk7JViQN6Owtszhf7BZq6VZb8cF8wZnmyRm2wTYCgU8p3PtuSGEmxc457iunU0M0Ed
         aUrJ8FjASSTX2IqBPxfCtBvoK3AXTAUeM+VKJhfh6GwN0k3iBpTSd+OpUyEQn+CNsjmA
         toNmQl35lsAfnVapDJXiHw4yM8+5Owtd5PLRMk1lOVU135TNyQPdU7upt+9/hi/uWD4d
         tiUg==
X-Gm-Message-State: AOAM533pwI6Bn7LrQ1z/1sVvtu209K7nkZ2HN6r6XrGGO5BzLOOspz9r
        NhGvXy0OrzJXX6CYI/I13w==
X-Google-Smtp-Source: ABdhPJyww/o4rG1Xgg5+OFNePM+PG/LX43Ff1V/MH9eSJ83/mWZ4rTI2R7sC49n3N2R3tOttPwHezQ==
X-Received: by 2002:a05:6e02:174b:: with SMTP id y11mr30453947ill.207.1625148224856;
        Thu, 01 Jul 2021 07:03:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u2sm44406ilm.19.2021.07.01.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:03:42 -0700 (PDT)
Received: (nullmailer pid 2278706 invoked by uid 1000);
        Thu, 01 Jul 2021 14:02:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh+dt@kernel.org>, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20210630132804.20436-2-chun-jie.chen@mediatek.com>
References: <20210630132804.20436-1-chun-jie.chen@mediatek.com> <20210630132804.20436-2-chun-jie.chen@mediatek.com>
Subject: Re: [v11 01/19] dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock
Date:   Thu, 01 Jul 2021 08:02:43 -0600
Message-Id: <1625148163.568657.2278705.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2021 21:27:46 +0800, Chun-Jie Chen wrote:
> This patch adds the new binding documentation for system clock
> and functional clock on Mediatek MT8192.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../arm/mediatek/mediatek,mt8192-clock.yaml   | 214 ++++++++++++++++++
>  .../mediatek/mediatek,mt8192-sys-clock.yaml   |  64 ++++++
>  2 files changed, 278 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml:18:7: [warning] wrong indentation: expected 8 but found 6 (indentation)
./Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml:19:7: [warning] wrong indentation: expected 8 but found 6 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml: properties:compatible: [{'enum': ['mediatek,mt8192-scp_adsp', 'mediatek,mt8192-imp_iic_wrap_c', 'mediatek,mt8192-audsys', 'mediatek,mt8192-imp_iic_wrap_e', 'mediatek,mt8192-imp_iic_wrap_s', 'mediatek,mt8192-imp_iic_wrap_ws', 'mediatek,mt8192-imp_iic_wrap_w', 'mediatek,mt8192-imp_iic_wrap_n', 'mediatek,mt8192-msdc_top', 'mediatek,mt8192-msdc', 'mediatek,mt8192-mfgcfg', 'mediatek,mt8192-mmsys', 'mediatek,mt8192-imgsys', 'mediatek,mt8192-imgsys2', 'mediatek,mt8192-vdecsys_soc', 'mediatek,mt8192-vdecsys', 'mediatek,mt8192-vencsys', 'mediatek,mt8192-camsys', 'mediatek,mt8192-camsys_rawa', 'mediatek,mt8192-camsys_rawb', 'mediatek,mt8192-camsys_rawc', 'mediatek,mt8192-ipesys', 'mediatek,mt8192-mdpsys']}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml: properties:compatible: [{'enum': ['mediatek,mt8192-topckgen', 'mediatek,mt8192-infracfg', 'mediatek,mt8192-pericfg', 'mediatek,mt8192-apmixedsys']}, {'const': 'syscon'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml: ignoring, error in schema: properties: compatible
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml: ignoring, error in schema: properties: compatible
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.example.dt.yaml:0:0: /example-0/syscon@10000000: failed to match any schema with compatible: ['mediatek,mt8192-topckgen', 'syscon']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.example.dt.yaml:0:0: /example-1/syscon@10001000: failed to match any schema with compatible: ['mediatek,mt8192-infracfg', 'syscon']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.example.dt.yaml:0:0: /example-2/syscon@10003000: failed to match any schema with compatible: ['mediatek,mt8192-pericfg', 'syscon']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-sys-clock.example.dt.yaml:0:0: /example-3/syscon@1000c000: failed to match any schema with compatible: ['mediatek,mt8192-apmixedsys', 'syscon']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-0/clock-controller@10720000: failed to match any schema with compatible: ['mediatek,mt8192-scp_adsp']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-1/clock-controller@11007000: failed to match any schema with compatible: ['mediatek,mt8192-imp_iic_wrap_c']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-2/clock-controller@11210000: failed to match any schema with compatible: ['mediatek,mt8192-audsys']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-3/clock-controller@11cb1000: failed to match any schema with compatible: ['mediatek,mt8192-imp_iic_wrap_e']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-4/clock-controller@11d03000: failed to match any schema with compatible: ['mediatek,mt8192-imp_iic_wrap_s']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-5/clock-controller@11d23000: failed to match any schema with compatible: ['mediatek,mt8192-imp_iic_wrap_ws']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-6/clock-controller@11e01000: failed to match any schema with compatible: ['mediatek,mt8192-imp_iic_wrap_w']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-7/clock-controller@11f02000: failed to match any schema with compatible: ['mediatek,mt8192-imp_iic_wrap_n']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-8/clock-controller@11f10000: failed to match any schema with compatible: ['mediatek,mt8192-msdc_top']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-9/clock-controller@11f60000: failed to match any schema with compatible: ['mediatek,mt8192-msdc']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-10/clock-controller@13fbf000: failed to match any schema with compatible: ['mediatek,mt8192-mfgcfg']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-11/clock-controller@14000000: failed to match any schema with compatible: ['mediatek,mt8192-mmsys']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-12/clock-controller@15020000: failed to match any schema with compatible: ['mediatek,mt8192-imgsys']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-13/clock-controller@15820000: failed to match any schema with compatible: ['mediatek,mt8192-imgsys2']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-14/clock-controller@1600f000: failed to match any schema with compatible: ['mediatek,mt8192-vdecsys_soc']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-15/clock-controller@1602f000: failed to match any schema with compatible: ['mediatek,mt8192-vdecsys']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-16/clock-controller@17000000: failed to match any schema with compatible: ['mediatek,mt8192-vencsys']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-17/clock-controller@1a000000: failed to match any schema with compatible: ['mediatek,mt8192-camsys']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-18/clock-controller@1a04f000: failed to match any schema with compatible: ['mediatek,mt8192-camsys_rawa']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-19/clock-controller@1a06f000: failed to match any schema with compatible: ['mediatek,mt8192-camsys_rawb']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-20/clock-controller@1a08f000: failed to match any schema with compatible: ['mediatek,mt8192-camsys_rawc']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-21/clock-controller@1b000000: failed to match any schema with compatible: ['mediatek,mt8192-ipesys']
Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.example.dt.yaml:0:0: /example-22/clock-controller@1f000000: failed to match any schema with compatible: ['mediatek,mt8192-mdpsys']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1498893

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

