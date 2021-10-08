Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8044263F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 07:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhJHFCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 01:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJHFCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 01:02:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8335CC061570;
        Thu,  7 Oct 2021 22:00:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so33972812lfa.9;
        Thu, 07 Oct 2021 22:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6pfqlNtrSH6NcXMnr6NSEeH0028ju0Jwm9BvNQ/kiu0=;
        b=lCiQYgCZcWnOoSPJlumWW06kWEYD/nhe9QM4J5x8bLwHHs5GQ+F6kaiiKYc4E7eLO5
         WuR28wegHWBYVNIoJkCTzF7tEfx0Hyt5ThsVYQ2SOdqYmYvTdSnBhYStQ+w0Fam0VW1Z
         KDMwe+KexeOk/imToysVdP6N78bpXdTQSbDSEGTqY9sAIKx2IbyhtmZnhHnu+n/JUPa8
         6yyDOCEf+uQysZHmLibVfQtL25vJ5nSY9FgzchoUG2zu6F8oX5dpd8h7p6bMcowfpI+x
         E2vAe47huY+I1UhC/WNmSBjy1YAR9o2bI3VXIwsq1HsRLMdl2ySW000lbxV2zl6EyoNd
         pGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6pfqlNtrSH6NcXMnr6NSEeH0028ju0Jwm9BvNQ/kiu0=;
        b=qfBiJUIbwCXmqu1I5WEoQfKTBWHCxUF+Ne1Y1R5XRWSG7Bs6BLVRh64Yws+axJDsbP
         oTAGUjwEVXKtAxO/sXjxyYb4ZLUYYuQaTyLbreAIKqhuo2ZI4D2ywFBquVYQZHG9yp8H
         la91gxwHiNkuT1nYdnu6V1ZzVLkx1A8Rg3b/aL704XgyQcKZDr7J7L/CrraHFeyYxusR
         plMrztP4bc01c/vp49mxrNhBxh3DaRB8sdFTQBsN6iw9D9IzgWiY8pnhCmhUtr2NsbKg
         ybmJEsrbcykSwzuZAPcU+MhYmMCvig/lQEbPr7T84OU2jPKZYuSpLfoWDvhL9a4QrPnm
         QuRQ==
X-Gm-Message-State: AOAM5302Yg9cW5SEPOPcPg0TQ+9Qb2KEGdKdyDd47tASuPUeaXL2Y8pc
        heu8Fgs64H7UZEQ0RHSBsRoaNP6WpNp5FxCUGIw=
X-Google-Smtp-Source: ABdhPJwkPKUAXd5lqJ3aBD0r5/9D0aaxZ4HR1Se+V9G/ZlAvcqxzw1XrUQQ6XRK0+j+xZmduWOxs+OW30cMpqOF0hOI=
X-Received: by 2002:a2e:9c94:: with SMTP id x20mr1253874lji.94.1633669202809;
 Thu, 07 Oct 2021 22:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com> <1629825378-8089-2-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1629825378-8089-2-git-send-email-manish.narani@xilinx.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Fri, 8 Oct 2021 12:59:51 +0800
Message-ID: <CAKgpwJVXyHcBoREcNhpsJxOBxxgkZMkY5Kt41n8Ux95aqxL10w@mail.gmail.com>
Subject: Re: [PATCH 1/6] usb: chipidea: Add support for VBUS control with PHY
To:     Manish Narani <manish.narani@xilinx.com>, Li Jun <jun.li@nxp.com>
Cc:     peter.chen@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        michal.simek@xilinx.com,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, git@xilinx.com,
        Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Narani <manish.narani@xilinx.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:23=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Some platforms make use of VBUS control over PHY which
> means controller driver has to access PHY registers to
> turn on/off VBUS line.This patch adds support for
> such platforms in chipidea.
>
> Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_usb2.c | 1 +
>  drivers/usb/chipidea/host.c         | 9 +++++++++
>  drivers/usb/chipidea/otg_fsm.c      | 7 +++++++
>  include/linux/usb/chipidea.h        | 1 +
>  4 files changed, 18 insertions(+)
>
> diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/c=
i_hdrc_usb2.c
> index 89e1d82..dc86b12 100644
> --- a/drivers/usb/chipidea/ci_hdrc_usb2.c
> +++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
> @@ -30,6 +30,7 @@ static const struct ci_hdrc_platform_data ci_default_pd=
ata =3D {
>
>  static const struct ci_hdrc_platform_data ci_zynq_pdata =3D {
>         .capoffset      =3D DEF_CAPOFFSET,
> +       .flags          =3D CI_HDRC_PHY_VBUS_CONTROL,
>  };
>
>  static const struct ci_hdrc_platform_data ci_zevio_pdata =3D {
> diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> index e86d13c..578968d 100644
> --- a/drivers/usb/chipidea/host.c
> +++ b/drivers/usb/chipidea/host.c
> @@ -63,6 +63,14 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int =
portnum, bool enable)
>                 priv->enabled =3D enable;
>         }
>
> +       if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL &&
> +           ci->usb_phy && ci->usb_phy->set_vbus) {
> +               if (enable)
> +                       ci->usb_phy->set_vbus(ci->usb_phy, 1);
> +               else
> +                       ci->usb_phy->set_vbus(ci->usb_phy, 0);
> +       }
> +

Can existing API usb_phy_vbus_on/off() work for you? I think that
helper will make it simple so you don't need a new flag and those
checks.

Li Jun
>         if (enable && (ci->platdata->phy_mode =3D=3D USBPHY_INTERFACE_MOD=
E_HSIC)) {
>                 /*
>                  * Marvell 28nm HSIC PHY requires forcing the port to HS =
mode.
> @@ -71,6 +79,7 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int p=
ortnum, bool enable)
>                 hw_port_test_set(ci, 5);
>                 hw_port_test_set(ci, 0);
>         }
> +
>         return 0;
>  };
>
> diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fs=
m.c
> index 6ed4b00..2f7f94d 100644
> --- a/drivers/usb/chipidea/otg_fsm.c
> +++ b/drivers/usb/chipidea/otg_fsm.c
> @@ -471,6 +471,10 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int=
 on)
>                                 return;
>                         }
>                 }
> +
> +               if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +                       ci->usb_phy->set_vbus(ci->usb_phy, 1);
> +
>                 /* Disable data pulse irq */
>                 hw_write_otgsc(ci, OTGSC_DPIE, 0);
>
> @@ -480,6 +484,9 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int =
on)
>                 if (ci->platdata->reg_vbus)
>                         regulator_disable(ci->platdata->reg_vbus);
>
> +               if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
> +                       ci->usb_phy->set_vbus(ci->usb_phy, 0);
> +
>                 fsm->a_bus_drop =3D 1;
>                 fsm->a_bus_req =3D 0;
>         }
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index edf3342..ee38835 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -62,6 +62,7 @@ struct ci_hdrc_platform_data {
>  #define CI_HDRC_REQUIRES_ALIGNED_DMA   BIT(13)
>  #define CI_HDRC_IMX_IS_HSIC            BIT(14)
>  #define CI_HDRC_PMQOS                  BIT(15)
> +#define CI_HDRC_PHY_VBUS_CONTROL       BIT(16)
>         enum usb_dr_mode        dr_mode;
>  #define CI_HDRC_CONTROLLER_RESET_EVENT         0
>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT       1
> --
> 2.1.1
>
