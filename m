Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D136330BECB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhBBMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:52:39 -0500
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:43484 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231424AbhBBMwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:52:35 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6EFE5182CED28;
        Tue,  2 Feb 2021 12:51:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3871:3873:3874:4250:4321:5007:7652:10004:10400:11026:11232:11473:11658:11914:12043:12114:12297:12438:12555:12740:12895:13069:13311:13357:13439:13894:14659:14721:21080:21433:21451:21611:21627:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pear45_5b049fa275cb
X-Filterd-Recvd-Size: 2431
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue,  2 Feb 2021 12:51:51 +0000 (UTC)
Message-ID: <1d4f5de1deebda31d9b1d185810b352ea0af21a3.camel@perches.com>
Subject: Re: [PATCH 2/3] printk: hard-code CONSOLE_LOGLEVEL_MIN in printk.c
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Date:   Tue, 02 Feb 2021 04:51:50 -0800
In-Reply-To: <YBkkDYZz3IgreEmt@jagdpanzerIV.localdomain>
References: <20210202070218.856847-1-masahiroy@kernel.org>
         <20210202070218.856847-2-masahiroy@kernel.org>
         <YBkkDYZz3IgreEmt@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-02 at 19:06 +0900, Sergey Senozhatsky wrote:
> On (21/02/02 16:02), Masahiro Yamada wrote:
> >  include/linux/printk.h | 1 -
> >  kernel/printk/printk.c | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index fd34b3aa2f90..ceaf0486c01c 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -48,7 +48,6 @@ static inline const char *printk_skip_headers(const char *buffer)
> >  
> > 
> >  /* We show everything that is MORE important than this.. */
> >  #define CONSOLE_LOGLEVEL_SILENT  0 /* Mum's the word */
> > -#define CONSOLE_LOGLEVEL_MIN	 1 /* Minimum loglevel we let people use */
> >  #define CONSOLE_LOGLEVEL_DEBUG	10 /* issue debug messages */
> >  #define CONSOLE_LOGLEVEL_MOTORMOUTH 15	/* You can't shut this one up */
> >  
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
[]
> > @@ -63,7 +63,7 @@
> >  int console_printk[4] = {
> >  	CONFIG_CONSOLE_LOGLEVEL_DEFAULT,	/* console_loglevel */
> >  	CONFIG_MESSAGE_LOGLEVEL_DEFAULT,	/* default_message_loglevel */
> > -	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
> > +	1,					/* minimum_console_loglevel */
> >  	CONFIG_CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
> 
> I personally don't think that this improves code readability.

Nor maintainability.


