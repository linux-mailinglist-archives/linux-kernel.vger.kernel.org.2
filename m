Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1093166FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhBJMoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:44:21 -0500
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:55870 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231171AbhBJMlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:41:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 93014837F24A;
        Wed, 10 Feb 2021 12:40:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3872:4321:4605:5007:7652:10004:10400:10848:11026:11232:11658:11914:12043:12114:12297:12438:12555:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21451:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: honey21_32078fe27610
X-Filterd-Recvd-Size: 2048
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Feb 2021 12:40:38 +0000 (UTC)
Message-ID: <c2ca4fc47e61a597261509d16510db6c592d1c80.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: Don't check for
 mutex_trylock_recursive()
From:   Joe Perches <joe@perches.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 10 Feb 2021 04:40:37 -0800
In-Reply-To: <20210210085248.219210-3-bigeasy@linutronix.de>
References: <20210210085248.219210-1-bigeasy@linutronix.de>
         <20210210085248.219210-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-10 at 09:52 +0100, Sebastian Andrzej Siewior wrote:
> mutex_trylock_recursive() has been removed from the tree, there is no
> need to check for it.
> 
> Remove traces of mutex_trylock_recursive()'s existence.

Yay.  Assuming patch 1 is applied, thanks.

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  scripts/checkpatch.pl | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1afe3af1cc097..4b2775fd31d9d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7062,12 +7062,6 @@ sub process {
>  			}
>  		}
>  
> 
> -# check for mutex_trylock_recursive usage
> -		if ($line =~ /mutex_trylock_recursive/) {
> -			ERROR("LOCKING",
> -			      "recursive locking is bad, do not use this ever.\n" . $herecurr);
> -		}
> -
>  # check for lockdep_set_novalidate_class
>  		if ($line =~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
>  		    $line =~ /__lockdep_no_validate__\s*\)/ ) {


