Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D412930E00A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhBCQu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhBCQuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:50:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C697A64F7C;
        Wed,  3 Feb 2021 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612370983;
        bh=9XENJ0HnM6JyUCLfiAwRo4hmqvm8LiTUr0z15OUhUK8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NpNvTOhhYlckCnP+jzFvqG15tQE0qUzvjEEY16Sko8o+bYSpuUdOb67RV63OlglFR
         zyQles57FiJZ/Nzf3P2IJy58SvUHMmb323PO+UT4D/IqWG48r6+mdc2hBFPMK6+uJ8
         Hxch/dipnDemgDJKvw0r1M1Wz2Vb0F9BoLJRsjgnPBIObLM5L3o5HyxRLVnMoOZhDr
         xnc43guWEi71Xtc5ziwutkHmzkb8XCWajwB1PfVhOKYWsD2Qa3nTdl+gCQeqdx5Qd6
         FEc3ycxF6J04OA0G9WSLpA4M0OIuLFHKH50OrqNWAumA44IFytqhlMBEuGlXqQjW6N
         Rhyi78rPsXFog==
Received: by mail-ed1-f49.google.com with SMTP id c6so432241ede.0;
        Wed, 03 Feb 2021 08:49:42 -0800 (PST)
X-Gm-Message-State: AOAM530/nYFYQOlKuU1FAthvjCEdatoAsqrFw9Bp3sCwLsbsWyq9PI7z
        T5JDG9wVWAGRhM65DEPNC96vPPSH7CCtywGl/g==
X-Google-Smtp-Source: ABdhPJxMmS6b6aSLwPk/md2549ocqhvcpGA3RF/qCBD0XqRCNO3D7pGtanOod4uSX09SicOxfSQwgUx1C9osglS4Oq0=
X-Received: by 2002:a05:6402:6c7:: with SMTP id n7mr3971188edy.289.1612370981263;
 Wed, 03 Feb 2021 08:49:41 -0800 (PST)
MIME-Version: 1.0
References: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
 <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com>
 <210b0e5a-767b-c285-62e2-23de19bd3cf1@xilinx.com> <CAL_Jsq+m7F+nD6VKd2L5i44hz32_-6iX3toZ0A0CBT-g7Xqu9g@mail.gmail.com>
 <a2f10400-51e5-bb76-f5c4-3b8e2fbc2793@xilinx.com> <20210203144344.4e261aea@slackpad.fritz.box>
In-Reply-To: <20210203144344.4e261aea@slackpad.fritz.box>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 3 Feb 2021 10:49:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKfLM03of1Pzoxx=n_PaU9gnFuxt2zikGPuc1UkMK9PVQ@mail.gmail.com>
Message-ID: <CAL_JsqKfLM03of1Pzoxx=n_PaU9gnFuxt2zikGPuc1UkMK9PVQ@mail.gmail.com>
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

On Wed, Feb 3, 2021 at 8:44 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Wed, 3 Feb 2021 15:15:19 +0100
> Michal Simek <michal.simek@xilinx.com> wrote:
>
> > On 2/3/21 3:12 PM, Rob Herring wrote:
> > > On Wed, Feb 3, 2021 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2/1/21 6:41 PM, Rob Herring wrote:
> > >>> On Mon, Feb 1, 2021 at 8:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > >>>>
> > >>>> The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
> > >>>> v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
> > >>>> commit
> > >>>> "81e0919a3e21 checks: Add interrupt provider test"
> > >>>> where reasons for this checking are mentioned as
> > >>>> "A missing #address-cells property is less critical, but creates
> > >>>> ambiguities when used in interrupt-map properties, so warn about this as
> > >>>> well now."
> > >>>>
> > >>>> Add address-cells property to gic and gpio nodes to get rid of this warning.
> > >>>> The similar change has been done for ZynqMP too.
> > >>>
> > >>> FYI, we're going to make this check dependent on having an
> > >>> interrupt-map property. So adding these isn't necessary.
> > >>
> > >> Good to know. Is there going to be report if interrupt-map doesn't
> > >> exist? Which can end up with reverting these changes?
> > >
> > > You mean a warning if '#address-cells' is present and interrupt-map is
> > > not? No, that would cause lots of warnings.
> >
> > yep.
>
> Why would we do that? That sounds dangerous and would be broken if the
> IRQ controller is in a generic .dtsi (as it usually is), but the
> interrupt map is only in *some* of the board .dts files.
>
> What is the problem of just putting #address-cells = <0>; in the
> IRQ controller node, after checking that there currently no interrupt
> maps in use and no IRQ children? And be safe for good? That's 16 bytes
> in the DTB, IIUC.

Because I don't think we need a bunch of warning fix patches to add
these everywhere. Also, the need for #address-cells pretty much makes
no sense on any modern system. It is a relic from days when the bus
(address) topology and interrupt topology were related.

> Because otherwise we have that lovely ambiguity between the
> implicit default #address-cells = 2; and the assumed default of 0.
>
> And that's why I think we also cannot *automatically* add an #ac = <0>;
> property, because that would change behaviour.

I'd rather try to limit where we assume the default of 2. My guess is
that's only some combination of old PowerPC and/or Sparc and no FDT
based DT.

Rob
