Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B514439CAC1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 21:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFETeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 15:34:12 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:32978 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229998AbhFETeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 15:34:10 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 85398100E7B42;
        Sat,  5 Jun 2021 19:32:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id BACFD1124F6;
        Sat,  5 Jun 2021 19:32:20 +0000 (UTC)
Message-ID: <0c0bdfa2c0c1f2c7ebdcbe7d4a1366c1697ce57a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: do not allow using -f/--file option without
 a filename
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sat, 05 Jun 2021 12:32:19 -0700
In-Reply-To: <20210605191754.28165-1-dwaipayanray1@gmail.com>
References: <20210605191754.28165-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BACFD1124F6
X-Spam-Status: No, score=-1.40
X-Stat-Signature: yj6jei1nxhby9siykowof8ya1fmi8tuj
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19i1kW3aqmTKMX5m4ckwaU7fZjBZd3fqsk=
X-HE-Tag: 1622921540-18543
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-06-06 at 00:47 +0530, Dwaipayan Ray wrote:
> When checkpatch is run without a filename, it reads from stdin.
> But if --file option is used along with that, it may generate
> false positives.
> 
> Consider the following test file:
> $cat test.c
> int x = a - b;
> 
> $cat test.c | ./scripts/checkpatch.pl -f
> WARNING: It's generally not useful to have the filename in the file
> +int x = a - b;
> 
> This is a false positive and occurs because $realfile is set to "-".
> Also since checkpatch relies on the file's extension to run specific
> checks for c files, assembly files, etc, most of the checks are
> not run as well.
> 
> So it is better to disable -f/--file option when checkpatch is
> run without a filename.

That's a reasonable commit message, thanks.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -331,6 +331,7 @@ help(0) if ($help);
>  
> 
>  die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
>  die "$P: --verbose cannot be used with --terse\n" if ($verbose && $terse);
> +die "$P: -f/--file requires at least one filename\n" if ($file && $#ARGV < 0);
>  
>  if ($color =~ /^[01]$/) {
>  	$color = !$color;


