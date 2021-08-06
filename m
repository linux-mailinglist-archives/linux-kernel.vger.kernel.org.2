Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED03E3093
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbhHFUxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:53:03 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:44575 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhHFUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:53:01 -0400
Received: by mail-io1-f46.google.com with SMTP id d22so13933240ioy.11;
        Fri, 06 Aug 2021 13:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVLyAZM767lCQjYHXP5y7pQwa3Dn1l6PYLmN/KqVz0o=;
        b=r6hm8DTiJyLoj65BT7erlP4OOQu4HrirIQsgG8ibHIBjQr4nF/ear4I4xzZersbnAV
         KfxyzBkERB8A9YZ9ytEK9vnopHKpClS/8Df3HYQtoNzWvNu9854I40bRs6Gt0BpFbViB
         0ZnDkMM3Mtroq12bBPWaTXAY0DIUxh8kJ87aagzwveVHUKlkbnFpBYxqsjzg63SS47kc
         lnPVk38EkIggV1DOUyfTJBUY2ehjG1arn55mqgriPMSal1umlKE4JBfbC8nGsFUSxewS
         g/Wwo91+or4i4tLWrUy7iWrv2JkB/cshoSYcJYo1fu+h3bh2xOaFpWFHYJ1eQVQFUzAk
         yS+g==
X-Gm-Message-State: AOAM533CCVS2/y0lUvz3GOnXKppIMeJzUdUIKzmXXgCg47ZN37JiwLKN
        cchB2CQZwtUruSrQFWCroQ==
X-Google-Smtp-Source: ABdhPJyqR5Qdm+ZUCNfw8o71loW7W+tR7K9SO6snsI4KLMvaPTUL4AzzZcbIs14hJ813EUljIw8hrA==
X-Received: by 2002:a92:b112:: with SMTP id t18mr1836724ilh.36.1628283164111;
        Fri, 06 Aug 2021 13:52:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d18sm5195594ile.32.2021.08.06.13.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:52:43 -0700 (PDT)
Received: (nullmailer pid 1776741 invoked by uid 1000);
        Fri, 06 Aug 2021 20:52:41 -0000
Date:   Fri, 6 Aug 2021 14:52:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>, Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 3/5] ARM: dts: Add basic support for EcoNet EN7523
Message-ID: <YQ2hGd1cERLbfjJ6@robh.at.kernel.org>
References: <20210730134552.853350-1-bert@biot.com>
 <20210730134552.853350-4-bert@biot.com>
 <20210730145901.GC19569@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730145901.GC19569@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:59:01PM +0100, Mark Rutland wrote:
> On Fri, Jul 30, 2021 at 03:45:50PM +0200, Bert Vermeulen wrote:
> > From: John Crispin <john@phrozen.org>
> > 
> > Add basic support for EcoNet EN7523, enough for booting to console.
> > 
> > The UART is basically 8250-compatible, except for the clock selection.
> > A clock-frequency value is synthesized to get this to run at 115200 bps.
> > 
> > Signed-off-by: John Crispin <john@phrozen.org>
> > Signed-off-by: Bert Vermeulen <bert@biot.com>
> > ---
> >  arch/arm/boot/dts/Makefile       |   2 +
> >  arch/arm/boot/dts/en7523-evb.dts |  17 ++++
> >  arch/arm/boot/dts/en7523.dtsi    | 128 +++++++++++++++++++++++++++++++
> >  3 files changed, 147 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/en7523-evb.dts
> >  create mode 100644 arch/arm/boot/dts/en7523.dtsi
> > 
> 
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> 
> > +		cpu0: cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a7";
> > +			reg = <0x0>;
> > +			enable-method = "psci";
> > +			clock-frequency = <80000000>;
> > +			next-level-cache = <&L2_0>;
> > +
> > +		};
> 
> > +	gic: interrupt-controller@09000000 {
> > +		compatible = "arm,gic-v3";
> > +		interrupt-controller;
> > +		#interrupt-cells = <3>;
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		reg = <0x09000000 0x20000>,
> > +			  <0x09080000 0x80000>;
> > +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +		its: gic-its@09020000 {
> > +			compatible = "arm,gic-v3-its";
> > +			msi-controller;
> > +			#msi-cell = <1>;
> 
> Missing 's' here for '#msi-cells'.

No need for a human to be checking this, the DT schemas will check this. 
Please run 'make dtbs_checks' on this. New platforms should be free of 
warnings ideally.

Rob
