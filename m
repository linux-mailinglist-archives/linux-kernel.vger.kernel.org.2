Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD03221AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhBVVla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhBVVkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:40:47 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C84C061786;
        Mon, 22 Feb 2021 13:40:05 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 875E930D;
        Mon, 22 Feb 2021 21:40:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 875E930D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614030005; bh=EFM1k3V9bO7Y53Xdrp5AG/ja+u+SEr6m8EZGNNYAocA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LblIRwbmGR0JwwL06ujLz65nEyig0pcLcQSCTe5cXiD8cpjKM+if4EwV8W/FVrR5K
         9Nzcgfwh0+r3yGzfWLj3zxVMqll1x8GDwzoXJfMNWmVRzszh1WWryqvEkkTGcxW58t
         xa7F8hXK+ZGNCvA28hSV+9njhkCUz1PoOwv06AWH6D5ujZqg7s41JIdzmlmDCScFvx
         cJ+zvVxkXttFBr1lPttyBv2Sp8DgrzjCsjboHmDSTCpvqsAtLLf4yBZJd4EPRaCpAx
         /CkdcPHJ0qWFONaTSyceBKFacD8ZEbFfY2wytr1xJ/f2DNQ5kzwV08wynccIkoL+0y
         WJwPfa/z7Eavw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC] scripts: kernel-doc: fix typedef support for struct parsing
In-Reply-To: <20210222160347.23410-1-yashsri421@gmail.com>
References: <20210222160347.23410-1-yashsri421@gmail.com>
Date:   Mon, 22 Feb 2021 14:40:04 -0700
Message-ID: <875z2jlr2j.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Srivastava <yashsri421@gmail.com> writes:

> There are files in kernel, which use 'typedef struct' syntax for defining
> struct. For eg, include/linux/zstd.h, drivers/scsi/megaraid/mega_common.h,
> etc.
> However, kernel-doc still does not support it, causing a parsing error.
>
> For eg, running scripts/kernel-doc -none on include/linux/zstd.h emits:
> "error: Cannot parse struct or union!"
>
> Add support for parsing it.
>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  scripts/kernel-doc | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 8b5bc7bf4bb8..46e904dc3f87 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1201,12 +1201,20 @@ sub dump_union($$) {
>  sub dump_struct($$) {
>      my $x = shift;
>      my $file = shift;
> +    my $decl_type;
> +    my $members;
>  
>      if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
> -	my $decl_type = $1;
> +	$decl_type = $1;
>  	$declaration_name = $2;
> -	my $members = $3;
> +	$members = $3;
> +    } elsif ($x =~ /typedef\s+(struct|union)\s*\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*\s*(\w*)\s*;/) {

So this isn't your fault, but these regexes are really getting out of
hand.  I would *really* like to see some effort made into making this
code more understandable / maintainable as we tweak this stuff.  So:

 - Splitting out the common part, as suggested by Lukas, would be really
   useful.  That would also avoid the problem of only occurrence being
   edited the next tine we add a new qualifier.

 - Splitting out other subsections of the regex and giving them symbolic
   names would also help.

 - We really could use some comments before these branches saying what
   they are doing; it is *not* obvious from the code.

See what I'm getting at here?

Thanks,

jon
