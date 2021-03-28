Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B134BC0F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 12:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC1KiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 06:38:01 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:48478 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229560AbhC1Khf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 06:37:35 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D392918041740;
        Sun, 28 Mar 2021 10:37:34 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA id D4D0D1A29FB;
        Sun, 28 Mar 2021 10:37:33 +0000 (UTC)
Message-ID: <3e7134b15bfbfbf47bf55fce733e8f986865f69b.camel@perches.com>
Subject: Re: [PATCH] kconfig: nconf: stop endless search-up loops
From:   Joe Perches <joe@perches.com>
To:     Mihai Moldovan <ionic@ionic.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 28 Mar 2021 03:37:32 -0700
In-Reply-To: <695102ca-0c05-7bf9-2758-08b5405e876b@ionic.de>
References: <20210327120155.500-1-ionic@ionic.de>
         <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>
         <111c5853-e488-0aaa-18e9-36792b648427@ionic.de>
         <362edad0-daea-1f56-bed3-b1df174cbbf1@infradead.org>
         <695102ca-0c05-7bf9-2758-08b5405e876b@ionic.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: 15kq3759yjaifrwfq6poj38pcp4ddzzt
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D4D0D1A29FB
X-HE-Tag: 1616927853-443206
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-03-28 at 11:27 +0200, Mihai Moldovan wrote:
> * On 3/27/21 11:26 PM, Randy Dunlap wrote:
> > There is a test for it in checkpatch.pl but I also used checkpatch.pl
> > without it complaining, so I don't know what it takes to make the script
> > complain.
> > 
> > 			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
> > 			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
> > 			    WARN("CONSTANT_COMPARISON",
> > 				 "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&
> 
> There are multiple issues, err, "challenges" there:
>   - literal "Constant" instead of "$Constant"
>   - the left part is misinterpreted as an operation due to the minus sign
>     (arithmetic operator)
>   - $Constant is defined as "qr{$Float|$Binary|$Octal|$Hex|$Int}" (which is
>     okay), but all these types do not include their negative range.
> 
> As far as I can tell, the latter is intentional. Making these types compatible
> with negative values causes a lot of other places to break, so I'm not keen on
> changing this.
> 
> The minus sign being misinterpreted as an operator is highly difficult to fix
> in a sane manner. The original intention was to avoid misinterpreting
> expressions like (var - CONSTANT real_op ...) as a constant-on-left expression
> (and, more importantly, to not misfix it when --fix is given).
> 
> The general idea is sane and we probably shouldn't change that, but it would
> be good to handle negative values as well.
> 
> At first, I was thinking of overriding this detection by checking if the
> leading part matches "(-\s*$", which should only be true for negative values,
> assuming that there is always an opening parenthesis as part of a conditional
> statement/loop (if, while). After playing around with this and composing this
> message for a few hours, it dawned on me that there can easily be free-
> standing forms (for instance as part of for loops or assignment lines), so
> that wouldn't cut it.
> 
> It really goes downhill from here.
> 
> I assume that false negatives are nuisances due to stylistic errors in the
> code, but false positives actually harmful since a lot of them make code
> review by maintainers very tedious.
> 
> So far, minus signs were always part of the leading capture group. I'd
> actually like to have them in the constant capture group instead:
> 
> -		    $line =~ /^\+(.*)\b($Constant|[A-Z_][A-Z0-9_]*)\s*($Compare)\s*($LvalOrFunc)/) {
> +		    $line =~ /^\+(.*)(-?\s*$Constant|[A-Z_][A-Z0-9_]*)\s*($Compare)\s*($LvalOrFunc)/) {
> 
> With that sorted, the next best thing I could come up with to weed out
> preceding variables was this (which shouldn't influence non-negative
> constants):
> 
> -			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
> +			if ($lead !~ /(?:$Operators|\.|[a-z])\s*$/ &&
> 
> 
> There still are a lot of expressions that won't match this, like
> "-1 + 0 == var" (i.e., "CONSTANT <arith_op> CONSTANT <op> ...") or
> constellations like a simple "(CONSTANT) <op> ..." (e.g.,
> "(1) == var").
> 
> This is all fuzzy and getting this right would involve moving away from
> trying to make sense of C code with regular expressions in Perl, but actually
> parsing it to extract the semantics. Not exactly something I'd like to do...
> 
> Thoughts on my workaround for this issue?

Making $Constant not include negative values was very intentional.

> Did I miss anything crucial or introduce a new bug inadvertently?

Not as far as I can tell from a trivial read.
My best guess as to what is best or necessary to do is nothing.
checkpatch isn't a real parser and never will be.

It can miss stuff.  It's imperfect.  It doesn't bother me.

