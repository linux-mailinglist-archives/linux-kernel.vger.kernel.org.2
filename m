Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF31537AE62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhEKSYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKSYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:24:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B43C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:23:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h4so30072523lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRP2V1owQtURI7uacfJAlhnG1X+WN+T4pPIUW785E68=;
        b=PwDCzHqvhpsGIY6ZKdMW7kNMfcas8us/yvacKvftleIg6L/4CL6sRhErvfpVMFwtS6
         Tt3DepBYVPE7yWyt6kSumiYOzI6psP5DiRxw1+v1eH7KCLDcVVuWYe+WCjmzQDUsDfIO
         S1CtBgYonS3r3gbSHa1nas5JfGL+PVsc3KKDnjEPB5bQmf7aKfJETFrbBIPwECqt9dpk
         8+npwsdRppv2Z+/VKhzRmbi0MO/rYtfXiWYruWdTLuxXs90An5Hce7jtwziZQHIC7bDz
         C0j77R3WQH2iB6RdRIX+fv28eBrXBWtxbH9njgLl+Bmkr9pB21TN+u28RVWouDBahdAq
         EuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRP2V1owQtURI7uacfJAlhnG1X+WN+T4pPIUW785E68=;
        b=NobQzuGeQccHljL3fdXQm48b+Nhk52g8x9SnspVp4QQuIw3YriZ1Phkj6S7cGFmFbr
         S8/L9CsZs4oN5KJTRSxR7rxKivpKRVRXezFJJH6rCgfTfvXZvvGU+825gT0M/fDpLUBs
         nV4dJFMsrTadYRKXTcHP7Ep6o69q+ttlxyIDQkj4106psO33PT1Hbyxq98qwyxAt9+cR
         IVD5gfyr3lk6U3ORmyotuTrnvkh/7grJ1QVJSh8few8/6spGL6ElXBJZ/l7qWHW+HSyo
         0apgGSo3HH3JQ1yW2sSYvjo95F8l75GUNaf9sU+FC2XHQmLYsDuq/HLE1vVvSlFpLvE1
         JAbg==
X-Gm-Message-State: AOAM532XerlMNnoAt0MsX9sSrbcfdEhy0g3wQCO4COmkf1E6UFybZJZ6
        Ya8CYh70JkwYpcFbnc2U0TqEuUaUQJ9MLEXPDchgYLAelNg=
X-Google-Smtp-Source: ABdhPJwMH7H0oisPlzng7AD8k94POgJBsFNjAPlQ/TtfiNQz2y8UpjVarfuboxmOJCJBPzPKV4Zb5IfRU35reZKQwyE=
X-Received: by 2002:a19:ac09:: with SMTP id g9mr22055658lfc.547.1620757402020;
 Tue, 11 May 2021 11:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <162074534493.289757.1243545574686276554.stgit@devnote2> <162074536334.289757.5292387320537578325.stgit@devnote2>
In-Reply-To: <162074536334.289757.5292387320537578325.stgit@devnote2>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 May 2021 11:23:10 -0700
Message-ID: <CAKwvOdkWxb+yJisafjFzy1FxbRZjdxhLqfwG=ryAQ10-j5ZhcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: Add -Wno-missing-field-initializers to for clang
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 8:02 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Since clang's -Wmissing-field-initializers warns valid syntax of
> initializing data structure (e.g. initializing static data
> structure with single NULL, the rest of fields are initialized
> with zero), it is better to disable this warning option
> for clang for now.
> This can stop building perf because -Werror is also specified.
>
> Note that same issue on gcc has been fixed in 4.7.0, so we don't need
> this for gcc.
>
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36750
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Seems fine, it's only enabled for the kernel at W=2 anyways.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/scripts/Makefile.include |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
> index f9271f3ea912..4fd5d33ded03 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -89,6 +89,10 @@ ifeq ($(CC_NO_CLANG), 1)
>  EXTRA_WARNINGS += -Wstrict-aliasing=3
>  endif
>
> +ifneq ($(CC_NO_CLANG), 1)
> +EXTRA_WARNINGS += -Wno-missing-field-initializers
> +endif
> +
>  # Hack to avoid type-punned warnings on old systems such as RHEL5:
>  # We should be changing CFLAGS and checking gcc version, but this
>  # will do for now and keep the above -Wstrict-aliasing=3 in place
>


-- 
Thanks,
~Nick Desaulniers
