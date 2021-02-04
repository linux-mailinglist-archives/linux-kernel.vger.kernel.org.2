Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9830EC66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBDGS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhBDGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:18:53 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA500C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 22:18:13 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id j4so1244550qvk.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 22:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOK/gpaaTvdqD3zldkgIKMPTl69NVRwknNeXPx+fgPA=;
        b=cGhU/Ld+Eg+W5/3YtGhtblV3V5TI6TMeXwehm3yzJDCjMpbbZbw9iBxPWRXUc1eIhU
         h1ZZk+uVizzJSGVzOzU713vuPPgjLIrPUOvDuhb3rMSbUKpK0f92jjrC6FJCoAPgsoPe
         m58K5RzGF7uT8WoZ8/QfNH/SyRmCsrJvNjiTiC1kuZFSXHYjHnGsMKDpZ1J8maCbnDJ3
         hpgVaP+vJ4ZAUAQig7yE4L3X3IUboezuEx3bSaMftQuP28Q24vipFlVxUuB7BQQgdWRY
         EIk3AO1VdL6lxA3Vhzh3GhpbPYP2j3WgVepW683bOUlDGww/qXzsoU8doyQZ7AqCU18Q
         mPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOK/gpaaTvdqD3zldkgIKMPTl69NVRwknNeXPx+fgPA=;
        b=djA2vYM7uUX82bDnTd+j27ASL+496oWkN3lYsbUQTwSwPvOZ8gQUcClVPICl0jpzMk
         az59AoRsQHfkt6akjqGr1mLa1AA+ZaD+CjfYKnCprhRsRDJQeDUGmRcF8pshWg07AOKm
         w6KRK499tqIM1q7NjM/kPRTB4oCb+LrPQo+OKOh2+Eo4MfyJZst2nrGhxx+J6duzqQ1R
         WnkKc12+qKeVGtaWQNchVjQ99o92w4RZx491kDcs2jEideL3NvTVF3jQVy2ShxJt7amv
         jmFpEaRzCKSg7UC07GhMwS1S6fV0m76iYpblhjUeCOmXo+UMTpf4TGHIxNzTeG88+6HU
         AGpg==
X-Gm-Message-State: AOAM530AZqtF8O4IHVKfwotiL73f7QbhnAIbxA/R26r9g7TYkgJ+Uqrh
        DTTHLZUf3UAVmiiMfav1mNQtr/Lm5qtjEQOKRn8Y4A==
X-Google-Smtp-Source: ABdhPJy/VQZc/9qvirpC6nf1OVgEfMenvNgJUYQFIcZJ30ahFFscZpPQA4MYDRnA5ApWMro0zwS9gizh6lyFxYyfB18=
X-Received: by 2002:a0c:b990:: with SMTP id v16mr6338305qvf.16.1612419492517;
 Wed, 03 Feb 2021 22:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20210204005036.1555294-1-kyletso@google.com> <CAGZ6i=3fdLt=MWZunfRDPpjcxjDO9K+v=64bpadvbpaxCUpHYg@mail.gmail.com>
In-Reply-To: <CAGZ6i=3fdLt=MWZunfRDPpjcxjDO9K+v=64bpadvbpaxCUpHYg@mail.gmail.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Thu, 4 Feb 2021 14:17:56 +0800
Message-ID: <CAGZ6i=3fgda+8brU49qG1pxc=1icM7eeuHx+oH6-bA9oa4qK1Q@mail.gmail.com>
Subject: Re: [PATCH] usb: pd: Reland VDO definitions of PD2.0
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, pmalani@chromium.org,
        Benson Leung <bleung@chromium.org>
Cc:     Benson Leung <bleung@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 8:55 AM Kyle Tso <kyletso@google.com> wrote:
>
> Hi, Benson and Prashant,
>
> On Thu, Feb 4, 2021 at 8:50 AM Kyle Tso <kyletso@google.com> wrote:
> >
> > Reland VDO definitions of PD Revision 2.0 as they are still used in
> > PD2.0 products.
> >
> > Fixes: 0e1d6f55a12e ("usb: pd: Update VDO definitions")
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >  include/linux/usb/pd_vdo.h | 69 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 66 insertions(+), 3 deletions(-)
> >
> Is there any chance that you have free time to verify this patch with
> CrOS configuration?
>
> thanks,
> Kyle
>

Hi,

I tried to enable the config "CONFIG_CROS_EC_TYPEC=m" and it can make now.

thanks,
Kyle

> > diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> > index e9b6822c54c2..5de7f550f93e 100644
> > --- a/include/linux/usb/pd_vdo.h
> > +++ b/include/linux/usb/pd_vdo.h
> > @@ -110,6 +110,10 @@
> >   * <20:16>  :: Reserved, Shall be set to zero
> >   * <15:0>   :: USB-IF assigned VID for this cable vendor
> >   */
> > +
> > +/* PD Rev2.0 definition */
> > +#define IDH_PTYPE_UNDEF                0
> > +
> >  /* SOP Product Type (UFP) */
> >  #define IDH_PTYPE_NOT_UFP      0
> >  #define IDH_PTYPE_HUB          1
> > @@ -248,7 +252,25 @@
> >          | ((pnum) & 0x1f))
> >
> >  /*
> > - * Passive Cable VDO
> > + * Cable VDO (for both Passive and Active Cable VDO in PD Rev2.0)
> > + * ---------
> > + * <31:28> :: Cable HW version
> > + * <27:24> :: Cable FW version
> > + * <23:20> :: Reserved, Shall be set to zero
> > + * <19:18> :: type-C to Type-A/B/C/Captive (00b == A, 01 == B, 10 == C, 11 == Captive)
> > + * <17>    :: Reserved, Shall be set to zero
> > + * <16:13> :: cable latency (0001 == <10ns(~1m length))
> > + * <12:11> :: cable termination type (11b == both ends active VCONN req)
> > + * <10>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
> > + * <9>     :: SSTX2 Directionality support
> > + * <8>     :: SSRX1 Directionality support
> > + * <7>     :: SSRX2 Directionality support
> > + * <6:5>   :: Vbus current handling capability (01b == 3A, 10b == 5A)
> > + * <4>     :: Vbus through cable (0b == no, 1b == yes)
> > + * <3>     :: SOP" controller present? (0b == no, 1b == yes)
> > + * <2:0>   :: USB SS Signaling support
> > + *
> > + * Passive Cable VDO (PD Rev3.0+)
> >   * ---------
> >   * <31:28> :: Cable HW version
> >   * <27:24> :: Cable FW version
> > @@ -264,7 +286,7 @@
> >   * <4:3>   :: Reserved, Shall be set to zero
> >   * <2:0>   :: USB highest speed
> >   *
> > - * Active Cable VDO 1
> > + * Active Cable VDO 1 (PD Rev3.0+)
> >   * ---------
> >   * <31:28> :: Cable HW version
> >   * <27:24> :: Cable FW version
> > @@ -286,7 +308,9 @@
> >  #define CABLE_VDO_VER1_0       0
> >  #define CABLE_VDO_VER1_3       3
> >
> > -/* Connector Type */
> > +/* Connector Type (_ATYPE and _BTYPE are for PD Rev2.0 only) */
> > +#define CABLE_ATYPE            0
> > +#define CABLE_BTYPE            1
> >  #define CABLE_CTYPE            2
> >  #define CABLE_CAPTIVE          3
> >
> > @@ -323,12 +347,22 @@
> >  #define CABLE_CURR_3A          1
> >  #define CABLE_CURR_5A          2
> >
> > +/* USB SuperSpeed Signaling Support (PD Rev2.0) */
> > +#define CABLE_USBSS_U2_ONLY    0
> > +#define CABLE_USBSS_U31_GEN1   1
> > +#define CABLE_USBSS_U31_GEN2   2
> > +
> >  /* USB Highest Speed */
> >  #define CABLE_USB2_ONLY                0
> >  #define CABLE_USB32_GEN1       1
> >  #define CABLE_USB32_4_GEN2     2
> >  #define CABLE_USB4_GEN3                3
> >
> > +#define VDO_CABLE(hw, fw, cbl, lat, term, tx1d, tx2d, rx1d, rx2d, cur, vps, sopp, usbss) \
> > +       (((hw) & 0x7) << 28 | ((fw) & 0x7) << 24 | ((cbl) & 0x3) << 18          \
> > +        | ((lat) & 0x7) << 13 | ((term) & 0x3) << 11 | (tx1d) << 10            \
> > +        | (tx2d) << 9 | (rx1d) << 8 | (rx2d) << 7 | ((cur) & 0x3) << 5         \
> > +        | (vps) << 4 | (sopp) << 3 | ((usbss) & 0x7))
> >  #define VDO_PCABLE(hw, fw, ver, conn, lat, term, vbm, cur, spd)                        \
> >         (((hw) & 0xf) << 28 | ((fw) & 0xf) << 24 | ((ver) & 0x7) << 21          \
> >          | ((conn) & 0x3) << 18 | ((lat) & 0xf) << 13 | ((term) & 0x3) << 11    \
> > @@ -395,6 +429,35 @@
> >          | ((hops) & 0x3) << 6 | (u2) << 5 | (u32) << 4 | (lane) << 3           \
> >          | (iso) << 2 | (gen))
> >
> > +/*
> > + * AMA VDO (PD Rev2.0)
> > + * ---------
> > + * <31:28> :: Cable HW version
> > + * <27:24> :: Cable FW version
> > + * <23:12> :: Reserved, Shall be set to zero
> > + * <11>    :: SSTX1 Directionality support (0b == fixed, 1b == cfgable)
> > + * <10>    :: SSTX2 Directionality support
> > + * <9>     :: SSRX1 Directionality support
> > + * <8>     :: SSRX2 Directionality support
> > + * <7:5>   :: Vconn power
> > + * <4>     :: Vconn power required
> > + * <3>     :: Vbus power required
> > + * <2:0>   :: USB SS Signaling support
> > + */
> > +#define VDO_AMA(hw, fw, tx1d, tx2d, rx1d, rx2d, vcpwr, vcr, vbr, usbss) \
> > +       (((hw) & 0x7) << 28 | ((fw) & 0x7) << 24                        \
> > +        | (tx1d) << 11 | (tx2d) << 10 | (rx1d) << 9 | (rx2d) << 8      \
> > +        | ((vcpwr) & 0x7) << 5 | (vcr) << 4 | (vbr) << 3               \
> > +        | ((usbss) & 0x7))
> > +
> > +#define PD_VDO_AMA_VCONN_REQ(vdo)      (((vdo) >> 4) & 1)
> > +#define PD_VDO_AMA_VBUS_REQ(vdo)       (((vdo) >> 3) & 1)
> > +
> > +#define AMA_USBSS_U2_ONLY      0
> > +#define AMA_USBSS_U31_GEN1     1
> > +#define AMA_USBSS_U31_GEN2     2
> > +#define AMA_USBSS_BBONLY       3
> > +
> >  /*
> >   * VPD VDO
> >   * ---------
> > --
> > 2.30.0.365.g02bc693789-goog
> >
