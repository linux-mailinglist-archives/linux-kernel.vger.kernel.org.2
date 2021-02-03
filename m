Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3730E1D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhBCSFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232365AbhBCSET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:04:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D81E64F8D;
        Wed,  3 Feb 2021 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612375417;
        bh=TTIVkRkgnia8XYsvPhgMP4dcZLIvLYeoer++KNF+4rs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oYS54+dIHjSdivO0SPEZDbzsIoTD9T/Q7HDyQiU3A7INrXlaJGLAhh9FW5sMlpECi
         Ac5Mhm1hFoodp8OS5zWB9vAsfWzWvo6RCwSB2Bwfa9ZpOJ44mtjOQSHAF003t4jVW/
         4zClHT6oE3Ip9kFDavAr0mWqRdeNuxIEUgNX9jnr0CcEAlgeyYZq1JzVPd+oKnB55X
         w2dnwHvMaxMzshQIJu3oi8H2bZs5T+0SelFtkKkZC60L1bpO6ir3Jy1ZRRLvS1D5S5
         xomF7Jqiao2CdmNiqh4yrStDX/joqdokmn3PBXRx2ZF3pPZEjgob8dpF4KELKywWOl
         dv0IyS2oUJp4w==
Received: by mail-ed1-f50.google.com with SMTP id s5so677223edw.8;
        Wed, 03 Feb 2021 10:03:37 -0800 (PST)
X-Gm-Message-State: AOAM530oLRsJpdme7CgYWLWFtGI0OZzW8eawl93jwmshdh15q9vSk6a5
        D+Iqv0rZk2adbPWOHL2gb+br/tncLyVMxBAjNw==
X-Google-Smtp-Source: ABdhPJxQOdRcU5ihhtNjMKJJpTN75hiZpojKFrv2qs72Sy7gA8yZBnbJKaVP5dqo7dqqriM+Ja5srnywPI9TIMX4WQE=
X-Received: by 2002:aa7:c7c8:: with SMTP id o8mr4345989eds.137.1612375415522;
 Wed, 03 Feb 2021 10:03:35 -0800 (PST)
MIME-Version: 1.0
References: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
 <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com>
 <210b0e5a-767b-c285-62e2-23de19bd3cf1@xilinx.com> <CAL_Jsq+m7F+nD6VKd2L5i44hz32_-6iX3toZ0A0CBT-g7Xqu9g@mail.gmail.com>
 <a2f10400-51e5-bb76-f5c4-3b8e2fbc2793@xilinx.com> <20210203144344.4e261aea@slackpad.fritz.box>
 <CAL_JsqKfLM03of1Pzoxx=n_PaU9gnFuxt2zikGPuc1UkMK9PVQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKfLM03of1Pzoxx=n_PaU9gnFuxt2zikGPuc1UkMK9PVQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 3 Feb 2021 12:03:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjBWpL=gpcNxQnN8Gkp+e=gxOVVmsZuaOz2+uuQ3QTOA@mail.gmail.com>
Message-ID: <CAL_JsqJjBWpL=gpcNxQnN8Gkp+e=gxOVVmsZuaOz2+uuQ3QTOA@mail.gmail.com>
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

On Wed, Feb 3, 2021 at 10:49 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Feb 3, 2021 at 8:44 AM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > On Wed, 3 Feb 2021 15:15:19 +0100
> > Michal Simek <michal.simek@xilinx.com> wrote:
> >
> > > On 2/3/21 3:12 PM, Rob Herring wrote:
> > > > On Wed, Feb 3, 2021 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 2/1/21 6:41 PM, Rob Herring wrote:
> > > >>> On Mon, Feb 1, 2021 at 8:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > > >>>>
> > > >>>> The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
> > > >>>> v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
> > > >>>> commit
> > > >>>> "81e0919a3e21 checks: Add interrupt provider test"
> > > >>>> where reasons for this checking are mentioned as
> > > >>>> "A missing #address-cells property is less critical, but creates
> > > >>>> ambiguities when used in interrupt-map properties, so warn about this as
> > > >>>> well now."
> > > >>>>
> > > >>>> Add address-cells property to gic and gpio nodes to get rid of this warning.
> > > >>>> The similar change has been done for ZynqMP too.
> > > >>>
> > > >>> FYI, we're going to make this check dependent on having an
> > > >>> interrupt-map property. So adding these isn't necessary.
> > > >>
> > > >> Good to know. Is there going to be report if interrupt-map doesn't
> > > >> exist? Which can end up with reverting these changes?
> > > >
> > > > You mean a warning if '#address-cells' is present and interrupt-map is
> > > > not? No, that would cause lots of warnings.
> > >
> > > yep.
> >
> > Why would we do that? That sounds dangerous and would be broken if the
> > IRQ controller is in a generic .dtsi (as it usually is), but the
> > interrupt map is only in *some* of the board .dts files.
> >
> > What is the problem of just putting #address-cells = <0>; in the
> > IRQ controller node, after checking that there currently no interrupt
> > maps in use and no IRQ children? And be safe for good? That's 16 bytes
> > in the DTB, IIUC.
>
> Because I don't think we need a bunch of warning fix patches to add
> these everywhere. Also, the need for #address-cells pretty much makes
> no sense on any modern system. It is a relic from days when the bus
> (address) topology and interrupt topology were related.
>
> > Because otherwise we have that lovely ambiguity between the
> > implicit default #address-cells = 2; and the assumed default of 0.
> >
> > And that's why I think we also cannot *automatically* add an #ac = <0>;
> > property, because that would change behaviour.
>
> I'd rather try to limit where we assume the default of 2. My guess is
> that's only some combination of old PowerPC and/or Sparc and no FDT
> based DT.

Actually, after reviewing of_irq_parse_raw() again, I think you're
mixing the 2 different #address-cells involved. Let's review which
#*-cells applies to parts of interrupt-map:

interrupt-map = <[ac current node or parent] [ic current node] [parent
intc phandle] [ac parent intc] [ic parent intc]>;

For [ac current node or parent], we start in the 'interrupt-map' node
(because it's the interrupt parent). From there, we walk up the tree
to find #address-cells. Worst case is we find none and take the
default of 2. First, dtc has pretty much always made no root
#address-cells a warning. Second, Linux has notion of a default and
that varies by arch and isn't used here. Only Sparc defaults to 2 (see
of_private.h) which means we should never hit the default on PowerPC
or Arm (or anything else).

The #address-cells the fix here addresses is the [parent intc
phandle]'s for [ac parent intc] cells. This default is 0 (see
newaddrsize in of_irq_parse_raw()). So really, we only need to be
checking for #address-cells in nodes with interrupt-map.

Rob
