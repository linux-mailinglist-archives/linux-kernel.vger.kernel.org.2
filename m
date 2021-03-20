Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC158342A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 06:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCTE4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 00:56:19 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:44668 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229564AbhCTE4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 00:56:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 203A6837F24D;
        Sat, 20 Mar 2021 04:56:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:2892:2895:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:3874:4321:5007:7264:7514:7652:7904:10004:10400:10848:11232:11658:11914:12043:12050:12297:12679:12683:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21067:21080:21627:30045:30054:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: iron37_620244d27755
X-Filterd-Recvd-Size: 2650
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Mar 2021 04:56:03 +0000 (UTC)
Message-ID: <03d462504887401ffbcdb58a392ad01923a2be7b.camel@perches.com>
Subject: Re: [PATCH] clang-format: Update ColumnLimit
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Fri, 19 Mar 2021 21:56:02 -0700
In-Reply-To: <CANiq72=sEtv6-uMqY5QqpHSEqZnMj=6VrhgyFE2a=wZy=+_SEQ@mail.gmail.com>
References: <20210319183714.8463-1-ansuelsmth@gmail.com>
         <20210319184234.jsudy6solmtrq6vz@archlinux-ax161>
         <YFTxOcf56lPBi2sb@Ansuel-xps.localdomain>
         <CANiq72=sEtv6-uMqY5QqpHSEqZnMj=6VrhgyFE2a=wZy=+_SEQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-03-19 at 19:48 +0100, Miguel Ojeda wrote:
> On Fri, Mar 19, 2021 at 7:45 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
> > 
> > Sorry, didn't notice that. Considering that checkpatch complains and
> > some reviewers actually state that 100 is the new limit, I think it's
> > time to update the file.
> 
> IIUC, 80 is still the soft limit, but 100 is now the hard limit.

80 columns is still the strongly preferred limit.

From coding-style.rst:
-------------------------------
The preferred limit on the length of a single line is 80 columns.

Statements longer than 80 columns should be broken into sensible chunks,
unless exceeding 80 columns significantly increases readability and does
not hide information.
-------------------------------

IMO: clang-format is mechanical and, like checkpatch, doesn't have much
'taste'.

Ideally, 100 columns would only be used when long length identifiers
exist with some mechanism that determines statement complexity.

Today it's fairly easy to go beyond 80 columns even if a statement
is similar to
	a = b + c;
when identifier lengths are relatively long.

There are many existing 25+ character length identifiers, so the trivial
statement above if used with all identifiers of 25 characters or more
exceeds 80 columns.

So for some things, clang-format (and checkpatch) should allow > 80 column
lines for trivial statements like the above.

It's not a trivial implementation problem though.

