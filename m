Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B554348474
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbhCXWS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:18:58 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:43810 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231854AbhCXWSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:18:42 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6A9901822451D;
        Wed, 24 Mar 2021 22:18:41 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA id D56711124F6;
        Wed, 24 Mar 2021 22:18:36 +0000 (UTC)
Message-ID: <9d320cd403921f4b36b726b71a51572463599cf5.camel@perches.com>
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
Date:   Wed, 24 Mar 2021 15:18:35 -0700
In-Reply-To: <3d66137e-7842-2764-456f-7cc9e54a6d2e@rasmusvillemoes.dk>
References: <20210324121832.3714570-1-arnd@kernel.org>
         <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
         <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
         <810d36184b9fa2880d3ba7738a8f182e27f5107b.camel@perches.com>
         <3252fd83141aa9e0e6001acee1dd98e87c676b9a.camel@perches.com>
         <9feab1e8-4dee-6b79-03f7-7b9f0cb24f6e@rasmusvillemoes.dk>
         <d184069de43135a9c9e5f031447faf98ab3f437d.camel@perches.com>
         <3d66137e-7842-2764-456f-7cc9e54a6d2e@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D56711124F6
X-Spam-Status: No, score=0.10
X-Stat-Signature: jght7a4w3aihr8qtzepipotqu39yx7bw
X-Rspamd-Server: rspamout01
X-HE-Tag: 1616624316-471145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-24 at 22:27 +0100, Rasmus Villemoes wrote:
> On 24/03/2021 20.24, Joe Perches wrote:
> > On Wed, 2021-03-24 at 18:33 +0100, Rasmus Villemoes wrote:
> > > On 24/03/2021 18.20, Joe Perches wrote:
> > > 
> > > > 
> > > > Maybe it's better to output non PTR_ERR %pe uses as decimal so this
> > > > sort of code would work.
> > > 
> > > No, because that would leak the pointer value when somebody has
> > > accidentally passed a real kernel pointer to %pe.
> > 
> > I think it's not really an issue.
> > 
> > _All_ code that uses %p<foo> extensions need inspection anyway.
> 
> There are now a bunch of sanity checks in place that catch e.g. an
> ERR_PTR passed to an extension that would derefence the pointer;
> enforcing that only ERR_PTRs are passed to %pe (or falling back to %p)
> is another of those safeguards.
> 
> > It's already possible to intentionally 'leak' the ptr value
> > by using %pe, -ptr so I think that's not really an issue.
> > 
> 
> Huh, what? I assume -ptr is shorthand for (void*)-(unsigned long)ptr.
> How would that leak the value if ptr is an ordinary kernel pointer?
> That's not an ERR_PTR unless (unsigned long)ptr is < 4095 or so.

You are confusing ERR_PTR with IS_ERR

ERR_PTR is just

include/linux/err.h:static inline void * __must_check ERR_PTR(long error)
include/linux/err.h-{
include/linux/err.h-    return (void *) error;
include/linux/err.h-}f 

> If you want to print the pointer value just do %px. No need for silly
> games.

There's no silly game here.  %pe would either print a string or a value.
It already does that in 2 cases.


