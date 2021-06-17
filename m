Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02CD3AB44A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhFQNJC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Jun 2021 09:09:02 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60043 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFQNJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:09:01 -0400
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id EC06C1C0007;
        Thu, 17 Jun 2021 13:06:51 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu 0/4] firmware: turris-mox-rwtm: fixups
In-Reply-To: <20210520113520.32240-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org>
Date:   Thu, 17 Jun 2021 15:06:51 +0200
Message-ID: <87sg1g1vys.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Series applied on mvebu/fixes

Thanks,

Gregory

> These 4 patches are just fixups. Per Andrew's request I have split them
> from V3 series, so they can be applied to stable.
>
> Marek Behún (2):
>   firmware: turris-mox-rwtm: fix reply status decoding function
>   firmware: turris-mox-rwtm: report failures better
>
> Pali Rohár (2):
>   firmware: turris-mox-rwtm: fail probing when firmware does not support
>     hwrng
>   firmware: turris-mox-rwtm: show message about HWRNG registration
>
>  drivers/firmware/turris-mox-rwtm.c | 55 +++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 8 deletions(-)
>
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
