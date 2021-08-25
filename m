Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F643F7E36
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhHYWKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbhHYWKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:10:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:10:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m4so1241002ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghFbFPwORK1+Bz2wOxhpN/SoN4TRNRW43zNAEvuCWSY=;
        b=E0x8czOulpWEN891RwS2QAyBvmp9MvfetYuWVhbr06f3zooNt13sa+lOLywDOoy2Dx
         Yv7hedc6sv4ydIHicr6V0Fif8+Eh5ODJaelTi8a4Uz4iaX4QGIngB09G84PYmiSfuh9i
         NiL5Ceil+a1RbaNyWvKo4yIn4O6zJfoNZTZaaGg7sxT8YDpqAmFzIdhncRBY5jAXgTE1
         AthI4l0Mw6uIbSwFjIY1jzdpuJyoAQdSxJZl5BLf8Xq+/wEk4hgGJ7uT5KcbNGCmWfGK
         wp3GCyC0dj2Pd2wTAMjlMQcqgo7Zm9q06CK3OlbmaI7C7R8gQR9la1434Xw4KEdhUm3H
         8S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghFbFPwORK1+Bz2wOxhpN/SoN4TRNRW43zNAEvuCWSY=;
        b=ZFQ5FXWvDZv1QW0zyrouKlzUGvTjHF6GwI3dTD1Xa2/EHMVfXpQTR1ay5SjKTFJBS6
         RNJ6HllJp1+7hW0CN4T44hIfi5uXfwLb+pE54BLrz16eScdeHo0zZBInqcBYBYFQ3UdY
         R43hmUI3ZczGJF/NJNFK1xXxiwnrpva84JN6HD9pKguy1M8AFJenx4+0pevWqMInE67W
         0g/72htsbUHNf9L/Av7RdJ1x14E6ljXQc+c5mpbZkPdX8No6IT7CCD0N4Hkk5UdOQNxm
         R2i1tX6+4rddfe6AhC5HVV/Kw2ubLbGCm6nbr2bYay7NP0NVHAiU9wBBDMgaVOmDNp8d
         1GUQ==
X-Gm-Message-State: AOAM532d9SATuEF/oHWsY/G6RKRDWcOjEIPYYQUIm/2haRDMGWWEARzU
        dOozvwel9l3FD69t4avvhO2Roo6fY2Aq0PW5flAtwg==
X-Google-Smtp-Source: ABdhPJzzXlIrFGyXH220jQi7T8nSZN7IM6dxT6KRzEETxGwid12RGI3KeDZHSF3ZBWxXHPPtg544/FeyqPAR+lyTDDY=
X-Received: by 2002:a2e:a40c:: with SMTP id p12mr323288ljn.479.1629929402286;
 Wed, 25 Aug 2021 15:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210825211823.6406-1-nathan@kernel.org> <20210825211823.6406-2-nathan@kernel.org>
In-Reply-To: <20210825211823.6406-2-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 15:09:51 -0700
Message-ID: <CAKwvOdmtd0PUH-=_OqTzhFYh=XimHDpFWP9bmcnMprioTSKHBw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation/llvm: Update mailing list
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 2:18 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> We are now at llvm@lists.linux.dev.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Documentation/kbuild/llvm.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index b18401d2ba82..06b8f826e1a3 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -111,7 +111,8 @@ Getting Help
>  ------------
>
>  - `Website <https://clangbuiltlinux.github.io/>`_
> -- `Mailing List <https://groups.google.com/forum/#!forum/clang-built-linux>`_: <clang-built-linux@googlegroups.com>
> +- `Mailing List <https://lore.kernel.org/llvm/>`_: <llvm@lists.linux.dev>
> +- `Old Mailing List Archives <https://groups.google.com/g/clang-built-linux>`_
>  - `Issue Tracker <https://github.com/ClangBuiltLinux/linux/issues>`_
>  - IRC: #clangbuiltlinux on chat.freenode.net
>  - `Telegram <https://t.me/ClangBuiltLinux>`_: @ClangBuiltLinux
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
