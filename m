Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EB5406A62
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhIJKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 06:53:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52112 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232415AbhIJKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:53:36 -0400
X-UUID: 7afaeee5e7e64cec9ab4614b76c303e0-20210910
X-UUID: 7afaeee5e7e64cec9ab4614b76c303e0-20210910
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1730091123; Fri, 10 Sep 2021 18:52:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Sep 2021 18:52:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Sep 2021 18:52:21 +0800
Message-ID: <3b21154346c0a36868fb5e9ac187379be97a69c1.camel@mediatek.com>
Subject: Re: [v2 11/24] clk: mediatek: Add MT8195 ccusys clock support
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        "Devicetree List" <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 10 Sep 2021 18:52:21 +0800
In-Reply-To: <CAGXv+5EMoZq8BohUA_OoChmEdHL988pphxUJX077hO88htRUtA@mail.gmail.com>
References: <20210820111504.350-1-chun-jie.chen@mediatek.com>
         <20210820111504.350-12-chun-jie.chen@mediatek.com>
         <CAGXv+5EMoZq8BohUA_OoChmEdHL988pphxUJX077hO88htRUtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-23 at 20:13 +0800, Chen-Yu Tsai wrote:
> On Fri, Aug 20, 2021 at 7:23 PM Chun-Jie Chen
> <chun-jie.chen@mediatek.com> wrote:
> > 
> > Add MT8195 ccusys clock controller which provides clock gate
> > control in Camera Computing Unit.
> 
> Could you offer a bit more explanation about this unit? Is it an ISP?
> Or some other function that does computation on images?
> 

CCU could access ISP HW control register and could be used for ISP
pipeline control. The use case is like secure camera or doing post-
processing on ISP statistic data.

Thanks!
Best Regards,
Chun-Jie

> > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/clk/mediatek/Makefile         |  3 +-
> >  drivers/clk/mediatek/clk-mt8195-ccu.c | 50
> > +++++++++++++++++++++++++++
> >  2 files changed, 52 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/clk/mediatek/clk-mt8195-ccu.c
> > 
> > diff --git a/drivers/clk/mediatek/Makefile
> > b/drivers/clk/mediatek/Makefile
> > index 718bbb04191b..03fb020834f3 100644
> > --- a/drivers/clk/mediatek/Makefile
> > +++ b/drivers/clk/mediatek/Makefile
> > @@ -80,6 +80,7 @@ obj-$(CONFIG_COMMON_CLK_MT8192_MSDC) += clk-
> > mt8192-msdc.o
> >  obj-$(CONFIG_COMMON_CLK_MT8192_SCP_ADSP) += clk-mt8192-scp_adsp.o
> >  obj-$(CONFIG_COMMON_CLK_MT8192_VDECSYS) += clk-mt8192-vdec.o
> >  obj-$(CONFIG_COMMON_CLK_MT8192_VENCSYS) += clk-mt8192-venc.o
> > -obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-
> > mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o clk-
> > mt8195-cam.o
> > +obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-
> > mt8195-topckgen.o clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o clk-
> > mt8195-cam.o \
> > +                                       clk-mt8195-ccu.o
> 
> When wrapping, please align with previous line. "clk-mt8195-ccu.o"
> should
> align with "clk-mt8195-apmixedsys.o".
> 
> 
> ChenYu

