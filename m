Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5395E31FE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBSR4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:56:08 -0500
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:60174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229726AbhBSR4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:56:05 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 834F8100E7B47;
        Fri, 19 Feb 2021 17:55:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3871:3874:4321:5007:7652:7903:10004:10400:11232:11658:11914:12043:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21433:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: food09_3c097ed2765f
X-Filterd-Recvd-Size: 1969
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Feb 2021 17:55:22 +0000 (UTC)
Message-ID: <a30afcb59bd441d90d6bba9936125c2773d830fb.camel@perches.com>
Subject: Re: [PATCH v4 1/2] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Feb 2021 09:55:21 -0800
In-Reply-To: <20210217165434.69298-2-dwaipayanray1@gmail.com>
References: <20210217165434.69298-1-dwaipayanray1@gmail.com>
         <20210217165434.69298-2-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-17 at 22:24 +0530, Dwaipayan Ray wrote:
> Add a new verbose mode to checkpatch.pl to emit additional verbose
> test descriptions. The verbose mode is optional and can be enabled
> by the flag -v or --verbose.
[]
> The verbose descriptions are not shown when the --terse option
> is enabled.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2209,7 +2256,15 @@ sub report {
>  		splice(@lines, 1, 1);
>  		$output = join("\n", @lines);
>  	}
> -	$output = (split('\n', $output))[0] . "\n" if ($terse);
> +
> +	if ($terse) {
> +		$output = (split('\n', $output))[0] . "\n";
> +	}
> +
> +	if ($verbose &&
> +	    exists $verbose_messages{$type}) {
> +		$output .= $verbose_messages{$type} . "\n\n";
> +	}

verbose output can be silly long if repeated multiple times.
Perhaps the verbose content should only be printed once when
first emitted with a flag set for that type.

Something like:

	if ($verbose && exists($verbose_messages{$type}) &&
	    !$verbose_emitted{$type}) {
		$output .= ...
		$verbose_emitted{$type} = 1;
	}


