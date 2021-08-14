Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAEB3EC0A2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhHNFXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhHNFXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:23:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE39C061575;
        Fri, 13 Aug 2021 22:22:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so3418671pjz.0;
        Fri, 13 Aug 2021 22:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qUlgCGK8+0KVcRwvfAdukdAi2gP9bLhzHb2DkcgfzQY=;
        b=OQqyGWEnIPLyf3mXTtyAaEWzqjlcyCUdbsTZsFKYqa8gAZOSlHOHrA++SGAjDCM22p
         anVJ+uBmvz9kl/eeKRiNY53lZBTvP4HgO021aS2HzrnH0XB3vWa/khh3xHM367OVTYRE
         8CpdEsiV5Duh5fXigEio/fXfI1uyps2jzP4LWgQQU3ckEhDYLd6enyJJUkooyVLbdsAa
         69I0VwvlzYUdSkA9d/D5fqBq4F9eCUXJ6GlF8wWTLjY31rZseLDIaNp+yh+hbwzbdTGK
         Sh40dkDnJUbxJaTx6hsdpIhjI9TlMVFj2aWH0qJ5ZO+A9bWGoaT0ufqA25AHNn39HLpW
         SpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qUlgCGK8+0KVcRwvfAdukdAi2gP9bLhzHb2DkcgfzQY=;
        b=txpOHCG2uwglZ3XdScTqqN6RL1guxTGu1vlDEXPVG6uCHzzFy5WxmGD7AVkakCBMa6
         ImTpbKt8/Cx+VEC88/0N6AR+jLX5MxQm6Vsqb9a417gI3xPuni5qrCgRs3d47P5bF7xx
         yGe7vs5F+luWITS0oxPLAyPoKcggJfz1blKLRYUpXy9H9Jp2YY71hd3suzZaVFVjzIzG
         kQpOJaMuUdKsG3MBFCdomxYUEL+bv7WKDAaOKW++7cGpOaOksmjRckyelVDbx0FimqE3
         1x5Gx4JkRihA84KVBqJCIe6BeVNMuF3/9txavOj+7hTk1vtsCoUYsv3ivnKY8OTFiPLR
         yFoQ==
X-Gm-Message-State: AOAM533O4X40Xax52D6p4YY4WQnHEuKG+XLVfy4alydzOl46o79TjsyS
        wuhZqJwSiERy8Yt8NPZoJbM=
X-Google-Smtp-Source: ABdhPJwD5gIcmIVuMlWVrreOkxKSMiaVBIuW/nBKpzkRSs0ejSmabXcCcl3mKEjdXsaLElfILCT8Bg==
X-Received: by 2002:a65:608f:: with SMTP id t15mr5420277pgu.452.1628918556102;
        Fri, 13 Aug 2021 22:22:36 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-92-48-112.hsd1.ca.comcast.net. [73.92.48.112])
        by smtp.gmail.com with ESMTPSA id b3sm4102861pfi.179.2021.08.13.22.22.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Aug 2021 22:22:35 -0700 (PDT)
Date:   Fri, 13 Aug 2021 22:22:29 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
Message-ID: <20210814052228.GA1298@taoren-ubuntu-R90MNF91>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
 <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
 <YRaFpq1LvRzMYr/A@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRaFpq1LvRzMYr/A@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Aug 13, 2021 at 04:45:58PM +0200, Andrew Lunn wrote:
> On Thu, Aug 12, 2021 at 08:40:17PM -0700, Tao Ren wrote:
> > On Fri, Aug 13, 2021 at 01:29:17AM +0000, Joel Stanley wrote:
> > > On Thu, 5 Aug 2021 at 22:28, <rentao.bupt@gmail.com> wrote:
> > > > +&mdio1 {
> > > > +       status = "okay";
> > > 
> > > You're enabling this but it looks like it's unused?
> > 
> > Thanks Joel for the careful review. The MDIO controller is not paired
> > with BMC MAC; instead, it's connected to the MDC/MDIO interface of the
> > on-board switch (whose ports are connected to BMC, Host and front panel
> > management port).
> 
> What switch is it? Is there a DSA driver for it? drivers/net/dsa/*
> Ideally you want Linux to be controlling the switch, in the standard
> linux way.
> 
>      Andrew

Thanks for jumping in. We are using BCM5389 and the MDIO bus is used to
access BCM5389 MDC/MDIO interface in Pseudo-PHY mode.

I didn't know drivers/net/dsa, but let me check out the drivers and see
if it works in the Cloudripper environment.


Thanks,

Tao
