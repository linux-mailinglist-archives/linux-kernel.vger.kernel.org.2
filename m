Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEFE30DD28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhBCOpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:45:30 -0500
Received: from foss.arm.com ([217.140.110.172]:41424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232948AbhBCOpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:45:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB3A211FB;
        Wed,  3 Feb 2021 06:44:30 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA6E63F73B;
        Wed,  3 Feb 2021 06:44:29 -0800 (PST)
Date:   Wed, 3 Feb 2021 14:43:44 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michal Simek" <monstr@monstr.eu>, git <git@xilinx.com>,
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: zynq: Add address-cells property to interrupt
 controllers
Message-ID: <20210203144344.4e261aea@slackpad.fritz.box>
In-Reply-To: <a2f10400-51e5-bb76-f5c4-3b8e2fbc2793@xilinx.com>
References: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
        <CAL_JsqJnu1M6ut8g_36ve-OG22jFsySHbmVHOgtDRhc-s37rpQ@mail.gmail.com>
        <210b0e5a-767b-c285-62e2-23de19bd3cf1@xilinx.com>
        <CAL_Jsq+m7F+nD6VKd2L5i44hz32_-6iX3toZ0A0CBT-g7Xqu9g@mail.gmail.com>
        <a2f10400-51e5-bb76-f5c4-3b8e2fbc2793@xilinx.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 15:15:19 +0100
Michal Simek <michal.simek@xilinx.com> wrote:

> On 2/3/21 3:12 PM, Rob Herring wrote:
> > On Wed, Feb 3, 2021 at 1:01 AM Michal Simek <michal.simek@xilinx.com> wrote:  
> >>
> >>
> >>
> >> On 2/1/21 6:41 PM, Rob Herring wrote:  
> >>> On Mon, Feb 1, 2021 at 8:27 AM Michal Simek <michal.simek@xilinx.com> wrote:  
> >>>>
> >>>> The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
> >>>> v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
> >>>> commit
> >>>> "81e0919a3e21 checks: Add interrupt provider test"
> >>>> where reasons for this checking are mentioned as
> >>>> "A missing #address-cells property is less critical, but creates
> >>>> ambiguities when used in interrupt-map properties, so warn about this as
> >>>> well now."
> >>>>
> >>>> Add address-cells property to gic and gpio nodes to get rid of this warning.
> >>>> The similar change has been done for ZynqMP too.  
> >>>
> >>> FYI, we're going to make this check dependent on having an
> >>> interrupt-map property. So adding these isn't necessary.  
> >>
> >> Good to know. Is there going to be report if interrupt-map doesn't
> >> exist? Which can end up with reverting these changes?  
> > 
> > You mean a warning if '#address-cells' is present and interrupt-map is
> > not? No, that would cause lots of warnings.  
> 
> yep. 

Why would we do that? That sounds dangerous and would be broken if the
IRQ controller is in a generic .dtsi (as it usually is), but the
interrupt map is only in *some* of the board .dts files.

What is the problem of just putting #address-cells = <0>; in the
IRQ controller node, after checking that there currently no interrupt
maps in use and no IRQ children? And be safe for good? That's 16 bytes
in the DTB, IIUC.

Because otherwise we have that lovely ambiguity between the
implicit default #address-cells = 2; and the assumed default of 0.

And that's why I think we also cannot *automatically* add an #ac = <0>;
property, because that would change behaviour.

Cheers,
Andre


> What's the timeline for this? I mean I want to get to state that
> all current warnings are gone that it will be much easier to add stuff
> which we have in soc tree.
> 
> Thanks,
> Michal
> 

