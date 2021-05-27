Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE64A39388A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhE0WHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:07:22 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:42806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234514AbhE0WHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:07:21 -0400
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D9EC618007A3B;
        Thu, 27 May 2021 22:05:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id B9C62B2798;
        Thu, 27 May 2021 22:05:46 +0000 (UTC)
Message-ID: <93eb25ab04c2f7436a49f301c2c79a49cb209c44.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix incorrect camelcase detection on
 numeric constant
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 27 May 2021 15:05:44 -0700
In-Reply-To: <20210527214741.180449-1-borneo.antonio@gmail.com>
References: <20210527214741.180449-1-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B9C62B2798
X-Spam-Status: No, score=-0.03
X-Stat-Signature: 5es8hhmm9e4w48x77ea7crwmzh3ywsds
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18GTx/EgcI2qEfKMz8iuhkQVdAKIGZMNF0=
X-HE-Tag: 1622153146-319043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-05-27 at 23:47 +0200, Antonio Borneo wrote:
> The code fragment below
> 	int foo(int *array, int index)
> 	{
> 		return array[index & 0xFF];
> 	}
> triggers an incorrect camelcase detection by checking a subset of
> the hex constant:
> 	CHECK: Avoid CamelCase: <xFF>
> 	#3: FILE: test.c:3:
> 	+	return array[index & 0xFF];
> 
> This is caused by passing the whole string "array[index & 0xFF]"
> to the inner loop that iterates over a "$Ident" match.
> With no check to exclude a constant, the match iterates over
> "array", "index" and "xFF", thus the camelcase detection.

The thing there is that 0xFF is not an $Ident as it doesn't
start with _[A-Za-z] so it's not excluding constants per-se.

So, you've added the right code, but just not quite the best
commit message.
 
> Force the match to start at word boundary so the constants will be
> filtered-out.

Anyway, thanks and cheers, Joe

> 
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> To: Andy Whitcroft <apw@canonical.com>
> To: Joe Perches <joe@perches.com>
> To: Dwaipayan Ray <dwaipayanray1@gmail.com>
> To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 23697a6b1eaa..f0032166dfc1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5656,7 +5656,7 @@ sub process {
>  			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
>  #Ignore some three character SI units explicitly, like MiB and KHz
>  			    $var !~ /^(?:[a-z_]*?)_?(?:[KMGT]iB|[KMGT]?Hz)(?:_[a-z_]+)?$/) {
> -				while ($var =~ m{($Ident)}g) {
> +				while ($var =~ m{\b($Ident)}g) {
>  					my $word = $1;
>  					next if ($word !~ /[A-Z][a-z]|[a-z][A-Z]/);
>  					if ($check) {
> 
> base-commit: c4681547bcce777daf576925a966ffa824edd09d


