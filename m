Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B680D3C617A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhGLRH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhGLRH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:07:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31C6C0613E5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 10:05:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h9so10048861ljm.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jZJrPjdUgS0Z2yjiY7d2Ru0LXr08Vx68ecg4BC7Ua4=;
        b=aApE6SaBO1NCqzN+Y+rt7z6fN0BXqBIFpki02LcooX1S2tukO+SE+R9UxryeAlm4WB
         sPCfxIOjxHogBt22liggY3RaXDnGpGjqhcUvoRs3h7jl7tADKQdBqNSIQzZgrqqrLcjT
         6g//HO41mUvaQnOay897rSY66FJ95ap29a+QMCSj886YtYyy7mTMhQWj81Eo3o5v0RR5
         oHvd0ascdQQ2ZYBMy2cctQ4Ta7C9mUGpbngyUrRzNryVo48sBs1i6I315eq71dsHSkmm
         +MOT4q4nIx+dod7RIQKFbAPQ/A1ZXNfttgGwZn/I3o3BxEUiBkYJtXKNRu3MhOGLY/1+
         /SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jZJrPjdUgS0Z2yjiY7d2Ru0LXr08Vx68ecg4BC7Ua4=;
        b=RQS51TKLljywXnMCCtaZ5hp0pFfAGHBswVigl2gNy+kGAVD3d5iQCygHo8Yzvch2Ki
         qcfmFdlAadq9fiqebWZDR9RPNPbU3kHVlrD3Jtq8KD2gkQ/c5vMR0b/+UcGenbqoK90W
         +XsFm/mUXoEt9JnGMWAm+wshakY0q2LQNmo3nQpjTrfqwqV2IijXeocIqnsgREYYfkqE
         SKOGtwcNQh779R2x90MGbMeleUXimR8GDiHk9bF8LxpC4obxvb6OHBCxensF8oK8Psji
         xVdRNYHZK6LkVaMmXEKpJLJEnDfJ6eeLYfz0UJeOxLp63YsthzbD7G4BIZu3Ue+aJKe1
         3mzg==
X-Gm-Message-State: AOAM530EAP+u+8wI91ukRH3TVFPOLmxW902soCWDV9CCcvNXpYoHeo7T
        SjbwuS8+ztbBUJVVQx1gIj0GYpZoH9Tt1dWUUcsxwA==
X-Google-Smtp-Source: ABdhPJxx+92gYgmWRSE9Ff7IhXrpo9eWuoPvzLLVHBgY2lYEbvSUyYavE7titIQRQ7+zkGwfoL3juX1GQjWeoBNgCiQ=
X-Received: by 2002:a2e:b5b5:: with SMTP id f21mr139300ljn.479.1626109505737;
 Mon, 12 Jul 2021 10:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210709000627.3183718-1-nathan@kernel.org> <20210712122433.GA28536@willie-the-truck>
In-Reply-To: <20210712122433.GA28536@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Jul 2021 10:04:54 -0700
Message-ID: <CAKwvOdmGhMbvtko2EVARg2E8zSX-LQKSPfdj6fbbAsCK4nw_Qg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and newer
To:     Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 5:24 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Nathan,
>
> On Thu, Jul 08, 2021 at 05:06:27PM -0700, Nathan Chancellor wrote:
> > Commit 97fed779f2a6 ("arm64: bti: Provide Kconfig for kernel mode BTI")
> > disabled CONFIG_ARM64_BTI_KERNEL when CONFIG_GCOV_KERNEL was enabled and
> > compilign with clang because of warnings that occur because LLVM was not
>
> Typo: "compilign"
>
> > emitting PAC/BTI instructions for compiler generated functions.
> >
> > This was an adequate fix to avoid the warnings with allmodconfig until
> > commit 51c2ee6d121c ("Kconfig: Introduce ARCH_WANTS_NO_INSTR and
> > CC_HAS_NO_PROFILE_FN_ATTR"), which prevented CONFIG_GCOV_KERNEL from
> > being selected with clang 12.0.0 and older because it does not support
> > the no_profile_instrument_function attribute. As a result,
> > CONFIG_ARM64_BTI_KERNEL gets enabled and there are more warnings of this
> > nature.
>
> I'm half asleep today, but I'm struggling to follow what GCOV_KERNEL has
> to do with the warnings here. Prior to 51c2ee6d121c, you could still go
> and turn that option off and so wouldn't the same warnings be triggered
> in that configuration?

Nathan, consider if any of the below can be reused to reword the commit message?
```
Prior to 51c2ee6d121c, allmodconfig with clang-11 would not select
ARM64_BTI_KERNEL because GCOV_KERNEL already had been.

After 51c2ee6d121c, allmodconfig with clang-11 does select
ARM64_BTI_KERNEL because GCOV_KERNEL cannot be selected.

clang-11 had basic support for BTI, but failed to instrument compiler
generated functions properly.  This produces the following stream of
warnings for clang-11 allmodconfig builds of ARCH=arm64:

warning: some functions compiled with BTI and some compiled without BTI
warning: not setting BTI in feature flags

This was fixed in clang-12 via https://reviews.llvm.org/D85649.
```
Perhaps its of interest to find which config in (allmodconfig minus
GCOV_KERNEL) but not in (defconfig) produces these, since I don't
think we see them in defconfig builds of clang-11?
https://github.com/ClangBuiltLinux/continuous-integration2/runs/3009146591?check_suite_focus=true

>
> In other words, I think there are two aspects to this patch:
>
>         1. Removing the (now useless) !GCOV_KERNEL dependency
>         2. Requiring Clang >= version 12
>
> but the commit message doesn't really say where these warnings are coming
> from or why Clang 12 gets rid of them.
>
> Thanks,
>
> Will



-- 
Thanks,
~Nick Desaulniers
