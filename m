Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931823481D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhCXTY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:24:28 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:58252 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237667AbhCXTYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:24:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BB3571801AC84;
        Wed, 24 Mar 2021 19:24:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:421:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1605:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2689:2731:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:6120:6691:6742:7652:7903:10004:10400:10848:11026:11232:11233:11473:11657:11658:11783:11914:12043:12048:12296:12297:12438:12740:12895:13894:14181:14659:14721:21080:21433:21451:21627:21740:21990:30012:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fish34_600c2bf2777d
X-Filterd-Recvd-Size: 4692
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Mar 2021 19:24:11 +0000 (UTC)
Message-ID: <d184069de43135a9c9e5f031447faf98ab3f437d.camel@perches.com>
Subject: Re: [RFC patch] vsprintf: Allow %pe to print non PTR_ERR %pe uses
 as decimal
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Date:   Wed, 24 Mar 2021 12:24:10 -0700
In-Reply-To: <9feab1e8-4dee-6b79-03f7-7b9f0cb24f6e@rasmusvillemoes.dk>
References: <20210324121832.3714570-1-arnd@kernel.org>
         <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
         <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
         <810d36184b9fa2880d3ba7738a8f182e27f5107b.camel@perches.com>
         <3252fd83141aa9e0e6001acee1dd98e87c676b9a.camel@perches.com>
         <9feab1e8-4dee-6b79-03f7-7b9f0cb24f6e@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-24 at 18:33 +0100, Rasmus Villemoes wrote:
> On 24/03/2021 18.20, Joe Perches wrote:
> > On Wed, 2021-03-24 at 09:52 -0700, Joe Perches wrote:
> > > On Wed, 2021-03-24 at 17:42 +0100, Arnd Bergmann wrote:
> > > > On Wed, Mar 24, 2021 at 3:20 PM Joe Perches <joe@perches.com> wrote:
> > > []
> > > > > > diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
> > > > > []
> > > > > > @@ -197,6 +197,12 @@ static void imx_ldb_encoder_enable(struct drm_encoder *encoder)
> > > > > >       int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
> > > > > >       int mux = drm_of_encoder_active_port_id(imx_ldb_ch->child, encoder);
> > > > > > 
> > > > > > +     if (mux < 0 || mux >= ARRAY_SIZE(ldb->clk_sel)) {
> > > > > > +             dev_warn(ldb->dev, "%s: invalid mux %d\n",
> > > > > > +                      __func__, ERR_PTR(mux));
> > > > > 
> > > > > This does not compile without warnings.
> > > > > 
> > > > > drivers/gpu/drm/imx/imx-ldb.c: In function ‘imx_ldb_encoder_enable’:
> > > > > drivers/gpu/drm/imx/imx-ldb.c:201:22: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘void *’ [-Wformat=]
> > > > >   201 |   dev_warn(ldb->dev, "%s: invalid mux %d\n",
> > > > >       |                      ^~~~~~~~~~~~~~~~~~~~~~
> > > > > 
> > > > > If you want to use ERR_PTR, the %d should be %pe as ERR_PTR
> > > > > is converting an int a void * to decode the error type and
> > > > > emit it as a string.
> > > > 
> > > > Sorry about that.
> > > > 
> > > > I decided against using ERR_PTR() in order to also check for
> > > > positive array overflow, but the version I tested was different from
> > > > the version I sent.
> > > > 
> > > > v3 coming.
> > > 
> > > Thanks.  No worries.
> > > 
> > > Up to you, vsprintf would emit the positive mux as a funky hashed
> > > hex value by default if you use ERR_PTR with mux > ARRAY_SIZE so
> > > perhaps %d without the ERR_PTR use makes the most sense.
> > > 
> 
> > 
> > Maybe it's better to output non PTR_ERR %pe uses as decimal so this
> > sort of code would work.
> 
> No, because that would leak the pointer value when somebody has
> accidentally passed a real kernel pointer to %pe.

I think it's not really an issue.

_All_ code that uses %p<foo> extensions need inspection anyway.

It's already possible to intentionally 'leak' the ptr value
by using %pe, -ptr so I think that's not really an issue.

> 
> If the code wants a cute -EFOO string explaining what's wrong, what
> about "%pe", ERR_PTR(mux < 0 : mux : -ERANGE)? Or two separate error
> messages
> 
> if (mux < 0)
>   ...
> else if (mux >= ARRAY_SIZE())
>   ...

Multiple tests, more unnecessary code, multiple format strings, etc...


