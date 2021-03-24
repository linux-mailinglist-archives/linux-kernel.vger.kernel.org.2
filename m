Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09205347E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhCXQwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:52:25 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:49684 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237103AbhCXQwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:52:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D6710100E7B48;
        Wed, 24 Mar 2021 16:52:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:421:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2689:2731:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4362:4605:5007:6742:7652:7903:10004:10400:10848:11026:11232:11233:11473:11657:11658:11783:11914:12043:12296:12297:12438:12740:12895:13019:13069:13311:13357:13894:14181:14659:14721:21080:21433:21451:21627:21660:21990:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mask89_440a42d2777c
X-Filterd-Recvd-Size: 3126
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Mar 2021 16:52:12 +0000 (UTC)
Message-ID: <810d36184b9fa2880d3ba7738a8f182e27f5107b.camel@perches.com>
Subject: Re: [PATCH] [v2] drm/imx: imx-ldb: fix out of bounds array access
 warning
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Mar 2021 09:52:11 -0700
In-Reply-To: <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
References: <20210324121832.3714570-1-arnd@kernel.org>
         <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
         <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-24 at 17:42 +0100, Arnd Bergmann wrote:
> On Wed, Mar 24, 2021 at 3:20 PM Joe Perches <joe@perches.com> wrote:
[]
> > > diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
> > []
> > > @@ -197,6 +197,12 @@ static void imx_ldb_encoder_enable(struct drm_encoder *encoder)
> > >       int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
> > >       int mux = drm_of_encoder_active_port_id(imx_ldb_ch->child, encoder);
> > > 
> > > +     if (mux < 0 || mux >= ARRAY_SIZE(ldb->clk_sel)) {
> > > +             dev_warn(ldb->dev, "%s: invalid mux %d\n",
> > > +                      __func__, ERR_PTR(mux));
> > 
> > This does not compile without warnings.
> > 
> > drivers/gpu/drm/imx/imx-ldb.c: In function ‘imx_ldb_encoder_enable’:
> > drivers/gpu/drm/imx/imx-ldb.c:201:22: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘void *’ [-Wformat=]
> >   201 |   dev_warn(ldb->dev, "%s: invalid mux %d\n",
> >       |                      ^~~~~~~~~~~~~~~~~~~~~~
> > 
> > If you want to use ERR_PTR, the %d should be %pe as ERR_PTR
> > is converting an int a void * to decode the error type and
> > emit it as a string.
> 
> Sorry about that.
> 
> I decided against using ERR_PTR() in order to also check for
> positive array overflow, but the version I tested was different from
> the version I sent.
> 
> v3 coming.

Thanks.  No worries.

Up to you, vsprintf would emit the positive mux as a funky hashed
hex value by default if you use ERR_PTR with mux > ARRAY_SIZE so
perhaps %d without the ERR_PTR use makes the most sense.



