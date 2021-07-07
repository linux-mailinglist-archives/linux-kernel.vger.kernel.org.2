Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8A93BEDC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhGGSRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbhGGSRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:17:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEA6C61C6D;
        Wed,  7 Jul 2021 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625681694;
        bh=ANUlKaG0E73h2Er0ZCOTCp3Ak/oC8FPGREk1Vt9apt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRQIhFKb7qBU/n6oQMur1uEeR6gjvSHCuTao3DFhlICX/0zpLayEdTDjJzUGLHb/x
         Qar0RonrjbUP4u0IKBRzEOrFAdXCX44ISM9kZbmbURrl8mbPswIbytZABsDxJTq0yr
         60So4qXbBiYq5AngCc65PbTjk1ZIi0L27CHFeKOGceHX0sQ5HcO6Jj7Nqeo5ZTWwrr
         tlXCEVeo/Fy7qkGyTwUCAcnDgPBgPdjOqyTBTjCBacQ5pAi2rde9Pgep24FC9mZKPD
         65/7IBgxC0nYWhOhnbVQs1tcte9E1PJzyArORc8nHr9atUc84UjzJpS8L121ha1Q24
         +xO50sWjro0Mg==
Received: by pali.im (Postfix)
        id 3A9FD622; Wed,  7 Jul 2021 20:14:52 +0200 (CEST)
Date:   Wed, 7 Jul 2021 20:14:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu 0/4] firmware: turris-mox-rwtm: fixups
Message-ID: <20210707181452.zwnltjqssotzc67v@pali>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org>
 <87sg1g1vys.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg1g1vys.fsf@BL-laptop>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gregory!

I see that you put this patch into mvebu/fixes branch and tagged it for
5.13 kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git/tag/?h=mvebu-fixes-5.13-1

But it looks like it was not merged into 5.13. Are you going to re-send
all pending patches to 5.14?

On Thursday 17 June 2021 15:06:51 Gregory CLEMENT wrote:
> Hello,
> 
> Series applied on mvebu/fixes
> 
> Thanks,
> 
> Gregory
> 
> > These 4 patches are just fixups. Per Andrew's request I have split them
> > from V3 series, so they can be applied to stable.
> >
> > Marek Behún (2):
> >   firmware: turris-mox-rwtm: fix reply status decoding function
> >   firmware: turris-mox-rwtm: report failures better
> >
> > Pali Rohár (2):
> >   firmware: turris-mox-rwtm: fail probing when firmware does not support
> >     hwrng
> >   firmware: turris-mox-rwtm: show message about HWRNG registration
> >
> >  drivers/firmware/turris-mox-rwtm.c | 55 +++++++++++++++++++++++++-----
> >  1 file changed, 47 insertions(+), 8 deletions(-)
> >
> > -- 
> > 2.20.1
> >
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
