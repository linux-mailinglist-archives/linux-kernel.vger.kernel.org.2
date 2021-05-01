Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9CF37093F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 00:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhEAWko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 18:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhEAWkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 18:40:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE19C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 15:39:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id n138so2559936lfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 15:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmEcPm7Asmrbgtr2u8nHPgQhaAjp5R45pnKPWNQs2ac=;
        b=FQNlxAac5CP4wbpA/QvohQyTlLFPfstTmWKFffPf+gSt/evK/52+Ni89OSPoXqhMEf
         UHA3S2Az+C8LVr/2LUqrBZjo8XOlncDExrlHaS+KdNIVjsziL2Pp/sMhrgMzFHeD4iYX
         OLUr51itW+1VXX0JFMMvn85ljLfhHMer5zE8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmEcPm7Asmrbgtr2u8nHPgQhaAjp5R45pnKPWNQs2ac=;
        b=CiWZan5At9y6W71G76sBQynUWdN8k7Bl7Q+cAXH7x4BKU2H/KTQ+vUUhcbmPNI3Ncj
         7omB1h4nuRSsYYN0ApYh4ZXF+IhwFqUnCn2RfI0qqqYI0T3MGq9AUlguZA67RNtu7vpY
         HWhDRcV5stFb2FQ/Dfo7sCWUQCus0OzM00Ak/gtgOY1zJYUIG3DVJlRh1VmwiBTcWXHM
         c31cnruugexK2B65/vUNjFHefXM3kvlnu5GjOSJ4tQTAra2NqF3o4g7ROE0BmjNEiAT8
         KSZfKghzOxMW8Q3xht6XtzAmSeLhxPAITLlA0skR2tzpXUnqmA00NtpncdxnZCo1fm4X
         XzkQ==
X-Gm-Message-State: AOAM533Oy7ZvZqM9I2n1LiPzmuGTra5fL2dq8nuHUYdlHKiyGD7Q0XII
        WgUICycb/dSR6saLGuL07cpO5weKQOGWwe2/
X-Google-Smtp-Source: ABdhPJzV4Yr34eHb5pF1/lxSaoor9WbuQYSXhgGNtI3IN9AIqi5Jg1V4LPir2xbP+o+aYKhCsgAXZQ==
X-Received: by 2002:a05:6512:2394:: with SMTP id c20mr7952321lfv.70.1619908789007;
        Sat, 01 May 2021 15:39:49 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t7sm203542lfe.170.2021.05.01.15.39.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 15:39:47 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id z23so2446521lji.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 15:39:47 -0700 (PDT)
X-Received: by 2002:a2e:954a:: with SMTP id t10mr8019788ljh.411.1619908787255;
 Sat, 01 May 2021 15:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210501195750.GA1480516@sguelton.remote.csb>
In-Reply-To: <20210501195750.GA1480516@sguelton.remote.csb>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 May 2021 15:39:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPoHOa6_gA3-pk=nOzpefZmsSK1an_iByEyhLe+3m-AA@mail.gmail.com>
Message-ID: <CAHk-=whPoHOa6_gA3-pk=nOzpefZmsSK1an_iByEyhLe+3m-AA@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Serge Guelton <sguelton@redhat.com>
Cc:     Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 1, 2021 at 12:58 PM Serge Guelton <sguelton@redhat.com> wrote:
>
> Different metrics lead to different choice, then comes the great pleasure of
> making compromises :-)

Even if that particular compromise might be the right one to do for
clang and llvm, the point is that the Fedora rule is garbage, and it
doesn't _allow_ for making any compromises at all.

The Fedora policy is basically "you have to use shared libraries
whether that makes any sense or not".

As mentioned, I've seen a project bitten by that insane policy.  It's bogus.

            Linus
