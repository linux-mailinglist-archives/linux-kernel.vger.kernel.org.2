Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BEB3BA95C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhGCQFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 12:05:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:47667 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCQFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 12:05:13 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 163Fs1rg021323;
        Sat, 3 Jul 2021 10:54:01 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 163FrvdE021319;
        Sat, 3 Jul 2021 10:53:57 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 3 Jul 2021 10:53:57 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ash Logan <ash@heyquark.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/4] powerpc: wii.dts: Expose the OTP on this platform
Message-ID: <20210703155357.GG1583@gate.crashing.org>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr> <20210519095044.4109-4-linkmauve@linkmauve.fr> <YNe5aW55SrXFGKFV@latitude> <20210701195655.knbcikdga57a7epx@luna> <YN7Uv/43TwL4+9ic@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YN7Uv/43TwL4+9ic@latitude>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 08:56:31AM +0000, Jonathan Neuschäfer wrote:
> On Thu, Jul 01, 2021 at 09:56:55PM +0200, Emmanuel Gil Peyrot wrote:
> > On Sat, Jun 26, 2021 at 11:34:01PM +0000, Jonathan Neuschäfer wrote:
> > > On Wed, May 19, 2021 at 11:50:43AM +0200, Emmanuel Gil Peyrot wrote:
> [...]
> > > > +		otp@d8001ec {
> > > > +			compatible = "nintendo,hollywood-otp";
> > > > +			reg = <0x0d8001ec 0x8>;
> > > 
> > > The OTP registers overlap with the previous node, control@d800100.
> > > Not sure what's the best way to structure the devicetree in this case,
> > > maybe something roughly like the following (untested, unverified):
> > [snip]
> > 
> > I couldn’t get this to work, but additionally it looks like it should
> > start 0x100 earlier and contain pic1@d800030 and gpio@d8000c0, given
> > https://wiibrew.org/wiki/Hardware/Hollywood_Registers
> > 
> > Would it make sense, for the time being, to reduce the size of this
> > control@d800100 device to the single register currently being used by
> > arch/powerpc/platforms/embedded6xx/wii.c (0xd800194, used to reboot the
> > system) and leave the refactor of restart + OTP + PIC + GPIO for a
> > future series?
> 
> Makes sense to me!

There is no benefit to pretending there is a "control" bus (there is no
such thing), it only gets in the way.


Segher
