Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DFB360814
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhDOLRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhDOLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:17:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5FC061574;
        Thu, 15 Apr 2021 04:17:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h20so11873464plr.4;
        Thu, 15 Apr 2021 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Xzhbfi8H9ftSIkgwmOeRE9lGFEylEcwsXMtPPxhe60=;
        b=VvrdAnQ+p0jxlGFOwXPb5TCzw7n/74reBVIuhJUv/J2WW6h1TBkAUy2SSFPoaOIshk
         mxJ8xeyo2voyIr+QqEKi3v69wx1IUokm0MLC8qJZG13hlYJaeX8ZczA5IQ8bEZYfrtLi
         peXMVx0PBJIsu4Pn2VZVysZJX4pEVFHkb0eFyZklKyEOc6EHJV5T4tuvZcASTOufczXx
         N2yP0OVYgGwxtfCYIJN66ym1gyT3kfJnlDFviM8hHFmpUyqbRTQkiuNG7eZrbZ9Sle6d
         dUSHgoTRsE61w9mB3/wCvpI8fq6rc8lD+830Nj49HrWEdHozf+BPvtrbvOi+4DPaY3Bb
         drqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Xzhbfi8H9ftSIkgwmOeRE9lGFEylEcwsXMtPPxhe60=;
        b=ik0j9jkrO9CTptZgrCZFX86cIT8KOXF/YsbTgas5RxxLdoKEDlxKbGfSCJaij2H7V8
         nv1CIz9d6zr9r8IV8wxNIDkrUSwRW8vIGiFxIDrMDZvhkBQfFXkoAcYH4j7Tk4gbiKXB
         r1mkgz6Vq9iC7mSrZNx4K+SZ+R/87ogLCAtKaF9ZPmcgYbdDc7VyvD8cO7aA9n4kfZWf
         +/rb+D/psPJEELWYfcj7UbZxHANmv+eSM3FnAPXDrXvfBLX5EKMx2zFJdNIU0pGoEKAJ
         eYA9NwgMHeplsZt1bpJc809zj+FQKWwX7kRCOyecilN6jun1TFrGvfCn2dvHwj9YgVGf
         6Y/A==
X-Gm-Message-State: AOAM531xm3qs2EH6KHImdqufs5LBzURgzFfAGU+tQrlXFybknkb6Tigt
        rULxjuo52+D43s4/CPSxu76NbrNllZ5Tmw==
X-Google-Smtp-Source: ABdhPJwVBgV01HQ5R9jcij9mWXogEw8h1tLfgGqxpYO3viU/s4KOZla/LreHcMt9mAZginlm7hPxPw==
X-Received: by 2002:a17:90b:3884:: with SMTP id mu4mr3365061pjb.128.1618485430760;
        Thu, 15 Apr 2021 04:17:10 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a089:2483:f13d:beac:b531? ([2405:201:600d:a089:2483:f13d:beac:b531])
        by smtp.gmail.com with ESMTPSA id n3sm1803590pga.92.2021.04.15.04.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 04:17:10 -0700 (PDT)
Subject: Re: [RFC] scripts: kernel-doc: improve parsing for kernel-doc
 comments syntax
To:     corbet@lwn.net
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210414192529.9080-1-yashsri421@gmail.com>
From:   Aditya Srivastava <yashsri421@gmail.com>
Message-ID: <d49dacfb-7612-b8fc-6ee5-3e2ec2a5c601@gmail.com>
Date:   Thu, 15 Apr 2021 16:47:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210414192529.9080-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/4/21 12:55 am, Aditya Srivastava wrote:
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
> 
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
> +	my $fn_type = qr{\w+\s*\*\s*}; # i.e. pointer declaration type, foo * bar() - desc
> +	my $parenthesis = qr{\(\w*\)};
> +	my $decl_end = qr{[-:].*};
> +	if (/^$decl_start\s*([\w\s]+?)$parenthesis?\s*$decl_end?$/) {
>  	    $identifier = $1;
> -	    $decl_type = 'function';
> -	    $identifier =~ s/^define\s+//;
> -	    $is_kernel_comment = 1;
>  	}
>  	if ($identifier =~ m/^(struct|union|enum|typedef)\b\s*(\S*)/) {
>  	    $decl_type = $1;
>  	    $identifier = $2;
>  	    $is_kernel_comment = 1;
>  	}
> +	elsif (/^$decl_start\s*$fn_type?(\w+)\s*$parenthesis?\s*$decl_end?$/ ||	# i.e. foo()
> +	    /^$decl_start\s*$fn_type?(\w+.*)$parenthesis?\s*$decl_end$/) {	# i.e. static void foo() - description; or misspelt identifier
> +	    $identifier = $1;
> +	    $decl_type = 'function';
> +	    $identifier =~ s/^define\s+//;
> +	    $is_kernel_comment = 1;
> +	}
>  	$identifier =~ s/\s+$//;
>  
>  	$state = STATE_BODY;
> 

Hi
I have generated a diff file for changes in kernel-doc warnings for
all the files in the kernel-tree, before and after this patch.
It can be found at:
https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/kernel-doc/kernel_doc_comment_syntax_improvement_diff.txt

Thanks
Aditya
