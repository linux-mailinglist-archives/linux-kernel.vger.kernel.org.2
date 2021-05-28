Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205C9393C49
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 06:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhE1E02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 00:26:28 -0400
Received: from mout01.posteo.de ([185.67.36.65]:55037 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhE1E0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 00:26:01 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id DF07F24002D
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1622175862; bh=YaR6TnaoHIvRnRaHuHg0gB1m485qDCczkmKeD6/uVxs=;
        h=Date:From:To:Cc:Subject:From;
        b=E94PpEN5+XECnT2cPEQKxBBW2u3b/ahLGuW0PssEsWRP/ZczzMuussOKVTj9dbCec
         7RsigY5qgm/B+IDOIIVy38pNlu3iHN2UpctTzfgIbtcdM0CmgjKhrJk9qCR+Sy3A75
         c+POW8PJA72k6C7x8c13RLxLk0Bkaufu2f07Ibgd5vbWPCW/IrOxk1W/s1wLNevtEJ
         Ad9vmbsIMRRt6iz6og394vvf4hj9tw+1lskTBKFX2Eriv3a8XhtrZ4/TPygBeYd5jk
         VGWJlWJvaDWW47iHWOmKlRIFQgKlPw3XCDGDkdsfUonagk/w1Ew60kLqLCF4w57lu9
         MUAT93iPI1gLA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Frs5c5zMjz6tm5;
        Fri, 28 May 2021 06:24:20 +0200 (CEST)
Date:   Fri, 28 May 2021 04:24:19 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v7 0/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210528062419.15d5189d@monster.powergraphx.local>
In-Reply-To: <YLBiHQaW6H4K7QyO@builder.lan>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
        <95e93676-cfcf-1aed-1741-d69b72286033@sholland.org>
        <20210525180744.24187bb1@monster.powergraphx.local>
        <YLBiHQaW6H4K7QyO@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 22:23:09 -0500
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> On Tue 25 May 11:07 CDT 2021, Wilken Gottwalt wrote:
> 
> > On Mon, 15 Mar 2021 23:33:31 -0500
> > Samuel Holland <samuel@sholland.org> wrote:
> > 
> > > On 3/14/21 4:30 AM, Wilken Gottwalt wrote:
> > > > Wilken Gottwalt (2):
> > > >   dt-bindings: hwlock: add sun6i_hwspinlock
> > > >   hwspinlock: add sun6i hardware spinlock support
> > > > 
> > > >  .../allwinner,sun6i-a31-hwspinlock.yaml       |  45 ++++
> > > >  MAINTAINERS                                   |   6 +
> > > >  drivers/hwspinlock/Kconfig                    |   9 +
> > > >  drivers/hwspinlock/Makefile                   |   1 +
> > > >  drivers/hwspinlock/sun6i_hwspinlock.c         | 210 ++++++++++++++++++
> > > >  5 files changed, 271 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml create mode
> > > > 100644 drivers/hwspinlock/sun6i_hwspinlock.c
> > > > 
> > > 
> > > Thanks for the very thorough testing!
> > 
> > So when will this end up in mainstream? Or do I have to somehing to get this
> > triggered? This is not my first driver and back then it was included into
> > mainline without anything special on my side. I'm a bit confused. Did I miss
> > something?
> > 
> 
> Sorry, I wasn't paying enough attention and you didn't Cc
> linux-remoteproc@ (as described in MAINTAINERS) so I lost track of the
> patch.

Oh, no, this is my fault. I just wasn't aware of that.

> It's now been applied, I'll do some build testing on the way out but it
> should show up in linux-next in the coming days.

Thank you very much.

> Thank you,
> Bjorn

