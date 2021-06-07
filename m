Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973E239DD74
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFGNTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGNTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:19:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C214861164;
        Mon,  7 Jun 2021 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623071830;
        bh=SGYTD9jGwwVnbXxZJo2IMmz6s1Wuu6sgPJY01wB0hj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dPCoPQPpVQTmPC46OSxK1YTNM4Rp6aENDRN4jpV6sOt92dlgCTNDtvdIKKhAOh//3
         7SrSB3TObM5qhZbsm4W8IHxTQFzgHQhiMyQMLjPpEawn++uhYu095w3YgbX8lb8H5O
         aZRBIAlEEPPBQC7dsVKW5uR2jUOXZh9P+woU4bzxO7usIMoDV16K2DSPEP1Dl3oPNg
         aP2Mp5L2uvW2dDYx7tobV4I6XjWu+onEc6DCtfPLqcEqK1CnlOIb09/ubR5+JdSKm5
         vVCljfmvgD8uqf2fgJ/akVABNFRLJUWejC+qX13dt4XDXUXT2LgdsVp58xuwlzagOL
         KJ+GHtyCIwDWQ==
Received: by mail-ej1-f52.google.com with SMTP id he7so7182705ejc.13;
        Mon, 07 Jun 2021 06:17:10 -0700 (PDT)
X-Gm-Message-State: AOAM5312a9/O8TZ6nJazTrI+3F5QPTj4no4w5rrPNXXiKm7DaUwj4xEF
        3NRacmcWIQbqHDfAf4AE3w5kPER/MPdoHi0C3A==
X-Google-Smtp-Source: ABdhPJyB2mu2p0Vz6GuEA33/JHz9vO2OJC5SpaUCqz5KbM1IIo7ajKUdT/3rQ7GMquBx8tQt0gQr02DtW31fRQgs5vQ=
X-Received: by 2002:a17:906:fa13:: with SMTP id lo19mr18291724ejb.468.1623071829381;
 Mon, 07 Jun 2021 06:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210601164800.7670-1-jbx6244@gmail.com> <20210601164800.7670-2-jbx6244@gmail.com>
 <YLhukPL7jSx3+dBj@vkoul-mobl> <3601774.Dhsi8hcfAM@diego>
In-Reply-To: <3601774.Dhsi8hcfAM@diego>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Jun 2021 08:16:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+xE7UfXcr-RTkxB8gZej8M52Fk-yM3yYA3KA7mMn50ng@mail.gmail.com>
Message-ID: <CAL_Jsq+xE7UfXcr-RTkxB8gZej8M52Fk-yM3yYA3KA7mMn50ng@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] dt-bindings: phy: rename phy nodename in phy-rockchip-inno-usb2.yaml
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        linux-phy@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 3:58 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Vinod,
>
> Am Donnerstag, 3. Juni 2021, 07:54:24 CEST schrieb Vinod Koul:
> > On 01-06-21, 18:47, Johan Jonker wrote:
> > > The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$=
"
> > > in phy-provider.yaml has required "#phy-cells" for phy nodes.
> > > The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
> > > Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
> > > notifications. Remove unneeded "#phy-cells" from parent node.
> > > Also sort example.
> > >
> > > make ARCH=3Darm dtbs_check
> > > DT_SCHEMA_FILES=3D~/.local/lib/python3.5/site-packages/dtschema/schem=
as/
> > > phy/phy-provider.yaml
> > >
> > > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml       | 11 +=
++--------
> > >  Documentation/devicetree/bindings/soc/rockchip/grf.yaml       |  4 +=
+--
> >
> > I dont have grf.yaml, I guess it would be easier to split this into two
> > or apply this thru rockchip tree. If you prefer latter:
> >
> > Acked-By: Vinod Koul <vkoul@kernel.org>
>
> before we do any more rounds, I'll just do that with your Ack, thanks :-)

This is generating warnings on linux-next now:

/builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/=
grf.example.dt.yaml:
syscon@ff770000: usb2phy@e450: '#phy-cells' does not match any of the
regexes: 'pinctrl-[0-9]+'
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/=
soc/rockchip/grf.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/=
grf.example.dt.yaml:
usb2phy@e450: '#phy-cells' does not match any of the regexes:
'pinctrl-[0-9]+'
From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/=
phy/phy-rockchip-inno-usb2.yaml

Rob
