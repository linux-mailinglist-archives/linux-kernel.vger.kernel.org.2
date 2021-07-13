Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D152B3C6CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhGMIws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:52:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34076 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234982AbhGMIwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:52:38 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m3E6k-00086V-2I; Tue, 13 Jul 2021 10:49:38 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, algea.cao@rock-chips.com,
        andy.yan@rock-chips.com,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: display: rockchip: Add compatible for rk3568 HDMI
Date:   Tue, 13 Jul 2021 10:49:37 +0200
Message-ID: <3865833.Ac65pObt5d@diego>
In-Reply-To: <1bd64284-0a20-12e3-e2e7-19cdfdbf1a25@wolfvision.net>
References: <20210707120323.401785-1-benjamin.gaignard@collabora.com> <20210707120323.401785-2-benjamin.gaignard@collabora.com> <1bd64284-0a20-12e3-e2e7-19cdfdbf1a25@wolfvision.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Dienstag, 13. Juli 2021, 10:44:00 CEST schrieb Michael Riesch:
> The HDMI TX block in the RK3568 requires two power supplies, which have
> to be enabled in some cases (at least on the RK3568 EVB1 the voltages
> VDDA0V9_IMAGE and VCCA1V8_IMAGE are disabled by default). It would be
> great if this was considered by the driver and the device tree binding.
> I am not sure, though, whether this is a RK3568 specific or
> rockchip_dw_hdmi specific thing. Maybe it can even enter the Synopsis DW
> HDMI driver.

I do remember that this discussion happened many years back already.
And yes the supplies are needed for all but back then there was opposition
as these are supposedly phy-related supplies, not for the dw-hdmi itself.
[There are variants with an external phy, like on the rk3328]

See discussion on [0]

[0] https://dri-devel.freedesktop.narkive.com/pen2zWo1/patch-v3-1-2-drm-bridge-dw-hdmi-support-optional-supply-regulators



> On 7/7/21 2:03 PM, Benjamin Gaignard wrote:
> > Define a new compatible for rk3568 HDMI.
> > This version of HDMI hardware block needs two new clocks hclk_vio and hclk
> > to provide phy reference clocks.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> > version 2:
> > - Add the clocks needed for the phy.
> > 
> >  .../bindings/display/rockchip/rockchip,dw-hdmi.yaml         | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> > index 75cd9c686e985..cb8643b3a8b84 100644
> > --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> > +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
> > @@ -23,6 +23,7 @@ properties:
> >        - rockchip,rk3288-dw-hdmi
> >        - rockchip,rk3328-dw-hdmi
> >        - rockchip,rk3399-dw-hdmi
> > +      - rockchip,rk3568-dw-hdmi
> >  
> >    reg-io-width:
> >      const: 4
> > @@ -51,8 +52,11 @@ properties:
> >            - vpll
> >        - enum:
> >            - grf
> > +          - hclk_vio
> > +          - vpll
> > +      - enum:
> > +          - hclk
> >            - vpll
> > -      - const: vpll
> 
> The description and documentation of the clocks are somewhat misleading
> IMHO. This is not caused by your patches, of course. But maybe this is a
> chance to clean them up a bit.
> 
> It seems that the CEC clock is an optional clock of the dw-hdmi driver.
> Shouldn't it be documented in the synopsys,dw-hdmi.yaml?
> 
> Also, it would be nice if the clocks hclk_vio and hclk featured a
> description in the binding.
> 
> BTW, I am not too familiar with the syntax here, but shouldn't items in
> clocks and items in clock-names be aligned (currently, there is a plain
> list vs. an enum structure)?
> 
> Best regards,
> Michael
> 
> >  
> >    ddc-i2c-bus:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> > 
> 




