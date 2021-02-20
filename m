Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88F3205E0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 16:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBTPPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 10:15:36 -0500
Received: from smtprelay0222.hostedemail.com ([216.40.44.222]:50716 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229734AbhBTPPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 10:15:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A2B45837F253;
        Sat, 20 Feb 2021 15:14:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6117:7652:7875:7903:8603:8784:9010:9025:10004:10400:10848:11026:11232:11473:11658:11783:11914:12043:12296:12297:12740:12895:13069:13095:13190:13229:13311:13357:13439:13894:14096:14097:14181:14659:14721:14764:21080:21433:21451:21611:21627:21939:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:146,LUA_SUMMARY:none
X-HE-Tag: wall13_5e05dae27667
X-Filterd-Recvd-Size: 2222
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Feb 2021 15:14:48 +0000 (UTC)
Message-ID: <cda9541eb8cff5cbba178d6a6d511a46f193aab1.camel@perches.com>
Subject: Re: [PATCH v5 0/2] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Feb 2021 07:14:46 -0800
In-Reply-To: <20210220120220.32585-1-dwaipayanray1@gmail.com>
References: <20210220120220.32585-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-02-20 at 17:32 +0530, Dwaipayan Ray wrote:
> Add a new verbose mode to checkpatch. The verbose test
> descriptions are read from the checkpatch documentation
> file at `Documentation/dev-tools/checkpatch.rst`.
> 
> The verbose mode is optional and can be enabled by the
> flag -v or --verbose.
> 
> The documentation file is only parsed by checkpatch.pl
> if the verbose mode is enabled. The verbose mode can
> not be used together with the --terse option.
> 
> Changes in v5:
> - Change the reference format to use absolute links.
> - Print verbose descriptions only for the first time
>   a message type is encountered.

OK, I think a nice addition would be to add --verbose
text to the --list-types option when used together.

$ ./scripts/checkpatch.pl --list-types --verbose
1	ALLOC_ARRAY_ARGS

	The first argument for kcalloc or kmalloc_array should be the
	number of elements.  sizeof() as the first argument is generally
	wrong.

	See: https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html

2	ALLOC_SIZEOF_STRUCT

	The allocation style is bad.  In general for family of
	allocation functions using sizeof() to get memory size,
	constructs like::

	p = alloc(sizeof(struct foo), ...)

	should be::

	p = alloc(sizeof(*p), ...)

	See: https://www.kernel.org/doc/html/latest/process/coding-style.html#allocating-memory

etc...


