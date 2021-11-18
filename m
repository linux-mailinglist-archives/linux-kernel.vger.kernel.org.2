Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80C04554CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhKRGaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:30:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52252 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243110AbhKRGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:30:45 -0500
X-UUID: 8b122f3c11a24095ae91710fff52edce-20211118
X-UUID: 8b122f3c11a24095ae91710fff52edce-20211118
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <james.lo@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1474894681; Thu, 18 Nov 2021 14:27:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 18 Nov 2021 14:27:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Nov 2021 14:27:40 +0800
Message-ID: <f4a008ef426eacc7ec13b8f30e12d6cddc79536e.camel@mediatek.com>
Subject: Re: [PATCH v15 2/4] dt-bindings: spmi: document binding for the
 Mediatek SPMI controller
From:   James Lo <james.lo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>
Date:   Thu, 18 Nov 2021 14:27:37 +0800
In-Reply-To: <1636983755.172933.595907.nullmailer@robh.at.kernel.org>
References: <20211115042030.30293-1-james.lo@mediatek.com>
         <20211115042030.30293-3-james.lo@mediatek.com>
         <1636983755.172933.595907.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-15 at 07:42 -0600, Rob Herring wrote:
> On Mon, 15 Nov 2021 12:20:28 +0800, James Lo wrote:
> > This adds documentation for the SPMI controller found on Mediatek
> > SoCs.
> > 
> > Signed-off-by: James Lo <james.lo@mediatek.com>
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
> review/Documentation/devicetree/bindings/spmi/spmi.yaml
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-
> pmif.example.dt.yaml: spmi@10027000: reg: [[268595200, 3584],
> [268603392, 256]] is too long
> 	From schema: /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See 
> https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/1555114__;!!CTRNKA9wMg0ARbw!0y2jw2KWA7dbbFP4B9bbycyT0PxWYrQ0KAUovVW46dRLqIfXI2maZrfVt1KSWIC1$
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

Due to [2/4] depends on [1/4], 

Can I only send [1/4] first ?

(After [1/4] is approved, and I will send [2/4][3/4][4/4] as V16.)

Or, could you please give us other suggestion ?

Many thanks

