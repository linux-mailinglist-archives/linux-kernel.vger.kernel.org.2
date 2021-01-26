Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81D305280
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhA0DQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:16:02 -0500
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:56044 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729334AbhAZUMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:12:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3F4C918224D77;
        Tue, 26 Jan 2021 20:11:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:968:973:981:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6120:7652:7901:7903:8784:8985:9010:9025:10004:10400:10848:11232:11658:11914:12043:12297:12740:12895:12903:13019:13138:13161:13206:13215:13229:13231:13439:13894:14181:14659:14721:21080:21433:21451:21627:21795:30012:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bean36_25142e827591
X-Filterd-Recvd-Size: 3411
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Jan 2021 20:11:10 +0000 (UTC)
Message-ID: <9bfc9c21d93bb55419954114ed3a7e5cbdc84ddb.camel@perches.com>
Subject: Re: [PATCH RFC 1/3] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
Date:   Tue, 26 Jan 2021 12:11:09 -0800
In-Reply-To: <20210126183521.26535-2-dwaipayanray1@gmail.com>
References: <20210126183521.26535-1-dwaipayanray1@gmail.com>
         <20210126183521.26535-2-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-27 at 00:05 +0530, Dwaipayan Ray wrote:
> Add a new verbose mode to checkpatch.pl to emit additional verbose
> test descriptions.
> 
> The verbose mode is optional and can be enabled by the flag
> --verbose.
> 
> The test descriptions are itself loaded from the checkpatch

descriptions are themselves, but themselves is unnecessary.

The verbose descriptions are read from Documentation/dev-tools/checkpatch.rst

> documentation file at Documentation/dev-tools/checkpatch.rst.
> The descriptions in the documentation are in a specified format
> enclosed within .. CHECKPATCH_START and .. CHECKPATCH_END labels.
> 
> This serves a dual purpose as an external documentation to checkpatch
> as well as enables flawless integration of the verbose mode.

Using 'flawless' when describing code or documentation generally isn't true.

> A subtle example of the format is as follows:

What is subtle about an example?

If there is something subtle about an example, there's also something
wrong with the example.

> Documentation/dev-tools/checkpatch.rst:
> 
> .. CHECKPATCH_START

Nak on the keyword uses.

This should really just parse the input file whenever TYPE is found
via some fixed format and save the verbose description after that.

Use .rst Field Lists instead, and ideally, keep the list in alphabetic
order or group by similar use.

https://docutils.sourceforge.io/docs/user/rst/quickref.html#field-lists

e.g.:

:LINE_SPACING:
	Vertical space is wasted given the limited number of lines an
	editor window can display when multiple blank lines are used.

:SPACING:
	Whitespace style used in the kernel sources is described in
	ref:`Documentation/process/Coding-Style.rst section 3.1.

:TRAILING_WHITESPACE:
	Trailing whitespace should always be removed.
	Some editors highlight the trailing whitespace and cause visual
	distractions when editing files.

etc...

> @@ -2185,6 +2235,11 @@ sub report {
>  		splice(@lines, 1, 1);
>  		$output = join("\n", @lines);
>  	}
> +
> +	if ($verbose && !$terse &&
> +	    exists $verbose_messages{$type}) {
> +		$output .= $verbose_messages{$type} . "\n\n";
> +	}
>  	$output = (split('\n', $output))[0] . "\n" if ($terse);

Don't use unnecessary multiple tests of the same object, just reorder
the code instead.  And also please use c-style function parentheses
rather than bare tests.

	if ($terse) {
		$output = ...
	} elsif ($verbose && exists($verbose_messages{$type})) {
		$output .= ...
	}



