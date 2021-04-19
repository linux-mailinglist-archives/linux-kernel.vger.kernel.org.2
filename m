Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339F736419B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbhDSMYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 08:24:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58259 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhDSMYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:24:22 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lYSwS-0007ru-JZ
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 12:23:52 +0000
Received: by mail-ed1-f69.google.com with SMTP id n18-20020a0564020612b02903853320059eso2061658edv.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 05:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9RbFGgUfh9R1pGM9X22W/pCvHlFibz2pAB/20DyBvc=;
        b=lGd6ucT5kT1+DuOI/yhBVQPwtOeKMuexvn474Dmek42kUTaEcygWE4hnn6SsYiDOac
         PdNE3bOL55V2FYq0XM1fKqdW84JbyhBDrgNiQPaI4JMrFCu7u/vcgCKzkLxQcMlkiGfN
         lbHDQOlHdqafcJ8ZZMC2d2KZTV1u1F6CzJUep9122eRhxsfDoQPMezTLAxWJUXkzIrEr
         fE2a1wPa0mogr+pbskYhE4m4GUE+JHFH9Rb5vyEpkGOfKai92sJA86L44qaS+Cq/Hdcw
         E7cjzFPGV6a9I2YH8UrjduLFZpXWocC/nSsw4zUBpJoEL+lRWM6JXz593u3jxe2OCIaM
         Bi+Q==
X-Gm-Message-State: AOAM530ggRAaQyzxfG42opD+oBRGzJxAELMhV/0lJx7mBM5+PKXfBXZt
        BvncLunQEnMMIwmHqHDyeTcaBV/YKlK6WRhJqDJa3QKHk/8884UsTNhwlZRiD8d7gnPvPBsuarN
        AQmo/J2VHSKC+OB509sI9i8TcUcKzP/v7krJK77RM8R5AlFAkj05WomMz7A==
X-Received: by 2002:ac2:559c:: with SMTP id v28mr12392219lfg.290.1618834651351;
        Mon, 19 Apr 2021 05:17:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZVAJt8pj4926EE+AA+D7ohFpNGRoRawnmzYkLavLiDvAptySqRSEF4uEolMuh029IJJSJPBB8U5CMzZJKe2E=
X-Received: by 2002:ac2:559c:: with SMTP id v28mr12392207lfg.290.1618834651099;
 Mon, 19 Apr 2021 05:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210419090750.1272562-1-kai.heng.feng@canonical.com> <CAJZ5v0imLOF-9VCSJdb-A2HR29SFX-HgU5Kh7Uf7COfuHpZMDg@mail.gmail.com>
In-Reply-To: <CAJZ5v0imLOF-9VCSJdb-A2HR29SFX-HgU5Kh7Uf7COfuHpZMDg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 19 Apr 2021 20:17:20 +0800
Message-ID: <CAAd53p7F8oPytk8GTZRULw4m2y7jJ8vPx-drnSbW4e-3vvVz9Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Invoke _PTS for s2idle
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 7:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Apr 19, 2021 at 11:08 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > HP EliteBook 840 G8 reboots on s2idle resume, and HP EliteBook 845 G8
> > wakes up immediately on s2idle. Both are caused by the XMM7360 WWAN PCI
> > card.
> >
> > There's a WWAN specific method to really turn off the WWAN via EC:
> >     Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
> >     {
> >     ...
> >         If (CondRefOf (\_SB.PCI0.GP12.PTS))
> >         {
> >             \_SB.PCI0.GP12.PTS (Arg0)
> >         }
> >     ...
> >     }
> >
> >     Scope (_SB.PCI0.GP12)
> >     {
> >     ...
> >         Method (PTS, 1, Serialized)
> >         {
> >             If (^^LPCB.EC0.ECRG)
> >             {
> >                 If ((PDID == 0xFFFF))
> >                 {
> >                     Return (Zero)
> >                 }
> >
> >                 POFF ()
> >                 SGIO (WWBR, One)
> >                 Sleep (0x1E)
> >                 Acquire (^^LPCB.EC0.ECMX, 0xFFFF)
> >                 ^^LPCB.EC0.WWP = One
> >                 Release (^^LPCB.EC0.ECMX)
> >                 Sleep (0x01F4)
> >             }
> >
> >             Return (Zero)
> >         }
> >     ...
> >     }
> >
> > So let's also invok _PTS for s2idle.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/acpi/sleep.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index 09fd13757b65..7e84b4b09919 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -698,6 +698,7 @@ int acpi_s2idle_prepare(void)
> >         }
> >
> >         acpi_enable_wakeup_devices(ACPI_STATE_S0);
> > +       acpi_enter_sleep_state_prep(ACPI_STATE_S0);
>
> The system is in S0 already at this point, so not really.

Ok, indeed ACPI spec only states _PTS can be used for S1 to S5.

> Please use a quirk to address this.

Let me discuss with HP folks. Right now it looks like we need to apply
this to all HP systems...

Kai-Heng

>
> >
> >         /* Change the configuration of GPEs to avoid spurious wakeup. */
> >         acpi_enable_all_wakeup_gpes();
> > --
