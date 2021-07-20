Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8C3CF2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbhGTDZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:25:41 -0400
Received: from mail-4324.protonmail.ch ([185.70.43.24]:37591 "EHLO
        mail-4324.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbhGTDZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:25:16 -0400
Date:   Tue, 20 Jul 2021 04:05:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1626753953;
        bh=CF66ovN+YSf9YBR9ds7RTgUBxPIbBt9/Vvb9vK60vdE=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=hh+W7g9OpxFb6zbZYWPF2i3zAYyAZ/W1WKLBPXCIsjhAmaffT749hojEApzgoHVHr
         vftQpD2Pf2lafkvhccd9IuKhV/jrLdoZXtCELPImLJVr6qaIiPrrU/frj0ccrEvSpd
         sn5E2pMY84ebzwqUyVsCBNFkt+Dtv2vClhbKp3fk=
To:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v4] usb: dwc3: Add support for VBUS power control
Message-ID: <1iGAbanUDRO1WcnGiuoPm8cgSBNSp7KCy7Z8G-1fMKl98WXRi8_E9W8z2OagnJwaDwnneyf4hXVaRAlZNE8EZWIMpBsfoG_fi-a91Ev7AHs=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20200805061744.20404-1-mike.looijmans@topic.nl>

On Wed,  5 Aug 2020 08:17:44 +0200, Mike Looijmans wrote:
> Support VBUS power control using regulator framework. Enables the regulat=
or
> while the port is in host mode.
>
> The "vbus-supply" property can be provided using a usb-connector child no=
de
> and standard devicetree bindings.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Add missing devm_regulator_get call which got lost during rebase
> v3: Remove devicetree binding, use standard usb-connector
>     Fix probe fail when vbus-supply is not present
> v4: Use devm_regulator_get (without "optional")
>
>  drivers/usb/dwc3/core.c | 34 ++++++++++++++++++++++++++--------
>  drivers/usb/dwc3/core.h |  4 ++++
>  drivers/usb/dwc3/drd.c  |  6 ++----
>  3 files changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index edc17155cb2b..abfd043bae21 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -25,6 +25,7 @@
>  #include <linux/of.h>
>  #include <linux/acpi.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>
>  #include <linux/usb/ch9.h>
> @@ -112,6 +113,23 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>  =09dwc->current_dr_role =3D mode;
>  }
>
> +void dwc3_set_vbus(struct dwc3 *dwc, bool enable)
> +{
> +=09int ret;
> +
> +=09if (enable !=3D dwc->vbus_reg_enabled) {
> +=09=09if (enable)
> +=09=09=09ret =3D regulator_enable(dwc->vbus_reg);
> +=09=09else
> +=09=09=09ret =3D regulator_disable(dwc->vbus_reg);
> +=09=09if (!ret)
> +=09=09=09dwc->vbus_reg_enabled =3D enable;
> +=09}
> +
> +=09if (dwc->usb2_phy)
> +=09=09otg_set_vbus(dwc->usb2_phy->otg, enable);
> +}
> +
>  static void __dwc3_set_mode(struct work_struct *work)
>  {
>  =09struct dwc3 *dwc =3D work_to_dwc(work);
> @@ -164,8 +182,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>  =09=09if (ret) {
>  =09=09=09dev_err(dwc->dev, "failed to initialize host\n");
>  =09=09} else {
> -=09=09=09if (dwc->usb2_phy)
> -=09=09=09=09otg_set_vbus(dwc->usb2_phy->otg, true);
> +=09=09=09dwc3_set_vbus(dwc, true);
>  =09=09=09phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>  =09=09=09phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>  =09=09}
> @@ -173,8 +190,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>  =09case DWC3_GCTL_PRTCAP_DEVICE:
>  =09=09dwc3_event_buffers_setup(dwc);
>
> -=09=09if (dwc->usb2_phy)
> -=09=09=09otg_set_vbus(dwc->usb2_phy->otg, false);
> +=09=09dwc3_set_vbus(dwc, false);
>  =09=09phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>  =09=09phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>
> @@ -1183,8 +1199,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  =09case USB_DR_MODE_PERIPHERAL:
>  =09=09dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>
> -=09=09if (dwc->usb2_phy)
> -=09=09=09otg_set_vbus(dwc->usb2_phy->otg, false);
> +=09=09dwc3_set_vbus(dwc, false);
>  =09=09phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>  =09=09phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>
> @@ -1198,8 +1213,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  =09case USB_DR_MODE_HOST:
>  =09=09dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
>
> -=09=09if (dwc->usb2_phy)
> -=09=09=09otg_set_vbus(dwc->usb2_phy->otg, true);
> +=09=09dwc3_set_vbus(dwc, true);
>  =09=09phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>  =09=09phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>
> @@ -1470,6 +1484,10 @@ static int dwc3_probe(struct platform_device *pdev=
)
>
>  =09dwc3_get_properties(dwc);
>
> +=09dwc->vbus_reg =3D devm_regulator_get(dev, "vbus");
> +=09if (IS_ERR(dwc->vbus_reg))
> +=09=09return PTR_ERR(dwc->vbus_reg);
> +
>  =09dwc->reset =3D devm_reset_control_array_get(dev, true, true);
>  =09if (IS_ERR(dwc->reset))
>  =09=09return PTR_ERR(dwc->reset);
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 4c171a8e215f..cee2574d7bf4 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1085,6 +1085,9 @@ struct dwc3 {
>
>  =09bool=09=09=09phys_ready;
>
> +=09struct regulator=09*vbus_reg;
> +=09bool=09=09=09vbus_reg_enabled;
> +
>  =09struct ulpi=09=09*ulpi;
>  =09bool=09=09=09ulpi_ready;
>
> @@ -1397,6 +1400,7 @@ struct dwc3_gadget_ep_cmd_params {
>
>  /* prototypes */
>  void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
> +void dwc3_set_vbus(struct dwc3 *dwc, bool enable);
>  void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
>  u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
>
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 7db1ffc92bbd..45fdec2d128d 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -384,8 +384,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_id=
status)
>  =09=09if (ret) {
>  =09=09=09dev_err(dwc->dev, "failed to initialize host\n");
>  =09=09} else {
> -=09=09=09if (dwc->usb2_phy)
> -=09=09=09=09otg_set_vbus(dwc->usb2_phy->otg, true);
> +=09=09=09dwc3_set_vbus(dwc, true);
>  =09=09=09if (dwc->usb2_generic_phy)
>  =09=09=09=09phy_set_mode(dwc->usb2_generic_phy,
>  =09=09=09=09=09     PHY_MODE_USB_HOST);
> @@ -398,8 +397,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_id=
status)
>  =09=09dwc3_event_buffers_setup(dwc);
>  =09=09spin_unlock_irqrestore(&dwc->lock, flags);
>
> -=09=09if (dwc->usb2_phy)
> -=09=09=09otg_set_vbus(dwc->usb2_phy->otg, false);
> +=09=09dwc3_set_vbus(dwc, false);
>  =09=09if (dwc->usb2_generic_phy)
>  =09=09=09phy_set_mode(dwc->usb2_generic_phy,
>  =09=09=09=09     PHY_MODE_USB_DEVICE);
> --
> 2.17.1

Tested after fixing a couple of small conflicts.

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>
