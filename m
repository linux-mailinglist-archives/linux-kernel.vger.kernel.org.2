Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7074331C132
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhBOSL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:11:56 -0500
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:33400 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230105AbhBOSLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:11:51 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 37C57180060E3;
        Mon, 15 Feb 2021 18:11:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3871:3872:3873:3874:4250:4321:4605:5007:6117:6119:6120:7652:7901:7903:8527:10004:10400:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:21080:21221:21324:21611:21627:30054:30056:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: horse35_6111c282763d
X-Filterd-Recvd-Size: 1908
Received: from [192.168.43.37] (unknown [172.58.92.12])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Feb 2021 18:11:06 +0000 (UTC)
Message-ID: <2162334bdf4d635f1414ffef52378c0f423366a7.camel@perches.com>
Subject: Re: [PATCH RFC v3 2/3] docs: add documentation for checkpatch
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-doc@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 15 Feb 2021 10:11:03 -0800
In-Reply-To: <20210214121501.GC2858050@casper.infradead.org>
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
         <20210213131513.51386-3-dwaipayanray1@gmail.com>
         <20210214121501.GC2858050@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-02-14 at 12:15 +0000, Matthew Wilcox wrote:
> On Sat, Feb 13, 2021 at 06:45:12PM +0530, Dwaipayan Ray wrote:
> > +Checkpatch (scripts/checkpatch.pl) is a perl script which checks for trivial style
> 
> It's quite amusing that this patch contains lines > 80 columns.

Then you could amuse yourself further by looking at the existing
line lengths of .rst files.

$ git ls-files -- '*.rst' | \
  xargs cat | \
  awk '{print length($0);}' | \
  sort -n | \
  uniq -c | \
  tail -20
      2 226
      1 230
      1 233
      1 234
     48 246
      1 253
      2 257
      1 263
      1 270
      1 275
      1 276
      1 293
      1 294
      1 308
      2 324
      1 359
      1 360
      5 369
      1 370
      2 409

Other than testing whether or not an SPDX license line exists,
checkpatch doesn't inspect .rst files.

There are better tools for that.


