Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDBA445159
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 10:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhKDJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:55:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56132 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229809AbhKDJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:55:19 -0400
X-UUID: aea61afcbd5647fe98e74fb0f2433ad9-20211104
X-UUID: aea61afcbd5647fe98e74fb0f2433ad9-20211104
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1794290791; Thu, 04 Nov 2021 17:52:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 4 Nov 2021 17:52:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 4 Nov 2021 17:52:36 +0800
Message-ID: <4c3036d8181c788fbf047883e2f49172edbe3f0f.camel@mediatek.com>
Subject: Re: [RESEND, v13 2/4] dt-bindings: spmi: document binding for the
 Mediatek SPMI controller
From:   James Lo <james.lo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 4 Nov 2021 17:52:36 +0800
In-Reply-To: <1635944770.215632.1040288.nullmailer@robh.at.kernel.org>
References: <20211103081021.9917-1-james.lo@mediatek.com>
         <20211103081021.9917-3-james.lo@mediatek.com>
         <1635944770.215632.1040288.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-11-03 at 08:06 -0500, Rob Herring wrote:
> On Wed, 03 Nov 2021 16:10:19 +0800, James Lo wrote:
> > This adds documentation for the SPMI controller found on Mediatek
> > SoCs.
> > 
> > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > ---
> >  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76
> > +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-
> pmif.example.dt.yaml: spmi@10027000: reg: [[268595200, 3584],
> [268603392, 256]] is too long
> 	From schema: /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-
> pmif.example.dt.yaml: spmi@10027000: reg: [[268595200, 3584],
> [268603392, 256]] is too long
> 	From schema: /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spmi/spmi.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See 
> https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/1550144__;!!CTRNKA9wMg0ARbw!yBdAIu8sF9FdGe9H9yO19pC0PvopKz_1DwYCmY0g5pqXvOC6acHZh_NfySMb2x_n$
>  
> 
> This check can fail if there are any dependencies. The base for a
> patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up
> to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Dear Rob,

Due to [RESEND,v13,2/4] depends on [RESEND,v13,1/4],
so we local can pass yaml when apply all 4 patches,
and fail only apply [RESEND,v13,2/4] as your bot's result.

Should we merge [RESEND,v13,2/4] and [RESEND,v13,2/4] to one patch ?
Or Could your bot help to run yaml check for all 4 patches applied (one
series) ?


Many thanks

