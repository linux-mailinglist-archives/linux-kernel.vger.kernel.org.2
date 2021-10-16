Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D32430374
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhJPPmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhJPPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:42:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B19AC061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 08:40:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y15so55706564lfk.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q88y4WBZj28jEM3JEV3sTlyhWcoR55HQTTGRioE6bb8=;
        b=RWvfd1Je9hSmT/qatBra/dYlQTeVwbONHHIbOZCZeDtvCB6/MPdCR8sayRyBNajSpU
         VaErKAyyaJiKiK//fHgCm5ZzDgyJbzmCUwQyFPEje9PuqElBQAPQNfJY5+njP4d/wBn5
         u6/WqZqcZh9bYzwWafKhBCaXdkenewyb8UgEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q88y4WBZj28jEM3JEV3sTlyhWcoR55HQTTGRioE6bb8=;
        b=fh+a9pX12fek7wAfn3SPaJu6a+3FZMkb+PeUvLknJbHnAQSWvw9aBgB6A43qFZEoBf
         X1dPMSR4ljMK0nhYo1Iub/sZSKMoq7Y+utWhW5CmoBlrxayfzbe2smuNXcTLBOjzhCnI
         446GR7nYOpMWMqTrzzYokkfmBfROnXx0SPmM4v9IOwUuW590C10x1ZETN2TXw4Uqq+0+
         dSxnnueELDKNBAxEyC6Nrqw5Y8BHQxC1hVsDG59tFUinJx7/Mq8eUO0ijGNmjyfUvA+b
         dJ7T4eT3WjdTAEMCLdy1VTIO5IkB4Lr2KMASGuFcT1DTdEpwYz/pTj2G6IcGtCLS1Fn1
         yARQ==
X-Gm-Message-State: AOAM533fl9a6o9gTKo8kOUHW3gGnrj2yAVhV07fUUd2Tyud8BfmfVUXS
        KH1/aydTY/ShZLUBG7w+0yfwZu+BI2ozHA==
X-Google-Smtp-Source: ABdhPJxA6o40qnnF9Es/XySNzfEXrJtqR3hwovqmMnMzgprDmQTvqC9V+LhbfR06+tOr1dtw9qkm4Q==
X-Received: by 2002:a2e:868e:: with SMTP id l14mr18979221lji.26.1634398806238;
        Sat, 16 Oct 2021 08:40:06 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t22sm921733ljj.61.2021.10.16.08.40.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 08:40:05 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z11so54286167lfj.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 08:40:05 -0700 (PDT)
X-Received: by 2002:a2e:1510:: with SMTP id s16mr19679295ljd.56.1634398804988;
 Sat, 16 Oct 2021 08:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211016064302.165220-1-pbonzini@redhat.com>
In-Reply-To: <20211016064302.165220-1-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Oct 2021 08:39:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijGo_yd7GiTMcgR+gv0ESRykwnOn+XHCEvs3xW3x6dCg@mail.gmail.com>
Message-ID: <CAHk-=wijGo_yd7GiTMcgR+gv0ESRykwnOn+XHCEvs3xW3x6dCg@mail.gmail.com>
Subject: Re: [PATCH] mm: allow huge kvmalloc() calls if they're accounted to memcg
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        syzbot+e0de2333cbf95ea473e8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 11:43 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Use memcg accounting as evidence that the crazy large allocations are
> expected---in which case, it is indeed a good idea to have them
> properly accounted---and exempt them from the warning.

This is not sensible.

The big allocation warnings are not about whether we have the memory
or not, or about whether it's accounted or not.

It's about bugs and overflows. Which we've had.

At least GFP_NOWARN would be somewhat sensible - although still wrong.
It should really be about "I've been careful with growing my
allocations", not about whether accounting or similar should be
disabled.

If the allocations really are expected to be that big, and it's
actually valid, just do vmalloc(), which doesn't warn.

                      Linus
