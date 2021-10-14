Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7139942E186
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhJNSoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJNSoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:44:02 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F34EC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:41:57 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i189so4965554ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vuxshsfHtLjbAbft8l5pvgP1W0cVnLR0zLA69xmTOI=;
        b=by5P0yKP3zQWYD4728dibXaqmBM8xi7P6Mh5FmkBcWyhEogUgg3ItaH0WQ0Qw2i9X9
         dX2vSCt/eV8t7U7kdbOsrilLeR5jPfMK4cXhDSldk/xKIYMprJl64WDCTcthiMj53MeO
         HEay/Ca4RKv1VMcySvZT6Cov24skCbyF0UbBFyiHBxOUTBtmS3E5XJ5BZ0PS86gAEI5s
         4f20fg41QbPOO5m+72cYY/MASLDKq9xL6A7E9IqVZJxsrCCwGpgLg+cODdGKzc1Q7JO9
         +xYtCR4mqOMR/KCC7VuQC/L8JpT161BEozi+EE5A9miJbtgyh/6Pm4xaYisszNyPzSE9
         A46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vuxshsfHtLjbAbft8l5pvgP1W0cVnLR0zLA69xmTOI=;
        b=IwbG9KxdYTWsaCLIGQYihV1DJr7qMw4IBT61c+djP0eh2H1ORwbyg/8SfgECz2VeMH
         DlHUYN+Efp36vfTL2SkbBWx2mj9qTD3EC9d8f6NI2//MGGY7gaYvuTXNksYgHvFHdNZu
         sODkyBOAeFseoM9Q12cTNa/1/L250It0NPTVlHPWKJ90nHZq1QwEUGmSibezhBHPoFYE
         dcxrPn0j/nfjQUWlOmA3gCMbPT8v2qgFTM7VeYZPHpMIqImmwjVxaFa/3GNr7K2N3gse
         uMa/oXqMrT33oQaLUj3Jgftl96qEHIHsgkd7LsgDV0XAKjJjPoYxpcLc/Nkk2V+sf998
         iWGg==
X-Gm-Message-State: AOAM531t47LkG9ku+1vp2Oq0WToPjtz3K2TyB0cBzSFIlTwlrx7EfLzJ
        SjRkz7Df93Xnv+/36gdMoPLuXn/QeD14ov52BHw=
X-Google-Smtp-Source: ABdhPJyLH2m3/G7uDqEmFfQiWoOEDf5lKmHYdpJ4vcqrnZL1K6nfo47X4ijAvGPq/rWWwBuh1AZEIypxE/oxExsVHqA=
X-Received: by 2002:a5d:9d56:: with SMTP id k22mr454360iok.177.1634236916655;
 Thu, 14 Oct 2021 11:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211014132331.GA4811@kernel.org> <YWhGQLHnA9BIVBpr@hirez.programming.kicks-ass.net>
 <CAKwvOdnkDUfRKzmLThQGW02Ew6x=KM0MQyHge7=kc673NYxo2g@mail.gmail.com> <CANiq72nt+8bCGAm8yhvTZfS64ovOi9_U=Gym7biUhdEsc3Neaw@mail.gmail.com>
In-Reply-To: <CANiq72nt+8bCGAm8yhvTZfS64ovOi9_U=Gym7biUhdEsc3Neaw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 14 Oct 2021 20:41:45 +0200
Message-ID: <CANiq72=UVCmjr1tpSwcoOkid5tWZirKCnV17_Peqy-LBmEQHEg@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as __noreturn
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 8:33 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> That would be a nice to do, but I am not sure about introducing one
> more macro about this... I think it would be simpler to submit patches
> for moves into `static_assert` even if we have to "flip" the meaning.

Actually, what would be ideal is a compiler-backed lint that checks
whether it could be an `static_assert`, perhaps in clang-tidy?

It would also ensure things are kept clean.

Cheers,
Miguel
