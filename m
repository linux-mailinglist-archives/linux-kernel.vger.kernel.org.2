Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8195F3F8E03
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbhHZSmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243288AbhHZSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:42:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB9C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:41:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b4so8797392lfo.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSi2CT3/EAuJ8jcPqCdGVYqPPf28RMrJEFE8J6fYp1k=;
        b=QnVjVhg8NS9rsFJf38THsE2c+locc1ye7QZAehoJy4p1/TL67fZfBLPuBZsjP8d73w
         4RxIO/ZauUUZRulREfT1TdnBshTxlViODZwLcPA9JX/rZnznm88zub8yU7JtNy+5jSDg
         nW9ECnoBI1ZiLfFXBT24mKJt3jAuHiJK10gBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSi2CT3/EAuJ8jcPqCdGVYqPPf28RMrJEFE8J6fYp1k=;
        b=YHNLroTkvwEm3z8BzumefnFwi5SJdKyd2i/Q1Sc0VPRYeEnEzgDpCsq1OH7maTRWMl
         qxkfN6uUUYhCEAOux7TPz4/q1EMigTAjNcsk0VUm8HFq0zImAQdubxZutzrymlUG3Exr
         oIhfHU/R3+Pp7NtVBCLUaiZPQUN649LQiXKP+CHsbJRQBh0GHHtA3nd8hnY9cQ4d44Uk
         lZNtfj/klMBpn48kL+QdvYTZujt8CXSGSCZJU3lN3CfUG7mUn7oYaWBIPF982q01c88O
         n3kGw3y3zQpIpgd1YCfggEgwSvXHM9liwreL+auz2D4RIOMGig8sT/sP2aDvx+J+uka4
         /IpQ==
X-Gm-Message-State: AOAM5308H1ANtte7wW7gIlbgymwDOIl70OVELRQYsCflV0KxvDHzM+zq
        Ahwxa3kZXdTn+r2LaU/ZUaqmYNGUqBtG+4Me
X-Google-Smtp-Source: ABdhPJzHFUT1Y9p7o6DpgvLIln1eejaoEPwr1u6hSuNUjIXsF/7gvekNrglpuC3QYbKCmQNkMOcJkA==
X-Received: by 2002:a05:6512:1293:: with SMTP id u19mr3811939lfs.86.1630003311243;
        Thu, 26 Aug 2021 11:41:51 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id g7sm420304ljk.130.2021.08.26.11.41.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 11:41:50 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id b4so8797229lfo.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:41:50 -0700 (PDT)
X-Received: by 2002:a05:6512:2091:: with SMTP id t17mr3780432lfr.253.1630003309915;
 Thu, 26 Aug 2021 11:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210826131747.GE26318@willie-the-truck>
In-Reply-To: <20210826131747.GE26318@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Aug 2021 11:41:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8Wxazuq+E4_V0GG4eda0rNpZi76AYWQe7xfPZAAexAQ@mail.gmail.com>
Message-ID: <CAHk-=wi8Wxazuq+E4_V0GG4eda0rNpZi76AYWQe7xfPZAAexAQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fix for 5.14
To:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 6:17 AM Will Deacon <will@kernel.org> wrote:
>
> Please pull this single arm64 fix for 5.14.

Pulled.

But adding Christoph to the cc, since I do think the eventual fix
needs to be in the DMA mapping code:

> We received a report this week
> that the generic version of pfn_valid(), which we switched to this merge
> window in 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID"), interacts
> badly with dma_map_resource() due to the following check:
>
>         /* Don't allow RAM to be mapped */
>         if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
>                 return DMA_MAPPING_ERROR;
>
> Since the ongoing saga to determine the semantics of pfn_valid() is
> unlikely to be resolved this week (does it indicate valid memory, or
> just the presence of a struct page, or whether that struct page has been
> initialised?), just revert back to our old version of pfn_valid() for
> 5.14.

I think that's the right thing for now, but yeah, that condition for
WARN_ON_ONCE() seems very questionable.

"pfn_valid()" is more about whether you can do a "pfn_to_page()" lookup on it.

II get the feeling that the dma-mapping code should allow pages that
are PageReserved() to be mapped - they aren't "ram" in the kernel
sense.

Perhaps also make sure it's not the zero page (which is
PageReserved(), but most definitely RAM).

In a PC world that would be (for example) the legacy PCI space at
0xa0000-0xfffff, but I could easily imagine other platforms having
other situations.

              Linus
