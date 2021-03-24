Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71806347F31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbhCXRVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:21:00 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:45432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237087AbhCXRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:20:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 126B118159034;
        Wed, 24 Mar 2021 17:20:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:152:334:355:379:421:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1543:1593:1594:1605:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2689:2731:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:6120:6742:7652:7903:10004:10400:10848:11026:11232:11233:11473:11657:11658:11783:11914:12043:12048:12296:12297:12438:12555:12740:12895:12986:13894:14096:14097:14181:14659:14721:21080:21433:21451:21627:21740:21990,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: blade66_5814dea2777c
X-Filterd-Recvd-Size: 5314
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Mar 2021 17:20:24 +0000 (UTC)
Message-ID: <3252fd83141aa9e0e6001acee1dd98e87c676b9a.camel@perches.com>
Subject: [RFC patch] vsprintf: Allow %pe to print non PTR_ERR %pe uses as
 decimal
From:   Joe Perches <joe@perches.com>
To:     Arnd Bergmann <arnd@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
Date:   Wed, 24 Mar 2021 10:20:23 -0700
In-Reply-To: <810d36184b9fa2880d3ba7738a8f182e27f5107b.camel@perches.com>
References: <20210324121832.3714570-1-arnd@kernel.org>
         <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
         <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
         <810d36184b9fa2880d3ba7738a8f182e27f5107b.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-24 at 09:52 -0700, Joe Perches wrote:
> On Wed, 2021-03-24 at 17:42 +0100, Arnd Bergmann wrote:
> > On Wed, Mar 24, 2021 at 3:20 PM Joe Perches <joe@perches.com> wrote:
> []
> > > > diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
> > > []
> > > > @@ -197,6 +197,12 @@ static void imx_ldb_encoder_enable(struct drm_encoder *encoder)
> > > >       int dual = ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
> > > >       int mux = drm_of_encoder_active_port_id(imx_ldb_ch->child, encoder);
> > > > 
> > > > +     if (mux < 0 || mux >= ARRAY_SIZE(ldb->clk_sel)) {
> > > > +             dev_warn(ldb->dev, "%s: invalid mux %d\n",
> > > > +                      __func__, ERR_PTR(mux));
> > > 
> > > This does not compile without warnings.
> > > 
> > > drivers/gpu/drm/imx/imx-ldb.c: In function ‘imx_ldb_encoder_enable’:
> > > drivers/gpu/drm/imx/imx-ldb.c:201:22: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘void *’ [-Wformat=]
> > >   201 |   dev_warn(ldb->dev, "%s: invalid mux %d\n",
> > >       |                      ^~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > If you want to use ERR_PTR, the %d should be %pe as ERR_PTR
> > > is converting an int a void * to decode the error type and
> > > emit it as a string.
> > 
> > Sorry about that.
> > 
> > I decided against using ERR_PTR() in order to also check for
> > positive array overflow, but the version I tested was different from
> > the version I sent.
> > 
> > v3 coming.
> 
> Thanks.  No worries.
> 
> Up to you, vsprintf would emit the positive mux as a funky hashed
> hex value by default if you use ERR_PTR with mux > ARRAY_SIZE so
> perhaps %d without the ERR_PTR use makes the most sense.
> 
> 

Maybe it's better to output non PTR_ERR %pe uses as decimal so this
sort of code would work.
---
 lib/vsprintf.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3600db686fa4..debdd1c62038 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -619,19 +619,23 @@ static char *string_nocheck(char *buf, char *end, const char *s,
 	return widen_string(buf, len, end, spec);
 }
 
-static char *err_ptr(char *buf, char *end, void *ptr,
-		     struct printf_spec spec)
+static noinline_for_stack
+char *err_ptr(char *buf, char *end, void *ptr, struct printf_spec spec)
 {
 	int err = PTR_ERR(ptr);
-	const char *sym = errname(err);
 
-	if (sym)
-		return string_nocheck(buf, end, sym, spec);
+	if (IS_ERR(ptr)) {
+		const char *sym = errname(err);
+
+		if (sym)
+			return string_nocheck(buf, end, sym, spec);
+	}
 
 	/*
-	 * Somebody passed ERR_PTR(-1234) or some other non-existing
-	 * Efoo - or perhaps CONFIG_SYMBOLIC_ERRNAME=n. Fall back to
-	 * printing it as its decimal representation.
+	 * Somebody passed ERR_PTR(-1234) or some other non-existing -E<FOO>
+	 * or perhaps CONFIG_SYMBOLIC_ERRNAME=n
+	 * or perhaps a positive number like an array index
+	 * Fall back to printing it as its decimal representation.
 	 */
 	spec.flags |= SIGN;
 	spec.base = 10;
@@ -2407,9 +2411,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	case 'e':
-		/* %pe with a non-ERR_PTR gets treated as plain %p */
-		if (!IS_ERR(ptr))
-			break;
+		/* %pe with a non-ERR_PTR(ptr) gets treated as %ld */
 		return err_ptr(buf, end, ptr, spec);
 	case 'u':
 	case 'k':

---


