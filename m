Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B4731452E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBIBBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhBIBBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:01:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD97D64E82;
        Tue,  9 Feb 2021 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612832424;
        bh=UDSESf14eWwyek98rHiUGI62NeiqsgkXvT/7JO82Zh4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gfmCBSDFURnGxtwgPqYhwY0MArgo4OEAiUu7c3UtPSPXw1SbENqV+aYlMJ37jcS20
         8q1Db3B4Fvwf72Hp55CYsNCegqSNRSoKUbtLJjP7+ViGhw3S3KmpTNeyAGsJxPbAm1
         b6RR07C6CNO7JJVD9O1v8CKkpZDAxdcJf7zEWoaluyUj72agSlVmPChz3WwXYZ5moV
         2/lcwLI1WP5ZwTpX0/bFY0xdCzpsiGkDM28xU8KAKiBl2Smumo1NBUQ6R+PcGsGlbi
         opopEIrY52RaFCwDYscci6Plv8FMllJ4vYM0xqmykSTClQDGG/CoP2/9rTasLFKa0f
         4heHLks0C47Xg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v6 00/22] Mediatek MT8192 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>, Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Mon, 08 Feb 2021 17:00:22 -0800
Message-ID: <161283242250.76967.15026468818750276885@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2020-12-22 05:09:25)
> This series is based on v5.10-rc1.
>=20

The DT bindings fail, can you fix and resend?

Documentation/devicetree/bindings/arm/mediatek/mediatek,msdc.yaml: 'additio=
nalProperties' is a required property
Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml: =
'additionalProperties' is a required property
Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml: 'addit=
ionalProperties' is a required property
Documentation/devicetree/bindings/arm/mediatek/mediatek,scp-adsp.yaml: 'add=
itionalProperties' is a required property
Documentation/devicetree/bindings/arm/mediatek/mediatek,msdc.yaml: ignoring=
, error in schema:
warning: no schema found in file: Documentation/devicetree/bindings/arm/med=
iatek/mediatek,msdc.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml: =
ignoring, error in schema:
warning: no schema found in file: Documentation/devicetree/bindings/arm/med=
iatek/mediatek,imp_iic_wrap.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.yaml: ignori=
ng, error in schema:
warning: no schema found in file: Documentation/devicetree/bindings/arm/med=
iatek/mediatek,mdpsys.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,scp-adsp.yaml: igno=
ring, error in schema:
warning: no schema found in file: Documentation/devicetree/bindings/arm/med=
iatek/mediatek,scp-adsp.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,msdc.example.dt.yam=
l: example-0: syscon@11f60000:reg:0: [0, 301334528, 0, 4096] is too long
        From schema: ~/.local/lib/python3.8/site-packages/dtschema/schemas/=
reg.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,msdc.example.dt.yam=
l: example-1: syscon@11f10000:reg:0: [0, 301006848, 0, 4096] is too long
        From schema: ~/.local/lib/python3.8/site-packages/dtschema/schemas/=
reg.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,mdpsys.example.dt.y=
aml: example-0: syscon@1f000000:reg:0: [0, 520093696, 0, 4096] is too long
        From schema: ~/.local/lib/python3.8/site-packages/dtschema/schemas/=
reg.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.exampl=
e.dt.yaml: example-0: syscon@11007000:reg:0: [0, 285241344, 0, 4096] is too=
 long
        From schema: ~/.local/lib/python3.8/site-packages/dtschema/schemas/=
reg.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.exampl=
e.dt.yaml: example-1: syscon@11cb1000:reg:0: [0, 298520576, 0, 4096] is too=
 long
        From schema: ~/.local/lib/python3.8/site-packages/dtschema/schemas/=
reg.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.exampl=
e.dt.yaml: example-2: syscon@11d03000:reg:0: [0, 298856448, 0, 4096] is too=
 long
        From schema: ~/.local/lib/python3.8/site-packages/dtschema/schemas/=
reg.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.exampl=
e.dt.yaml: example-3: syscon@11d23000:reg:0: [0, 298987520, 0, 4096] is too=
 long
        From schema: ~/.local/lib/python3.8/site-packages/dtschema/schemas/=
reg.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.exampl=
e.dt.yaml: example-4: syscon@11e01000:reg:0: [0, 299896832, 0, 4096] is too=
 long
        From schema: ~/.local/lib/python3.8/site-packages/dtschema/schemas/=
reg.yaml
Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.exampl=
e.dt.yaml: example-5: syscon@11f02000:reg:0: [0, 300949504, 0, 4096] is too=
 long
        From schema: ~/.local/lib/python3.8/site-packages/dtschema/schemas/=
reg.yaml
