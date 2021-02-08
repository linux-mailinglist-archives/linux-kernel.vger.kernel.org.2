Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A84A314095
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBHUfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:35:39 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45594 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbhBHTPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:15:30 -0500
Received: by mail-ot1-f52.google.com with SMTP id o12so15183155ote.12;
        Mon, 08 Feb 2021 11:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9MpW4g/Oa/7358qxsu5N9b3A3zLC/8dOk9zLIzf9+VY=;
        b=Zk4MBZ26nLLfcAWQQFCxSAJc4oC8VhF37gulUjG+rDuRxsr/DXd/WdrH0xK6Qu7YAo
         KP7/q3q1FpyAJE3BFJcCRgLSnkxf3covQ0OEWupEfq+yIoAGN9kw3HXjh6upOMIjA3w8
         +3WBpTP3mRq+TRAWAyCuHDx8Qc5fco3ZaWuZIFfaWN/GqGiDHPOX1uJw6httCl6tRQ9r
         SR+OEM0qw6DH256MUGbpBiEwxoK0gX1hgAm++3kKPmurSpRG8vKBapsN+fh+1unUoCbF
         QrWNXWDkEhHbdvqb25Hoo3XTHjCvYAEI5LB55ToyvDs64EejEQd+9R/AcHHP1Q6It9/r
         ci1Q==
X-Gm-Message-State: AOAM533TjRbaV3iQeGm35kn5OXtr3lynfpqaBWbsiRg6v8ocreVSE+Ei
        C9qiXjbJZ5YwG0ZItybO3ntrhpE+jA==
X-Google-Smtp-Source: ABdhPJy2Zdk/7lhRLfQ4vS7stnE58LqLxeABIlpPpWwn9WDzA3vpkWV8wHQrC0uGs0rwMLBvpmZeqQ==
X-Received: by 2002:a9d:6e0b:: with SMTP id e11mr8799402otr.343.1612811688715;
        Mon, 08 Feb 2021 11:14:48 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g11sm3859816oif.9.2021.02.08.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:14:48 -0800 (PST)
Received: (nullmailer pid 1735846 invoked by uid 1000);
        Mon, 08 Feb 2021 19:14:47 -0000
Date:   Mon, 8 Feb 2021 13:14:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin 'marcan' <marcan@marcan.st>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 18/18] arm64: apple: Add initial Mac Mini 2020 (M1)
 devicetree
Message-ID: <20210208191447.GA1677483@robh.at.kernel.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-19-marcan@marcan.st>
 <20210208110441.25qc6yken4effd6c@kozik-lap>
 <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd67b2ce-9676-31b4-85f7-de1ec9b2bf72@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:56:53PM +0900, Hector Martin 'marcan' wrote:
> On 08/02/2021 20.04, Krzysztof Kozlowski wrote:
> > apple
> > 
> > Don't make things different for this one platform (comparing to all
> > other platforms). Apple is not that special. :)
> 
> AAPL is the old vendor prefix used in the PowerPC era. I'm happy to use
> `apple`, as long as we're OK with having two different prefixes for the same
> vendor, one for PPC and one for ARM64. I've seen opinions go both ways on
> this one :)
> 
> > > + * Copyright 2021 Hector Martin <marcan@marcan.st>
> > 
> > A lot here might be difficult to reverse-egineer or figure out by
> > ourself, so usually people rely on vendor sources (the open source
> > compliance package). Didn't you receive such for the iOS (or whatever
> > was on your Mac)?
> 
> Apple source drops are sparse (they don't even include things like the
> irqchip driver, only the very core OS code) and APSL licensed, which is a
> license incompatible with the GPL. Worse, they've moved to a partial-blob
> model with the M1; M1-compatible XNU source code drops now include a .a blob
> with startup and CPU-specific code, for which no source code is provided.
> (to be clear: Apple does not ship Linux for these machines)
> 
> Honestly, beyond what's in this patchset and a few more details about CPU
> registers like performance monitoring stuff that exist in public XNU drops
> but I haven't looked into yet, Apple's source code drops are going to be
> practically useless to us from here on out. It's all binaries after this.
> 
> Apple device trees are not open source at all; those are provided by iBoot
> and ship with device firmware, which is not openly licensed. Those device
> trees are OF-inspired, but otherwise in a different format and structure to
> Linux device trees.
> 
> Since there is zero Apple-published code or data with a license compatible
> with the Linux kernel to be used here, there can be zero copyright lines
> claiming any submissions are copyright Apple from us, because that would
> imply a license violation has occurred. I am treating this as I would any
> other no-source reverse engineering project, that is, ensuring that I only
> look at Apple code (binaries, source, devicetrees, whatever) to understand
> how the hardware functions, build documentation for it (at least in my head,
> but I am also trying to document things on our wiki as I go), and then write
> original code to drive it from Linux, unrelated to whatever Apple was doing.
> 
> We're also trying to avoid looking at any Apple stuff in general as much as
> possible, preferring black-box approaches where feasible, to minimize
> exposure. For example, I only looked at an (outdated, arm32 era) AIC
> register name list in XNU to write the AIC driver; there is no actual AIC
> driver code in the source, and instead of decompiling Apple's binary blob
> AIC driver module, I figured out how the hardware actually worked via
> probing and experimentation. The entire userspace GPU stack is being reverse
> engineered via a black-box approach, without any decompilation. I'm going to
> see what I can do about the kernel driver in the future, and prefer some
> kind of mmio tracing solution if I can get it all to work on macOS.
> 
> As for this file specifically: while I am obviously looking at Apple's DTs
> to figure out things like register offsets and what hardware exists, those
> are facts, and facts are not copyrightable, and thus Apple does not hold any
> copyright interest over this code as I submitted it. Short of verbatim
> copying and pasting of entire nodes with bespoke property names (which would
> never fly here anyway because Apple does things very differently from Linux
> DTs when you get down into the details), it would be extremely hard to argue
> that translating hardware information from decompiled Apple DTs to Linux DTs
> would constitute a copyright violation, since the entire purpose of DTs is
> to describe hardware facts.
> 
> You can read more about our reverse engineering and copyright policy at
> https://alx.sh/re - if you have any suggestions or spot anything
> problematic, please let me know.
> 
> (I'm actually probably going to change that copyright line to "The Asahi
> Linux Contributors" for v2, if that's okay with the kernel folks, to be in
> line with our other projects; I defaulted to my name since so far I'm the
> only contributor to these files, but I expect other people to throw PRs at
> me in the future and the history to end up with more names here)

Does there need to be a legal entity behind 'The Asahi Linux 
Contributors' to be valid?

From a more practical standpoint, if we want to relicense something in 
say 5 years from now, who do we ask for an okay?

> > I guess Rob will comment on the dt-bindings more... but for me a generic
> > "arm-platform" is too generic. What's the point of it? I didn't see any
> > of such generic compatibles in other platforms.
> 
> This is a hack for patches #11/#12 to use, and I expect it will go away once
> we figure out how to properly handle that problem (which needs further
> discussion). Sorry for the noise, this should not be there in the final
> version.

I was going to ask on this. If you have a user of it, I'm okay with it. 
Generally though, 3 or 4 levels of compatible don't really have users.

> > > +		bootargs = "earlycon";
> > 
> > This should not be hard-coded in DTS. Pass it from bootloader.
> 
> My apologies, this was garbage left over from before I had bootargs support
> in the bootloader. Will be gone for v2.
> 
> > > +	clk24: clk24 {
> > 
> > Just "clock". Node names should be generic.
> 
> Really? Almost every other device device tree uses unique clock node names.

It's a WIP to be more consistent around node names. For actual
clock controllers we have 'clock-controller(@.*)?'. There's not really 
something established for 'fixed-clock'. We probably should define 
something, but that goes in the schema first.

> > > +		compatible = "fixed-clock";
> > > +		#clock-cells = <0>;
> > > +		clock-frequency = <24000000>;
> > > +		clock-output-names = "clk24";
> > 
> > What clock is it? Part of board or SoC? Isn't it a work-around for
> > missing clock drivers?
> 
> The clock topology isn't entirely known yet; I'm submitting this as an
> initial bring-up patchset and indeed there should be a clockchip driver in
> the future. The UART driver wants a clock to be able to calculate baud
> rates. I figured we can get away with a fixed-clock for now while that part
> of the SoC gets figured out.

That is normal. It does break compatibility between an old kernel 
and new DT. There's not really a good way to avoid that.

Rob
