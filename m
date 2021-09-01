Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B4F3FE504
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbhIAVhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245507AbhIAVhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:37:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3651C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:36:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id l10so2023349lfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYemb+IVIGMJMpiffbPQhUFiWax0UjI4yymjBbO+x2M=;
        b=L3OYKEs58Snx5mC+czL344+tZCIO7gfpz++GT7mAJJ9TkuGPjlXiYIOypkBLHsfxzx
         ds+STBdb8Ysq9cPQg06QQe80hsqF++3uZ2kqZQdkxsBDjcVYbjIWPXjRsuzwUZsae9l9
         mKlZ8KFBOIQgr5ExFEYl0ynTDLEaiIPke2C9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYemb+IVIGMJMpiffbPQhUFiWax0UjI4yymjBbO+x2M=;
        b=YQB32z3OpDXZEpTfbhypDZ7jq+1j7aNwemuibjRGxoFhN4LwM78eRYGD3dtvHAPqiy
         g3K3c385URKDLfnAiaZ1ms4QBWd8mdqu0a27pTKcE7WbMwXCdzicJiSzWxTpLJX5uGvq
         ylT3ei2H9R1Ox9xT+SufZoizs7GXNz/nFL0mWOFWJh17QfcMn1MH/U6p0+IPMCIsLVV+
         OiVVmMtzH7EhsKsVNLfE6Dqwlo7hm3yu8RRiN3TcnZ1ngUNqByweN0/cigxi+Jt4zkBe
         Er6o3l6oVB3XRELI5nboQsxcQMGU7onRUg4BfVxchnvgtvKbh6yWTXCtjz6hiHZPz+uA
         sgCA==
X-Gm-Message-State: AOAM533QMY53zDqHGhM9s9mM0/lmHEKoG2bCo+NlR5OpJxyjVoyMqLWl
        kkMXkYMqVJccE6fHWtoPPPofjwz48flqV0hG
X-Google-Smtp-Source: ABdhPJxoDUV8D+lylJomKp/QPxM/1/XH1HPuAM4duQJJI+7xDxyHzypnB363caifM97wDKXvqZoXwQ==
X-Received: by 2002:a05:6512:118b:: with SMTP id g11mr1056401lfr.205.1630532172689;
        Wed, 01 Sep 2021 14:36:12 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id z25sm73302lfh.200.2021.09.01.14.36.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 14:36:12 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id j4so1973728lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:36:11 -0700 (PDT)
X-Received: by 2002:a05:6512:128a:: with SMTP id u10mr1107687lfs.40.1630532171691;
 Wed, 01 Sep 2021 14:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATrzUSQg8pnpG1cDbA0sRdAeQGyy7d3ZqFJ4HMZymB=xQ@mail.gmail.com>
In-Reply-To: <CAK7LNATrzUSQg8pnpG1cDbA0sRdAeQGyy7d3ZqFJ4HMZymB=xQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 1 Sep 2021 14:35:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbjVb5wNURa7-_PtvKqf96X-7a1OoUDPJjo9rz68YB=Q@mail.gmail.com>
Message-ID: <CAHk-=wjbjVb5wNURa7-_PtvKqf96X-7a1OoUDPJjo9rz68YB=Q@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v5.15-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 6:34 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> After pulling this, you may see new warnings like this:
>
>     arch/x86/entry/vdso/Makefile:135: FORCE prerequisite is missing
>
> They are just trivial Makefile mistakes, and patches
> already exist. So, they will be fixed sooner or later.

I refuse to have new warnings in my tree, particularly during the merge window.

So I will not be pulling this, since I do indeed see those warnings
when doing my test builds.

                Linus
