Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB43EB6F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhHMOqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:46:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48662 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235131AbhHMOqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=38IBKVZVPTV/8WbCeQGQRU16Bwkgg1bsJyoAG5N1EVM=; b=EbfPbkWC+9PSeZNWrM8Tt5/V1z
        KJ8x52VMBSgil//JYcbD96Ksen36PdaS2wSWoNjqqMthtxBttm2q/AwP2vLV0fxfj91517AGuReAj
        O2LdYoGoVInOMtHs3+4aYQZMJwF39qcijVsG6bRUExyRzVdqkOZ9s047SciVEiLpUwzs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mEYRa-00HVga-GS; Fri, 13 Aug 2021 16:45:58 +0200
Date:   Fri, 13 Aug 2021 16:45:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tao Ren <rentao.bupt@gmail.com>
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
Message-ID: <YRaFpq1LvRzMYr/A@lunn.ch>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
 <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 08:40:17PM -0700, Tao Ren wrote:
> On Fri, Aug 13, 2021 at 01:29:17AM +0000, Joel Stanley wrote:
> > On Thu, 5 Aug 2021 at 22:28, <rentao.bupt@gmail.com> wrote:
> > > +&mdio1 {
> > > +       status = "okay";
> > 
> > You're enabling this but it looks like it's unused?
> 
> Thanks Joel for the careful review. The MDIO controller is not paired
> with BMC MAC; instead, it's connected to the MDC/MDIO interface of the
> on-board switch (whose ports are connected to BMC, Host and front panel
> management port).

What switch is it? Is there a DSA driver for it? drivers/net/dsa/*
Ideally you want Linux to be controlling the switch, in the standard
linux way.

     Andrew
