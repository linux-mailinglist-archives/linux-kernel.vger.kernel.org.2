Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388B131DCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhBQPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhBQPqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:46:49 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054C3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:46:09 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a22so16743391ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+g26s0aSTGaLnN/gduWXkSeKUiKej72AeVs+y0HyD/Y=;
        b=t2VoafJleFp20lwXCFmM5iSb5m9wFPosnlyI5nerNlgLygDZDt0/5pzDjixNoyQ8SD
         0bah+i2BhxdfCvc6kPDbRXRxo5ZROLJ8KAU8V102wpo92ia5noLZtfHDItdrQmTGGsoI
         8s/HCmiNUaavVCdAPyuCRkDPXPLrJUMC0Wd0EGVTgP9JD0H6WLTzCj/cu0lH4A4v3Nta
         1EnyoMcbVAzE7eKJcL0CsHAngq53cJPaBZGSO7kG1AZ78+MdqCClD6n5QQrzZJYqfP3Z
         bxCpOX/vdPO2vdfte0B/7ynwyJR5Oh4VdDbJX8JIjeuMRZAp1aq7wTQcwc4Pele7LgRM
         3KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+g26s0aSTGaLnN/gduWXkSeKUiKej72AeVs+y0HyD/Y=;
        b=RGHlxT6oBLz8lte/PS8LenY/5xjXD5eWmkpCK1Qk7f51LioKxrY03vv/S7N+RQcVAL
         8acM2jymo0U6KxzAL/adJENR6vMq1hxXu4g6K8mesQLKke9PlbeNjSmdrhVytNq0VgBl
         cHOtpzADBDq2U8m0Fg1979+kqhqpQt8utxPU9uGOfcCfnD/0xpd9/0AFC48RjP1Xk58C
         Z5ICLE0qZd3WbRjY7c5bWTRIuSAtSXTaL8xfMsJbv2tug8I5U5KaXvsCS9dKcVEkvhFw
         nr2YWARFnBZyVf+YS6Ax874FwXBngylQl8dN62sUsdJM+osc5q9AsJq4fpMQFNzdsAU6
         sFOg==
X-Gm-Message-State: AOAM533rucPd+asqqPut3+PmgVHiHH5QRS+FsuV6CcGRBluZ9Na2NsX/
        rbH6/r7fFYByp4BFwM8QdxyuYMkdZYGqqyY5pYODXdaGGavd8g==
X-Google-Smtp-Source: ABdhPJwkxjQwo9r5TcgZguEoGBqCrOTVBwSTpuJDf5PTRuTXglNtaaPdorCmbJ35G1PXZB2gjM2gn864+Jn3yUBSHlc=
X-Received: by 2002:a2e:985a:: with SMTP id e26mr7402280ljj.370.1613576767331;
 Wed, 17 Feb 2021 07:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
 <20210213131513.51386-3-dwaipayanray1@gmail.com> <b2e25e683a3e2f31d4dc2d666e082634e30643b3.camel@perches.com>
 <CABJPP5CaAavDMWy8xmQ8Bxpf5549v8fqOz8Zi=g7g6ZGnCAVmg@mail.gmail.com> <4d6856b33cc870ac655d801d066f04af6ebadcd7.camel@perches.com>
In-Reply-To: <4d6856b33cc870ac655d801d066f04af6ebadcd7.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 17 Feb 2021 21:16:08 +0530
Message-ID: <CABJPP5A+g1_jCLPPgSc4wu8O7birW4yBE_9+HJusLFHOsS3Eug@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/3] docs: add documentation for checkpatch
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 4:07 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2021-02-16 at 19:48 +0530, Dwaipayan Ray wrote:
> > On Sun, Feb 14, 2021 at 10:27 PM Joe Perches <joe@perches.com> wrote:
> > > On Sat, 2021-02-13 at 18:45 +0530, Dwaipayan Ray wrote:
> > > > Add documentation for kernel script checkpatch.pl.
> > > > This documentation is also parsed by checkpatch to
> > > > enable a verbose mode.
> > > >
> > > > The message types in checkpatch are documented with rst
> > > > field lists. A total of 33 checkpatch type descriptions
> > > > are added.
> > >
> > > Alphabetic ordering isn't that great for these entries.
> > > Please group them by use:
> > >
> > > whitespace/code layout style:
> > > SPACING, TRAILING_WHITESPACE, LINE_SPACING
> []
> > Could I get some comment on this grouping for types:
> >
> > Allocation Style: ALLOC_ARRAY_ARGS, ALLOC_SIZEOF_STRUCT, ALLOC_WITH_MULTIPLY
> >
> > API Usage: ARCH_DEFINES, ARCH_INCLUDE_LINUX, ARRAY_SIZE, AVOID_BUG,
> >                     AVOID_EXTERNS, AVOID_L_PREFIX, BIT_MACRO, CONSIDER_KSTRTO
> >
> > Comment Style: BLOCK_COMMENT_STYLE, C99_COMMENTS
> >
> > Commit Message: BAD_SIGN_OFF, BAD_STABLE_ADDRESS_STYLE, COMMIT_COMMENT_SYMBOL,
> >                               COMMIT_MESSAGE, MISSING_SIGN_OFF,
> > NO_AUTHOR_SIGN_OFF
> >
> > Comparison Style: ASSIGN_IN_IF, BOOL_COMPARISON, COMPARISON_TO_NULL,
> >                                CONSTANT_COMPARISON
> >
> > Spacing & Brackets: ASSIGNMENT_CONTINUATIONS, BRACES, BRACKET_SPACE,
> >                                   CODE_INDENT, CONCATENATED_STRING,
> > LINE_SPACING,
> >                                   TRAILING_WHITESPACE
> >
> > Others: CAMELCASE, CONFIG_DESCRIPTION
> >
> > This is what I have done till now. Any suggestions would be nice and if it looks
> > okay I would like to send the v4 in.
>
> Looks OK.
>
> Please make sure you at least include SPACING in the spacing & brackets
> descriptions.
>
> It also seems like ref links to Documentation/process/coding-style.rst
> <section> (3.1 in the SPACING case) should be used more frequently.
>
> It'd be 'nice' to somehow use sortable tables with some grouping
> attribute for these groups, but I have no idea if that's feasible with
> .rst restrutured text files.
>

I too didn't find anything like that. Seems like static tables are the most
that's feasible with sphynx. But here it might not look well.

> Perhaps simplify the checkpatch code a bit for the --terse and --verbose
> output.
>
> Maybe something like:
> ---
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 869d80397f9f..07566cb3b3f8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
>
> @@ -292,15 +292,16 @@ GetOptions(
>
>  help(0) if ($help);
>
> +die "$P: --git cannot be used with --file or --fix\n" if ($git && ($file || $fix));
> +die "$P: --verbose canot be used with --terse\n" if ($verbose && $terse);
> +
>  list_types(0) if ($list_types);
>

Sure will do this. Sending you the updated patch in a while.

Thanks!
--Dwaipayan
