Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC74325BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhJRSAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhJRSAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:00:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5298FC061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:57:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q16so1271697ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enwUwHCvAXH97heRPPUL44a0hk47wLy74P2gCbKr6NU=;
        b=Bmhkl7KfEzX5Uq7jl7xfID7BkPuhl5sDEzqgBuDyAA02Gi/wM31V/IBFmwWEhFVK00
         68fN8uBsbkAmuwdDzeJIHGrtcQU5Nczhzxw6O9q3mu+Ng5DdUUy45mnW2E4EbGSm/8r+
         yeCCr++Yidmwd9CEfrt+AyM0xc4yHQvyDl6dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enwUwHCvAXH97heRPPUL44a0hk47wLy74P2gCbKr6NU=;
        b=IFjwf8Yt7+jEFnCAtOk2/YOEEViwpnoq5ng8Hwy2qbsFOOiEw6VfoINy58pN7YqZVA
         bmQsM6dlG5H96zqoZ39Bt2Wg+F4Kwn/nQVO/v3lRxjchrQjWdkYJuG1DclECSSmy589w
         VosPDyEvqSr0Va+RQFAigxA5fuDEuGIBg9dpDw53dYyMydEOEXX/HNdS+czEjQurwuh0
         OrwlnNLLAnP6FfqNuSfO0ua/xX+xmg/fiEANFXYqlcbPizx40j35Oa8dIPPFhtjheaM6
         8NDmIr2WUnRA6daFxp1JqyH6TEQlWFldtLXQ/5aIK+6UG1WwF35p0wgB8YxOkzQJB3qt
         vqZw==
X-Gm-Message-State: AOAM532QV9s/oZV8O7urCeNJ4ueu0j2QqvNAYb2O7xJCuQ7M0w8djx3+
        4t7UFz5xxcLiTzWl6GJdY5Jk7hjLL7zNV4bS
X-Google-Smtp-Source: ABdhPJz5ndCNzobkvDcyUCf4l5dPDAOlvH1ow/EuqPAFIU4WczNOoAwnf2RFmoNuxw1Ks5kwu073GQ==
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr1209379lji.181.1634579875231;
        Mon, 18 Oct 2021 10:57:55 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 79sm516593ljj.124.2021.10.18.10.57.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 10:57:54 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u21so1474972lff.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 10:57:52 -0700 (PDT)
X-Received: by 2002:a05:6512:2248:: with SMTP id i8mr1099221lfu.655.1634579872363;
 Mon, 18 Oct 2021 10:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211018174137.579907-1-pbonzini@redhat.com>
In-Reply-To: <20211018174137.579907-1-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Oct 2021 07:57:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg0+bWDKfApDHVR70hsaRA_7bEZfG1XtN2DxZGo+np9Ug@mail.gmail.com>
Message-ID: <CAHk-=wg0+bWDKfApDHVR70hsaRA_7bEZfG1XtN2DxZGo+np9Ug@mail.gmail.com>
Subject: Re: [GIT PULL] KVM fixes for Linux 5.15-rc7
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 7:42 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> * avoid warning with -Wbitwise-instead-of-logical

Christ. Please no.

Guys, you can't just mindlessly shut off warnings without even
thinking about the code.

Apparently the compiler gives completely insane warning "fixes"
suggestions, and somebody just completely mindlessly followed that
compiler badness.

The way to do a logical "or" (instead of a bitwise one on two boolean
expressions) is to use "||".

Instead, the code was changed to completely insane

   (int) boolexpr1 | (int) boolexpr2

thing, which is entirely illegible and pointless, and no sane person
should ever write code like that.

In other words, the *proper* fix to a warning is to look at the code,
and *unsderstand* the code and the warning, instead of some mindless
conversion to just avoid a warning.

NEVER EVER do mindless changes to source code because the compiler
tells you to. Apparently the clang people wrote a particularly bad
warning "explanation", and that's on clang.

I'm not going to pull this. The clang warning fix is wrong, and then
another commit literally disables accounting for another non-fatal
run-time warning.

Again - warnings are not an excuse to just "mindlessly shut up the warning".

They need some thought.

None of this kind of "I'll do wrong things just to make the warning go
away" garbage that this pull request has two very different examples
of.

I'm adding some clang people, because apparently that

    note: cast one or both operands to int to silence this warning

thing came from clang. Somebody in the clang community really needs to
re-think their "informational" messages.

Giving people those kinds of insane suggestions is a disservice to
everybody. Clang should fix their stupid "note" before release.
Please, guys.

            Linus
