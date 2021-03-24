Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BAD3484DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhCXWq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:46:27 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:49940 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238238AbhCXWqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:46:15 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 90F89180188C7;
        Wed, 24 Mar 2021 22:46:14 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA id 6EBA4268E38;
        Wed, 24 Mar 2021 22:46:10 +0000 (UTC)
Message-ID: <ea434f6d5a4a8cdd31ca3347c5830bdd857058bf.camel@perches.com>
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
Date:   Wed, 24 Mar 2021 15:46:09 -0700
In-Reply-To: <aa3b389e-d433-0243-41c7-9d0b6da24ed7@rasmusvillemoes.dk>
References: <20210324121832.3714570-1-arnd@kernel.org>
         <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
         <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
         <810d36184b9fa2880d3ba7738a8f182e27f5107b.camel@perches.com>
         <3252fd83141aa9e0e6001acee1dd98e87c676b9a.camel@perches.com>
         <9feab1e8-4dee-6b79-03f7-7b9f0cb24f6e@rasmusvillemoes.dk>
         <d184069de43135a9c9e5f031447faf98ab3f437d.camel@perches.com>
         <3d66137e-7842-2764-456f-7cc9e54a6d2e@rasmusvillemoes.dk>
         <9d320cd403921f4b36b726b71a51572463599cf5.camel@perches.com>
         <aa3b389e-d433-0243-41c7-9d0b6da24ed7@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Stat-Signature: zjuoah5n8zj5n8679onckacuei1y5ot9
X-Rspamd-Queue-Id: 6EBA4268E38
X-HE-Tag: 1616625970-648878
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-24 at 23:36 +0100, Rasmus Villemoes wrote:
> On 24/03/2021 23.18, Joe Perches wrote:
> > There's no silly game here.  %pe would either print a string or a value.
> 
> A hashed value, that is, never the raw value.

There is value in printing the raw value.
As discussed, it can simplify the code.

The worry about exposing a ptr value is IMO overstated.

It's trivial to inspect the uses and _all_ %p<FOO> uses need inspection
and validation at acceptance anyway.


