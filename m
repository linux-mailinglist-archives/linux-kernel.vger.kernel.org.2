Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEAF389A10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhESXsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhESXsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:48:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F294C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:47:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m11so21678604lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9oTbZIyiIaHi1iCf8hX5UcohP9vOgIE4i4KX0bQx08=;
        b=UjGprNw4xulFbgsqqQIybEukYiuM1x0V4rdOLWAKR2E5uwxhlN0O1EYttfhMy5nfrl
         Fu7B+hAGiwlvHr8ch8K1TODwS5itX+ZMCfo7S58BL4rducRCh+kZOXUEUoBOfNGnroy+
         wFmmT5LtsyRPw3E8zp0p2Qv/h2MJuOFGZl7aLPYGTNbRhSByp6l3owzbhjDaQYvMnj7G
         GFl/OQIQQWjBT9JnfhKXOb2iWFqdFGSgIqols/8CmAMS/L5Fn1dpSqKTozv1VFXIAG8C
         nNb+GplESaBmnuiGgWuR+u3efQlvFjQr4mbQDwuUyKnHgT05gTYB1y7mJ44foAwgqeo1
         NOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9oTbZIyiIaHi1iCf8hX5UcohP9vOgIE4i4KX0bQx08=;
        b=kMHBDAp5Fd1fTWye/CEcOs8FVZ0e99nnEJDCr+LAmxStWl6f6lhFr0nkwLzEfm9wfM
         87nuAU12gx3huN5XAbc0uacmTbJn9pExX0mRfqY4uJDcWQ325WyaEL6AQYDbSUNBi6So
         2uLFr8gxeYEQYPhQCJNTfytZIqWM4vNFxrLze4Jm5wE5GhdN9bO9s1raKsMn9pXq9guU
         vkOFaRrw3Fpyo23oq6scXHpa82ADEGQMd1vIvay7GgcCP1BZRtdl6gifKQwIy8W5rkuB
         SIfLarIst3p5icCnI98vzBkLprJeWipaO2Ufo5JMTsn90G4tO6kRpQxLBw9T+DHC0Yvg
         iM5Q==
X-Gm-Message-State: AOAM530T+SaIQ+vsLr9uqQgvxu99iqFWsIgnP7Ud2UJUykrwDxCmsDo/
        cPy1Z1+1miWhBURrhimPnvlwscw7ev+nQTUrmo51Dc9LLEE=
X-Google-Smtp-Source: ABdhPJyPyRZDgO6BHZT0q0XtE/fVWlYYAV6VdBFeiameE/ZjhNvAO2yWpWKTWGR2FitB3Ge5B6uXGt0C/cnIRrC8meU=
X-Received: by 2002:a19:ef10:: with SMTP id n16mr1070975lfh.649.1621468033943;
 Wed, 19 May 2021 16:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210512090047.2069033-1-arnd@kernel.org>
In-Reply-To: <20210512090047.2069033-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:47:03 +0200
Message-ID: <CACRpkdZXd1Bcf2or=6RsP9GqR-LepXxjQHTP_r8b6idonEnFng@mail.gmail.com>
Subject: Re: [PATCH] [v2] ARM: mark prepare_page_table as __init
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:01 AM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> In some configurations when building with gcc-11, prepare_page_table
> does not get inline, which causes a build time warning for a section
> mismatch:
>
> WARNING: modpost: vmlinux.o(.text.unlikely+0xce8): Section mismatch in reference from the function prepare_page_table() to the (unknown reference) .init.data:(unknown)
> The function prepare_page_table() references
> the (unknown reference) __initdata (unknown).
> This is often because prepare_page_table lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
>
> Mark the function as __init to avoid the warning regardless of the
> inlining, and remove the 'inline' keyword. The compiler is
> free to ignore the 'inline' here and it doesn't result in better
> object code or more readable source.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: remove 'inline', as suggested by Russell and Ard

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
