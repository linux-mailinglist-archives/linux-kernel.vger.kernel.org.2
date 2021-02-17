Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19231D79B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 11:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhBQKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 05:38:22 -0500
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:36644 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229707AbhBQKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:38:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 99826837F24C;
        Wed, 17 Feb 2021 10:37:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:6120:6299:7652:7901:7903:8957:10010:10400:11026:11232:11473:11658:11783:11889:11914:12043:12297:12438:12555:12740:12895:13095:13138:13206:13229:13231:13439:13894:14181:14659:14721:21080:21433:21451:21611:21627:21939:30012:30054:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: gold08_4914dfe2764b
X-Filterd-Recvd-Size: 3759
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Feb 2021 10:37:38 +0000 (UTC)
Message-ID: <4d6856b33cc870ac655d801d066f04af6ebadcd7.camel@perches.com>
Subject: Re: [PATCH RFC v3 2/3] docs: add documentation for checkpatch
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Feb 2021 02:37:37 -0800
In-Reply-To: <CABJPP5CaAavDMWy8xmQ8Bxpf5549v8fqOz8Zi=g7g6ZGnCAVmg@mail.gmail.com>
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
         <20210213131513.51386-3-dwaipayanray1@gmail.com>
         <b2e25e683a3e2f31d4dc2d666e082634e30643b3.camel@perches.com>
         <CABJPP5CaAavDMWy8xmQ8Bxpf5549v8fqOz8Zi=g7g6ZGnCAVmg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-16 at 19:48 +0530, Dwaipayan Ray wrote:
> On Sun, Feb 14, 2021 at 10:27 PM Joe Perches <joe@perches.com> wrote:
> > On Sat, 2021-02-13 at 18:45 +0530, Dwaipayan Ray wrote:
> > > Add documentation for kernel script checkpatch.pl.
> > > This documentation is also parsed by checkpatch to
> > > enable a verbose mode.
> > > 
> > > The message types in checkpatch are documented with rst
> > > field lists. A total of 33 checkpatch type descriptions
> > > are added.
> > 
> > Alphabetic ordering isn't that great for these entries.
> > Please group them by use:
> > 
> > whitespace/code layout style:
> > SPACING, TRAILING_WHITESPACE, LINE_SPACING
[]
> Could I get some comment on this grouping for types:
> 
> Allocation Style: ALLOC_ARRAY_ARGS, ALLOC_SIZEOF_STRUCT, ALLOC_WITH_MULTIPLY
> 
> API Usage: ARCH_DEFINES, ARCH_INCLUDE_LINUX, ARRAY_SIZE, AVOID_BUG,
>                     AVOID_EXTERNS, AVOID_L_PREFIX, BIT_MACRO, CONSIDER_KSTRTO
> 
> Comment Style: BLOCK_COMMENT_STYLE, C99_COMMENTS
> 
> Commit Message: BAD_SIGN_OFF, BAD_STABLE_ADDRESS_STYLE, COMMIT_COMMENT_SYMBOL,
>                               COMMIT_MESSAGE, MISSING_SIGN_OFF,
> NO_AUTHOR_SIGN_OFF
> 
> Comparison Style: ASSIGN_IN_IF, BOOL_COMPARISON, COMPARISON_TO_NULL,
>                                CONSTANT_COMPARISON
> 
> Spacing & Brackets: ASSIGNMENT_CONTINUATIONS, BRACES, BRACKET_SPACE,
>                                   CODE_INDENT, CONCATENATED_STRING,
> LINE_SPACING,
>                                   TRAILING_WHITESPACE
> 
> Others: CAMELCASE, CONFIG_DESCRIPTION
> 
> This is what I have done till now. Any suggestions would be nice and if it looks
> okay I would like to send the v4 in.

Looks OK.

Please make sure you at least include SPACING in the spacing & brackets
descriptions.

It also seems like ref links to Documentation/process/coding-style.rst
<section> (3.1 in the SPACING case) should be used more frequently.

It'd be 'nice' to somehow use sortable tables with some grouping
attribute for these groups, but I have no idea if that's feasible with
.rst restrutured text files.

Perhaps simplify the checkpatch code a bit for the --terse and --verbose
output.

Maybe something like:
---
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 869d80397f9f..07566cb3b3f8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl

@@ -292,15 +292,16 @@ GetOptions(
 
 help(0) if ($help);
 
+die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
+die "$P: --verbose canot be used with --terse\n" if ($verbose && $terse);
+
 list_types(0) if ($list_types);


