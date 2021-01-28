Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B4F307FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhA1Ubk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:31:40 -0500
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:40190 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229595AbhA1Ubj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:31:39 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 785C218018AB6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:13:26 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D34D3181D3042;
        Thu, 28 Jan 2021 19:11:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3867:3868:3871:3872:4321:4605:5007:6119:7652:7903:10004:10400:10848:11232:11658:11914:12296:12297:12740:12760:12895:13069:13095:13161:13229:13311:13357:13439:14181:14659:14721:21080:21221:21433:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: patch09_4108f99275a2
X-Filterd-Recvd-Size: 2214
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jan 2021 19:11:06 +0000 (UTC)
Message-ID: <37535426fad04587289023e3dcc705a438c59ef6.camel@perches.com>
Subject: Re: [PATCH v2 1/3] checkpatch: add verbose mode
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
Date:   Thu, 28 Jan 2021 11:11:05 -0800
In-Reply-To: <20210128143802.15888-2-dwaipayanray1@gmail.com>
References: <20210128143802.15888-1-dwaipayanray1@gmail.com>
         <20210128143802.15888-2-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-28 at 20:08 +0530, Dwaipayan Ray wrote:
> Add a new verbose mode to checkpatch.pl to emit additional verbose
> test descriptions. The verbose mode is optional and can be enabled
> by the flag -v or --verbose.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[] 
> +sub load_docs {
> +	open(my $docs, '<', "$docsfile")
> +	    or warn "$P: Can't read the documentation file $docsfile $!\n";
> +
> +	my @lines = ();
> +	while (<$docs>) {
> +		my $line = $_;
> +
> +		$line =~ s/\s*\n?$//g;

chomp

> +		push (@lines, $line);
> +	}
> +	close($docs);
> +
> +	my $linenr = 0;
> +	my $cnt = scalar @lines;
> +	while ($linenr < $cnt) {
> +		while ($linenr < $cnt &&
> +		       $lines[$linenr++] !~ /^\:(.+)\:$/)
> +		{
> +		}
> +
> +		last if ($linenr >= $cnt);
> +
> +		my $type = $lines[$linenr - 1];
> +		$type =~ s/^\:(.+)\:$/$1/;
> +		my $message = '';
> +
> +		while ($linenr < $cnt &&
> +		       $lines[$linenr] =~ /^(?:\s+(.+)$|$)/) {
> +			$message .= $1 if (defined $1);
> +			$message .= "\n";
> +			$linenr++;
> +		}
> +
> +		$message = trim($message);
> +		$verbose_messages{$type} = $message;
> +	}
> +}

I think this is overly complicated.

There's no need to read and store the entire file and then
parse it.  Just parse it line by line as its read.


