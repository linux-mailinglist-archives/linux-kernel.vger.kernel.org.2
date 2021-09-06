Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E4401F12
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbhIFROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbhIFROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:14:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E936AC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:12:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y6so12338797lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wG+m7axsyf9xe/P3eHS5Xatu0sFA+zmgWESW9SpvH6I=;
        b=LLRQolIN0Z8DHNVqkw31H4xNxRValfnKjUOyyhL9sHuUUjtKUGSTH69a+eYok9fgvp
         g1L+bhrywdbnu57OcTIWACmngZXKAQmXpMTaZg38WX3/ZbWpNZuD31WEQFPVLWqOlFOs
         /lBf+EeQKzTUNFwbSwsYdh93DQvBy9fU1SGcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wG+m7axsyf9xe/P3eHS5Xatu0sFA+zmgWESW9SpvH6I=;
        b=JZMPF8rOxF+VuQ2rJlo6Fhc1PsCPLDreGQRX5r/seiZovCW1uutvNbho4AST6XKmvR
         punEUrZWAXkAkLuhG19FNchuxd6GzVhivvX7aNWJPCZDZSiJUNkyKl6lGqaCeE2gdewg
         Lq+Dq4WhDRKZM6q+ICQgG8aU4Zuzbfs8aCNaRC8eIJ4AnzDYLQ8W+alVKudWnhO65EkM
         5cMzkZVdnnpyHcs+rzoKND1QPotzMUYDQofoaqeUoiMjg8eLSZDSGSpvwR2/vmPW1DKs
         UYbB+eAz7sFhYAdK/j4eCwYZBDLlJYkaJlfltkxSlu1tiwIQ9NwAIHUaR2/ZPcVAqbtb
         9Jog==
X-Gm-Message-State: AOAM533x0qGkl1JjsmCcK7Mac68ckTNWk/nHib0Ch/NJFJi8dxYiWlBS
        YNlPjvvbADv66a/JeUMOxht3DVot6p2VgjrCcds=
X-Google-Smtp-Source: ABdhPJzK89YhzMKheyO1CFEGHP/THThB/7cYEzCHuquWXtisSzz78IvLi/YiZzek+oK5hdShYOc1rA==
X-Received: by 2002:a2e:b613:: with SMTP id r19mr11180764ljn.136.1630948373433;
        Mon, 06 Sep 2021 10:12:53 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d20sm788311lfv.117.2021.09.06.10.12.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 10:12:52 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m28so14543525lfj.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:12:52 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr10361132lfb.141.1630948372307;
 Mon, 06 Sep 2021 10:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210830184429.1ee4b4d8@canb.auug.org.au> <20210906154151.0aa41a7a@canb.auug.org.au>
 <202109061000.79CF310@keescook>
In-Reply-To: <202109061000.79CF310@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Sep 2021 10:12:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSzN4p0EW2LkA0YkRBjkOXpdaiLZMez=h=3d4Q2Gjp3A@mail.gmail.com>
Message-ID: <CAHk-=wgSzN4p0EW2LkA0YkRBjkOXpdaiLZMez=h=3d4Q2Gjp3A@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the kspp tree
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 10:06 AM Kees Cook <keescook@chromium.org> wrote:
>>
> Linus, warnings are being reported (as above)

New warnings are apparently at least partly reported, but also clearly
(a) old warnings are ignored, and (b) new warnings seem to be very
spottily fixed too.

Guenter reports "pass: 89 fail: 64" for his build setups.

So the fact that *I* require a clean build, and generally have two
reject a couple of build requests every merge window because of that
clearly doesn't mean that we actually have clean builds.

I've had that "no warnings" requirement for years. And that means that
*my* build has been clean for years.

I want *all* builds to be clean, or at least as far as possible.

You should be the last to complain. You are literally the drop that
broke the camel's back. I'm done being the last guard against build
warnings.

           Linus
