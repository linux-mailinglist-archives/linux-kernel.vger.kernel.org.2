Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FE231B158
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 17:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBNQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 11:58:26 -0500
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:43844 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229637AbhBNQ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:58:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id EDC4B18029299;
        Sun, 14 Feb 2021 16:57:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6117:6119:6120:7652:7901:7903:8784:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12679:12740:12760:12895:13069:13095:13138:13231:13311:13357:13439:14181:14659:14721:21080:21433:21451:21611:21627:21939:30012:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: place77_161588327634
X-Filterd-Recvd-Size: 2333
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun, 14 Feb 2021 16:57:41 +0000 (UTC)
Message-ID: <b2e25e683a3e2f31d4dc2d666e082634e30643b3.camel@perches.com>
Subject: Re: [PATCH RFC v3 2/3] docs: add documentation for checkpatch
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-doc@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 14 Feb 2021 08:57:40 -0800
In-Reply-To: <20210213131513.51386-3-dwaipayanray1@gmail.com>
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
         <20210213131513.51386-3-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-02-13 at 18:45 +0530, Dwaipayan Ray wrote:
> Add documentation for kernel script checkpatch.pl.
> This documentation is also parsed by checkpatch to
> enable a verbose mode.
> 
> The message types in checkpatch are documented with rst
> field lists. A total of 33 checkpatch type descriptions
> are added.

Alphabetic ordering isn't that great for these entries.
Please group them by use:

whitespace/code layout style:
SPACING, TRAILING_WHITESPACE, LINE_SPACING

commit message defects:
BAD_SIGN_OFF, BAD_STABLE_ADDRESS_STYLE, COMMIT_COMMENT_SYMBOL, COMMIT_MESSAGE

Allocation style:
group: ALLOC_ARRAY_ARGS, ALLOC_SIZEOF_STRUCT, ALLOC_WITH_MULTIPLY

> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
[]
> +4 Type Descriptions
> +-------------------
> +
> +This section contains a description of all the message types in checkpatch.
> +
> +.. Types in this section are also parsed by checkpatch.
> +.. Please keep the types sorted alphabetically.
> +
> +:ALLOC_ARRAY_ARGS:
> +  The first argument for kcalloc or kmalloc_array should be the
> +  number of elements.  sizeof() as the first argument is generally
> +  wrong.

If you look at the generated .html file, the output format  is poor.

It would probably be better to use
**<TYPE>**
for each of these blocks instead of
:<TYPE>:

and update the script appropriately.

