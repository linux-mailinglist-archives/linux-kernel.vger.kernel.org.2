Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576CF304FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhA0De2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbhAZVau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:30:50 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:30:10 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c132so96757pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPhH8nCzVbNzJsc/BNpQKLyOyxnyLT0e84sZo+cfEdA=;
        b=vs3D6j9FHmp2A6bOjYkNNmD8TQmRZTcHizmecEAvaiowLkpyn3blT8KZEKwcxwjcXg
         /E4FSGaLwJP+twT5qqMwLIwKV9XmTvhjU2Kgng1bA8auhik6DWoUa+Xy+50HzbfGbpVt
         UoFlkfI+Zj7hMDEXIBXjqpcMMf+GUwartmMUv7zOxkpnOOUlCaAnsOxHD94zFJ98BAHS
         ChqIRiszntt1Unb0La398eQ5sqC90Jy/noqhlseDkcWKGDj4k41jABgcH6f9zc3TQ4Cu
         GpRNl9X0r1wq5cCaS6TfOX1+FM2a1XbS5oCU1nwgUAV97sofWevlSvyhbyttuS59Utjn
         ufjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPhH8nCzVbNzJsc/BNpQKLyOyxnyLT0e84sZo+cfEdA=;
        b=shq2JBDujOqMSuMElqBFVtBXwo6OqtPfI/9nKe0hNa04HeLe9nIwHcUc3Jk6Rw8ZOV
         aIIfClQfHzpu7lNs8oqSDQRh1GK+f642yUPwGIzpoq5hfaz4bx7kahciz09Vdz+gJPGT
         YBbwr0/vX1cVNiUDM5tgMdIADs1o4KX5OwOauMAJ+7ReRte2OxfMhqObAfFJZC1Bws53
         6Je1qmg8tUkPYFGFgcmhO0C21KLwv0BEQ3L+4jPxb8nu+Q/7EH3MADCNl/1C+sE7pccX
         TF02caFxXq/bd0Uqf/u6RUOeGDw7E4g2MzGt5MjQ1VH92sWq5Rs15jWusxXkmmBxt5Fu
         9yNg==
X-Gm-Message-State: AOAM531pioJpVtAunuG94G5J7Y5Hz0NbgdoD2f+i7You64LnIwXW2kz9
        QBsZYzA0hF7u0GFctSunBVG/gtam1o+OyeUCamRlIw==
X-Google-Smtp-Source: ABdhPJz1UX9zaU1d48OdAOLml1pI4WxoG+DXXqlFfWKRvwxiP0IMPmNknqQByiR4TNAq3KvuXhYbSM5aJCr7lkvqFXA=
X-Received: by 2002:a62:7896:0:b029:1b6:7319:52a7 with SMTP id
 t144-20020a6278960000b02901b6731952a7mr7456699pfc.30.1611696609419; Tue, 26
 Jan 2021 13:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20210126212730.2097108-1-nathan@kernel.org>
In-Reply-To: <20210126212730.2097108-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Jan 2021 13:29:58 -0800
Message-ID: <CAKwvOdkpJn=e+4cuX7-F3AUPhSGKGqG1SuNtZTo1FKCLFjHSGQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS/.mailmap: Use my @kernel.org address
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 1:27 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Use my @kernel.org for all points of contact so that I am always
> accessible.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index b1ab0129c7d6..b25a44ab5ba6 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -247,6 +247,7 @@ Morten Welinder <welinder@anemone.rentec.com>
>  Morten Welinder <welinder@darter.rentec.com>
>  Morten Welinder <welinder@troll.com>
>  Mythri P K <mythripk@ti.com>
> +Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
>  Nguyen Anh Quynh <aquynh@gmail.com>
>  Nicolas Ferre <nicolas.ferre@microchip.com> <nicolas.ferre@atmel.com>
>  Nicolas Pitre <nico@fluxnic.net> <nicolas.pitre@linaro.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 992fe3b0900a..f9a360103daa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4303,7 +4303,7 @@ S:        Maintained
>  F:     .clang-format
>
>  CLANG/LLVM BUILD SUPPORT
> -M:     Nathan Chancellor <natechancellor@gmail.com>
> +M:     Nathan Chancellor <nathan@kernel.org>
>  M:     Nick Desaulniers <ndesaulniers@google.com>
>  L:     clang-built-linux@googlegroups.com
>  S:     Supported
>
> base-commit: f8ad8187c3b536ee2b10502a8340c014204a1af0
> --
> 2.30.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210126212730.2097108-1-nathan%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
