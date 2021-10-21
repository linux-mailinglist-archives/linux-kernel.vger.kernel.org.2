Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2005B435D45
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhJUItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhJUItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:49:07 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F249AC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:46:51 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id o4so12840065oia.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdXFjy61Qy/rnsWDdjxcnajZ2gMgamPPbsD5FZNqukA=;
        b=cnx7RWXe9MTa2MyYSEhY11osG+93I8MxzJ7YGe9R3MBcBh818wFg8gXiNrmQwSWnFC
         wxl5gQXgq/UOg0CLpgJRaKhnKaqeanItrEtiC7ACXxPgc5bNcNYWGveXIPp93STtRcrb
         iKSV5e6zUvcLsUOUr7Nujd6G18wCd0vo0Yxzky7sVWYchvWu/YLPdhjD/j9YEjumxpEl
         BpdWvCqtNM51PmjdT3Bydf1MpOZy/5f/d1fslw7UB0axfJQeX48O3z6Soo5jT8VjEwcM
         QQ1z+lMKRWwIfOZrtihBi3sstqQr8k5baiYdYgG/xflNTXMcCAm9NodyKw/Bn77cYza2
         v9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdXFjy61Qy/rnsWDdjxcnajZ2gMgamPPbsD5FZNqukA=;
        b=UBGr7vS1sYk/+7i/BJaZkkUMolWp7pYnYcUDLZXES2jeBRMGkWBm4Jego6DWsXCpBm
         bw7SPpPO9tKPZtS3Osn10MGQzfD8vxHOoiowQagxnR9Xd/zbIC5PLBvfBqiTAO71eVr5
         ZQXwxxhKyjki5OOlfEzTSGeEVyegQiLg7u74hVjna8L/me/DOcN8557hDWs9jCci6+6J
         SCreBzhQTK3vb0z9wwllVr0skkJNcxfMMWIOfYYrXxkyEb34TiAN2ijtuSuNAGZoji6t
         xXtJvWn2pL3ZZntx0mEMmnw2Ifa/FRWKO5Thsdwi56mWYVlpnSFL37m0niSmxo4dk16X
         pqdg==
X-Gm-Message-State: AOAM531WuhiXIPtPI2sa4ESF0ol0RFKoIHb7OlmCuE/Dc/FyBdRCvmQb
        vulBESQbISuxsst1b+I7Mkg+CzsuHU8iuarE2ZYDlA==
X-Google-Smtp-Source: ABdhPJzVvuyF5GdGpswaNFJXcJVKW/wyXlllnzMgF8chWYnVNr+F18Z+ShLA/2gjBOhpxLhqslZEhvZw3tToO3Mvy5c=
X-Received: by 2002:a05:6808:6ce:: with SMTP id m14mr398982oih.134.1634806011175;
 Thu, 21 Oct 2021 01:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211020200039.170424-1-keescook@chromium.org>
 <CANpmjNMPaLpw_FoMzmShLSEBNq_Cn6t86tO_FiYLR2eD001=4Q@mail.gmail.com> <202110210141.18C98C4@keescook>
In-Reply-To: <202110210141.18C98C4@keescook>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 Oct 2021 10:46:39 +0200
Message-ID: <CANpmjNNwEXH2=mp4RS6UUU7U9az7_zgVM223w-NJgqw1Zp-4xQ@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc.h: Define __SANITIZE_ADDRESS__ under
 hwaddress sanitizer
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 10:43, Kees Cook <keescook@chromium.org> wrote:

> > Other than that,
> >
> >   Reviewed-by: Marco Elver <elver@google.com>
>
> Thanks! (Oh, BTW, it seems "b4" won't include your Reviewed-by: tag if
> it is indented like this.)

Ah, I'll stop doing that then -- or can we make b4 play along?

Thanks,
-- Marco
