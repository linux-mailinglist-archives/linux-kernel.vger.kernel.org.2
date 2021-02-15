Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667DF31C2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBOTwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhBOTwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:52:38 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC3EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:51:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id df22so9628716edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggXAchxe/nqZ+4UDDGVutSsPhwxIlT0f1nO/trNU9oc=;
        b=IarEwOMOZA33L50oHF3AETzMXemhi0EnToMfhtmZUS8KKm/d0nN+tkOx4xdwD2VTdn
         WD5BVHnFcSLwHfXjAnYDdhNkNAP7SCxaxnKm8qQAV1i64056rPwLJJ2j2pU0zNNaRvHw
         43CyDY40W/dharZ3Two4gbZkV6v6WUSmnsu85LWL+H6lNJTpggZFoR/auGcAE8vGCe6F
         J46nC7kFBtHIUHx+W8Ns6SLSt2Va0IKY/ZrXVAgVRFl0WqvnxM+weHG1wBeWRNHtC5ph
         3i1TeyBzgvHMLDdcE3N8dvJB/qdfF0OarRY3HS4CNooxK6aOlWAiqLGxkyfsnlXY2m+3
         3H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggXAchxe/nqZ+4UDDGVutSsPhwxIlT0f1nO/trNU9oc=;
        b=MxWu8C+PUaQUcawuqzsNScF/LWxIDu3kCngHb/nTHPWRnS+hHFOaBGkfX/utCEjqOU
         BXSCAzaxifWe3DkWUawtKIg1nkxKng0aIN17Q2U+R5Mv6116SeWU7XP8kTQnkSa1WUlU
         nFKIvph5/z5wCzobUnja3zz0TfeeJIBoSjvw44fc61GwPZOUez5Zx8dcYWFhZ3UD2iQ1
         GCR4DVTWDwWKwCN1NgKdnKwoYiGx8oVuq6fUG053gOkWo/JwRnxRZJ21WDxhU6YPsEQN
         eTKK8SA2qQi8WLZeNwhM7GzoDwU9mPpmNxuBHyxPSW6n0VaUcIrnS/VrZpMsGBP9Bn59
         doSQ==
X-Gm-Message-State: AOAM532t/vUOL5SYmBCBP63HSttfJ/TGk2+rGIvhg6L492mVMG198GSL
        DPO31gCWwpDsnubq+TojyUxHQA8yR6c4MsYsVsxPgg==
X-Google-Smtp-Source: ABdhPJyof1WMeYuO/LOIuwozPZ/M/dMJEhGnpPp9NrjZXVqoSJFYUy5W8dTWP0sEIEjNai5f72V89i+osUosOBSYxh8=
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr17395465edd.341.1613418717238;
 Mon, 15 Feb 2021 11:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
 <20210215192237.362706-2-pasha.tatashin@soleen.com> <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
 <CA+CK2bA7Xz0Zg5phsQi3mhnp+_PHLAAGRLgFTQNw1FjBHaXsHA@mail.gmail.com> <CAMj1kXESuD-von_dtzYcUMwK7TLF=qTki9bd8_iTo_isBwj13g@mail.gmail.com>
In-Reply-To: <CAMj1kXESuD-von_dtzYcUMwK7TLF=qTki9bd8_iTo_isBwj13g@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 15 Feb 2021 14:51:21 -0500
Message-ID: <CA+CK2bDJ7Y2-vEpZrZ0fzigAfDgcJOmjhmin_GjTqioYXAYB3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 2:34 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 15 Feb 2021 at 20:30, Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > > Can't we simply use signed arithmetic here? This expression works fine
> > > if the quantities are all interpreted as s64 instead of u64
> >
> > I was thinking about that, but I do not like the idea of using sign
> > arithmetics for physical addresses. Also, I am worried that someone in
> > the future will unknowingly change it to unsigns or to phys_addr_t. It
> > is safer to have start explicitly set to 0 in case of wrap.
>
> memstart_addr is already a s64 for this exact reason.

memstart_addr is basically an offset and it must be negative. For
example, this would not work if it was not signed:
#define vmemmap ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))

However, on powerpc it is phys_addr_t type.

>
> Btw, the KASLR check is incorrect: memstart_addr could also be
> negative when running the 52-bit VA kernel on hardware that is only
> 48-bit VA capable.

Good point!

if (IS_ENABLED(CONFIG_ARM64_VA_BITS_52) && (vabits_actual != 52))
    memstart_addr -= _PAGE_OFFSET(48) - _PAGE_OFFSET(52);

So, I will remove IS_ENABLED(CONFIG_RANDOMIZE_BASE) again.

I am OK to change start_linear_pa, end_linear_pa to signed, but IMO
what I have now is actually safer to make sure that does not break
again in the future.
