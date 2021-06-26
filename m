Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510A53B57C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 05:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhF1DTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 23:19:36 -0400
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:55492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231678AbhF1DTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 23:19:35 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2F30018027FB9;
        Mon, 28 Jun 2021 03:17:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 9E699315D7E;
        Mon, 28 Jun 2021 03:17:09 +0000 (UTC)
Message-ID: <075e07c40b99f93123051ef8833612bc88a55120.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch: skip spacing tests on linker scripts
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20210626034016.170306-2-jim.cromie@gmail.com>
References: <20210626034016.170306-1-jim.cromie@gmail.com>
         <20210626034016.170306-2-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Fri, 25 Jun 2021 21:15:09 -0700
User-Agent: Evolution 3.40.0-1 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.69
X-Stat-Signature: ujcakg6uthd5pott8gkaaos5skj8orsa
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9E699315D7E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+CCw0rhYnrZWLAhwGAO/WNoJF/Taq8vm8=
X-HE-Tag: 1624850229-472669
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-25 at 21:40 -0600, Jim Cromie wrote:
> Before issuing a WARNING on spacing, exclude reports on linker
> scripts, which don't comport to C style rules.  skip_on_filename()
> skips on *.lds.h files, I think covering all cases.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2546,6 +2546,11 @@ sub get_raw_comment {
>  	return $comment;
>  }
> 
> +sub skip_on_filename {
> +	my $fname = shift;
> +	return $fname =~ m@\.lds\.h$@;
> +}

nak.  This is poor naming for what is not a generic function.

> @@ -5134,7 +5139,8 @@ sub process {
>  							}
>  						}
>  					} elsif ($ctx =~ /Wx[^WCE]|[^WCE]xW/) {
> -						if (ERROR("SPACING",
> +						if (!skip_on_filename($realfile) &&
> +						    ERROR("SPACING",
>  							  "need consistent spacing around '$op' $at\n" . $hereptr)) {
>  							$good = rtrim($fix_elements[$n]) . " " . trim($fix_elements[$n + 1]) . " ";
>  							if (defined $fix_elements[$n + 2]) {

This .lds.h test is also used in one other place.

It might be better to avoid all tests in .lds.h files by using a
"next if" much earlier.


