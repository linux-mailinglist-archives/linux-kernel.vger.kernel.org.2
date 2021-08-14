Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9B3EC388
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbhHNP1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 11:27:36 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50024 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238554AbhHNP1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 11:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=k5oaY0yxV1bCHw1gaOjIPXieerYTHQ1q9Of4rT8QusE=; b=ZptVl3mdz5xew2/cEvmLXeaPEx
        kfWsMX17M/uIERuvvQsegMfyaHuAX+EZ0mziXAYD6MRw/qUSF8wXGeHQfxqFrdwsOxsuBRizEhpky
        n27x1Z+yZTYummSjmDQhYN0vbxL9ccLr1+BQa7sGLKWPIJaRaI0VJuxGiCR0Z4OWZYio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mEvYl-0004x1-9S; Sat, 14 Aug 2021 17:26:55 +0200
Date:   Sat, 14 Aug 2021 17:26:55 +0200
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
Message-ID: <YRfgv5OknMluW7jj@lunn.ch>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
 <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
 <20210813034016.GA21895@taoren-ubuntu-R90MNF91>
 <YRaFpq1LvRzMYr/A@lunn.ch>
 <20210814052228.GA1298@taoren-ubuntu-R90MNF91>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814052228.GA1298@taoren-ubuntu-R90MNF91>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for jumping in. We are using BCM5389 and the MDIO bus is used to
> access BCM5389 MDC/MDIO interface in Pseudo-PHY mode.
> 
> I didn't know drivers/net/dsa, but let me check out the drivers and see
> if it works in the Cloudripper environment.

The b53 driver knows about this switch, so please make use of that
driver. See Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
for how you describe it in DT.

    Andrew
