Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7B420028
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhJCFO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 01:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhJCFOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:14:25 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C197C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 22:12:38 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id s64so26796753yba.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 22:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7X9wrDB6kU7Zn7sIQW2J6Ll13ujNfojISEAcJyTSWLk=;
        b=jLtcR920mB32Erq/w8ERUFrtfop3VMZPzSXioNVFO5nkrxWjjnS27eHpdQDOcIz6aS
         wEQ1DKp3HrnyGj3PaqCoaQB1sEV0pI1w9QriH7/HdLjWMAGmPdmsOytb4Ua0KxQpqID6
         PJWwxyXDh+F9IAAv5GTLJXkgoAo9oKQyJb8mwMNhgM8VQNnXjwFRy9GgT/4G2TdJtMyc
         BgoPBeSob15CeOJrJuXChfrwMDk8uH4VWsPLXq8cWQlZ0Jehp8szuaC4iqHBZMwZof3Q
         /iekaLW4/WSwnC0xU9cG4/VUj70irEa7qVOpZuG3/uvAQDT6NXvorfLrhniiyFFhEnXM
         Q4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7X9wrDB6kU7Zn7sIQW2J6Ll13ujNfojISEAcJyTSWLk=;
        b=NvcpQ15Cx/prb1mmSFHht+E+ujkZUTqFLS2n1Dv0/WncHzG+Jds6cVfvasa0r7yS6P
         xJX9o44SrTaurVt4OEaBb72kmMFtoU303fVgkhQdYyrJMs7wE5jEt3IFHKIsX/zAahEa
         U+zFX18FmwmRZkgmPcbfSlLs0eJNaZqLKmUCjAVMQ88pb3+wm4fy+DfXNEuEYNxGIHga
         jMRm/nYOsYsXCjvaDZ0GUfilMoJiXm300uuKE1AdNatLCr7kAXUmWhTv5+b+3V6Zv9MY
         +PUF6XucORT+AIahJzrUppLFpk76+T9ZB4YfycpNIvnzPQ45T/F+1EUR5qWnd1tdHBvC
         V3Yg==
X-Gm-Message-State: AOAM531fFma1N8X7VIJ/Ub8T8SG/uGcoSzHD0RdosrTkb4srnv+78Ws+
        TI5jRqwMM11KUvQVp3GHJ3KWcpv7dnAqkcoVY2k=
X-Google-Smtp-Source: ABdhPJy817h9V/7Ib9kAPHPA8COqHqpGAEw31gHfGIS6uWAf/DE8EyGo50QsuLMKTfIqU3VGiYGFdsFqpYvUqRf2HZ0=
X-Received: by 2002:a05:6902:705:: with SMTP id k5mr5753780ybt.67.1633237957581;
 Sat, 02 Oct 2021 22:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <d15bba541aac03ebe24c733f24b6bda96d03a3ec.camel@perches.com> <20211002140247.28677-1-utkarshverma294@gmail.com>
In-Reply-To: <20211002140247.28677-1-utkarshverma294@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 3 Oct 2021 07:12:26 +0200
Message-ID: <CAKXUXMwF4+6xVe606=rK1wUX6S3azhRwPY_SrmUjmXVV7Vj42A@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add check for continue statement in UNNECESSARY_ELSE
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 4:03 PM Utkarsh Verma <utkarshverma294@gmail.com> wrote:
>
> UNNECESSARY_ELSE only checks for the usage of else after a return or
> break. But the same logic is also true for continue statement.

Just a bit nicer wording and improving your English writing:

But the same logic applies for the continue statement.

>
> else used after a continue statement is unnecessary. So add a test
> for continue statement also.
s/else/An else branch/

s/for continue statement/for the continue statement/
s/also/, too/

Other than that, all good. Great patch.

>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  scripts/checkpatch.pl | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c27d2312cfc3..0eee086d87fe 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4011,15 +4011,15 @@ sub process {
>
>  # check indentation of any line with a bare else
>  # (but not if it is a multiple line "if (foo) return bar; else return baz;")
> -# if the previous line is a break or return and is indented 1 tab more...
> +# if the previous line is a break or continue or return and is indented 1 tab more...
>                 if ($sline =~ /^\+([\t]+)(?:}[ \t]*)?else(?:[ \t]*{)?\s*$/) {
>                         my $tabs = length($1) + 1;
> -                       if ($prevline =~ /^\+\t{$tabs,$tabs}break\b/ ||
> -                           ($prevline =~ /^\+\t{$tabs,$tabs}return\b/ &&
> -                            defined $lines[$linenr] &&
> -                            $lines[$linenr] !~ /^[ \+]\t{$tabs,$tabs}return/)) {
> +                       if ($prevline =~ /^\+\t{$tabs,$tabs}(break|continue|return)\b/ &&
> +                           !($1 eq "return" &&
> +                             defined $lines[$linenr] &&
> +                             $lines[$linenr] =~ /^[ \+]\t{$tabs,$tabs}return/)) {
>                                 WARN("UNNECESSARY_ELSE",
> -                                    "else is not generally useful after a break or return\n" . $hereprev);
> +                                    "else is not generally useful after a $1\n" . $hereprev);
>                         }
>                 }
>
> --
> 2.25.1
>
