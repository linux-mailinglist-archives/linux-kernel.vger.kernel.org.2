Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552AC457CCB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 11:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhKTKRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 05:17:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhKTKRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 05:17:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C0306008E;
        Sat, 20 Nov 2021 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637403242;
        bh=p8lvv0uMUg2IIWA7VgSF5vRjXpzRznQaMfH/9LDbzn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHnDXOiB4aqq5Yhc6RZ4CA+75emu6gHisSS3WmbqOHmaqcpiRNY03RXvpO3fNqurT
         SFP7kEkRxfPZqr/nV0CV0e8cSD6f2n+Bxd5jvUxEs8i8021M0teijhSI1C/PrzBXDH
         Ng4LdKYFlD8c8cTDSYr3qVwltZzMbCqwBAe++XfvEl5zImwQTA4fIbfn16lLv5axdQ
         sqJoTHBfrg1zrrq/lDJPB2xL6ecCFR4UoU+CJaqo+LN5/MtMkOgY8ck7V/5wQry3j3
         6bGCCicItMohwBH2je7nElTwKy3sTqcJ+04QojStBfjETAU2xifTcJOpqrWL7ieQWN
         WnR4L4yx0KUEw==
Date:   Sat, 20 Nov 2021 18:13:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>
Subject: Re: [PATCH V5] dt-bindings: soc: imx: Add binding doc for spba bus
Message-ID: <20211120101354.GA31998@dragon>
References: <20201118230414.121316-1-aford173@gmail.com>
 <20201130220249.GA3109751@robh.at.kernel.org>
 <CAHCN7x+om4W5jqnuAW4-nMkZLc5nrYu7NUsbM36r0wyFSYa4-g@mail.gmail.com>
 <CAHCN7xKEkpq07AfMbpPfEcz0x=XvVjST==8gYRyrbW+Cjs3ONg@mail.gmail.com>
 <CAHCN7xJK-iMMNMOtJCn9a2T2Jox=3LK3ANPGgZAC645wJw=3JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJK-iMMNMOtJCn9a2T2Jox=3LK3ANPGgZAC645wJw=3JQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 09:36:59AM -0500, Adam Ford wrote:
> On Sat, Oct 16, 2021 at 3:11 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Thu, Apr 1, 2021 at 4:19 PM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > On Mon, Nov 30, 2020 at 4:02 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, 18 Nov 2020 17:04:14 -0600, Adam Ford wrote:
> > > > > Add binding doc for fsl,spba-bus.
> > > > >
> > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > > ---
> > > > > make dt_binding_check -j8 |grep spba
> > > > >   DTEX    Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dts
> > > > >   DTC     Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
> > > > >   CHECK   Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml
> > > > >
> > > > > V5:  Rebase on 5.10-rc2 to be able to check yaml
> > > > >      Add Reg entry
> > > > >
> > > > > V4:  Remove an accidental makefile change
> > > > >      Move type:object under additional properties
> > > > >
> > > > > V3:  Rebase sample from aips-bus example
> > > > >      Split off from series adding i.MX8M Nano functions to reduce noise
> > > > >
> > > > > V2:  Attempted to update yaml from feedback
> > > > >
> > > >
> > > > Applied, thanks!
> > >
> > > Rob,
> > >
> > > I am not seeing this anywhere.  Can you tell me where this was
> > > applied?  It's not appearing in Linux-next
> >
> > Rob,
> >
> > Patchwork shows this has been accepted [1], however I don't see that
> > it's still applied.
> >
> >
> > [1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20201118230414.121316-1-aford173@gmail.com/
> >
> > Can you apply it?  It looks like building the device tree is throwing
> > messages because this is missing.
> >
> 
> Shawn,
> 
> Since you're the maintainer for the IMX stuff, can I update the
> MAINTAINERS file to add this yaml file under the IMX section?  When
> building device trees, it throws a bunch of splat because this patch
> was never applied, and checkpatch is showing it wants a maintainer.

checkpatch warning on maintainer shouldn't be a problem.  We don't
really want to bloat IMX entry in MAINTAINERS.

Shawn
