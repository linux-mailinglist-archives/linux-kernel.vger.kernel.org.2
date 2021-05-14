Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B71380525
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhENI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhENI0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:26:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED0EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:25:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u21so43496062ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PV2s94YrOisqT7vMow1MSTArbLb4x54m3t4M6sxYgd4=;
        b=mszs3i61VpgEcW+HhPVGH8seTyGbkLh7fyiVAwvdyu5YG279nwzxdH0nq8ZJSwPTTO
         epGalcRCLv6KsUjFWW6RNzeua5NbNtseN5BrbXtMS3ZWuSkJ8Z4Tw1iCDHJ4jFWpDMBm
         DhansTsqpezKeGUTYk8MLDUY6vLuF2UzzK16AWXAE6kiT8trDSSkpp75J4+Re850oRfM
         1xInEBmHT5mOSj4sswnW0rVUvIKW2aCn1wURSi5nrTMbynQ9yEXxL+UTg+XBLrKu/SbA
         J1KuWq4yy8iM/BJfucYyNzbP6BlvIdLrDDIsHIxmMcDkrWT2Qlq9v6AWq9bPyzIPJ/mf
         q0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PV2s94YrOisqT7vMow1MSTArbLb4x54m3t4M6sxYgd4=;
        b=so8bfSq0Ix/xNzFJKh4sQmqSOD/YtaZShFchPgTJV1zw4uedmEgvfsfKG3hmSNiwmH
         S4XI/akVDfQg4r1wvqqmf/eac870FkHW2iYmjrTzOY8C8qG0vkgrN5sLQPSoSRSTFuf1
         L1YBC/mcilNfhY4IYZ5565NQWF9GKEsYJhDXq8EYdUTgMPsCmufK2tRZdPxu8XUOgcAh
         CsAZu8zdrK5g1eVXegfCk9dFYL6aqisI8i1Hu7g4C/7I+Hc1T9q2qnhmygBUH9j7BPMK
         k3OhuhUiBImZZ2+Hc8pw2f6a1lap/dUMUBnQmQ+XlSgjWaeT/HXJ083algy5W7S72yHK
         PKdg==
X-Gm-Message-State: AOAM532Hg+kZjV0iFplv04wf9veFN8iepxuYEVn4vtRxe9C0dluM0x3a
        aJXsTsoFTGNpk7s88nmlpsvTZ4UcohypbkABZqimag==
X-Google-Smtp-Source: ABdhPJzvcfolTJJGELzA1NbWGzfPhoG5rqgQHhAsYFVH5w6zh66Wfl3cLyM9JlAR/cDKDRUohcKGJin39+nb++iBxow=
X-Received: by 2002:a17:906:15c7:: with SMTP id l7mr26355348ejd.167.1620980718039;
 Fri, 14 May 2021 01:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210407123438.224551-1-mindal@semihalf.com> <20210511030658.GG3425@dragon>
 <AM0PR04MB67542D30A9424D455DB3ADD496539@AM0PR04MB6754.eurprd04.prod.outlook.com>
 <20210513021214.GJ3425@dragon> <20210513141921.i7sfmekbcw2m7vxd@skbuf>
 <CAPv3WKfnWFjfZw39avZBEyUpEsH2f=NCs8VfjeR+wzk4qV3GmA@mail.gmail.com> <20210513183102.6dflgb4v2oekdlq5@skbuf>
In-Reply-To: <20210513183102.6dflgb4v2oekdlq5@skbuf>
From:   =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>
Date:   Fri, 14 May 2021 10:25:07 +0200
Message-ID: <CAKpxNiyxDi66CXW4Z_exC=uy6mNbfhdBG5czgqNZqxmszegB0A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Thu, May 13, 2021 at 8:31 PM Vladimir Oltean <vladimir.oltean@nxp.com> w=
rote:
>
> Hi Marcin,
>
> On Thu, May 13, 2021 at 07:54:15PM +0200, Marcin Wojtas wrote:
> > Hi Vladimir,
> >
> > czw., 13 maj 2021 o 16:19 Vladimir Oltean <vladimir.oltean@nxp.com> nap=
isa=C5=82(a):
> > >
> > > On Thu, May 13, 2021 at 10:12:15AM +0800, Shawn Guo wrote:
> > > > On Tue, May 11, 2021 at 09:48:22AM +0000, Claudiu Manoil wrote:
> > > > > >-----Original Message-----
> > > > > >From: Shawn Guo <shawnguo@kernel.org>
> > > > > >Sent: Tuesday, May 11, 2021 6:07 AM
> > > > > [...]
> > > > > >Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE =
window
> > > > > >ranges
> > > > > >
> > > > > >+ Claudiu
> > > > > >
> > > > > >On Wed, Apr 07, 2021 at 02:34:38PM +0200, Kornel Duleba wrote:
> > > > > >> Currently all PCIE windows point to bus address 0x0, which doe=
s not match
> > > > > >> the values obtained from hardware during EA.
> > > > > >> Replace those values with CPU addresses, since in reality we
> > > > > >> have a 1:1 mapping between the two.
> > > > > >>
> > > > > >> Signed-off-by: Kornel Duleba <mindal@semihalf.com>
> > > > > >
> > > > > >Claudiu,
> > > > > >
> > > > > >Do you have any comment on this?
> > > > > >
> > > > >
> > > > > Well, probing is still working with this change, I've just tested=
 it.
> > > > >
> > > > > PCI listing at boot time changes from:
> > > > >
> > > > > pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 =
ranges:
> > > > > pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815f=
fff -> 0x0000000000
> > > > > pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cf=
fff -> 0x0000000000
> > > > >
> > > > > to:
> > > > >
> > > > > pci-host-generic 1f0000000.pcie: host bridge /soc/pcie@1f0000000 =
ranges:
> > > > > pci-host-generic 1f0000000.pcie:      MEM 0x01f8000000..0x01f815f=
fff -> 0x01f8000000
> > > > > pci-host-generic 1f0000000.pcie:      MEM 0x01f8160000..0x01f81cf=
fff -> 0x01f8160000
> > > > >
> > > > > and looks reasonable.
> > > > > Adding Vladimir and Alex just in case.
> > > > >
> > > > > Acked-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > > >
> > > > Thanks, Claudiu.
> > > >
> > > > Kornel,
> > > >
> > > > Do we need a Fixes tag for this patch?
> > > >
> > > > Shawn
> > >
> > > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > >
> > > I am not sure whether "incorrect data that is unused" deserves a Fixe=
s:
> > > tag or not, probably not.
> > >
> > > Bjorn Helgaas did point out before that "The fact that all these wind=
ows
> > > map to PCI bus address 0 looks broken", so there's that:
> > >
> > > https://patchwork.kernel.org/project/linux-pci/cover/20201129230743.3=
006978-1-kw@linux.com/
> > >
> > > And while it does look "broken", with the Enhanced Allocation capabil=
ity
> > > and the pci-host-ecam-generic driver, there is no address translation
> > > taking place, so no inbound/outbound windows are configured, so the
> > > range.pci_addr calculated in devm_of_pci_get_host_bridge_resources() =
is
> > > not used for anything except for printing.
> >
> > ...in Linux. Please note Linux device trees can be used as-is by other
> > projects. Regardless my opinion on how that's unfortunate, FreeBSD
> > does additional ranges check before performing EA and fails. Since the
> > current DT description is imo broken and the change is transparent for
> > Linux, it would be great to get this change merged into tree in case
> > there are are no objections.
>
> Just for my curiosity, can you please link me to the extra FreeBSD checks=
?

FreeBSD parses values from "ranges" and uses "rman" API to store them.
Now "rman", or Resource manager is used in the FreeBSD kernel to
manage memory regions.
In particular it checks if any two regions inserted into the same
"manager" overlap.
If they do it is treated as a fatal error, which in our case causes
the PCI driver to fail to probe.
code: https://github.com/freebsd/freebsd-src/blob/main/sys/dev/pci/pci_host=
_generic.c#L148.

>
> Anyway, I'm not sure what is more "broken", to have a "ranges" property
> when no address translation takes place, or for that "ranges" property
> to be set to a confusing "child address space" value. That's not to say
> I have an objection against Shawn merging the patch.
>
> My main point was slightly different though, the "ranges" property is
> currently mandatory, although in this case it provides no information
> which cannot be retrieved directly from the config space. Properties
> that have no other use except to be pedantic are, well, useless.
> Maybe we can do something about that too.
