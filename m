Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66A5438B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJXSQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:16:55 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:38311 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhJXSQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:16:54 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 19OIEHZh010785
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 03:14:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 19OIEHZh010785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1635099258;
        bh=kHtJLapBKvIj9iQkHyruElX5mMdvn2N3gxSrFaMdF7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z1WpbCSzg9n56nhwK2gTP4gWzrDQ32G/XuNa6UWHXJhh38IZMVt+TauZSLFnoNwyk
         oMeCYYbd9dr2MBmgimwPd8RwPadEUl3hDfdIb/h1TLlJ4f1yCf+1T6TbpSfqfcMNwk
         CUCI9axsyhoz3a6mz0KbtaUaV0HcFForMfS/ph0b0bSLvCdkyeDI58uF8NZWWKvS+h
         DxmA/3i2pWJmq/zj6pNR5uTYia++E1CRoAFshJB5xbkIxkXV5BYu8fb9HTqakUe/OP
         DIFv8Qo89NMnFfI2WXVAJ+YjJSLqrEnVDy1Xqdae5X1HPz2rEaiqNhuSdbGipDS2XJ
         ZCqXjfTJHNjPQ==
X-Nifty-SrcIP: [209.85.214.174]
Received: by mail-pl1-f174.google.com with SMTP id r5so1776816pls.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:14:18 -0700 (PDT)
X-Gm-Message-State: AOAM530E2QbrFiAiJRSUyNMXUMPD08LJPq5NZl7xLSCGRMFJq6dojr+q
        nmYKidfHv9k6jZ2dyQ8Y9SoRU7OO/kZuhUa4kdE=
X-Google-Smtp-Source: ABdhPJwak0mPVnTwbpijmOOOfyX87n+NAEV7TBWHob/zaajpaZcyUjhQwTEaEd2YWrQuMsB8pxYEfjY+VSowfK9Lagc=
X-Received: by 2002:a17:90b:4ac1:: with SMTP id mh1mr14876550pjb.144.1635099257239;
 Sun, 24 Oct 2021 11:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
In-Reply-To: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Oct 2021 03:13:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
Message-ID: <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
Subject: Re: Commit 0d989ac2c90b broke my x86-64 build.
To:     Rob Landley <rob@landley.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 3:36 PM Rob Landley <rob@landley.net> wrote:
>
> The attached config built fine before the above commit, doesn't build after. The
> commit in question did nothing except remove support for building x86-64 without
> libelf.

You enable CONFIG_STACK_VALIDATION in your .config file.
At least, you observed
"warning: Cannot use CONFIG_STACK_VALIDATION=y, please install
libelf-dev, libelf-devel or elfutils-libelf-devel"
in the previous builds.


>
> It took me a while to notice because the commit ONLY broke x86-64. I can still
> build arm (32 and 64 bit), i686, m68k, mips/mipsel, powerpc, s390x, and sh4
> without libelf in my cross compiler. Heck, I can still build i686. The change
> seems to have added a unique build dependency to just x86-64.

The other architectures are not affected because you cannot enable
CONFIG_STACK_VALIDATION.

Please note only x86_64 selects HAVE_STACK_VALIDATION.


> Rob
>
> P.S. Why do you need a special library to parse elf anyway? It's a fairly simple
> file format, linux has include/linux.elf.h, the toolchain already has an objtool
> prefixed for the appropriate cross compiler...

You are asking a question about the objtool implementation.
CCed Josh Poimboeuf.


-- 
Best Regards
Masahiro Yamada
