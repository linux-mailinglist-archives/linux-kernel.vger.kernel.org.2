Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9233F01F9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhHRKsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhHRKsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:48:16 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 03:47:42 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b200so2085427iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ga1LKRsZo7FK/NouAlLZlaG+OrM/2OOXzxvNw7QH1pY=;
        b=F2NorgIHAJhbf6tz6BnTD5Y/gRyF8xmpMTGWjYyvcD7Mmcp9o1gChPKOaAl4fKO2ql
         H27NJBx0GwIStUxQL/xSf8yr7RQQ9M5PYvosoCFjFmlxJhClCBU2gyTE2BGLMHnnx2kn
         ti2GyEFhOn/IzyYSqQp9aU6yzj4B9elG3FbY8G505EyirOtoGE4Rl0occszcViz/p5NK
         RSsnU1vmc5O1ZlwzMxkKjnx2fihbWNBOMAVLVxxBb2NCLXX0v/XfJy7AA2VKnkt13/W6
         lJqsE4/5nJAx3yUECdaR9G1cCbwYP7vjWD46WE5bUAyA/wmP5k7uKAGRWFyD3eL4vZZI
         wsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ga1LKRsZo7FK/NouAlLZlaG+OrM/2OOXzxvNw7QH1pY=;
        b=hPBtkR0cE8VcZXFcKgLQJC+FIQWubV2jvqBUojvmssb9kjmhyoEE7pACCKRtT2UGaW
         UfS0Ho7xiI8fw0CalqdjVOjtSB+lv2lZnBC5pRl3AYj0Ab8zu1Gs4mrupj9orzRK69p6
         IsuWdhzDbPx8lfXxJDuM8rhOtfMx+d1mD54ttfOFWBTrEN3/NLqdSL3O5T4d+8EnOyjM
         5aW9s/VNP/pZ+3bzYZClGLZnlzYW1jkftzEU+HiRHIJDWhxg6h9p4s7Y/m2EOvNg3IZU
         hp94NSAZIuFAPwc8nS1IquStbcKr/Fc48Ag+q6j4EFLX7DipDcCI5BOMKQDurmkFyEwn
         oxXQ==
X-Gm-Message-State: AOAM532XJMS23AOxvx1GRvIDjVKXrbLj9kbZWe7hI+npHdT8ErXpoLpq
        l6Wv4JuvDTmBX8L74VX3FlyhDjW988w+kKaf5Gavsw==
X-Google-Smtp-Source: ABdhPJzuHyL/CVzMxRmpjdQbzLa4rT0Rz+GMpQ4XETcR0XMaCBK7DdFz0G1GK1bAG4b6C+3ukCNkhYf1RaSiVc/o8Bs=
X-Received: by 2002:a05:6638:974:: with SMTP id o20mr7277374jaj.10.1629283661292;
 Wed, 18 Aug 2021 03:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210813043131.833006-1-icenowy@aosc.io> <YRuDG78N2mB5w37p@kuha.fi.intel.com>
 <58034df4-f18c-ab3e-1fcc-dc85fc35320f@roeck-us.net> <CAGZ6i=1s9X58tOwoiGAxMkMVBTyGTjysOSe9bP8Q4WosmCtymw@mail.gmail.com>
 <ADFCCA37-D216-407A-BDC6-01DB7F14548B@aosc.io>
In-Reply-To: <ADFCCA37-D216-407A-BDC6-01DB7F14548B@aosc.io>
From:   Kyle Tso <kyletso@google.com>
Date:   Wed, 18 Aug 2021 18:47:25 +0800
Message-ID: <CAGZ6i=0e7OoaR-K56ka8PzXsd=whgaqYZ3JsZW2uKE2PBQd+oQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 5:27 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2021=E5=B9=B48=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
4:02:24, Kyle Tso <kyletso@google.com> =E5=86=99=E5=88=B0:
> >On Tue, Aug 17, 2021 at 11:13 PM Guenter Roeck <linux@roeck-us.net> wrot=
e:
> >>
> >> On 8/17/21 2:36 AM, Heikki Krogerus wrote:
> >> > On Fri, Aug 13, 2021 at 12:31:31PM +0800, Icenowy Zheng wrote:
> >> >> Currently, TCPM code omits discover when swapping to gadget, and as=
sume
> >> >> that no altmodes are available when swapping from gadget. However, =
we do
> >> >> send discover when we get attached as gadget -- this leads to modes=
 to be
> >> >> discovered twice when attached as gadget and then swap to host.
> >> >>
> >> >> Always re-send discover when swapping DR, regardless of what change=
 is
> >> >> being made; and because of this, the assumption that no altmodes ar=
e
> >> >> registered with gadget role is broken, and altmodes de-registeratio=
n is
> >> >> always needed now.
> >> >>
> >> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> >> ---
> >> >>   drivers/usb/typec/tcpm/tcpm.c | 9 ++++-----
> >> >>   1 file changed, 4 insertions(+), 5 deletions(-)
> >> >>
> >> >> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm=
/tcpm.c
> >> >> index b9bb63d749ec..ab6d0d51ee1c 100644
> >> >> --- a/drivers/usb/typec/tcpm/tcpm.c
> >> >> +++ b/drivers/usb/typec/tcpm/tcpm.c
> >> >> @@ -4495,15 +4495,14 @@ static void run_state_machine(struct tcpm_p=
ort *port)
> >> >>              tcpm_set_state(port, ready_state(port), 0);
> >> >>              break;
> >> >>      case DR_SWAP_CHANGE_DR:
> >> >> -            if (port->data_role =3D=3D TYPEC_HOST) {
> >> >> -                    tcpm_unregister_altmodes(port);
> >> >> +            tcpm_unregister_altmodes(port);
> >> >> +            if (port->data_role =3D=3D TYPEC_HOST)
> >> >>                      tcpm_set_roles(port, true, port->pwr_role,
> >> >>                                     TYPEC_DEVICE);
> >> >> -            } else {
> >> >> +            else
> >> >>                      tcpm_set_roles(port, true, port->pwr_role,
> >> >>                                     TYPEC_HOST);
> >> >> -                    port->send_discover =3D true;
> >> >> -            }
> >> >> +            port->send_discover =3D true;
> >> >>              tcpm_ams_finish(port);
> >> >>              tcpm_set_state(port, ready_state(port), 0);
> >> >>              break;
> >> >
> >> > Why is it necessary to do discovery with data role swap in general?
> >> >
> >> > thanks,
> >> >
> >>
> >> Additional question: There are two patches pending related to DR_SWAP
> >> and discovery. Are they both needed, or do they both solve the same
> >> problem ?
> >>
> >> Thanks,
> >> Guenter
> >
> >Hi, I just noticed this patch.
> >
> >Part of this patch and part of my patch
> >https://lore.kernel.org/r/20210816075449.2236547-1-kyletso@google.com
> >are to solve the same problem that Discover_Identity is not sent in a
> >case where the port becomes UFP after DR_SWAP while in PD3.
> >
> >The difference (for the DR_SWAP part) is that my patch does not set
> >the flag "send_discover" if the port becomes UFP after PD2 DR_SWAP.
> >That is because in PD2 Spec, UFP is not allowed to be the SVDM
> >Initiator.
> >
> >This patch indeed solves another problem where
> >tcpm_unregister_altmodes should be called during PD3 DR_SWAP because
> >the port partner may return mode data in the latest Discover_Mode. For
> >the PD2 case, I don't think it needs to be called because PD2 DFP will
> >always return NAK for Discover_Mode. However it is fine because it is
>
> It sounds like my dock is doing something against the specification...
>
> It sends altmodes rather than NAK when my board gets attached as
> UFP and send bogus discovers (because of bugs of current TCPM
> code). These altmodes are then registered in TCPM and never get
> cleaned up within it, which leads to conflict when the dock is
> removed and then re-inserted.
>

Could you provide more details?
1. Is the connection in PD3 ?
2. Could you provide the tcpm logs?

> (BTW is it neceesary for data role and power role to be the same
> when attaching? My board now gets attached as UFP to drain
> power, and then do DR_SWAP to become USB host.)
>

Either Sink/UFP or Source/DFP in the beginning. Then DR_SWAP is okay
when both ports are in ready state. Your dock looks like a Sourcing
Device.

Type-C Spec:
```
4.8.4 Sourcing Device

A Sourcing Device is a special sub-class of a DRP that is capable of
supplying power, but is not capable of acting as a USB host. For
example a hub=E2=80=99s UFP or a monitor=E2=80=99s UFP that operates as a d=
evice but
not as a host.

The Sourcing Device shall follow the rules for a DRP (See Section
4.5.1.4 and Figure 4-15). It shall also follow the requirements for
the Source as Power Source (See Section 4.8.1). The Sourcing Device
shall support USB PD and shall support the DR_Swap command in order to
enable the Source to assume the UFP data role.
```

thanks,
Kyle

> >safe to call tcpm_unregister_altmodes even if there is no mode data.
> >
> >In fact, when I was tracing the code I found another bug. PD2 UFP is
> >not allowed to send Discover_Identity and Discover_Mode. I can send
> >another patch to address this problem.
> >
> >thanks,
> >Kyle
