Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D6E3D3A77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhGWMGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234867AbhGWMGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:06:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E121B60E53;
        Fri, 23 Jul 2021 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627044446;
        bh=uyKT1GDKC5mj7Y+MQVXtJESzzJLuwEKulFzv02Sw5NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rui2XmBbSLPHcGI4FAl7pnyNNUAMEEZcgcRLGBnBXzrVFTFGOOf7m4tRFsKGrygdT
         yo2pQ4QFpjmRX+eCuthT1KxKUnBgplc/FIgBUB9go7TAZpPOJod0vP4YoSu6rCT3Up
         JTzi4aJxAD3sOlBimUQ3wjh6sp1mxCWW3n6sQuL/+MmOtbk7W6ZxAHtVLyrCyDVKuU
         wX9DKd05DcVIQ4UR0U8BG5EQgDslY92e5WrbQw6KtP7v3ZzL6D2h3vUjIl++Ib89q/
         jif9nY5Rm1sO6hTwF6LQtL6dheURtc6/wvj4iyAlk0HpyqmWWeD+63JD7rNsZVH9Zw
         9EPOHC7pU0/Pg==
Received: by pali.im (Postfix)
        id A0E0C10D1; Fri, 23 Jul 2021 14:47:23 +0200 (CEST)
Date:   Fri, 23 Jul 2021 14:47:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu 0/4] firmware: turris-mox-rwtm: fixups
Message-ID: <20210723124723.vcckljhotgqe3cne@pali>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org>
 <87sg1g1vys.fsf@BL-laptop>
 <20210707181452.zwnltjqssotzc67v@pali>
 <87sg0519mj.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg0519mj.fsf@BL-laptop>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 July 2021 14:45:56 Gregory CLEMENT wrote:
> Hello Pali,
> 
> > Hello Gregory!
> >
> > I see that you put this patch into mvebu/fixes branch and tagged it for
> > 5.13 kernel:
> > https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tag/?h=mvebu-fixes-5.13-1
> >
> > But it looks like it was not merged into 5.13. Are you going to re-send
> > all pending patches to 5.14?
> 
> They have been merged in 5.14 during merged windows and they are now
> also in 5.13.4. So I think everything is OK now.
> 
> Gregory

Yes! I already figured out. So everything is fine now.

> 
> >
> > On Thursday 17 June 2021 15:06:51 Gregory CLEMENT wrote:
> >> Hello,
> >> 
> >> Series applied on mvebu/fixes
> >> 
> >> Thanks,
> >> 
> >> Gregory
> >> 
> >> > These 4 patches are just fixups. Per Andrew's request I have split them
> >> > from V3 series, so they can be applied to stable.
> >> >
> >> > Marek Behún (2):
> >> >   firmware: turris-mox-rwtm: fix reply status decoding function
> >> >   firmware: turris-mox-rwtm: report failures better
> >> >
> >> > Pali Rohár (2):
> >> >   firmware: turris-mox-rwtm: fail probing when firmware does not support
> >> >     hwrng
> >> >   firmware: turris-mox-rwtm: show message about HWRNG registration
> >> >
> >> >  drivers/firmware/turris-mox-rwtm.c | 55 +++++++++++++++++++++++++-----
> >> >  1 file changed, 47 insertions(+), 8 deletions(-)
> >> >
> >> > -- 
> >> > 2.20.1
> >> >
> >> 
> >> -- 
> >> Gregory Clement, Bootlin
> >> Embedded Linux and Kernel engineering
> >> http://bootlin.com
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
