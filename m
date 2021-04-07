Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91ED357376
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354954AbhDGRsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:48:07 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:49524 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233520AbhDGRsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:48:03 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BEEF91813F559;
        Wed,  7 Apr 2021 17:47:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id EF0D8D1517;
        Wed,  7 Apr 2021 17:47:51 +0000 (UTC)
Message-ID: <1bbc36d5fbc74f11b2a1c0d3255bb3394a048a20.camel@perches.com>
Subject: Re: [RESEND PATCH v1] checkpatch: exclude four preprocessor
 sub-expressions from MACRO_ARG_REUSE
From:   Joe Perches <joe@perches.com>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 07 Apr 2021 10:47:50 -0700
In-Reply-To: <20210407105042.25380-1-mailhol.vincent@wanadoo.fr>
References: <20210407105042.25380-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF0D8D1517
X-Spam-Status: No, score=0.10
X-Stat-Signature: gz3fjhraxu55boyfniturqsod18efez6
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19u7TqTAX6xrGu7WV97zsm4NR5e6PBQWFs=
X-HE-Tag: 1617817671-456947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-07 at 19:50 +0900, Vincent Mailhol wrote:
> __must_be_array, offsetof, sizeof_field and __stringify are all
> preprocessor macros and do not evaluate their arguments. As such, it
> is safe not to warn when arguments are being reused in those four
> sub-expressions.
> 
> Exclude those so that they can pass checkpatch.
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index df8b23dc1eb0..25ee4fd5b118 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5736,7 +5736,7 @@ sub process {
>  			        next if ($arg =~ /\.\.\./);
>  			        next if ($arg =~ /^type$/i);
>  				my $tmp_stmt = $define_stmt;
> -				$tmp_stmt =~ s/\b(sizeof|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
> +				$tmp_stmt =~ s/\b(__must_be_array|offsetof|sizeof|sizeof_field|__stringify|typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
>  				$tmp_stmt =~ s/\#+\s*$arg\b//g;
>  				$tmp_stmt =~ s/\b$arg\s*\#\#//g;
>  				my $use_cnt = () = $tmp_stmt =~ /\b$arg\b/g;


