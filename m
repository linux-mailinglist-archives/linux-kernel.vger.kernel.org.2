Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CA372899
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhEDKQw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 May 2021 06:16:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34656 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEDKQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:16:51 -0400
Received: from chickenburger.collabora.co.uk (chickenburger.collabora.co.uk [46.235.227.242])
        by bhuna.collabora.co.uk (Postfix) with ESMTP id ED5DA1F42458;
        Tue,  4 May 2021 11:15:54 +0100 (BST)
From:   "Ezequiel Garcia" <ezequiel.garcia@collabora.com>
In-Reply-To: <20210501013448.GA4001859@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 190.2.109.197
Date:   Tue, 04 May 2021 11:15:54 +0100
Cc:     "Benjamin Gaignard" <benjamin.gaignard@collabora.com>,
        joro@8bytes.org, will@kernel.org, heiko@sntech.de,
        xxm@rock-chips.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
To:     "Rob Herring" <robh@kernel.org>
MIME-Version: 1.0
Message-ID: <4bee-60911f00-11-7473f580@227440849>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 2/4] =?utf-8?q?dt-bindings=3A?=
 =?utf-8?q?_iommu=3A?==?utf-8?q?_rockchip=3A?= Add compatible for v2
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
 
On Friday, April 30, 2021 22:34 -03, Rob Herring <robh@kernel.org> wrote: 
 
> On Thu, Apr 22, 2021 at 04:16:00PM +0200, Benjamin Gaignard wrote:
> > Add compatible for the second version of IOMMU hardware block.
> > RK356x IOMMU can also be link to a power domain.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> > version 2:
> >  - Add power-domains property
> > 
> >  .../devicetree/bindings/iommu/rockchip,iommu.yaml          | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> > index 0db208cf724a..e54353ccd1ec 100644
> > --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> > +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> > @@ -19,7 +19,9 @@ description: |+
> >  
> >  properties:
> >    compatible:
> > -    const: rockchip,iommu
> > +    enum:
> > +      - rockchip,iommu
> > +      - rockchip,iommu-v2
> 
> This should be SoC specific.
> 

It seems iommu-v2 is really the name Rockchip gives to this IOMMU IP core.
Can we keep the "rockchip,iommu-v2" compatible, and add SoC-specific ones, as we normally do:

compatible = "rockchip,rk3568-iommu", "rockchip,iommu-v2";

Just like we'd do with any peripheral:

compatible = "st,stm32-dwmac", "snps,dwmac-3.50a";

Thanks!
Ezequiel

