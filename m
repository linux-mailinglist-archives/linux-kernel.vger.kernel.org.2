Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152DE370351
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhD3WHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhD3WHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:07:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AEBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:06:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d15so31287261ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2PZfG2pzx7ZqFXKYqcny8O3yH0zHaMgCgEYwxgafKI=;
        b=Gmc33dvFHMmXR/GuoeUDt2Xn/SVFDn0SpZH1uBECztye2cY51egwBSd6PXXnVpKxSy
         lMWbSiAfoR1p/P1f2X2TKbpYClo9+LKDa62IdiK+MmeyGPMrHQZ36ECDFDHtownHHyMO
         BDLe/gNxJ83M8L7oMNwmcFHFZ36a1fIRkbUCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2PZfG2pzx7ZqFXKYqcny8O3yH0zHaMgCgEYwxgafKI=;
        b=Vg67R1ZibX2EtdQyLpZFtr7FXIIaAp0iMhKNYsG8RU1DziS8Q3N6pkBF9YG8ORT6cg
         TmHUMjVJWXftOT5oLWkyoOAcoVcw5T0B+zsf6wSrkor4ufXrvqh+5h/SjrpJgVnt0kmx
         8NpDS9Cooxqf3Zc7PHdA+fXP2d0uEAqV67m1/cf2jd0Iw6kocNYlV0iYR01fWVAaXDZu
         Z71Wp3alCTJyqNXUUgi5NkLesPy+at89/Nn++0IRqPDt8zsxGSU1y8yd5czeOgdNkpEK
         geynXMEimMgDl9XKeWgM+2dlC7Rt6wa36qK3XTTybrTottnrXVmbumNKCvFLeVbhl3oZ
         Q3NQ==
X-Gm-Message-State: AOAM530cxktsoRZ8N9z1/KxIPD6XfE2tBZez6LZ25L0v5EXOCXli+iLC
        1mUpyFYH1Ywyz9YfkLncs9HFUx+VPYtmTJlS
X-Google-Smtp-Source: ABdhPJwLz+QRsfAF9lAcry4zDZbxsxmV0MtvDmCgvBB6AnfWDYQJFhrx1sG6a37rfOM2bw+jMHK1OA==
X-Received: by 2002:a2e:a785:: with SMTP id c5mr5138141ljf.456.1619820406818;
        Fri, 30 Apr 2021 15:06:46 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j2sm112622lji.33.2021.04.30.15.06.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 15:06:46 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j10so19156621lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:06:46 -0700 (PDT)
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr4523604lfg.40.1619820405966;
 Fri, 30 Apr 2021 15:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <75d07691-1e4f-741f-9852-38c0b4f520bc@synopsys.com>
In-Reply-To: <75d07691-1e4f-741f-9852-38c0b4f520bc@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Apr 2021 15:06:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJEgjCYzHZFPxTs01p7FMEHKKqXyqwRVBk6KnvHB1qVA@mail.gmail.com>
Message-ID: <CAHk-=wjJEgjCYzHZFPxTs01p7FMEHKKqXyqwRVBk6KnvHB1qVA@mail.gmail.com>
Subject: Re: Heads up: gcc miscompiling initramfs zlib decompression code at -O3
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jann Horn <jannh@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 1:46 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> I've hit a mainline gcc 10.2 (also gcc 9.3) bug which triggers at -O3
> causing wrong codegen.

I'd be more than happy to just disable CC_OPTIMIZE_FOR_PERFORMANCE_O3 entirely.

The advantages are very questionable - with a lot of the optimizations
at O3 being about loops, something which the kernel to a close
approximation doesn't have.

Most kernel loops are "count on one hand" iterations, and loop
optimizations generally just make things worse.

And we've had problems with -O3 before, because not only are the
optimizations a bit esoteric, they are often relatively untested. If
you look around at various projects (outside the kernel), -O2 is
generally the "default".

And that's entirely ignoring the gcc history - where -O3 has often
been very buggy indeed. It's gotten much better, but I just don't see
the upside of using -O3.

In fact, it looks like we already have that

        depends on ARC

for -O3, exactly because nobody really wants to use this.

So this bug seems to be entirely ARC-specific, in that only ARC can
use -O3 for the kernel already.

             Linus
