Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E035302D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbhDBUN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:13:27 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49473 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhDBUNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:13:25 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 912D91BF203;
        Fri,  2 Apr 2021 20:13:19 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>, andrew@lunn.ch,
        kabel@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
In-Reply-To: <20210217153038.1068170-1-rsalvaterra@gmail.com>
References: <20210217153038.1068170-1-rsalvaterra@gmail.com>
Date:   Fri, 02 Apr 2021 22:13:19 +0200
Message-ID: <87h7kocun4.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

> Hardware buffer management has never worked on the Turris Omnia, as the
> required MBus window hadn't been reserved. Fix thusly.
>
> Fixes: 018b88eee1a2 ("ARM: dts: turris-omnia: enable HW buffer management")
>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index 646a06420c77..dc80a909ea88 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -32,7 +32,8 @@ soc {
>  		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
>  			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
>  			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
> -			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
> +			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
> +			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
>  
>  		internal-regs {
>  
> -- 
> 2.30.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
