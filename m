Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722903F2235
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 23:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhHSVXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 17:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhHSVXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:23:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BE5C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 14:23:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso4800142wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTwZBkmlhJu0yeh0rq+kkxVJ4zxvvlL9c7xZVRRZ+sE=;
        b=hm3YWklxaUQMS7M0lRFXt2/cVhSuKMYtjezycChJg7GMdAG2SRzUzV2YRoVQjqTBu9
         NeIN3/QnIPWfepvfuazKanaV3Es5bj601eWQggIZcT5YbX8yW10eY1/a6bAD/1GNQQKD
         xy+UGrnNXV4vjYqlSoztr9rGD9zD8qk7AuJKOxTYre4WlDi4Rx+Z4+RTWZmAgkhZFIvA
         38AjjvhIAMevtrddq1WfmOp4gt+l/vm1t8RfTMlQVoZjrftArMauIgQZcGab1Cn9rC9w
         b6ZXWzjgkPfzCwYOQRr1wOwhrqZhKoysU2J9ncY2mvW76qX/emEmS1StLo0PeIIQI3UR
         RVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTwZBkmlhJu0yeh0rq+kkxVJ4zxvvlL9c7xZVRRZ+sE=;
        b=EPM1ZfRlckZioIm3SaJMANLMZ5KrFvgmolPcr7erizaUuBFezrMjxk+W1Hoiar6dIZ
         utxldQTUwUoAbhRf+UuNkdUNejP0iPvwJ9Jyh7geG0voekzakm/ULRQfrXHHn47Al0qC
         RecX3KfJRhAemO0DbgFZRbZFUe0LxYnL7RvmpargaFRQPQ7oowCYeBFWvo+DtpAaBq8o
         sQWxVuWj0vkPOfT9+dwt/JdBEZ9tm8mIJfRCSQJOFj4xG3QEV7Ka7kUpj/HZ3XNuytam
         VVNw40+DVKX3/P3AVqYq/kzKyHiypM7F1Qqj885gyQGMUvsc69SNfb+4ECHZE11QF208
         rR4g==
X-Gm-Message-State: AOAM5330MNxoVn9fJX8BcCmanxttON8xkrUSloN/av5rXdG/GflKacLF
        5+FUfhpUv6DHpzS+3gy1lHVknEnwP6/jQxjybdnB5g==
X-Google-Smtp-Source: ABdhPJzwKnOB57PqKiz5Zvz6940JuKHAZFiPnQ1ZrkvNbHwIQaFZxN/j6SqZCUjwjTVJG4fPbNi8YDX7r+yh95nWmYk=
X-Received: by 2002:a05:600c:2283:: with SMTP id 3mr559171wmf.149.1629408194471;
 Thu, 19 Aug 2021 14:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210818063107.2696454-1-yuzhao@google.com> <20210818063107.2696454-2-yuzhao@google.com>
 <20210819091923.GA15467@willie-the-truck>
In-Reply-To: <20210819091923.GA15467@willie-the-truck>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 19 Aug 2021 15:23:02 -0600
Message-ID: <CAOUHufbysyPZFZDOaGn+FwVojy-krCZR--7dd0qkWqKL+s9S_Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] mm: x86, arm64: add arch_has_hw_pte_young()
To:     Will Deacon <will@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 3:19 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Aug 18, 2021 at 12:30:57AM -0600, Yu Zhao wrote:
> > Some architectures set the accessed bit in PTEs automatically, e.g.,
> > x86, and arm64 v8.2 and later. On architectures that do not have this
> > capability, clearing the accessed bit in a PTE triggers a page fault
> > following the TLB miss.
> >
> > Being aware of this capability can help make better decisions, i.e.,
> > whether to limit the size of each batch of PTEs and the burst of
> > batches when clearing the accessed bit.
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  arch/arm64/include/asm/cpufeature.h | 19 ++++++-------------
> >  arch/arm64/include/asm/pgtable.h    | 10 ++++------
> >  arch/arm64/kernel/cpufeature.c      | 19 +++++++++++++++++++
> >  arch/arm64/mm/proc.S                | 12 ------------
> >  arch/arm64/tools/cpucaps            |  1 +
> >  arch/x86/include/asm/pgtable.h      |  6 +++---
> >  include/linux/pgtable.h             | 12 ++++++++++++
> >  mm/memory.c                         | 14 +-------------
> >  8 files changed, 46 insertions(+), 47 deletions(-)
>
> Please cc linux-arm-kernel and the maintainers on arm64 patches.

Done. Also adding a link to the original post:
https://lore.kernel.org/patchwork/patch/1478354/

> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index 9bb9d11750d7..2020b9e818c8 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -776,6 +776,12 @@ static inline bool system_supports_tlb_range(void)
> >               cpus_have_const_cap(ARM64_HAS_TLB_RANGE);
> >  }
> >
> > +/* Check whether hardware update of the Access flag is supported. */
> > +static inline bool system_has_hw_af(void)
> > +{
> > +     return IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && cpus_have_const_cap(ARM64_HW_AF);
> > +}
>
> How accurate does this need to be? Heterogeneous (big/little) systems are
> very common on arm64, so the existing code enables hardware access flag
> unconditionally on CPUs that support it, meaning we could end up running
> on a system where some CPUs have hardware update and others do not.
>
> With your change, we only enable hardware access flag if _all_ CPUs support
> it (and furthermore, we prevent late onlining of CPUs without the feature
> if was detected at boot). This sacrifices a lot of flexibility, particularly
> if we end up tackling CPU errata in this area in future, and it's not clear
> that it's really required for what you're trying to do.

It doesn't need to be accurate but then my question is how helpful it
is if it's not accurate. Conversely, shouldn't all CPUs have it if
it's really helpful? So it seems to me whether such a flexibility is
needed in the future is questionable -- AFAIK, there are no CPUs (ARM
or not) that have such a behavior in the present. I agree we want to
try to be future proof, but usually this comes at a cost. For this
specific case, we would need two functions to detect the capability at
global and local levels to fully explore this theoretical flexibility.

The bottomline is I don't have a problem with having an additional
function to detect the capability at a global level. Note that the
specific concern in this patchset is that if a CPU thinks all other
CPUs have the capability and clears the accessed bit on many PTEs,
then those who don't have the capability may suffer the faults for
that action. (This is different from the cow_user_page() case.)
