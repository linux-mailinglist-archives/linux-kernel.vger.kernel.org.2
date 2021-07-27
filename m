Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13AE3D7021
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhG0HP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhG0HPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:15:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1ADC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:15:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hb6so20479405ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywU7xJjCDbVGINDQQEbkRxSRar0OtZ578Jl7x/Efm9s=;
        b=LQLfG0PMbhHdLJRP2W8khiLozHeBUffbso/aQJxtbUneE4yRN4+gaXQYkspP6dUXsc
         9No8YlS4Z8U/aEQzAOs5SifpJkimO74XHeScX+7EmnKhUEkx5KEqKvUqWa0wh1+G87Zn
         dH+kDCV/vKn1cOnKMchGRk2OPMDdDRDwa+d/MF2S5f4bHshcDKk4I8YwXzTNRTBQjRZp
         7q2uPTg1LzmzvKIJz2/mFfGWI+0BKcEDwlvBUGuauzHFL4IyaET+TXmM3D5DyYtvKXRI
         LFpMzIl/bVMLHpVeGdItgvyUrN7m+YHSvcQfxSkY7VE7eK3yFMVzG/x0ckjf6EEk/oTI
         6vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywU7xJjCDbVGINDQQEbkRxSRar0OtZ578Jl7x/Efm9s=;
        b=dYQ7+k5025++aMiQdHFGdafY9iZ68GUFygFQr3NwhhXw+HpO+aPQc5J2lBK1gjQ8Pf
         ViamcxqsgAiR8IC/s7mE5GoasohAFawofx/htBSjTkkuQRyEduRsplaFDey0smR2eeW9
         4ASY/hD/3puv/dYmDrfGm7jlt7sWD3SSWDU/0mVgCT59Iux5g6b/v4+Jqxbyb+HC4Ud6
         VDN3sVpdd4FYcUJalnhRoFtknxoSwlFOrBWMFohB59pSvoPEeG+EFK1fNSh2Qgz2DvXB
         JKyvJIwIyKCNUsD3Oi+ux+u979/k623+xRVzKFgNzlNUZbO93y+Gr2lMCHjVWqUTr5TS
         g4Sg==
X-Gm-Message-State: AOAM530z1VEWBGvk10Qvx/Ph96Noip73j+jbVp9bIphoATeYgJI5ZRsZ
        Txy7b0AUvEdBMiVUfVGaC7Oi/VZDTG4ghsEw66/X
X-Google-Smtp-Source: ABdhPJwtpZlGoT0XHY9usC9DFARqvNLc4fb5IE8gUTiBvidrKs8glIL5XfhXs1NBjoGGusGFMupRGMJb3V/sQaYr4Ns=
X-Received: by 2002:a17:906:56ca:: with SMTP id an10mr15800499ejc.90.1627370153372;
 Tue, 27 Jul 2021 00:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com> <CAGG=3QVc_OZoKi2J8tqRoBKcPekgAMMi=6Uphg1hNGNDK1qJUA@mail.gmail.com>
 <YP+x8y6MoPNHh58q@kroah.com>
In-Reply-To: <YP+x8y6MoPNHh58q@kroah.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 27 Jul 2021 00:15:42 -0700
Message-ID: <CAGG=3QW0=gec-s=HvWfAk68943HpzoXd4yc2jDAH5Hrudziefw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:12 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 27, 2021 at 12:08:37AM -0700, Bill Wendling wrote:
> > On Mon, Jul 26, 2021 at 11:41 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Jul 26, 2021 at 11:15:52PM -0700, Bill Wendling wrote:
> > > > On Mon, Jul 26, 2021 at 10:27 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Mon, Jul 26, 2021 at 01:47:33PM -0700, Nathan Chancellor wrote:
> > > > > > + Greg and Rafael as the maintainer and reviewer of drivers/base/module.c
> > > > > > respectively, drop everyone else.
> > > > >
> > > > > Odd no one cc:ed us originally, I guess they didn't want the patch ever
> > > > > merged?  :(
> > > > >
> > I don't believe I saw you or Rafael listed in the
> > "script/get_maintainers" output. I tried to copy everyone who showed
> > up.
>
> $ ./scripts/get_maintainer.pl --file drivers/base/module.c
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS)
> "Rafael J. Wysocki" <rafael@kernel.org> (reviewer:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS)
> linux-kernel@vger.kernel.org (open list)
>
I did it on the patches themselves, not the individual files. I
thought I got everyone, but apparently didn't. :-(

-bw
