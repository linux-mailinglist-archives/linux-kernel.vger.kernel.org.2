Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA83397AA2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhFATWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhFATWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:22:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7D9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:20:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e11so20723197ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l0Qbrea+PxVgdT68iuGwF0mAxIyy2sZ0fOtF/mCAdE=;
        b=NxqHANsd9noU1dytE+vzA0ZU0iV7rpsgI3kFKMXoCmoKp83F1a8PSCZsNNLDEcDqG4
         PyNUoeLYmBc5P+tSCSu2G++2hjnudsCV9oCrwfVLfjHHQ+VAjrGWkCwMx+TliUIckf67
         cWggurPyXcZVZ8BQyoXEr4W9ZI9qVgpWrUWffTQriUsL+nczRV65DjrRRJoutcXEUtyK
         LnDnb8+G3TmmiStxQl5M0HuL7ApFRFu9W0/LEZNpgh+UkchIdZalfGnkL/hzzsM3K8Ux
         hicUScIEpTQ2rb33iDerOraMbzDqakKQpBpFtiuVnPfzLABLnTiY3BsIv15R26Ybk8Tx
         8GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l0Qbrea+PxVgdT68iuGwF0mAxIyy2sZ0fOtF/mCAdE=;
        b=TWAL+RVQY20sm4pTrrf6XJiQKnPWlChoQrv6uDoeR+yP15wXlIlQzAEnFtqIVmnHYI
         4raatNMiql2X0bCCYkHEXjo/55qB2OCqgiWS9KjfF66DBEA6WjNhFFP0WO88Oc6F+UFI
         k0+c1hbW5Ilr670kBAn+W34jO5nl6B07fkTXPG8ZAn0MAG3mK3/hCCIBlO4MfpKRjhSR
         +9JCWO6/V09xEAgYJk7WMjbsCR9ya7ecwRlCTF0tYyBb9UxyJ3qSkd637OSecDHC4UnB
         rN6I9IYejzPT+Zt15jt++tK7e2YRQkb+8m9L9EiPe1vMeksYTEyKWJQJKrNEpR+GKV1z
         2Y1Q==
X-Gm-Message-State: AOAM530jLPY5u1OEiyhsA+vmg399UfPoZErb7hHfIiZMmwUvhQbb2Enb
        Dw8OnTdghHNfDWM+WdOnmqYqzFqmHj3R0+AJb6TWuQ==
X-Google-Smtp-Source: ABdhPJx43g/X4e8v9nDAfLRkirfdqZRzLYD9L19ygH8q8d3688C274KOySycHdChSG1cz2OnjgOH0cvNTVjAIbuYbwo=
X-Received: by 2002:a2e:b710:: with SMTP id j16mr22510652ljo.479.1622575255259;
 Tue, 01 Jun 2021 12:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-4-nathan@kernel.org>
In-Reply-To: <20210521011239.1332345-4-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Jun 2021 12:20:43 -0700
Message-ID: <CAKwvOdn49Nm27rCyyTeGvz4qtL0uNp7ZW_AB_Asc1PdGW=xW7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] hexagon: Select ARCH_WANT_LD_ORPHAN_WARN
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Brian Cain <bcain@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 6:13 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Now that we handle all of the sections in a Hexagon defconfig, select
> ARCH_WANT_LD_ORPHAN_WARN so that unhandled sections are warned about by
> default.

Great to see another arch using this build-safety feature!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/hexagon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index 44a409967af1..e5a852080730 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -30,6 +30,7 @@ config HEXAGON
>         select MODULES_USE_ELF_RELA
>         select GENERIC_CPU_DEVICES
>         select SET_FS
> +       select ARCH_WANT_LD_ORPHAN_WARN
>         help
>           Qualcomm Hexagon is a processor architecture designed for high
>           performance and low power across a wide variety of applications.
> --
> 2.32.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
