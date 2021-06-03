Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CFA39AEAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 01:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFCXaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 19:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 19:30:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B7DC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 16:28:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w15so9182201ljo.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yp2xRS7FBwt+MIq6S/QXxDvwXDIU2o3m3x2Gm2/0e9o=;
        b=MPHHM8hgXKQMT2F3JT70zdDS0t7cPi9LrYCnvh+CZ4kgONtffvYF4ixcKpCqqoO1Fs
         lJ2z7gOX0dMnOUZDsvDEoig7HUnPRq1rZ/Ye6SoLbryAHRbJhWlS4o9Bjo68dOwqmmec
         F1c6lUNcrK7UQ3b2+QDUfywN8IxfiMOKNfIpCZBVSE2I5EjCxtcpwNB3ySLJ7m+C/DcJ
         n2hjy3cxhoujdU5akqnPzk4ppjraB4hTA22266tJLfRLaNTqSaGHibK1uKWHHgbwS8ZO
         B4zbM+2OAZKY2NJaEpT3bmSNiZtXlnzqNNnDvxjzgqyJBaT1jzTOFQ3uGZn7oXSPjY9e
         9c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp2xRS7FBwt+MIq6S/QXxDvwXDIU2o3m3x2Gm2/0e9o=;
        b=brO/ezDTKlTIWQ+bkDE6JHpUaVkCs0hIfgWKDSw4kAScDFV6od8A8EDgA0FAd8oFDg
         ybql3JfoGpMZMHV4d+eWGDGAm4/nn7tN8UJKM0dmkrI0YrnDfPrXlr4MPsXUhIQ4yBxr
         0W8tPSjTQKe35rwbdJ1ktcvaJCGmWeWu17zlgIo/ra/EZTe5yxZbC8KXed87wtAixWSY
         SaxJrrNOLcyQL46Qb9hYiOv1s09/ZlC0ymMNdWmrb9D+Rv08/bq513wCgFuEe6Vcp5CE
         dbZZVKf3lyJhTbPMdPnSx+PbO8YQgQZJGUj/jYfwDvJo9nKO1M+OZLfmyxcwQ4hQ6rzP
         Cg3Q==
X-Gm-Message-State: AOAM530EMytZ5sGMw/btr/KZnkRAkz81PK2XFsfSXipcqQgNWpVz/69w
        ywOM04siAyE2JJn7W9lXT3x0P59+QCW8V6pIykXSxA==
X-Google-Smtp-Source: ABdhPJzXbiQOm/LTa/9I1aTG6l1jQZ5G6mYyNqgFW8DJe4zWHMlzneqPaWc1OYbyRPsdbcfjM4egzmVvxwPKp5INQg0=
X-Received: by 2002:a05:651c:b1f:: with SMTP id b31mr1302202ljr.0.1622762887714;
 Thu, 03 Jun 2021 16:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210226164345.3889993-1-arnd@kernel.org> <CAK8P3a2E0pv6PKzcCoRZH0G_gGrhWeiDwN7h090iQpd6c=XG1Q@mail.gmail.com>
In-Reply-To: <CAK8P3a2E0pv6PKzcCoRZH0G_gGrhWeiDwN7h090iQpd6c=XG1Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Jun 2021 16:27:56 -0700
Message-ID: <CAKwvOdna9KPAsN6+qTDkWMdXYDg5AGUnp=ek5McxtDXLSQdVWg@mail.gmail.com>
Subject: Re: [PATCH] ARM: ep93xx: don't use clang IAS for crunch
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:01 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Feb 26, 2021 at 5:44 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> >  obj-$(CONFIG_CRUNCH)           += crunch.o crunch-bits.o
> > -AFLAGS_crunch-bits.o           := -Wa,-mcpu=ep9312
> > +AFLAGS_crunch-bits.o           := -Wa,-mcpu=ep9312 $(cc-option, -fno-integrated-as)
>
> I reworked that patch just before sending it out, and ended up with two typos
> in there, it should be
>
> +AFLAGS_crunch-bits.o           := -Wa,-mcpu=ep9312 $(call cc-option,
> -no-integrated-as)
>
> I'll wait for others to comment before I send the fixed version.

Probably good for that v2?
-- 
Thanks,
~Nick Desaulniers
