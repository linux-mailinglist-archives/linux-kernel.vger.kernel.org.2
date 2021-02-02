Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095A930C292
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhBBOyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhBBOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:53:19 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816B1C061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 06:52:38 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id u16so9970845qvo.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHYghtKgrrWF03mk9TitT4grGLLx+SPuNZIfRbTgwjs=;
        b=EDkwE2MIBgfcCVyclcD1ro/CbUNsnvbLiSvMmF6GYFKIdZ+tHW80JZzcPprPQfu/56
         Gap6aPwG6at8Wuxk+GOFrjhPbQOJvV4s4eATU0XLHv2u925tjQeEHpyesey3aK94nOh5
         Q3zExIAYjogRb0HB+fitmbovUkJjB8CDbtFUx/QXDdulecqqiaEvM3FgRuRWJ/XvUXvW
         t4Kq6yhXP6MII+Zsoy/Ehz1BMfBzMnRM4GMQU8ZhUFnL7HITwhB25tZwpo/rm2ElkwWk
         ClwbEsGdBeKBMgKuZT7dPJ9h/JzdQjTtqKbNsEfC1rzhCG58lSbfi5JRHlATmYiwVBcC
         Vpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHYghtKgrrWF03mk9TitT4grGLLx+SPuNZIfRbTgwjs=;
        b=YknMg/v4bAzjQJslrra0Dvh7iLsjo95tbxCVs2lYe6d9veov+WYtUtPuNDul0/I+yo
         BmIklkeu1zt2v5I1LDuezin+OwVx0Yg9pAf4fkoHR5/MIThgjThnhLrQwxTEhi0sXVuy
         oIVDD9Aa7Fy4Da39Y91qFKKPjEcM27eAapGPef13Rb8g+c6fu6QQxz+rIbR2LjDxjk7H
         8Zo1R6fSlr5ykkHTafJpAhmCJhK76vLvsLLSUswIlg3o2z09vGs/sUDX3GA+y72YAiKA
         fB79lcrvRx05JmJEt8+AwSnZyOPL2PLrQeQvdQu20AQcje005DRzh3LSCjWzVe+BVo8/
         Tqvw==
X-Gm-Message-State: AOAM531jqDhJa2etgGpa1P2ROCHU1fX6DsS7vnAYkbj4cA4QOJGGAXxA
        brYwZdhu6n1H7vcoU6SPbd0tgGX/PLDvD+WUYGedqw==
X-Google-Smtp-Source: ABdhPJza+1g64XyZy4xiMZ4LGVCInev5SV0wGZG03qN07O7bnY8bhuW1nAPtgxWkJ9AeouksqQ0K33Fc+O0DI5WxDe4=
X-Received: by 2002:a05:6214:11ab:: with SMTP id u11mr20540119qvv.17.1612277557310;
 Tue, 02 Feb 2021 06:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20210202093342.738691-1-kyletso@google.com> <20210202093342.738691-4-kyletso@google.com>
 <029f8d48-8932-8a2c-4edf-df73d66b21b5@roeck-us.net>
In-Reply-To: <029f8d48-8932-8a2c-4edf-df73d66b21b5@roeck-us.net>
From:   Kyle Tso <kyletso@google.com>
Date:   Tue, 2 Feb 2021 22:52:21 +0800
Message-ID: <CAGZ6i=1dQrT89GpC=zxRnUae1ee40djiqYRWwQu9irheJuCcsQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] usb: pd: Make SVDM Version configurable in VDM header
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, robh+dt@kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 10:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/2/21 1:33 AM, Kyle Tso wrote:
> > PD Rev 3.0 introduces SVDM Version 2.0. This patch makes the field
> > configuable in the header in order to be able to be compatible with
> > older SVDM version.
> >
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >  include/linux/usb/pd_vdo.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> > index e9b6822c54c2..69ed6929ce6e 100644
> > --- a/include/linux/usb/pd_vdo.h
> > +++ b/include/linux/usb/pd_vdo.h
> > @@ -21,22 +21,24 @@
> >   * ----------
> >   * <31:16>  :: SVID
> >   * <15>     :: VDM type ( 1b == structured, 0b == unstructured )
> > - * <14:13>  :: Structured VDM version (can only be 00 == 1.0 currently)
> > + * <14:13>  :: Structured VDM version
> >   * <12:11>  :: reserved
> >   * <10:8>   :: object position (1-7 valid ... used for enter/exit mode only)
> >   * <7:6>    :: command type (SVDM only?)
> >   * <5>      :: reserved (SVDM), command type (UVDM)
> >   * <4:0>    :: command
> >   */
> > -#define VDO(vid, type, custom)                               \
> > +#define VDO(vid, type, ver, custom)                  \
> >       (((vid) << 16) |                                \
> >        ((type) << 15) |                               \
> > +      ((ver) << 13) |                                \
> >        ((custom) & 0x7FFF))
> >
>
> Yu have to fix all users of VDO() as well, or the code will
> no longer compile after this patch.
>
> Guenter
>
That's right!
Fix incoming...

thanks,
Kyle
