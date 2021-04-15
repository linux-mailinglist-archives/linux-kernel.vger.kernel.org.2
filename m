Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D3E361421
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhDOVaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:30:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:58784 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235835AbhDOVaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:30:12 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AE58180F;
        Thu, 15 Apr 2021 21:29:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AE58180F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1618522188; bh=t67+k546gBIsT9XMy+RiKFoHmpRAnf+zrnYpN23A658=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qCgLddaaKzlYEgUW7CqQ/6SBb65eOp9XNBTVKE1iVE6xxFvFni03RbE4P4n3TiuRy
         QUTdLo0nyU0cJaI7G+VZy29Io1laPGte88fA/Zr+D3fSV9er440lMD5plm3R0riP0L
         5LFCzft7q0Ww86FmO+nEGUdo8aEdbWZ/rE/JcanuIlAhVvmcBn6/HS4sfzp96jOB6B
         H9RFGNFcmPwO7OFeZVb5s5ULsc9eZ3wDpqdabjIr6V4/J4K+sC7uMyxrC/2QMtm1xZ
         +CR4tNzlZgsfoaLKrGmM6xVj3cX9m5TOUxqGd7QL7Xtbhd81cMSitd4OFuH+hmco5n
         307Z1ytvm8BHQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] scripts: kernel-doc: improve parsing for kernel-doc
 comments syntax
In-Reply-To: <20210414192529.9080-1-yashsri421@gmail.com>
References: <20210414192529.9080-1-yashsri421@gmail.com>
Date:   Thu, 15 Apr 2021 15:29:47 -0600
Message-ID: <87y2djgrsk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Srivastava <yashsri421@gmail.com> writes:

> Currently kernel-doc does not identify some cases of probable kernel
> doc comments, for e.g. pointer used as declaration type for identifier,
> space separated identifier, etc.
>
> Some example of these cases in files can be:
> i)" *  journal_t * jbd2_journal_init_dev() - creates and initialises a journal structure"
> in fs/jbd2/journal.c
>
> ii) "*      dget, dget_dlock -      get a reference to a dentry" in
> include/linux/dcache.h
>
> iii) "  * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t"
> in include/linux/seqlock.h
>
> Also improve identification for non-kerneldoc comments. For e.g.,
>
> i) " *	The following functions allow us to read data using a swap map"
> in kernel/power/swap.c does follow the kernel-doc like syntax, but the
> content inside does not adheres to the expected format.
>
> Improve parsing by adding support for these probable attempts to write
> kernel-doc comment.
>
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Link: https://lore.kernel.org/lkml/87mtujktl2.fsf@meer.lwn.net
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  scripts/kernel-doc | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

OK, I've applied this, but I have a couple of comments...

> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 888913528185..37665aa41e6b 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -2110,17 +2110,25 @@ sub process_name($$) {
>      } elsif (/$doc_decl/o) {
>  	$identifier = $1;
>  	my $is_kernel_comment = 0;
> -	if (/^\s*\*\s*([\w\s]+?)(\(\))?\s*([-:].*)?$/) {
> +	my $decl_start = qr{\s*\*};

I appreciate the attempt to make the regexes a bit more comprehensible,
but we can do better yet, methinks.  This $decl_start is very much like
$doc_com defined globally.

It would really help a lot if we could at least take the incredible mass
of regexes in this program and boil them down to a smaller, unique set
that is used throughout.  kernel-doc might still make brains explode,
but perhaps the blast radius would be a bit smaller.

> +	my $fn_type = qr{\w+\s*\*\s*}; # i.e. pointer declaration type, foo * bar() - desc

Some of the lines in this change go waaaaay beyond the 80-character
limit; please try not to do that.  I fixed up the offending comments
this time around.

Thanks,

jon

