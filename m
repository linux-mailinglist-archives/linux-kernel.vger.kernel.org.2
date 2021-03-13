Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54818339E59
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 14:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhCMNtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 08:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMNsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 08:48:32 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0759C061574;
        Sat, 13 Mar 2021 05:48:31 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h18so5245520ils.2;
        Sat, 13 Mar 2021 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Mk7qqMNv7tZl3c93938Nv0q1u8cVkjj0T2h6mx/gspA=;
        b=Hwr/kUfQ3Oz8UHgf9Fbs4x+K8Nf+1mEf+TRyC49YnCeuwQ0y20v2ico0Og9yg13Nrl
         2aQQXJWqNpUOt/wlS2f3vpcwDNXpD1eWR1RUDr20QvszQUSpMs0kKNVU1ZKjNYEWLs0L
         gX+WVcdWfB/kIFy9DFruVDg4haHCSeur3pO3YTesxFrLiaRplZoCPWTH2x80I54Hx7lg
         BYrsqreWn9SO24qRtMxd07CGWwCuc6BXMXRkgUe/BfyEWKkBI3rSD+m7uyRckJg64QNQ
         afi98sRTvNQaDtetDIc0elI23ZBrew5dLWzMWc9VTDn2hmmOC8Bp3dMKClu6Q/h0Vuxa
         gxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Mk7qqMNv7tZl3c93938Nv0q1u8cVkjj0T2h6mx/gspA=;
        b=OKuehTJqRlXwQ90rd2wSJ4Hkq/kFzmLrk6mKuxgHO+D6LQZCOHXyA0NeZpxe3w0U5j
         vWYD4zF0WaSMRbWgqrqhE4wQeHnw3wLlB3MUiIVXK7hBNi1cvTlx8aUqYHB+NrUpXmZ7
         nc1Mo2v7zNGGSHGXUos4gS88IlLnJdjWo2CKR4vFjet38m0Zq+l48ccCeCRpaPREYpQX
         7JmRGwSxvUm1alKsnFQi9hBXHTJ3FXSLFRJbfOB/x+Vk0iUqHrs9+TRz3cL1cgIi38sh
         V86uNGJ5KMsamBEUfSaVAQ3uvv8QSmQkwoMSgFBWN5gdi6h5dxMaYi9UkH5vNZQ3swPO
         6zOw==
X-Gm-Message-State: AOAM533Cun8tCdXMJBOOF561G1sTH6Q/aggtJK8Kh+dDUzd8DxncgQRb
        UpKjGlN1s7IBrTmXDAVcM2dtidOlUIiCANGWfWA=
X-Google-Smtp-Source: ABdhPJxMO51vqd6zi8j7ux/cJxS92Ptv9k0ZA2Ri2UbKr1iZnks/Ahc1v9uwNmfamiZUzDmEvKhFWwyMFEgnob89NN0=
X-Received: by 2002:a92:444e:: with SMTP id a14mr6190973ilm.215.1615643311027;
 Sat, 13 Mar 2021 05:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org> <20210312205914.GG22098@zn.tnic>
 <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic> <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic> <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic> <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic>
In-Reply-To: <20210313132927.GF16144@zn.tnic>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 13 Mar 2021 14:47:54 +0100
Message-ID: <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 2:29 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sat, Mar 13, 2021 at 01:58:56PM +0100, Sedat Dilek wrote:
> > You can add Debian/experimental APT sources.list ...
>
> I could but I don't expect clang12 to behave any differently here.
>

Agreed in things of build-time.
There were some improvements and optimizations to LLVM/Clang but twice
as slow is really hard compared with GCC.

I was thinking more in the direction of "compatibility" of tip tree
with recent LLVM/Clang other than what is officially supported via
Kbuild-system.

Let me look if I will do a selfmade ThinLTO+PGO optimized LLVM
toolchain v12.0.0-rc3 this weekend.

- Sedat -
