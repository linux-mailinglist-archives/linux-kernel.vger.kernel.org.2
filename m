Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F73815E4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 06:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhEOE1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 00:27:21 -0400
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:51232 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229506AbhEOE1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 00:27:20 -0400
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D4A82182CED2A;
        Sat, 15 May 2021 04:26:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id E4613B2796;
        Sat, 15 May 2021 04:26:06 +0000 (UTC)
Message-ID: <68e897fec0e6258b2a964908af650d8608189454.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Print some info if no filenames are given
From:   Joe Perches <joe@perches.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 14 May 2021 21:26:05 -0700
In-Reply-To: <1621052131-16309-1-git-send-email-yangtiezhu@loongson.cn>
References: <1621052131-16309-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E4613B2796
X-Spam-Status: No, score=1.26
X-Stat-Signature: gapktgit9j1kn7ofq5cyhqc9p9prg7bx
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18/OXvHLG10EBECofBmYOdeCFEqdLEM+Rg=
X-HE-Tag: 1621052766-813315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-05-15 at 12:15 +0800, Tiezhu Yang wrote:
> After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
> if no filenames are given, it will read patch from stdin rather than exit
> directly, it is better to print some info about what to do next, otherwise
> it is a bit confusing whether the script hangs.

I think this is unnecessary.
It's like trying to make cat without command line arguments emit something.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -361,6 +361,8 @@ if ($^V && $^V lt $minimum_perl_version) {
>  
> 
>  #if no filenames are given, push '-' to read patch from stdin
>  if ($#ARGV < 0) {
> +	print "$P: missing patchfile or -f file\n";
> +	print "Use --help if necessary or read patch from stdin\n";
>  	push(@ARGV, '-');
>  }
>  
> 


