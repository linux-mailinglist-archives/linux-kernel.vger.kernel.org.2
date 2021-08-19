Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D983F13C5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhHSGsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhHSGsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:48:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4097FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:48:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso10658855pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LZbrqbnGVF4s6R8ZE29TSFBtRgWG1aFf5wVvmTN0Kls=;
        b=LzpwSI+PQ849sv+/d2wxrfSs4Stz85cvghRvs9r62qeewVfZppUpmwfon/gbQBU0LX
         cCuBbMRsYTuBSGa8L2dOIOhwrfCAdgb7dKrQJu9iJ5l86UXsTJCt0bwwYwUPUmRZqLuo
         /lpq+/Nz+2q92pnRVoUf2ddPftWpPY5/mlDMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZbrqbnGVF4s6R8ZE29TSFBtRgWG1aFf5wVvmTN0Kls=;
        b=meuE5JPJYyPsXA7/Y5RLgXOMYSzaWVMkwAqWRT2dP5CuGq2Uksm1pW37mrAQhRC3sb
         KF7ysqjmOorgcq/39DSFeAhruq03tcZcEQJ16yf4g3mHHwITfKuPyj+HLddQ0OjaVLLm
         iPugg/LZ7UN0q36XH5+DMGTU2cV4AQxmFBXQE5a8hkXjbR0B/S/vZJz+xnnInSw3OV7W
         5PYbXvHGiZos2wwvQ7zd2N+xv3HY0Xr9U/U8c2gNjgMSdFzDle2LGgh3Kq1OuinUsl4k
         i+Sap8PCjF34lCTusPi1XgFMlJ6mxtvYBF4WOU8Ku/HhH8xUlp+GwQ5py5fTv+BWTgQ7
         DTNQ==
X-Gm-Message-State: AOAM533kWFgnNx5He7f2guHsZQ05yznatywdKAJ6kpoxJfPS0mwlHGiZ
        NXFnBZlSlKxNsE9mucStbRBIog==
X-Google-Smtp-Source: ABdhPJw8G2jVp3T8UDYSrVTUZDASHoPOochThbPOlZLvNxJjGz+1teyquH91ZQLct5RsTmLvrQxSfw==
X-Received: by 2002:a17:902:6b03:b0:12d:8f77:83d1 with SMTP id o3-20020a1709026b0300b0012d8f7783d1mr10332933plk.11.1629355682754;
        Wed, 18 Aug 2021 23:48:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c26sm2442811pgl.10.2021.08.18.23.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 23:48:02 -0700 (PDT)
Date:   Wed, 18 Aug 2021 23:48:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 02/13] gen_compile_commands: extract compiler command
 from a series of commands
Message-ID: <202108182347.0CDD87706@keescook>
References: <20210819005744.644908-1-masahiroy@kernel.org>
 <20210819005744.644908-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819005744.644908-3-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 09:57:33AM +0900, Masahiro Yamada wrote:
> The current gen_compile_commands.py assumes that objects are always
> built by a single command.
> 
> It makes sense to support cases where objects are built by a series of
> commands:
> 
>   cmd_<object> := <command1> ; <command2>
> 
> One use-case is <command1> is a compiler command, and <command2> is
> an objtool command.
> 
> It allows *.cmd files to contain an objtool command so that any change
> in it triggers object rebuilds.
> 
> If ; appears after the C source file, take the first command.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Seems reasonable, given patch 3.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> 
>  scripts/clang-tools/gen_compile_commands.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index b7e9ecf16e56..0033eedce003 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -18,7 +18,7 @@ _DEFAULT_OUTPUT = 'compile_commands.json'
>  _DEFAULT_LOG_LEVEL = 'WARNING'
>  
>  _FILENAME_PATTERN = r'^\..*\.cmd$'
> -_LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c)$'
> +_LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
>  _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
>  # The tools/ directory adopts a different build system, and produces .cmd
>  # files in a different format. Do not support it.
> -- 
> 2.30.2
> 

-- 
Kees Cook
