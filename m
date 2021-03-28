Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2076534BBD2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhC1J1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhC1J1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 05:27:16 -0400
Received: from mail.ionic.de (ionic.de [IPv6:2001:41d0:a:588b:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5DF6C061762
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 02:27:15 -0700 (PDT)
Authentication-Results: root24.eu; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=ionic.de 
   (client-ip=217.92.117.31; helo=home.ionic.de; 
   envelope-from=ionic@ionic.de; receiver=<UNKNOWN>)
Received: from [192.168.0.46] (home.ionic.de [217.92.117.31])
        by mail.ionic.de (Postfix) with ESMTPSA id 0003E4F00335;
        Sun, 28 Mar 2021 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
        t=1616923635; bh=Ll6xz1GHdtVoXWThs4MJlXY4CapAMv9/7Y56mgdyoj4=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=vAIJfEaDauj3kgS66m4QtWbUONGlMfWzJC6U4ODyaldAIkhZtlj9lgCKgFpi3sMad
         51UiO9/231zy2urSaNpPsJ8UTAX27tyOhZ2DwpbyqZtYxgSUqeC4I9hQpPlkHxXiEm
         k/44iVvdsQwLGZF/LeB9xdu/TFEhtCRwU1e73pNU=
To:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210327120155.500-1-ionic@ionic.de>
 <1ca3a90f-799e-d917-370e-1475e33cdb14@infradead.org>
 <111c5853-e488-0aaa-18e9-36792b648427@ionic.de>
 <362edad0-daea-1f56-bed3-b1df174cbbf1@infradead.org>
From:   Mihai Moldovan <ionic@ionic.de>
Subject: Re: [PATCH] kconfig: nconf: stop endless search-up loops
Message-ID: <695102ca-0c05-7bf9-2758-08b5405e876b@ionic.de>
Date:   Sun, 28 Mar 2021 11:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <362edad0-daea-1f56-bed3-b1df174cbbf1@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* On 3/27/21 11:26 PM, Randy Dunlap wrote:
> There is a test for it in checkpatch.pl but I also used checkpatch.pl
> without it complaining, so I don't know what it takes to make the script
> complain.
> 
> 			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
> 			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
> 			    WARN("CONSTANT_COMPARISON",
> 				 "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&

There are multiple issues, err, "challenges" there:
  - literal "Constant" instead of "$Constant"
  - the left part is misinterpreted as an operation due to the minus sign
    (arithmetic operator)
  - $Constant is defined as "qr{$Float|$Binary|$Octal|$Hex|$Int}" (which is
    okay), but all these types do not include their negative range.

As far as I can tell, the latter is intentional. Making these types compatible
with negative values causes a lot of other places to break, so I'm not keen on
changing this.

The minus sign being misinterpreted as an operator is highly difficult to fix
in a sane manner. The original intention was to avoid misinterpreting
expressions like (var - CONSTANT real_op ...) as a constant-on-left expression
(and, more importantly, to not misfix it when --fix is given).

The general idea is sane and we probably shouldn't change that, but it would
be good to handle negative values as well.

At first, I was thinking of overriding this detection by checking if the
leading part matches "(-\s*$", which should only be true for negative values,
assuming that there is always an opening parenthesis as part of a conditional
statement/loop (if, while). After playing around with this and composing this
message for a few hours, it dawned on me that there can easily be free-
standing forms (for instance as part of for loops or assignment lines), so
that wouldn't cut it.

It really goes downhill from here.

I assume that false negatives are nuisances due to stylistic errors in the
code, but false positives actually harmful since a lot of them make code
review by maintainers very tedious.

So far, minus signs were always part of the leading capture group. I'd
actually like to have them in the constant capture group instead:

-		    $line =~ /^\+(.*)\b($Constant|[A-Z_][A-Z0-9_]*)\s*($Compare)\s*($LvalOrFunc)/) {
+		    $line =~ /^\+(.*)(-?\s*$Constant|[A-Z_][A-Z0-9_]*)\s*($Compare)\s*($LvalOrFunc)/) {

With that sorted, the next best thing I could come up with to weed out
preceding variables was this (which shouldn't influence non-negative
constants):

-			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
+			if ($lead !~ /(?:$Operators|\.|[a-z])\s*$/ &&


There still are a lot of expressions that won't match this, like
"-1 + 0 == var" (i.e., "CONSTANT <arith_op> CONSTANT <op> ...") or
constellations like a simple "(CONSTANT) <op> ..." (e.g.,
"(1) == var").

This is all fuzzy and getting this right would involve moving away from
trying to make sense of C code with regular expressions in Perl, but actually
parsing it to extract the semantics. Not exactly something I'd like to do...

Thoughts on my workaround for this issue? Did I miss anything crucial or
introduce a new bug inadvertently?
