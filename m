Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F3C40ED78
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhIPWmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbhIPWmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:42:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F32EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:40:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i4so24609144lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3YLfr1u9APyPAn/xTQmLc+SC/g630ZJTt80Yi4gRR0=;
        b=KexSko9o03e221TiMOQcTGIr9nxX31lcgWZUT24uOnOkzlEIhpxo0+4tUxCTb2Ra/Q
         GsFPvcg0/vafhLPRYj90x5CgbUW+XaYgtuop2sFuXbDy2Mg5M88m2NUwydBOu2w0Ed1X
         ezmTcMaksDzPxUfp3T+vTrHpF2N1PBXlyzx43Lh3UpWmhKiz5He6roLpcQOlvLNKOisg
         mrShZLY0/+FLp66Y5jdw1ddAglorYfMwyZxmeZJXsxRROBYX3MR8pqe3lsx6qCUxYFKV
         gYUNUCLzpcS75fnYiZsPBOBRhCnzXSGI1xhGZNo6PUr2qxVWfYuiNib+raeA5hCEelG9
         fv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3YLfr1u9APyPAn/xTQmLc+SC/g630ZJTt80Yi4gRR0=;
        b=ioG94FOZgx9KSQXmkWqM3q+3YYZ89NStumD4dRxX+WRMvmgJDG5DL5/hJormjC5NuH
         mc5YPEfvcwueFiowuvEKAsXWsHuZfzmJbMucXXCsrMzPihpfqMAxQRXTby03W8nXqSjh
         FIr8bnHtgsyDU3penFZLtqZcaM0BdNzq4cx2K3k/Y9jmYvfN9zuO0q/IU0z9PhKYTDi/
         +Nv0HN+CxG6qg7O2UOkifhYMoVhw9WzSErp/M5leP2bXE6jALC07gHsT+7wSOU37OJ99
         W0yoALm0aCY3VoVojqVKyiufQRT/f9rrTpRi8VA8DG8p/cxD7vEJWW/bFTAXYjLKQO6s
         VXoA==
X-Gm-Message-State: AOAM530nANFFwHrpsI80rUKKGQZKmdzK2rUJrMKd3rHo4/FOhqewONeH
        yUKF7HvoaIlxKXVctLNFWGXU+sHX/IykqJscmxvq+g==
X-Google-Smtp-Source: ABdhPJyXkDeVnrvOs5LxGzFpx28xI/fxsrzke22YPtz1FA5rrloxgUZ0IpMgelFS1ql+FkIwlgn7h9HODNy4TSmiYuQ=
X-Received: by 2002:a05:6512:e89:: with SMTP id bi9mr5610868lfb.95.1631832055603;
 Thu, 16 Sep 2021 15:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210830213846.2609349-1-ndesaulniers@google.com>
In-Reply-To: <20210830213846.2609349-1-ndesaulniers@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 00:40:44 +0200
Message-ID: <CACRpkdap==EPZpAggMmd0XN1J-DwK=OQu3oGn-V=zPOaq5XnHw@mail.gmail.com>
Subject: Re: [PATCH] ARM: select HAVE_FUTEX_CMPXCHG
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 11:38 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:

> tglx notes:
>   This function [futex_detect_cmpxchg] is only needed when an
>   architecture has to runtime discover whether the CPU supports it or
>   not.  ARM has unconditional support for this, so the obvious thing to
>   do is the below.
>
> Fixes linkage failure from Clang randconfigs:
> kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> and boot failures for CONFIG_THUMB2_KERNEL.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/325
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

LGTM
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker!

Yours,
Linus Walleij
