Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D303EC08E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 06:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhHNEri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 00:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhHNErh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 00:47:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81E4D60ED5;
        Sat, 14 Aug 2021 04:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628916429;
        bh=XM44hiFvUZcKVHqfpXQVZsW5QF3yfvaruepxYJ4tch0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pk+wsmtIFB9+vToHFqru+TSC6a9oiJuMmXm3ObKVkl+uehKIhE/b0MUt3FtyA9BX0
         J7ySV3g8FPNkZpuHNXZadobBWCUXUX69ZVrjXtRdNl+F1MO4Y52+VSURmu5+7aAiXD
         YR/170sSNy53ycdF/CVb4VjeR4aO4W+rDmK9SuJamul9dvyNhY4ua3Pym8gYmIufwO
         v8wskIXQ2yynT2+wn43gFnPZ/cVtK4rLbWm976nJQtQNTldbaRjhtMkU8RZXxLX7SP
         UuvzZYJG867PiYswSSzfGpRQUktOtSpVWwbaUouRtqczTW06kzmw5jrK2i4InSJkbL
         s0nZp6zDHIX6A==
Date:   Sat, 14 Aug 2021 12:47:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
 LX2160A UART
Message-ID: <20210814044703.GU30984@dragon>
References: <20210615131605.616-1-thunder.leizhen@huawei.com>
 <20210615131605.616-2-thunder.leizhen@huawei.com>
 <AS8PR04MB8946D0EB15D631346F4D13198FF69@AS8PR04MB8946.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8946D0EB15D631346F4D13198FF69@AS8PR04MB8946.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:52:04PM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Zhen Lei <thunder.leizhen@huawei.com>
> > Sent: Tuesday, June 15, 2021 8:16 AM
> > To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; Mark Kettenis <mark.kettenis@xs4all.nl>;
> > devicetree <devicetree@vger.kernel.org>; linux-arm-kernel <linux-arm-
> > kernel@lists.infradead.org>; linux-kernel <linux-kernel@vger.kernel.org>
> > Cc: Zhen Lei <thunder.leizhen@huawei.com>
> > Subject: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
> > LX2160A UART
> > 
> > Mark Kettenis told us that:
> > According to the NXP documentation, the LX2160A has a real PL011 UART.
> > 
> > Therefore, rewrite it to the compatible string of pl011. The property "current-
> > speed" specific to "arm,sbsa-uart" is also deleted.
> 
> Sorry that I missed the discussion on the v1.  But looks like this change breaks the LX2160 boot.  The AMBA matching doesn't seem to work.  And the console is not registered correctly.
> 
> [    0.639055] OF: amba_device_add() failed (-2) for /soc/serial@21c0000
> [    0.645612] OF: amba_device_add() failed (-2) for /soc/serial@21d0000

Patch dropped.

Shawn
