Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF43EDF63
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhHPVkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhHPVkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:40:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E50C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:39:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d4so37172893lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGcAQINMauR3fG/B1eqlh1AWzF5L+XVU1Fpb6Li0xOk=;
        b=HPJ3a93PPBYIfaVBcO1fICBECWt/eOQ/wlBPWeF19J7vlNo9uptuMQ3JiHjyihEmIq
         cnMJEXneZQSLWfdnJd9A0mIGhvF+a/TIJtgWb7Q8wyhivwnw599cQRqhfQ1RnnyewDEE
         PKOo9NrCqiTtros6Z8sk1OqCVXzYlY+Ym+aqjRXNPoXVlUEsUYRGuDlsjBgURC3uSxQR
         W5P78cA1kqayTOjfn2NC9F48putXWr6LSQ3k631smN/SzcyBZq14rIf766SXNxy8d9St
         hSDYYoK1jC+UuSuW0tgEMjOvqzAI/nathxpV8hf70ZN1T3GY8hzIinnDVFTuB9WpvEY3
         1gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGcAQINMauR3fG/B1eqlh1AWzF5L+XVU1Fpb6Li0xOk=;
        b=THq8/TRe9oXkOXnYFCBiuxkUt0SgiyxRzKC2eTTFp37/31XcV1qDqq5pPJjpE2w6vK
         ugTpY9zmtCnpiwOZASHGKCalAIrQJocHF2SUP+284ereO1tSMHu+w+NyAcrAbN6B35aP
         3yP4sxwQoICjyHM+0ikxGiG1w6QII6LissczrzgbG25W/zHoe17Un+6yOEXG+8x5MMSL
         kuN2JyC8saShA5KhyT3b51GtS/3p/9J/QXA1rDQQ7hcbi/VrMRt3JmirQtXYfVGifeDO
         fIVtBSWKWZTDnlFY+X/j/aw7g6a03dNrNVJxn4ZXfsX3v6oAbBI5zGPS1zZLGUNgvwjh
         Y4gQ==
X-Gm-Message-State: AOAM532bsyyLfJ3bq/M8NghC1stgAZL8FYEK+cFDpl+plnUfOskQA0pF
        lPj0mTiiqDBT0drSqZEMjZ8zQcXTodPMPtZO84TlJA==
X-Google-Smtp-Source: ABdhPJzJGg8jp/ZSLGfmeuroyLf5UpsuS04K//ZQixEUBkRwi1V3MzJVAFLrIT4Y1Vvm4k96iRX7WcBscxFJiMQhyfY=
X-Received: by 2002:a19:7603:: with SMTP id c3mr270464lff.543.1629149990588;
 Mon, 16 Aug 2021 14:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210816202056.4586-1-nathan@kernel.org>
In-Reply-To: <20210816202056.4586-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Aug 2021 14:39:39 -0700
Message-ID: <CAKwvOdnZqFEpaCXyjkWE47jO_bNfuNDoZKTafcHHakbh=pzZ9w@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: Remove -Wno-format-invalid-specifier from
 clang block
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 1:21 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Turning on -Wformat does not reveal any instances of this warning across
> several different builds so remove this line to keep the number of
> disabled warnings as slim as possible.
>
> This has been disabled since commit 61163efae020 ("kbuild: LLVMLinux:
> Add Kbuild support for building kernel with Clang"), which does not
> explain exactly why it was turned off but since it was so long ago in
> terms of both the kernel and LLVM so it is possible that some bug got
> fixed along the way.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I ran a few builds with this patch applied and didn't spot any
instances of this warning. We can always bring it back if necessary.
Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 891866af0787..3900f5824721 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -777,7 +777,6 @@ KBUILD_CFLAGS += $(stackp-flags-y)
>
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CPPFLAGS += -Qunused-arguments
> -KBUILD_CFLAGS += -Wno-format-invalid-specifier
>  KBUILD_CFLAGS += -Wno-gnu
>  # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
>  # source of a reference will be _MergedGlobals and not on of the whitelisted names.
>
> base-commit: f12b034afeb3a977bbb1c6584dedc0f3dc666f14
> --
> 2.33.0.rc2
>


-- 
Thanks,
~Nick Desaulniers
