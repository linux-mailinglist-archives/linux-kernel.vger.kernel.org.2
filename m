Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965B730E042
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhBCQ4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhBCQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:55:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8636C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 08:55:02 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y18so332357edw.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 08:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tx0GSrwn5ZZZSdoc4S5WG7zaN/w57zzukI2zMNMaHVA=;
        b=eFHP8Z6qQMusC2MOYfI2yDwBSA+L6nqiECECOAi1UY2oVssMJ/2pmk5I3Hx364ivGp
         if4bKt0MjZtIzaxingm3oDtPPQoaonr02AIEXL0yzTXTz0UbJiTq0R6flGkl443lc/EF
         tVROT3Z45tinS5jdLig6y2+VmdUc5D5qm4f/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tx0GSrwn5ZZZSdoc4S5WG7zaN/w57zzukI2zMNMaHVA=;
        b=MSvifyVAKlyBrXkRBun8rIj64k+5hTobME0OyIZSRBSNmmxf9HgYCQKxyL6Xbi4m2l
         pEwsQpRGLBATUUaQ4ao8r0BBBTgnnaG7NAvwctVGYs24/JdAJdZfeXhIyQVMHMM3csz3
         W5P0RqX2PJrcgQZ2rmYMXr98QKxo/WocDPK5jfGIfQJE9HT2h72DSMq5hYYI9JXXs1HP
         HdUqep2wRKnIWqpVHoFB4vUjsHXfUbtSnhABImMWuzfycARN6RMap0vHtiqYHDHWP5V9
         U/jNQ2eq4r1Eg0+0sou3Jzgl5G8BN2GYoiMC/mY0ZTyoZgvIgA6s1B8DL8pEMaOQfMmB
         BtmA==
X-Gm-Message-State: AOAM530aBXWSH3w2+Gtjn4o2NLdAtOPc4yKh6awt84T5cr2CYcDWPy8A
        pKUwwBaSm4Txu7uyD18VFQp3kut1jNgWgAADBBJ57g==
X-Google-Smtp-Source: ABdhPJyJfTgWP0p2yJQBWc0q6TSOUH+XVYtNVbFAyAEUSeAQRhjYk7S47zHV5llyE4OBO1fRJJQ/PlZCfrxHeZu8s9w=
X-Received: by 2002:a05:6402:18f:: with SMTP id r15mr4050001edv.53.1612371301178;
 Wed, 03 Feb 2021 08:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20210202161733.932215-1-kyletso@google.com> <20210202161733.932215-3-kyletso@google.com>
In-Reply-To: <20210202161733.932215-3-kyletso@google.com>
From:   Benson Leung <bleung@chromium.org>
Date:   Wed, 3 Feb 2021 08:54:49 -0800
Message-ID: <CANLzEksFtyYe01F_+MEFdG+KC83FAu00-PAtc95-v2GswMnTvw@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] usb: pd: Update VDO definitions
To:     Kyle Tso <kyletso@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hdegoede@redhat.com, Rob Herring <robh+dt@kernel.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Kyle,

On Tue, Feb 2, 2021 at 8:23 AM Kyle Tso <kyletso@google.com> wrote:
>
> "PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10" introduces several
> changes regarding the ID Header VDO and the Product Type VDOs.
>
> Signed-off-by: Kyle Tso <kyletso@google.com>

We have to actually be very careful in this change, because the switch
from PD 2.0 -> PD 3.0 does not mean that a PD 3.0 DFP will never
encounter a PD 2.0 partner or cable again.

It actually has to be the case that we may have to maintain two sets
of these object field definitions (and any other PD object decoding we
do in the kernel) and switch the decoding on pd_revision (which I
recently added here:
https://lore.kernel.org/linux-usb/20210129061406.2680146-3-bleung@chromium.org).

Just to put a point on it: PD 2.0's Passive Cable VDO has B4, which is
"Vbus through cable." PD 3.0, on the other hand, reserves this bit, so
the field is gone. We can't just delete that bit in the kernel's data
structures. We have to be able to refer to it if we encounter a PD 2.0
cable.

I think this change needs to be reworked so that we strictly maintain
a PD 2.0 object field definitions, and a separate PD 3.0 one too. They
will operate on the same objects, but whoever's doing the decoding has
to check the revision (2.0 vs 3.0) first to check applicability of one
set or the other.

Thanks,
Benson


> ---
>  drivers/usb/typec/class.c  |   8 +-
>  include/linux/usb/pd_vdo.h | 308 ++++++++++++++++++++++++++++---------
>  2 files changed, 242 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 42d1be1eece9..1db08138b75d 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -89,7 +89,7 @@ static const char * const typec_accessory_modes[] = {
>
>  /* Product types defined in USB PD Specification R3.0 V2.0 */
>  static const char * const product_type_ufp[8] = {
> -       [IDH_PTYPE_UNDEF]               = "undefined",
> +       [IDH_PTYPE_NOT_UFP]             = "not_ufp",
>         [IDH_PTYPE_HUB]                 = "hub",
>         [IDH_PTYPE_PERIPH]              = "peripheral",
>         [IDH_PTYPE_PSD]                 = "psd",
> @@ -97,17 +97,17 @@ static const char * const product_type_ufp[8] = {
>  };
>
>  static const char * const product_type_dfp[8] = {
> -       [IDH_PTYPE_DFP_UNDEF]           = "undefined",
> +       [IDH_PTYPE_NOT_DFP]             = "not_dfp",
>         [IDH_PTYPE_DFP_HUB]             = "hub",
>         [IDH_PTYPE_DFP_HOST]            = "host",
>         [IDH_PTYPE_DFP_PB]              = "power_brick",
> -       [IDH_PTYPE_DFP_AMC]             = "amc",
>  };
>
>  static const char * const product_type_cable[8] = {
> -       [IDH_PTYPE_UNDEF]               = "undefined",
> +       [IDH_PTYPE_NOT_CABLE]           = "not_cable",
>         [IDH_PTYPE_PCABLE]              = "passive",
>         [IDH_PTYPE_ACABLE]              = "active",
> +       [IDH_PTYPE_VPD]                 = "vpd",
>  };
>
>  static struct usb_pd_identity *get_pd_identity(struct device *dev)
> diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> index 8c08eeb9a74b..e9b6822c54c2 100644
> --- a/include/linux/usb/pd_vdo.h
> +++ b/include/linux/usb/pd_vdo.h
> @@ -103,34 +103,46 @@
>   * --------------------
>   * <31>     :: data capable as a USB host
>   * <30>     :: data capable as a USB device
> - * <29:27>  :: product type (UFP / Cable)
> + * <29:27>  :: product type (UFP / Cable / VPD)
>   * <26>     :: modal operation supported (1b == yes)
> - * <25:16>  :: product type (DFP)
> + * <25:23>  :: product type (DFP) (SVDM version 2.0+ only; set to zero in version 1.0)
> + * <22:21>  :: connector type (SVDM version 2.0+ only; set to zero in version 1.0)
> + * <20:16>  :: Reserved, Shall be set to zero
>   * <15:0>   :: USB-IF assigned VID for this cable vendor
>   */
> -#define IDH_PTYPE_UNDEF                0
> +/* SOP Product Type (UFP) */
> +#define IDH_PTYPE_NOT_UFP      0
>  #define IDH_PTYPE_HUB          1
>  #define IDH_PTYPE_PERIPH       2
>  #define IDH_PTYPE_PSD          3
>  #define IDH_PTYPE_AMA          5
>
> +/* SOP' Product Type (Cable Plug / VPD) */
> +#define IDH_PTYPE_NOT_CABLE    0
>  #define IDH_PTYPE_PCABLE       3
>  #define IDH_PTYPE_ACABLE       4
> +#define IDH_PTYPE_VPD          6
>
> -#define IDH_PTYPE_DFP_UNDEF    0
> +/* SOP Product Type (DFP) */
> +#define IDH_PTYPE_NOT_DFP      0
>  #define IDH_PTYPE_DFP_HUB      1
>  #define IDH_PTYPE_DFP_HOST     2
>  #define IDH_PTYPE_DFP_PB       3
> -#define IDH_PTYPE_DFP_AMC      4
>
> -#define VDO_IDH(usbh, usbd, ptype, is_modal, vid)              \
> -       ((usbh) << 31 | (usbd) << 30 | ((ptype) & 0x7) << 27    \
> -        | (is_modal) << 26 | ((vid) & 0xffff))
> +/* ID Header Mask */
> +#define IDH_DFP_MASK           GENMASK(25, 23)
> +#define IDH_CONN_MASK          GENMASK(22, 21)
> +
> +#define VDO_IDH(usbh, usbd, ufp_cable, is_modal, dfp, conn, vid)               \
> +       ((usbh) << 31 | (usbd) << 30 | ((ufp_cable) & 0x7) << 27                \
> +        | (is_modal) << 26 | ((dfp) & 0x7) << 23 | ((conn) & 0x3) << 21        \
> +        | ((vid) & 0xffff))
>
>  #define PD_IDH_PTYPE(vdo)      (((vdo) >> 27) & 0x7)
>  #define PD_IDH_VID(vdo)                ((vdo) & 0xffff)
>  #define PD_IDH_MODAL_SUPP(vdo) ((vdo) & (1 << 26))
>  #define PD_IDH_DFP_PTYPE(vdo)  (((vdo) >> 23) & 0x7)
> +#define PD_IDH_CONN_TYPE(vdo)  (((vdo) >> 21) & 0x3)
>
>  /*
>   * Cert Stat VDO
> @@ -138,6 +150,7 @@
>   * <31:0>  : USB-IF assigned XID for this cable
>   */
>  #define PD_CSTAT_XID(vdo)      (vdo)
> +#define VDO_CERT(xid)          ((xid) & 0xffffffff)
>
>  /*
>   * Product VDO
> @@ -149,112 +162,267 @@
>  #define PD_PRODUCT_PID(vdo)    (((vdo) >> 16) & 0xffff)
>
>  /*
> - * UFP VDO1
> + * UFP VDO (PD Revision 3.0+ only)
>   * --------
>   * <31:29> :: UFP VDO version
>   * <28>    :: Reserved
>   * <27:24> :: Device capability
> - * <23:6>  :: Reserved
> + * <23:22> :: Connector type (10b == receptacle, 11b == captive plug)
> + * <21:11> :: Reserved
> + * <10:8>  :: Vconn power (AMA only)
> + * <7>     :: Vconn required (AMA only, 0b == no, 1b == yes)
> + * <6>     :: Vbus required (AMA only, 0b == yes, 1b == no)
>   * <5:3>   :: Alternate modes
>   * <2:0>   :: USB highest speed
>   */
> -#define PD_VDO1_UFP_DEVCAP(vdo)        (((vdo) & GENMASK(27, 24)) >> 24)
> +#define PD_VDO_UFP_DEVCAP(vdo) (((vdo) & GENMASK(27, 24)) >> 24)
> +
> +/* UFP VDO Version */
> +#define UFP_VDO_VER1_2         2
>
> +/* Device Capability */
>  #define DEV_USB2_CAPABLE       BIT(0)
>  #define DEV_USB2_BILLBOARD     BIT(1)
>  #define DEV_USB3_CAPABLE       BIT(2)
>  #define DEV_USB4_CAPABLE       BIT(3)
>
> +/* Connector Type */
> +#define UFP_RECEPTACLE         2
> +#define UFP_CAPTIVE            3
> +
> +/* Vconn Power (AMA only, set to AMA_VCONN_NOT_REQ if Vconn is not required) */
> +#define AMA_VCONN_PWR_1W       0
> +#define AMA_VCONN_PWR_1W5      1
> +#define AMA_VCONN_PWR_2W       2
> +#define AMA_VCONN_PWR_3W       3
> +#define AMA_VCONN_PWR_4W       4
> +#define AMA_VCONN_PWR_5W       5
> +#define AMA_VCONN_PWR_6W       6
> +
> +/* Vconn Required (AMA only) */
> +#define AMA_VCONN_NOT_REQ      0
> +#define AMA_VCONN_REQ          1
> +
> +/* Vbus Required (AMA only) */
> +#define AMA_VBUS_REQ           0
> +#define AMA_VBUS_NOT_REQ       1
> +
> +/* Alternate Modes */
> +#define UFP_ALTMODE_NOT_SUPP   0
> +#define UFP_ALTMODE_TBT3       BIT(0)
> +#define UFP_ALTMODE_RECFG      BIT(1)
> +#define UFP_ALTMODE_NO_RECFG   BIT(2)
> +
> +/* USB Highest Speed */
> +#define UFP_USB2_ONLY          0
> +#define UFP_USB32_GEN1         1
> +#define UFP_USB32_4_GEN2       2
> +#define UFP_USB4_GEN3          3
> +
> +#define VDO_UFP(ver, cap, conn, vcpwr, vcr, vbr, alt, spd)                     \
> +       (((ver) & 0x7) << 29 | ((cap) & 0xf) << 24 | ((conn) & 0x3) << 22       \
> +        | ((vcpwr) & 0x7) << 8 | (vcr) << 7 | (vbr) << 6 | ((alt) & 0x7) << 3  \
> +        | ((spd) & 0x7))
> +
>  /*
> - * DFP VDO
> + * DFP VDO (PD Revision 3.0+ only)
>   * --------
>   * <31:29> :: DFP VDO version
>   * <28:27> :: Reserved
>   * <26:24> :: Host capability
> - * <23:5>  :: Reserved
> + * <23:22> :: Connector type (10b == receptacle, 11b == captive plug)
> + * <21:5>  :: Reserved
>   * <4:0>   :: Port number
>   */
>  #define PD_VDO_DFP_HOSTCAP(vdo)        (((vdo) & GENMASK(26, 24)) >> 24)
>
> +#define DFP_VDO_VER1_1         1
>  #define HOST_USB2_CAPABLE      BIT(0)
>  #define HOST_USB3_CAPABLE      BIT(1)
>  #define HOST_USB4_CAPABLE      BIT(2)
> +#define DFP_RECEPTACLE         2
> +#define DFP_CAPTIVE            3
> +
> +#define VDO_DFP(ver, cap, conn, pnum)                                          \
> +       (((ver) & 0x7) << 29 | ((cap) & 0x7) << 24 | ((conn) & 0x3) << 22       \
> +        | ((pnum) & 0x1f))
>
>  /*
> - * Cable VDO
> + * Passive Cable VDO
>   * ---------
>   * <31:28> :: Cable HW version
>   * <27:24> :: Cable FW version
> - * <23:20> :: Reserved, Shall be set to zero
> - * <19:18> :: type-C to Type-A/B/C/Captive (00b == A, 01 == B, 10 == C, 11 == Captive)
> - * <17>    :: Type-C to Plug/Receptacle (0b == plug, 1b == receptacle)
> + * <23:21> :: VDO version
> + * <20>    :: Reserved, Shall be set to zero
> + * <19:18> :: Type-C to Type-C/Captive (10b == C, 11b == Captive)
> + * <17>    :: Reserved, Shall be set to zero
>   * <16:13> :: cable latency (0001 == <10ns(~1m length))
> - * <12:11> :: cable termination type (11b == both ends active VCONN req)
> - * <10>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
> - * <9>     :: SSTX2 Directionality support
> - * <8>     :: SSRX1 Directionality support
> - * <7>     :: SSRX2 Directionality support
> - * <6:5>   :: Vbus current handling capability
> + * <12:11> :: cable termination type (10b == Vconn not req, 01b == Vconn req)
> + * <10:9>  :: Maximum Vbus voltage (00b == 20V, 01b == 30V, 10b == 40V, 11b == 50V)
> + * <8:7>   :: Reserved, Shall be set to zero
> + * <6:5>   :: Vbus current handling capability (01b == 3A, 10b == 5A)
> + * <4:3>   :: Reserved, Shall be set to zero
> + * <2:0>   :: USB highest speed
> + *
> + * Active Cable VDO 1
> + * ---------
> + * <31:28> :: Cable HW version
> + * <27:24> :: Cable FW version
> + * <23:21> :: VDO version
> + * <20>    :: Reserved, Shall be set to zero
> + * <19:18> :: Connector type (10b == C, 11b == Captive)
> + * <17>    :: Reserved, Shall be set to zero
> + * <16:13> :: cable latency (0001 == <10ns(~1m length))
> + * <12:11> :: cable termination type (10b == one end active, 11b == both ends active VCONN req)
> + * <10:9>  :: Maximum Vbus voltage (00b == 20V, 01b == 30V, 10b == 40V, 11b == 50V)
> + * <8>     :: SBU supported (0b == supported, 1b == not supported)
> + * <7>     :: SBU type (0b == passive, 1b == active)
> + * <6:5>   :: Vbus current handling capability (01b == 3A, 10b == 5A)
>   * <4>     :: Vbus through cable (0b == no, 1b == yes)
>   * <3>     :: SOP" controller present? (0b == no, 1b == yes)
> - * <2:0>   :: USB SS Signaling support
> + * <2:0>   :: USB highest speed
>   */
> -#define CABLE_ATYPE            0
> -#define CABLE_BTYPE            1
> +/* Cable VDO Version */
> +#define CABLE_VDO_VER1_0       0
> +#define CABLE_VDO_VER1_3       3
> +
> +/* Connector Type */
>  #define CABLE_CTYPE            2
>  #define CABLE_CAPTIVE          3
> -#define CABLE_PLUG             0
> -#define CABLE_RECEPTACLE       1
> -#define CABLE_CURR_1A5         0
> +
> +/* Cable Latency */
> +#define CABLE_LATENCY_1M       1
> +#define CABLE_LATENCY_2M       2
> +#define CABLE_LATENCY_3M       3
> +#define CABLE_LATENCY_4M       4
> +#define CABLE_LATENCY_5M       5
> +#define CABLE_LATENCY_6M       6
> +#define CABLE_LATENCY_7M       7
> +#define CABLE_LATENCY_7M_PLUS  8
> +
> +/* Cable Termination Type */
> +#define PCABLE_VCONN_NOT_REQ   0
> +#define PCABLE_VCONN_REQ       1
> +#define ACABLE_ONE_END         2
> +#define ACABLE_BOTH_END                3
> +
> +/* Maximum Vbus Voltage */
> +#define CABLE_MAX_VBUS_20V     0
> +#define CABLE_MAX_VBUS_30V     1
> +#define CABLE_MAX_VBUS_40V     2
> +#define CABLE_MAX_VBUS_50V     3
> +
> +/* Active Cable SBU Supported/Type */
> +#define ACABLE_SBU_SUPP                0
> +#define ACABLE_SBU_NOT_SUPP    1
> +#define ACABLE_SBU_PASSIVE     0
> +#define ACABLE_SBU_ACTIVE      1
> +
> +/* Vbus Current Handling Capability */
> +#define CABLE_CURR_DEF         0
>  #define CABLE_CURR_3A          1
>  #define CABLE_CURR_5A          2
> -#define CABLE_USBSS_U2_ONLY    0
> -#define CABLE_USBSS_U31_GEN1   1
> -#define CABLE_USBSS_U31_GEN2   2
> -#define VDO_CABLE(hw, fw, cbl, gdr, lat, term, tx1d, tx2d, rx1d, rx2d, cur,\
> -                 vps, sopp, usbss) \
> -       (((hw) & 0x7) << 28 | ((fw) & 0x7) << 24 | ((cbl) & 0x3) << 18  \
> -        | (gdr) << 17 | ((lat) & 0x7) << 13 | ((term) & 0x3) << 11     \
> -        | (tx1d) << 10 | (tx2d) << 9 | (rx1d) << 8 | (rx2d) << 7       \
> -        | ((cur) & 0x3) << 5 | (vps) << 4 | (sopp) << 3                \
> -        | ((usbss) & 0x7))
> +
> +/* USB Highest Speed */
> +#define CABLE_USB2_ONLY                0
> +#define CABLE_USB32_GEN1       1
> +#define CABLE_USB32_4_GEN2     2
> +#define CABLE_USB4_GEN3                3
> +
> +#define VDO_PCABLE(hw, fw, ver, conn, lat, term, vbm, cur, spd)                        \
> +       (((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21          \
> +        | ((conn) & 0x3) << 18 | ((lat) & 0xf) << 13 | ((term) & 0x3) << 11    \
> +        | ((vbm) & 0x3) << 9 | ((cur) & 0x3) << 5 | ((spd) & 0x7))
> +#define VDO_ACABLE1(hw, fw, ver, conn, lat, term, vbm, sbu, sbut, cur, vbt, sopp, spd) \
> +       (((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21          \
> +        | ((conn) & 0x3) << 18 | ((lat) & 0xf) << 13 | ((term) & 0x3) << 11    \
> +        | ((vbm) & 0x3) << 9 | (sbu) << 8 | (sbut) << 7 | ((cur) & 0x3) << 5   \
> +        | (vbt) << 4 | (sopp) << 3 | ((spd) & 0x7))
> +
>  #define VDO_TYPEC_CABLE_TYPE(vdo)      (((vdo) >> 18) & 0x3)
>
>  /*
> - * AMA VDO
> + * Active Cable VDO 2
>   * ---------
> - * <31:28> :: Cable HW version
> - * <27:24> :: Cable FW version
> - * <23:12> :: Reserved, Shall be set to zero
> - * <11>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
> - * <10>    :: SSTX2 Directionality support
> - * <9>     :: SSRX1 Directionality support
> - * <8>     :: SSRX2 Directionality support
> - * <7:5>   :: Vconn power
> - * <4>     :: Vconn power required
> - * <3>     :: Vbus power required
> - * <2:0>   :: USB SS Signaling support
> + * <31:24> :: Maximum operating temperature
> + * <23:16> :: Shutdown temperature
> + * <15>    :: Reserved, Shall be set to zero
> + * <14:12> :: U3/CLd power
> + * <11>    :: U3 to U0 transition mode (0b == direct, 1b == through U3S)
> + * <10>    :: Physical connection (0b == copper, 1b == optical)
> + * <9>     :: Active element (0b == redriver, 1b == retimer)
> + * <8>     :: USB4 supported (0b == yes, 1b == no)
> + * <7:6>   :: USB2 hub hops consumed
> + * <5>     :: USB2 supported (0b == yes, 1b == no)
> + * <4>     :: USB3.2 supported (0b == yes, 1b == no)
> + * <3>     :: USB lanes supported (0b == one lane, 1b == two lanes)
> + * <2>     :: Optically isolated active cable (0b == no, 1b == yes)
> + * <1>     :: Reserved, Shall be set to zero
> + * <0>     :: USB gen (0b == gen1, 1b == gen2+)
>   */
> -#define VDO_AMA(hw, fw, tx1d, tx2d, rx1d, rx2d, vcpwr, vcr, vbr, usbss) \
> -       (((hw) & 0x7) << 28 | ((fw) & 0x7) << 24                        \
> -        | (tx1d) << 11 | (tx2d) << 10 | (rx1d) << 9 | (rx2d) << 8      \
> -        | ((vcpwr) & 0x7) << 5 | (vcr) << 4 | (vbr) << 3               \
> -        | ((usbss) & 0x7))
> -
> -#define PD_VDO_AMA_VCONN_REQ(vdo)      (((vdo) >> 4) & 1)
> -#define PD_VDO_AMA_VBUS_REQ(vdo)       (((vdo) >> 3) & 1)
> +/* U3/CLd Power*/
> +#define ACAB2_U3_CLD_10MW_PLUS 0
> +#define ACAB2_U3_CLD_10MW      1
> +#define ACAB2_U3_CLD_5MW       2
> +#define ACAB2_U3_CLD_1MW       3
> +#define ACAB2_U3_CLD_500UW     4
> +#define ACAB2_U3_CLD_200UW     5
> +#define ACAB2_U3_CLD_50UW      6
> +
> +/* Other Active Cable VDO 2 Fields */
> +#define ACAB2_U3U0_DIRECT      0
> +#define ACAB2_U3U0_U3S         1
> +#define ACAB2_PHY_COPPER       0
> +#define ACAB2_PHY_OPTICAL      1
> +#define ACAB2_REDRIVER         0
> +#define ACAB2_RETIMER          1
> +#define ACAB2_USB4_SUPP                0
> +#define ACAB2_USB4_NOT_SUPP    1
> +#define ACAB2_USB2_SUPP                0
> +#define ACAB2_USB2_NOT_SUPP    1
> +#define ACAB2_USB32_SUPP       0
> +#define ACAB2_USB32_NOT_SUPP   1
> +#define ACAB2_LANES_ONE                0
> +#define ACAB2_LANES_TWO                1
> +#define ACAB2_OPT_ISO_NO       0
> +#define ACAB2_OPT_ISO_YES      1
> +#define ACAB2_GEN_1            0
> +#define ACAB2_GEN_2_PLUS       1
> +
> +#define VDO_ACABLE2(mtemp, stemp, u3p, trans, phy, ele, u4, hops, u2, u32, lane, iso, gen)     \
> +       (((mtemp) & 0xff) << 24 | ((stemp) & 0xff) << 16 | ((u3p) & 0x7) << 12  \
> +        | (trans) << 11 | (phy) << 10 | (ele) << 9 | (u4) << 8                 \
> +        | ((hops) & 0x3) << 6 | (u2) << 5 | (u32) << 4 | (lane) << 3           \
> +        | (iso) << 2 | (gen))
>
> -#define AMA_VCONN_PWR_1W       0
> -#define AMA_VCONN_PWR_1W5      1
> -#define AMA_VCONN_PWR_2W       2
> -#define AMA_VCONN_PWR_3W       3
> -#define AMA_VCONN_PWR_4W       4
> -#define AMA_VCONN_PWR_5W       5
> -#define AMA_VCONN_PWR_6W       6
> -#define AMA_USBSS_U2_ONLY      0
> -#define AMA_USBSS_U31_GEN1     1
> -#define AMA_USBSS_U31_GEN2     2
> -#define AMA_USBSS_BBONLY       3
> +/*
> + * VPD VDO
> + * ---------
> + * <31:28> :: HW version
> + * <27:24> :: FW version
> + * <23:21> :: VDO version
> + * <20:17> :: Reserved, Shall be set to zero
> + * <16:15> :: Maximum Vbus voltage (00b == 20V, 01b == 30V, 10b == 40V, 11b == 50V)
> + * <14>    :: Charge through current support (0b == 3A, 1b == 5A)
> + * <13>    :: Reserved, Shall be set to zero
> + * <12:7>  :: Vbus impedance
> + * <6:1>   :: Ground impedance
> + * <0>     :: Charge through support (0b == no, 1b == yes)
> + */
> +#define VPD_VDO_VER1_0         0
> +#define VPD_MAX_VBUS_20V       0
> +#define VPD_MAX_VBUS_30V       1
> +#define VPD_MAX_VBUS_40V       2
> +#define VPD_MAX_VBUS_50V       3
> +#define VPDCT_CURR_3A          0
> +#define VPDCT_CURR_5A          1
> +#define VPDCT_NOT_SUPP         0
> +#define VPDCT_SUPP             1
> +
> +#define VDO_VPD(hw, fw, ver, vbm, curr, vbi, gi, ct)                   \
> +       (((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21  \
> +        | ((vbm) & 0x3) << 15 | (curr) << 14 | ((vbi) & 0x3f) << 7     \
> +        | ((gi) & 0x3f) << 1 | (ct))
>
>  /*
>   * SVDM Discover SVIDs request -> response
> --
> 2.30.0.365.g02bc693789-goog
>


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
