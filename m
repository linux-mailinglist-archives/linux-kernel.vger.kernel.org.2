Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFF386FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbhERCYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:24:11 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:60510 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237658AbhERCYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:24:11 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 41988B9E0;
        Tue, 18 May 2021 02:22:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 400311D42F6;
        Tue, 18 May 2021 02:22:52 +0000 (UTC)
Message-ID: <b09f7f17f07cf960c26ddb522558e3ab5187ba83.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add help info if no filenames are given
From:   Joe Perches <joe@perches.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 17 May 2021 19:22:50 -0700
In-Reply-To: <1621301101-10650-1-git-send-email-yangtiezhu@loongson.cn>
References: <1621301101-10650-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.59
X-Stat-Signature: jihq8tuq4xpq9hfagci99qa1jnm7u98h
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 400311D42F6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX189Clm5kzluHcxTV3Ni94MGzXh0bkt97MM=
X-HE-Tag: 1621304572-653515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-05-18 at 09:25 +0800, Tiezhu Yang wrote:
> After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
> if no filenames are given, it will read patch from stdin rather than exit
> directly. This means the script waits for input indefinitely, which
> confuses new checkpatch users at first.
> 
> Add some help info on this behaviour of checkpatch to lower the confusion.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 23697a6..825eb00 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -80,6 +80,8 @@ sub help {
>  Usage: $P [OPTION]... [FILE]...
>  Version: $V
>  
> 
> +When FILE is -, or absent, checkpatch reads from standard input.
> +
>  Options:
>    -q, --quiet                quiet
>    -v, --verbose              verbose mode
> @@ -138,8 +140,6 @@ Options:
>    --kconfig-prefix=WORD      use WORD as a prefix for Kconfig symbols (default
>                               ${CONFIG_})
>    -h, --help, --version      display this help and exit
> -
> -When FILE is - read standard input.

This line is redundant/unnecessary.

>  EOM
>  
> 
>  	exit($exitcode);


