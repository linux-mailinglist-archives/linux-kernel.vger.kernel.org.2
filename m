Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7079743636A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJUNxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhJUNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:53:09 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8568EC061220
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:50:53 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d15so1390082qkj.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X627hdV4ApujpQUUoEd4GytdquRpFSDxi4GbRHWgN6w=;
        b=Z+oMjis/ZipjIr5vTe+hVa0eMETxOPNSk9m/G9sJp1pi52o1QPJGeWvVm+MTdxMJBn
         GKFaN0OU+7E5H4WbFyjLmmJp+luref7Tsa0bGnUHytQUNMIb78o8CJnie3BgXbz0/fMb
         99kNq2E54BieCWqFnlQtRzm/MGigLNX0bX/qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X627hdV4ApujpQUUoEd4GytdquRpFSDxi4GbRHWgN6w=;
        b=EQ1xm6WfudYT98iBqrTa7V7rSPc8DMLgK0El7EQDPqAioPXAIlnkp3c15VeKMchWwv
         DHbInOrw/NqlMO04lH83T9BaS2oPSPxDJvRAFkAEOguZRYfdrReG+W1O5l+plggAbovZ
         VEKDsOd744IvhJakXU65jLLXK+IDuo2z0heSN5mUPZzDaeC6w+l72mjfPQtBVj9Fblgf
         VriTQhpZLigHxdHZ1FKiD3aYVDBxkHUX4D9oCa1AAZCTqoP4AIDzCQVVfYP0flwvWjUn
         ZaqyOQ4RRnJ9IP34snKXDzeNeuzXaGYCtjZ9/mP0Ryz7TipRzYv1UOMCJ51OTiQhJ6Wr
         G2eg==
X-Gm-Message-State: AOAM530DV/HIBdL3T1C7H+7cCaf062rVfkllXxmVhgZQr3n4AXwWEzTF
        +3E0a19AEJAJRRYE+vRHoA3guw==
X-Google-Smtp-Source: ABdhPJwqW44ZpMxik6TDzwJfex2I8L3bKqq5BfFwqJLkmT76/W23bk6UkpQChFWN95mIjNDXH8TynA==
X-Received: by 2002:a05:620a:1a28:: with SMTP id bk40mr4577765qkb.224.1634824252613;
        Thu, 21 Oct 2021 06:50:52 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id 12sm2656131qty.9.2021.10.21.06.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:50:52 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:50:50 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] compiler-gcc.h: Define __SANITIZE_ADDRESS__ under
 hwaddress sanitizer
Message-ID: <20211021135050.vmangeqpl7ahidus@meerkat.local>
References: <20211020200039.170424-1-keescook@chromium.org>
 <CANpmjNMPaLpw_FoMzmShLSEBNq_Cn6t86tO_FiYLR2eD001=4Q@mail.gmail.com>
 <202110210141.18C98C4@keescook>
 <CANpmjNNwEXH2=mp4RS6UUU7U9az7_zgVM223w-NJgqw1Zp-4xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNNwEXH2=mp4RS6UUU7U9az7_zgVM223w-NJgqw1Zp-4xQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 10:46:39AM +0200, Marco Elver wrote:
> > >   Reviewed-by: Marco Elver <elver@google.com>
> >
> > Thanks! (Oh, BTW, it seems "b4" won't include your Reviewed-by: tag if
> > it is indented like this.)
> 
> Ah, I'll stop doing that then -- or can we make b4 play along?

I'd rather not allow for that, as this can lead to increased false-positive
rates. It's already a bit too much of a cross-your-fingers kind of thing.

-K
