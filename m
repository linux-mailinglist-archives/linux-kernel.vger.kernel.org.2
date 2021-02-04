Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37AB30E900
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhBDA4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhBDA4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:56:39 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C30C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 16:55:59 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id a1so958697qvd.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 16:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yg2+jEqmcaTcVPRTx8oUm7PKwpuDkoxaGpldMu+rehI=;
        b=XVhcsBiS6iHdmtG44VFaqppcYvU5Tnte0HOwaFFVd0KocCq4Itoj2oDigFMVYcxbH+
         8BMtBNsADEW+5sc7A4KH+2jyQhQPzLrpFgL6sOt9d45i1QbLLCijjZ/AhovK7S74AOpa
         NkfntYjx2hFvAPZZ7Riel53fq3daZRlFnod7EcScZDXlC+D2TxzgWPoaI4GM53PchY7j
         A673DA2RK7r0MqtVy+9k26EMluE2T0cflr+KfoZUO1LGzgOVcfWMhKQRKWS2J1rQnvuO
         O/sNndhraoYDz+KaKSYHTNFv52Sq4mg0CXXnRJI8wfJYD+kidZMMqe1UnqKy4uYvAIua
         Bmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yg2+jEqmcaTcVPRTx8oUm7PKwpuDkoxaGpldMu+rehI=;
        b=igyu7qeU8HhtEaCvs3/hF76IBhzx3kp3eFfQ9nzTwdpfQHOzn/ICfBCHmb9zuCxamS
         92n5fEBcD3p4VOQzYc9WFdo6fwLUgfy5H++b3kIxZ0G5hjxKDhhXzFWfYINXv8bFRdwp
         PR9efVgzqocHxJzw0R8Dt2UmHgbVo4iIhgpx98uj5PRlQkllygxcRQe+4u3qjmH4y9Hg
         ZkmvzIZVHCQf5Wr14GZAFze40pyGwm0Xakl0CUyYKHT11Mj7AUoacFFh74EQbYfKtGD4
         n2gYHzs+G6QAuhOIXCBWwLcXNs+H9fzFBbWxp/ddZk4GVnt2umNKUMoeForyhrcJ3DeW
         bTZg==
X-Gm-Message-State: AOAM530YOQ5PHgKbpOGjucgZbUHmS1zgE4rVZHCyorrQHNZnCqZqNI+F
        /zvBxZXlsqxtVv7A1caT4RpXzddU5Yyroj6KmCSfsg==
X-Google-Smtp-Source: ABdhPJxo1ON5CTtwmHqfOQb/3oNlTJEW9aen4Vt5TKfQiS/67rB7Y1lFa6iDHmiXlLMarnqGXMEIWgItEgpMJE0MHBs=
X-Received: by 2002:ad4:5887:: with SMTP id dz7mr5560776qvb.44.1612400157748;
 Wed, 03 Feb 2021 16:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20210204005036.1555294-1-kyletso@google.com>
In-Reply-To: <20210204005036.1555294-1-kyletso@google.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Thu, 4 Feb 2021 08:55:41 +0800
Message-ID: <CAGZ6i=3fdLt=MWZunfRDPpjcxjDO9K+v=64bpadvbpaxCUpHYg@mail.gmail.com>
Subject: Re: [PATCH] usb: pd: Reland VDO definitions of PD2.0
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Benson Leung <bleung@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Benson and Prashant,

On Thu, Feb 4, 2021 at 8:50 AM Kyle Tso <kyletso@google.com> wrote:
>
> Reland VDO definitions of PD Revision 2.0 as they are still used in
> PD2.0 products.
>
> Fixes: 0e1d6f55a12e ("usb: pd: Update VDO definitions")
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  include/linux/usb/pd_vdo.h | 69 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 3 deletions(-)
>
Is there any chance that you have free time to verify this patch with
CrOS configuration?

thanks,
Kyle

> diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> index e9b6822c54c2..5de7f550f93e 100644
> --- a/include/linux/usb/pd_vdo.h
> +++ b/include/linux/usb/pd_vdo.h
> @@ -110,6 +110,10 @@
>   * <20:16>  :: Reserved, Shall be set to zero
>   * <15:0>   :: USB-IF assigned VID for this cable vendor
>   */
> +
> +/* PD Rev2.0 definition */
> +#define IDH_PTYPE_UNDEF                0
> +
>  /* SOP Product Type (UFP) */
>  #define IDH_PTYPE_NOT_UFP      0
>  #define IDH_PTYPE_HUB          1
> @@ -248,7 +252,25 @@
>          | ((pnum) & 0x1f))
>
>  /*
> - * Passive Cable VDO
> + * Cable VDO (for both Passive and Active Cable VDO in PD Rev2.0)
> + * ---------
> + * <31:28> :: Cable HW version
> + * <27:24> :: Cable FW version
> + * <23:20> :: Reserved, Shall be set to zero
> + * <19:18> :: type-C to Type-A/B/C/Captive (00b == A, 01 == B, 10 == C, 11 == Captive)
> + * <17>    :: Reserved, Shall be set to zero
> + * <16:13> :: cable latency (0001 == <10ns(~1m length))
> + * <12:11> :: cable termination type (11b == both ends active VCONN req)
> + * <10>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
> + * <9>     :: SSTX2 Directionality support
> + * <8>     :: SSRX1 Directionality support
> + * <7>     :: SSRX2 Directionality support
> + * <6:5>   :: Vbus current handling capability (01b == 3A, 10b == 5A)
> + * <4>     :: Vbus through cable (0b == no, 1b == yes)
> + * <3>     :: SOP" controller present? (0b == no, 1b == yes)
> + * <2:0>   :: USB SS Signaling support
> + *
> + * Passive Cable VDO (PD Rev3.0+)
>   * ---------
>   * <31:28> :: Cable HW version
>   * <27:24> :: Cable FW version
> @@ -264,7 +286,7 @@
>   * <4:3>   :: Reserved, Shall be set to zero
>   * <2:0>   :: USB highest speed
>   *
> - * Active Cable VDO 1
> + * Active Cable VDO 1 (PD Rev3.0+)
>   * ---------
>   * <31:28> :: Cable HW version
>   * <27:24> :: Cable FW version
> @@ -286,7 +308,9 @@
>  #define CABLE_VDO_VER1_0       0
>  #define CABLE_VDO_VER1_3       3
>
> -/* Connector Type */
> +/* Connector Type (_ATYPE and _BTYPE are for PD Rev2.0 only) */
> +#define CABLE_ATYPE            0
> +#define CABLE_BTYPE            1
>  #define CABLE_CTYPE            2
>  #define CABLE_CAPTIVE          3
>
> @@ -323,12 +347,22 @@
>  #define CABLE_CURR_3A          1
>  #define CABLE_CURR_5A          2
>
> +/* USB SuperSpeed Signaling Support (PD Rev2.0) */
> +#define CABLE_USBSS_U2_ONLY    0
> +#define CABLE_USBSS_U31_GEN1   1
> +#define CABLE_USBSS_U31_GEN2   2
> +
>  /* USB Highest Speed */
>  #define CABLE_USB2_ONLY                0
>  #define CABLE_USB32_GEN1       1
>  #define CABLE_USB32_4_GEN2     2
>  #define CABLE_USB4_GEN3                3
>
> +#define VDO_CABLE(hw, fw, cbl, lat, term, tx1d, tx2d, rx1d, rx2d, cur, vps, sopp, usbss) \
> +       (((hw) & 0x7) << 28 | ((fw) & 0x7) << 24 | ((cbl) & 0x3) << 18          \
> +        | ((lat) & 0x7) << 13 | ((term) & 0x3) << 11 | (tx1d) << 10            \
> +        | (tx2d) << 9 | (rx1d) << 8 | (rx2d) << 7 | ((cur) & 0x3) << 5         \
> +        | (vps) << 4 | (sopp) << 3 | ((usbss) & 0x7))
>  #define VDO_PCABLE(hw, fw, ver, conn, lat, term, vbm, cur, spd)                        \
>         (((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21          \
>          | ((conn) & 0x3) << 18 | ((lat) & 0xf) << 13 | ((term) & 0x3) << 11    \
> @@ -395,6 +429,35 @@
>          | ((hops) & 0x3) << 6 | (u2) << 5 | (u32) << 4 | (lane) << 3           \
>          | (iso) << 2 | (gen))
>
> +/*
> + * AMA VDO (PD Rev2.0)
> + * ---------
> + * <31:28> :: Cable HW version
> + * <27:24> :: Cable FW version
> + * <23:12> :: Reserved, Shall be set to zero
> + * <11>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
> + * <10>    :: SSTX2 Directionality support
> + * <9>     :: SSRX1 Directionality support
> + * <8>     :: SSRX2 Directionality support
> + * <7:5>   :: Vconn power
> + * <4>     :: Vconn power required
> + * <3>     :: Vbus power required
> + * <2:0>   :: USB SS Signaling support
> + */
> +#define VDO_AMA(hw, fw, tx1d, tx2d, rx1d, rx2d, vcpwr, vcr, vbr, usbss) \
> +       (((hw) & 0x7) << 28 | ((fw) & 0x7) << 24                        \
> +        | (tx1d) << 11 | (tx2d) << 10 | (rx1d) << 9 | (rx2d) << 8      \
> +        | ((vcpwr) & 0x7) << 5 | (vcr) << 4 | (vbr) << 3               \
> +        | ((usbss) & 0x7))
> +
> +#define PD_VDO_AMA_VCONN_REQ(vdo)      (((vdo) >> 4) & 1)
> +#define PD_VDO_AMA_VBUS_REQ(vdo)       (((vdo) >> 3) & 1)
> +
> +#define AMA_USBSS_U2_ONLY      0
> +#define AMA_USBSS_U31_GEN1     1
> +#define AMA_USBSS_U31_GEN2     2
> +#define AMA_USBSS_BBONLY       3
> +
>  /*
>   * VPD VDO
>   * ---------
> --
> 2.30.0.365.g02bc693789-goog
>
