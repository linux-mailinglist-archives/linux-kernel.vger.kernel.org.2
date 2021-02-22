Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FEA321E85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhBVRuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBVRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:50:17 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8ACC061786;
        Mon, 22 Feb 2021 09:49:37 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id z18so11571111ile.9;
        Mon, 22 Feb 2021 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqp0KUt/ON1evnwg7CU4+QUDw8az+ViCzd56I6hP/Wc=;
        b=W17mcyu+YOndPMVtSKrSjmwfrfs98z6akzj1XstFlB4wcHb5nrYJdnxodFanCSu3QQ
         uP04tCRq7c4Nu+b1z8GiH4LGAyuCwJObCqkUeRCsGU+Hw+Pjr0mCFSpjYFFjaWeK7kiR
         zJi088KY8ot5bLnMehAk2zCCyOmL+qgjD3uHNZ8jzuBL5Uh4EpQxO32wv6jq/R53E3ty
         mw9s/eP0GduKhzhcHQcgswaWNPvN/f+Qb5PA5ZuDNIW/l4HMaXero8T3UsRa4Zuq/7Dg
         cpbGQZ/66xnKT2Wbu3ZAGQ+PEN/e0bJZrN3BP+rU6Zqt2bnJbp50mUSPqKBMuSmZEklC
         eBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqp0KUt/ON1evnwg7CU4+QUDw8az+ViCzd56I6hP/Wc=;
        b=LXgIGX9HZesmbGOaEcYcm2AL6YuDrcsoz68FcL6imxasS+6cmuATGvS/DcS7nZZpuv
         4vlB+XCSQdsPxgHBzh9icIBeep3RyfX5jxtqFvZE1HvzphLQ409eAELhu2J2aJakVI7F
         WLGUfdYARvEtKDl6Fwx7KqXZcGuZHlMkiQsCGPDiFwXrVXE74YRMj+DuGOuLR2zfRwki
         km/pCguZfTIECr7B22BlMyBfelbfhBggtQk3p2jbSfTIJcr2xdzLkp5mBJKyBexl26d1
         2KDrymlalPH7Ajgv00N/nhfzPch1SrUW8fqpnYYFoE5OGRmrdHGUKy95MUXZj6f2CZcp
         qZDQ==
X-Gm-Message-State: AOAM532j8DxYo7InwYIMVJpPYNgv7g3gW604sK2itG1iOC8Kng4DwPrP
        TLcJstmlP5ACKI0vy9hV/k7Ku/xhJ7I7bkk3ApggG1b9xvo=
X-Google-Smtp-Source: ABdhPJwUGwWSiB2iumLh8m38uhK4i36vjVoxsNoogiIB2dUxtXDyAjHGi0LAlIOPCHJivSlOoqBD3SODfTONl2rsS6E=
X-Received: by 2002:a05:6e02:1aa8:: with SMTP id l8mr15940426ilv.251.1614016176735;
 Mon, 22 Feb 2021 09:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20210222160347.23410-1-yashsri421@gmail.com>
In-Reply-To: <20210222160347.23410-1-yashsri421@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 22 Feb 2021 18:49:25 +0100
Message-ID: <CAKXUXMz-2TC2oYX2K4ZJOaXpFfaL8e1J87GBj0o-+t_X74Ypyw@mail.gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: fix typedef support for struct parsing
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 5:03 PM Aditya Srivastava <yashsri421@gmail.com> wrote:
>
> There are files in kernel, which use 'typedef struct' syntax for defining
stylistic:
s/in kernel/in the kernel tree/
s/defining struct/defining some struct/
> struct. For eg, include/linux/zstd.h, drivers/scsi/megaraid/mega_common.h,
> etc.

stylistic:
s/For eg/E.g./ or
s/For eg/For example/

semantically:
It makes much more sense to name how many occurrences of this pattern
exist in the kernel tree within how many files in order to get a good
impression on the use of that pattern within the kernel tree.


> However, kernel-doc still does not support it, causing a parsing error.
>
> For eg, running scripts/kernel-doc -none on include/linux/zstd.h emits:
> "error: Cannot parse struct or union!"
>

semantically:
Drop the example and turn the two sentences above into one.

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
> -       my $decl_type = $1;
> +       $decl_type = $1;
>         $declaration_name = $2;
> -       my $members = $3;
> +       $members = $3;
> +    } elsif ($x =~ /typedef\s+(struct|union)\s*\{(.*)\}(?:\s*(?:__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*\s*(\w*)\s*;/) {
> +       $decl_type = $1;
> +       $declaration_name = $3;
> +       $members = $2;
> +    }
>

Could you put the common expression parts into meaningful variables to
avoid repeating yourself in the two pattern matching expressions?

Other than that, it looks good to me.

Lukas

> +    if ($members) {
>         if ($identifier ne $declaration_name) {
>             print STDERR "${file}:$.: warning: expecting prototype for $decl_type $identifier. Prototype was for $decl_type $declaration_name instead\n";
>             return;
> --
> 2.17.1
>
