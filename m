Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4238031FE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhBSR43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:56:29 -0500
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:60272 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229726AbhBSR4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:56:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 75D58100E7B40;
        Fri, 19 Feb 2021 17:55:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 20,1.5,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2565:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:4823:5007:6119:7652:7903:8531:9025:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:14764:14989:21080:21433:21451:21611:21627:21740:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tail44_090e71c2765f
X-Filterd-Recvd-Size: 2427
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Feb 2021 17:55:41 +0000 (UTC)
Message-ID: <02966e73a288d49372746d61547084e13a2fac29.camel@perches.com>
Subject: Re: [PATCH v4 2/2] docs: add documentation for checkpatch
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Feb 2021 09:55:40 -0800
In-Reply-To: <20210217165434.69298-3-dwaipayanray1@gmail.com>
References: <20210217165434.69298-1-dwaipayanray1@gmail.com>
         <20210217165434.69298-3-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-17 at 22:24 +0530, Dwaipayan Ray wrote:
> Add documentation for kernel script checkpatch.pl.
> This documentation is also parsed by checkpatch to
> enable a verbose mode.
> 
> The checkpatch message types are grouped by usage. Under
> each group the types are described briefly. 34 of such
> types are documented.

Of course with more to come as you are work on them... ;)

> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
[]
> +    This applies for all non-functional blocks.
> +    However, there is one special case, namely functions: they have the
> +    opening brace at the beginning of the next line, thus::
> +
> +      int function(int x)
> +      {
> +        body of function
> +      }
> +
> +    Ref: `Documentation/process/coding-style.rst section 3`

Ideally, these Ref: entries should use a form with the specific section
to jump to.  For example:

	Ref: `https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces`

Perhaps "See: " might be better than "Ref: "

	See: `https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces`

> +  **CODE_INDENT**
> +    Code indent should use tabs instead of spaces.
> +    Outside of comments, documentation and Kconfig,
> +    spaces are never used for indentation.
> +    Ref: `Documentation/process/coding-style.rst section 1`

	See: `https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation`

etc...


