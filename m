Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67BC435ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhJUGNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhJUGNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:13:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BDAF60F57;
        Thu, 21 Oct 2021 06:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634796662;
        bh=cLSPcz5o6Nd3ZF5ZYiGKFvfPxQ4wyBKrhoKQQIRSR7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJcRuG+eSBiqg7iPDFVDbfQQP+MQf113rokN4sFL0rXPfrwPTuG0V07qoq1+TxJs/
         YeEbBNgjp8lyhmJ7mRbBw1VwIeHKUbivVRwa6HO+deLHMgfrjBD7dSdkGaA6pgvpIB
         5nA04BSv7XDN6X7gRmhcklRSVGDVhLpEflYm2jbsCvWNpwIHY3JIZO5T+71VhiFPHi
         zEAiXPiBVJSz0NKkqwVjedvB3S588JGbRPIhfzYW5Yc4bMczcxOpYlOcSIxMngVA/W
         aQeMSHdga5PzdRuAUbsSPCIQ2LeTFsnhvwQgMstC/wX99BV7ShF+KVu5GeTkar4tvh
         5GsyxCiqj8pJA==
Date:   Thu, 21 Oct 2021 11:40:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>, kishon@ti.com,
        robh+dt@kernel.org, andrew@lunn.ch, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] phy: Add lan966x ethernet serdes PHY driver
Message-ID: <YXEEcJHuEdFLPyCU@matsya>
References: <20211015123920.176782-1-horatiu.vultur@microchip.com>
 <20211015123920.176782-4-horatiu.vultur@microchip.com>
 <YW8HIHTCVgB+URJ5@matsya>
 <20211020091733.fxph2pq3xa3byvry@soft-dev3-1.localhost>
 <YXA3VVUGEjUR4HDC@matsya>
 <YXA6lZBTeA6aNxVD@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXA6lZBTeA6aNxVD@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-21, 17:49, Alexandre Belloni wrote:
> On 20/10/2021 21:05:49+0530, Vinod Koul wrote:
> > > > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > > 
> > > > Any reason why this is dual licensed, why not GPL only?
> > > 
> > > No reason, I think I copy this from a different file.
> > 
> > Please have a chat with your lawyers on the correct license this should
> > have!
> Dual GPL and MIT was Microsemi's policy, I'm not sure it carried over to
> Microchip.

That is why they need to talk to someone and decide what license
applies :)

-- 
~Vinod
