Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0903D3AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhGWMPZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jul 2021 08:15:25 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:34173 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbhGWMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:15:24 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 779EBC989F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 12:46:19 +0000 (UTC)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E5647C0006;
        Fri, 23 Jul 2021 12:45:56 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu 0/4] firmware: turris-mox-rwtm: fixups
In-Reply-To: <20210707181452.zwnltjqssotzc67v@pali>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org> <87sg1g1vys.fsf@BL-laptop>
 <20210707181452.zwnltjqssotzc67v@pali>
Date:   Fri, 23 Jul 2021 14:45:56 +0200
Message-ID: <87sg0519mj.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

> Hello Gregory!
>
> I see that you put this patch into mvebu/fixes branch and tagged it for
> 5.13 kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tag/?h=mvebu-fixes-5.13-1
>
> But it looks like it was not merged into 5.13. Are you going to re-send
> all pending patches to 5.14?

They have been merged in 5.14 during merged windows and they are now
also in 5.13.4. So I think everything is OK now.

Gregory

>
> On Thursday 17 June 2021 15:06:51 Gregory CLEMENT wrote:
>> Hello,
>> 
>> Series applied on mvebu/fixes
>> 
>> Thanks,
>> 
>> Gregory
>> 
>> > These 4 patches are just fixups. Per Andrew's request I have split them
>> > from V3 series, so they can be applied to stable.
>> >
>> > Marek Behún (2):
>> >   firmware: turris-mox-rwtm: fix reply status decoding function
>> >   firmware: turris-mox-rwtm: report failures better
>> >
>> > Pali Rohár (2):
>> >   firmware: turris-mox-rwtm: fail probing when firmware does not support
>> >     hwrng
>> >   firmware: turris-mox-rwtm: show message about HWRNG registration
>> >
>> >  drivers/firmware/turris-mox-rwtm.c | 55 +++++++++++++++++++++++++-----
>> >  1 file changed, 47 insertions(+), 8 deletions(-)
>> >
>> > -- 
>> > 2.20.1
>> >
>> 
>> -- 
>> Gregory Clement, Bootlin
>> Embedded Linux and Kernel engineering
>> http://bootlin.com

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
