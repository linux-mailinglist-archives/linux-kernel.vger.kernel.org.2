Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007B830FE0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbhBDUUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239971AbhBDUUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:20:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F6E164F6A;
        Thu,  4 Feb 2021 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612469354;
        bh=ZbLhFh9ekMPZ7GsNUm17lM69d0KfshZaVXI3G/nk2ms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Npo7RmNAZ6aSCRqxm4nVlbaC/27YVRcbCPdd/fbIg19/B+FHezlIum4hWxlFIF7ON
         HMOxuGrqn9JuVV79dSuBTZghrifXAnGKneLW7L/czTVKPl1MzkLQbuw3PahK1Amqy2
         cnBZC/y1Ot1iy8ll6/IASEqB/ZdXLA7vrWkAmhvhtZHqT0hFRmnEt66ImRMlB13Icx
         NtJeNk/LaUOIDjpJBVB9ebf1u9+lZOn+UsBT1S/liZzVG46TrZcZ4mHf1BkmjlJL5G
         2cvkY+S7xZ8ThK83wbkfkmvi5O4WLdd7xBdUeGvpLT+Ss3FBG7ySG8TNHT77tD85JA
         NkkFlyHwtO0Lg==
Received: by mail-ed1-f47.google.com with SMTP id s26so46656edt.10;
        Thu, 04 Feb 2021 12:09:14 -0800 (PST)
X-Gm-Message-State: AOAM531K4uYq6IDJ93BAFYjox0VBQjP8N2zqqGGaHHen5cBcWwemTJcd
        SCrjjyK05ugEGQarzr138Q9rU1Iqz4dJrQN67w==
X-Google-Smtp-Source: ABdhPJyUV5HEhzX+4uiSU3UPrmRnNReleaqLxoxL2nV/uRrWwsFnvLuMCAGXLzBp06xeHA/+3g2JdEtwmOqvoL43N+E=
X-Received: by 2002:aa7:c906:: with SMTP id b6mr311329edt.194.1612469352891;
 Thu, 04 Feb 2021 12:09:12 -0800 (PST)
MIME-Version: 1.0
References: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
 <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com>
 <210b0e5a-767b-c285-62e2-23de19bd3cf1@xilinx.com> <CAL_Jsq+m7F+nD6VKd2L5i44hz32_-6iX3toZ0A0CBT-g7Xqu9g@mail.gmail.com>
 <a2f10400-51e5-bb76-f5c4-3b8e2fbc2793@xilinx.com> <20210203144344.4e261aea@slackpad.fritz.box>
 <CAL_JsqKfLM03of1Pzoxx=n_PaU9gnFuxt2zikGPuc1UkMK9PVQ@mail.gmail.com> <CAL_JsqJjBWpL=gpcNxQnN8Gkp+e=gxOVVmsZuaOz2+uuQ3QTOA@mail.gmail.com>
In-Reply-To: <CAL_JsqJjBWpL=gpcNxQnN8Gkp+e=gxOVVmsZuaOz2+uuQ3QTOA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 4 Feb 2021 14:09:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++DyiKG9smQGx9FAPDJnVrezcXNb0Y5uh-5_2GBzTQpQ@mail.gmail.com>
Message-ID: <CAL_Jsq++DyiKG9smQGx9FAPDJnVrezcXNb0Y5uh-5_2GBzTQpQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: zynq: Add address-cells property to interrupt controllers
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 12:03 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Feb 3, 2021 at 10:49 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Feb 3, 2021 at 8:44 AM Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > On Wed, 3 Feb 2021 15:15:19 +0100
> > > Michal Simek <michal.simek@xilinx.com> wrote:
> > >
> > > > On 2/3/21 3:12 PM, Rob Herring wrote:
> > > > > On Wed, Feb 3, 2021 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > > > >>
> > > > >>
> > > > >>
> > > > >> On 2/1/21 6:41 PM, Rob Herring wrote:
> > > > >>> On Mon, Feb 1, 2021 at 8:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > > > >>>>
> > > > >>>> The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
> > > > >>>> v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
> > > > >>>> commit
> > > > >>>> "81e0919a3e21 checks: Add interrupt provider test"
> > > > >>>> where reasons for this checking are mentioned as
> > > > >>>> "A missing #address-cells property is less critical, but creates
> > > > >>>> ambiguities when used in interrupt-map properties, so warn about this as
> > > > >>>> well now."
> > > > >>>>
> > > > >>>> Add address-cells property to gic and gpio nodes to get rid of this warning.
> > > > >>>> The similar change has been done for ZynqMP too.
> > > > >>>
> > > > >>> FYI, we're going to make this check dependent on having an
> > > > >>> interrupt-map property. So adding these isn't necessary.
> > > > >>
> > > > >> Good to know. Is there going to be report if interrupt-map doesn't
> > > > >> exist? Which can end up with reverting these changes?
> > > > >
> > > > > You mean a warning if '#address-cells' is present and interrupt-map is
> > > > > not? No, that would cause lots of warnings.
> > > >
> > > > yep.
> > >
> > > Why would we do that? That sounds dangerous and would be broken if the
> > > IRQ controller is in a generic .dtsi (as it usually is), but the
> > > interrupt map is only in *some* of the board .dts files.
> > >
> > > What is the problem of just putting #address-cells = <0>; in the
> > > IRQ controller node, after checking that there currently no interrupt
> > > maps in use and no IRQ children? And be safe for good? That's 16 bytes
> > > in the DTB, IIUC.
> >
> > Because I don't think we need a bunch of warning fix patches to add
> > these everywhere. Also, the need for #address-cells pretty much makes
> > no sense on any modern system. It is a relic from days when the bus
> > (address) topology and interrupt topology were related.
> >
> > > Because otherwise we have that lovely ambiguity between the
> > > implicit default #address-cells = 2; and the assumed default of 0.
> > >
> > > And that's why I think we also cannot *automatically* add an #ac = <0>;
> > > property, because that would change behaviour.
> >
> > I'd rather try to limit where we assume the default of 2. My guess is
> > that's only some combination of old PowerPC and/or Sparc and no FDT
> > based DT.
>
> Actually, after reviewing of_irq_parse_raw() again, I think you're
> mixing the 2 different #address-cells involved. Let's review which
> #*-cells applies to parts of interrupt-map:
>
> interrupt-map = <[ac current node or parent] [ic current node] [parent
> intc phandle] [ac parent intc] [ic parent intc]>;
>
> For [ac current node or parent], we start in the 'interrupt-map' node
> (because it's the interrupt parent). From there, we walk up the tree
> to find #address-cells. Worst case is we find none and take the
> default of 2. First, dtc has pretty much always made no root
> #address-cells a warning. Second, Linux has notion of a default and
> that varies by arch and isn't used here. Only Sparc defaults to 2 (see
> of_private.h) which means we should never hit the default on PowerPC
> or Arm (or anything else).

Actually, Sparc doesn't even use this code. Turns out PowerPC is a bit
more complicated.

I traced where the '2' in this code came from. PowerPC had a mixture
of the default being 1 or 2. For the interrupt parsing code, it was 1
(from prom_n_addr_cells()) before commit 0ebfff1491ef and 2
(hardcoded) after it. That's not the only place that a default was
set. The early_init_dt_scan_root() function at that time defaulted to
2. Now it's 1 as we added per arch default defines which used the '1'
from prom_n_addr_cells() (now of_n_addr_cells()). So in conclusion,
PowerPC has had a mixture of defaults and no one cared since 2006 when
it changed. I'm inclined to rip out these defaults and just fail.

Rob
