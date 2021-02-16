Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A631CBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhBPOUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhBPOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:19:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7938C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:18:52 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b3so13233206wrj.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydSVplyCbekENrKjGYCbN31ZHi4GQiUsavtSWIdE7WQ=;
        b=XIBlbgPsJ1B7Xxrwtu/pEkpdbjZWJE+D38NMZJDf59kPikUY8w7fYbO5jLdTBRm4C/
         tYXfcDWipNI0QNLIw5EpR6Vr8NvJ1luoMm5RKZdZpJIBKSxu8QNDcJtdBwu03VYwofXr
         i8FeLuCTUttFXtN4yQuzfDTLw6yxHslE/JtLWEe1bJ0ZehzpAy6kzRLHY7EAya+d5f1w
         6oPCJH81yB/r4RZdbFD7Y3p1Pj61vFfZRK7d7RSDlcp9UXSXJkHJxThWgS4Ewkv/0lGc
         aVBg0W44fq9+R4j4iVxTkekZbUwczPFdcktOWVEop3YRpdBUYSLnqSCdTzLTchmC6JAI
         7/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydSVplyCbekENrKjGYCbN31ZHi4GQiUsavtSWIdE7WQ=;
        b=RdiiI5sRb/C3ZnM3WCN51jFUCrld7RwIAb8npqf24XFbhibHj2L3S/vb48fe9tACFi
         qXE0y3rE4MnaSVzWss3GUzXxlw4+V4JH8uirWpj7HC5q4Ic0L6c5s8J8dg3+XSwuwQSA
         aZ0ZwuEBjANHEvqBKL9FyNSnwtS1xn01usZfWtsB7eLfPr1+woEi1VCzzR/GYdvHuBeQ
         1+uP0l6MT2JbU0C+19fdIUki9KXI8mainAU4zZdIDvLqsl5SoAmQWcvNGRrSM6zYWwLf
         bwBfngaYZeY4Cda+awIf8mEJKvTqrsSLKHdD1bVKtutr4a2aIZSqliao8FyueA6TGRNG
         M7zw==
X-Gm-Message-State: AOAM5303JUyJ1I6gjje+F/PQhUWP49j0ruLWiSx+du6UoZ4lcfeloaC/
        03a3J88J2laLMXjAXDL02BS1Y1zM/9jDyNuDTJE8lZPI1aRQ1obL
X-Google-Smtp-Source: ABdhPJzZawgZRLvkKppc98IHqIkXN6SOSc0FzGsVlF0vofBcTa/6OLdIMhh8Rfz21oqxBUkZTxuQKtJ7S+tm/GsYPoM=
X-Received: by 2002:a5d:45ca:: with SMTP id b10mr24528912wrs.9.1613485131379;
 Tue, 16 Feb 2021 06:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
 <20210213131513.51386-3-dwaipayanray1@gmail.com> <b2e25e683a3e2f31d4dc2d666e082634e30643b3.camel@perches.com>
In-Reply-To: <b2e25e683a3e2f31d4dc2d666e082634e30643b3.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 16 Feb 2021 19:48:52 +0530
Message-ID: <CABJPP5CaAavDMWy8xmQ8Bxpf5549v8fqOz8Zi=g7g6ZGnCAVmg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/3] docs: add documentation for checkpatch
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 10:27 PM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2021-02-13 at 18:45 +0530, Dwaipayan Ray wrote:
> > Add documentation for kernel script checkpatch.pl.
> > This documentation is also parsed by checkpatch to
> > enable a verbose mode.
> >
> > The message types in checkpatch are documented with rst
> > field lists. A total of 33 checkpatch type descriptions
> > are added.
>
> Alphabetic ordering isn't that great for these entries.
> Please group them by use:
>
> whitespace/code layout style:
> SPACING, TRAILING_WHITESPACE, LINE_SPACING
>
> commit message defects:
> BAD_SIGN_OFF, BAD_STABLE_ADDRESS_STYLE, COMMIT_COMMENT_SYMBOL, COMMIT_MESSAGE
>
> Allocation style:
> group: ALLOC_ARRAY_ARGS, ALLOC_SIZEOF_STRUCT, ALLOC_WITH_MULTIPLY
>
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> []
> > +4 Type Descriptions
> > +-------------------
> > +
> > +This section contains a description of all the message types in checkpatch.
> > +
> > +.. Types in this section are also parsed by checkpatch.
> > +.. Please keep the types sorted alphabetically.
> > +
> > +:ALLOC_ARRAY_ARGS:
> > +  The first argument for kcalloc or kmalloc_array should be the
> > +  number of elements.  sizeof() as the first argument is generally
> > +  wrong.
>
> If you look at the generated .html file, the output format  is poor.
>
> It would probably be better to use
> **<TYPE>**
> for each of these blocks instead of
> :<TYPE>:
>
> and update the script appropriately.
>

Hi,
Could I get some comment on this grouping for types:

Allocation Style: ALLOC_ARRAY_ARGS, ALLOC_SIZEOF_STRUCT, ALLOC_WITH_MULTIPLY

API Usage: ARCH_DEFINES, ARCH_INCLUDE_LINUX, ARRAY_SIZE, AVOID_BUG,
                    AVOID_EXTERNS, AVOID_L_PREFIX, BIT_MACRO, CONSIDER_KSTRTO

Comment Style: BLOCK_COMMENT_STYLE, C99_COMMENTS

Commit Message: BAD_SIGN_OFF, BAD_STABLE_ADDRESS_STYLE, COMMIT_COMMENT_SYMBOL,
                              COMMIT_MESSAGE, MISSING_SIGN_OFF,
NO_AUTHOR_SIGN_OFF

Comparison Style: ASSIGN_IN_IF, BOOL_COMPARISON, COMPARISON_TO_NULL,
                               CONSTANT_COMPARISON

Spacing & Brackets: ASSIGNMENT_CONTINUATIONS, BRACES, BRACKET_SPACE,
                                  CODE_INDENT, CONCATENATED_STRING,
LINE_SPACING,
                                  TRAILING_WHITESPACE

Others: CAMELCASE, CONFIG_DESCRIPTION

This is what I have done till now. Any suggestions would be nice and if it looks
okay I would like to send the v4 in.

Thanks & Regards,
Dwaipayan.
