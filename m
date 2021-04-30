Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027F236F405
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 04:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhD3CX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 22:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3CX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 22:23:26 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B1C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 19:22:39 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso8211254otn.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 19:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1n4DqmQlREsyApKfLukQaSZjYP8wuyF8Nb/20OdqmY=;
        b=e4KXnDTnpJTwipuBHLtQlvQNVgnd5Ewz6oLdgY/R/3zTKMBVG3bVe8w4orndX2D55Y
         mKIKRtp2ra3AUm6d6M7ZtMJDEwCY8a6YG3zNWFLjxg9dVNrnFf1B19mDYRlJpCh5qi5e
         6+15lJWvBmMcajQ+ttAxk7yejqkgEPamXYfG9lwyxS4c4GoIvEO2sjN08lm3S9+SnhtA
         4+OmDEXGM1CVyRBIsuJRn3FvxUDwm6J+kZfjcD1H5HZzi5B0Fsj6nUHOkC7eTxv1j349
         E3Eo2bNizLv7fvJdVqUg1vUKT0wkacZvWwpQDiUer+RWHQUfd+nKrDn7bww0YVsFwSOR
         vy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1n4DqmQlREsyApKfLukQaSZjYP8wuyF8Nb/20OdqmY=;
        b=JGHqAflRfhJqnBdKk9deTpuMjbHvPboOEi9qgjBPDoh+4fw1zixdpmJTUEfH/daq7m
         exBAs9rYjG/3zUnDUL8DrLy7/UnHCMrJJrZ17jB2khHV+45iyh9AnZcCHHT/+HQyTonc
         Wd4ZfiPrPbYqKZi2U7MCcH+msOTyaZhq/kq6Zx6XCMPJDI9NzjaWGqy7mmbHKTGmxwVW
         XgfZ5WJXyHtcGiC2xRy7tIEfvwWwEw60A+jjurPCAQv784/QFUmesuNs5ffVBywJ1UrA
         YHyOAHeteHXJmfY8Z21vtSaX9nOCUNc2vd7yy4LYd56DqCRonkdPQb2oDHttaO3FlWMH
         kySA==
X-Gm-Message-State: AOAM532hijgXr3p83n2GbtjQhjrlVC0OZ81D+HqJiBafiFprf3CLk5Ve
        KbARZCUDcTPjjhOAr7AN8w9Qf7G0ciuJGag/d4uKKQ==
X-Google-Smtp-Source: ABdhPJwHRunh6SzaJrnN2G80tKQrp7L5jqTEAu/UcVZTNi874MCaHNIM7myYhealTvA3NcvA8NziYwHtuo+MgztDlhw=
X-Received: by 2002:a9d:449:: with SMTP id 67mr1613259otc.333.1619749358628;
 Thu, 29 Apr 2021 19:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Apr 2021 19:22:27 -0700
Message-ID: <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 5:19 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Apr 29, 2021 at 2:53 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I haven't looked into why this is so slow with clang, but it really is
> > painfully slow:
> >
> >    time make CC=clang allmodconfig
> >    real 0m2.667s
> >
> > vs the gcc case:
> >
> >     time make CC=gcc allmodconfig
> >     real 0m0.903s
>
> Can
> you provide info about your clang build such as the version string,
> and whether this was built locally perhaps?

d'oh it was below.

> > This is on my F34 machine:
> >
> >      clang version 12.0.0 (Fedora 12.0.0-0.3.rc1.fc34)

-- 
Thanks,
~Nick Desaulniers
