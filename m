Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F73370E13
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 18:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhEBQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhEBQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 12:50:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDDCC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 09:50:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j4so4656055lfp.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrBBUUki0q/lD+33Iml9xa0KjdifXO2SpGhQjWkCsUo=;
        b=GQ6bAO/iUjOWkhj/CDLBoW//nsQ2hMNU+ryalBV1hNVTYhcVR1Mncyw2TcTLyFg5qn
         ppV57IK9F0MG2fcJxyuS5BZr0j3TGoY9c/474e0t5nXDmO78iwWZA9oTX4QuJQ6p2Dxo
         q7cJhsJBUqNjZSY38KQFdjSqOVokbqr7LBGK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrBBUUki0q/lD+33Iml9xa0KjdifXO2SpGhQjWkCsUo=;
        b=GKw83lz6vweelfeXxcj8yME2D0cMwFE6aKGdP+Hyn2BQZUl9S9QL6d8fDR185tr2Tk
         vWjNbz/xlg+7leMFVCbFG/q2EgeAIWdQQXWgmT9+mJmJZ8PQvO68bHZWL+7wVZddI0SW
         tFyA7c3hfTQr05t/jYG6hz/ZZ99GVSPBqdfoswArgVf3COSR5VdV0Lw7JpAC2s7FGwG9
         6PT1Cq+D5OYwa7hBoCbqpt/s4IMnB6fbyxY+zamoU+zWjDDMwRUb/3F6ikr2JoqbMqhI
         7onmYROzeiLnqUdyKbOp2K1qNPi5HuvYHljXxaDe25j8iiXwCX9TldFbis8kZnV+jbXJ
         PNlQ==
X-Gm-Message-State: AOAM532UnD1kI6WsIT74f/cG/UkluMxx6EYci2UxORzwfWlZy8al+DnU
        MfkM+Fx6VjOkoEe3LdaVj+tEIx0em85llYme
X-Google-Smtp-Source: ABdhPJyMgld49oZL3KVJro7cP3I7cho86UEtRehR+lvxrvHYwlHaNjgcE36NIzqsdisoyOkdMgRmvw==
X-Received: by 2002:a05:6512:b26:: with SMTP id w38mr10481627lfu.152.1619974201585;
        Sun, 02 May 2021 09:50:01 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id c17sm886869lfs.75.2021.05.02.09.50.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 09:50:00 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b7so272588ljr.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 09:50:00 -0700 (PDT)
X-Received: by 2002:a2e:330f:: with SMTP id d15mr10619472ljc.251.1619974200472;
 Sun, 02 May 2021 09:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost> <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
 <20210502164542.GA4522@localhost>
In-Reply-To: <20210502164542.GA4522@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 May 2021 09:49:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=winSraiwc4gC5WFWSehFq+s7AqCJZoMqUuHLX0nYVG0nQ@mail.gmail.com>
Message-ID: <CAHk-=winSraiwc4gC5WFWSehFq+s7AqCJZoMqUuHLX0nYVG0nQ@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Adrian Bunk <bunk@kernel.org>
Cc:     Tom Stellard <tstellar@redhat.com>,
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

On Sun, May 2, 2021 at 9:45 AM Adrian Bunk <bunk@kernel.org> wrote:
>
> Mesa and PostgreSQL are among the packages that do use libLLVM.so,
> this is a popular library for implementing compilers and JITs.

Yes, and it's entirely reasonable to update those packages if it turns
out libLLVM has a bug in it.

Because we're talking about a small handful of packages, not some kind
of "everything" model.

So again, what's your point?

             Linus
