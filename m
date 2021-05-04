Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6083C37322E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhEDWDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhEDWDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:03:41 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02858C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:02:45 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e190so28755ybb.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rvtc4dyMiADMF+m7+qY/GWjUxbRAuv1Uh1ldPKNJtaY=;
        b=J9eoEftlm7XfM8y31wTf2+SAv+LT4MdLHh/W83JFpd8qSdJCNgtX9kDOM6bL1kH3wJ
         VR7qAwn3C3DWd5BgpG0ahw2h6eC6PtqyqUbgLg5UpBfSkJTdeLMyfSNYOwT6Vux2RC3S
         cwHNtg6JYySVdmii1H5AVhhYTHhXknxJekLNkkJwupONYk1pEGa+CXURhcDpbsud/6bk
         BkDfedTCh8ykcl+haBo7NsuAnH920j5LR4oha7E5Co9sP3rTsW20+KzQNkoeActOEeJw
         1TsAZU7Hu0ZQtwST4nhfgT/092W1rLNssGLhQMOR0T0DrYrVS/BQTI4qNxlkI7dmnXuc
         G/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rvtc4dyMiADMF+m7+qY/GWjUxbRAuv1Uh1ldPKNJtaY=;
        b=f7cdEFGec4DN0UeMzr3xaPvmKPflzn1wkK6I3eL6n0G8z60D/wOH/39qJGQQlHFwdF
         v+KsSswPVKyK4Wx/Qqsy+rVRcMAx1YwVn74jq5rl/ZMKlZfcrzpdAN0zk7X652lT2HFk
         kp6Da67r45STXGxtNSPfNGDcvi/g2L+E8XEVWyyH/CWbf9HX/gHLJOomxBkeQaWOgD5U
         Dgfu572HMA6b9VjPw3+pL1LEqMQd9E7OfDhQKkbXH6WO+ZqP/DNWb9/T7b84Knht9ek9
         vsA+ZRJzgi1ENHzKMsmwNoC6yn3OsQDwBqQAx9qq1BjxXXU+1a0zeXGTw+5ILuD+mAWl
         5KLQ==
X-Gm-Message-State: AOAM530R5JaFynLgODqoJ5Iz7MTYEThF9+wVbE+1m4irQPQ1x/VjhRHJ
        lVFUo6lGD8W/jEbLvsBRTZNVFnW3nLggeibQvmU=
X-Google-Smtp-Source: ABdhPJyPjWciesnXXs/sOXCwWPwmUgaNIIGYUtNGDS+8h7vx9I/99oBDgr0J18gXD7ov5qKjJH/sQFuZiwYmtCCurv0=
X-Received: by 2002:a25:d45:: with SMTP id 66mr14776555ybn.93.1620165764361;
 Tue, 04 May 2021 15:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost> <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
 <20210502164542.GA4522@localhost> <CAHk-=winSraiwc4gC5WFWSehFq+s7AqCJZoMqUuHLX0nYVG0nQ@mail.gmail.com>
 <20210502175510.GB4522@localhost> <CAHk-=whTjJwCt2E0_JM2dDq=+UybvJN7QK+6K6e80A9Zd8duYg@mail.gmail.com>
 <20210502214803.GA7951@localhost>
In-Reply-To: <20210502214803.GA7951@localhost>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 May 2021 00:02:33 +0200
Message-ID: <CANiq72=5766fGQjNoMoOxrywoJHQ+-i4U+Nb62MeEaRok4LCFg@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Adrian Bunk <bunk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 2, 2021 at 11:48 PM Adrian Bunk <bunk@kernel.org> wrote:
>
> Library packages in ecosystems like Go or Rust are copies of the source
> code, and when an application package is built with these "libraries"
> (might even be using LTO) this is expected to be faster than using
> shared libraries.

Rust libraries only need to include "copies" for generics; and only
enough information to use them. Keeping the raw source code would be
one way of doing that (like C++ header-only libraries), but it is not
required.

However, it is true that Rust does not have a stable ABI, that the
vast majority of Rust open source applications get built from source
via Cargo and that Cargo does not share artifacts in its cache.

Cheers,
Miguel
