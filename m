Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7E3DAB87
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhG2TBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhG2TBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:01:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B9C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 12:01:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id d73so11822368ybc.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMRycNlt7ES7kF6ezVUYuskwJ/T4IKJjcQobjR4RSD4=;
        b=cFpi1M7qYM3XfdgHPKkC+vm6dZjwvdn3EfcqmOIMjLRz4TQ3UIZKJjUYKMD3Fokfje
         CpDCFZnH22rDjKqdDFAnPE7Gv+TC8SgFU7u5Kbtpkl6AO1H7ZzasMqae45NlY+mD7DlR
         unyPSHCscYq40R6qTALdXsIeSQ8vhRHr6aAJJuEsVkqKjT6WSkBTey38Tc3dRUFZgdJK
         i5GMfbKdEeEz7U8FjuylRaqKXdxsrSeIakRGyYZs81CWJrmr2K7cvUspdDvg7TDn/D8x
         jKlvuhH5+OCt4K47XyjlkrQx7o5ut8imc67k+/jnhp8N5qDYMfFgtxByJ56kpcQQb7d/
         8PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMRycNlt7ES7kF6ezVUYuskwJ/T4IKJjcQobjR4RSD4=;
        b=htJw+V2B6fgXaev+SKxTtIs+yDkv09cvHU0xEhzhIzG2uOmK8Jp2sd2q8sesaGn375
         1UNXzDK/vgIW9u8NouARCYeRvNjww3Pfb2zSH09W69UOFsWpiXTBYigvZJfoQtzpzRfJ
         pZ/bf2n5aGQ0RlgMdcj+EwyDukZhayxAbF8mwf4omZyXSuLR2IpyYnphSos0gZRCBxrk
         OehBFnLxnHNAUJ2hvoyIXPCX55REn0exXLAqdro419PvlsJVT/vjISFb6fmRthktB8tD
         HOacSwMIcFRChIJTdTHIPM3+Cg+uRU+UX8VjIJonEFcnZtZwKcJJxRFH7cDWvCHS68oh
         VZVA==
X-Gm-Message-State: AOAM530WUR48EvdE3LtMIytMxxDr2e+YRfz6SBlX2bdaFbmB4ngAkiTF
        Z3vdKCJJ9dR2RVtVzDjHdn+m2naQ25M5sMY/r2gsRw==
X-Google-Smtp-Source: ABdhPJyg/YetziUGJSaXot2KuqGgbTVvVtMmN3N1dHm1mUYPErYLJSr1M1/cI9c92eqYrHnoUX63ULDib3cCo6sf7Fo=
X-Received: by 2002:a25:b708:: with SMTP id t8mr8963591ybj.139.1627585271495;
 Thu, 29 Jul 2021 12:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210726175357.1572951-1-mizhang@google.com> <20210726175357.1572951-3-mizhang@google.com>
 <YQL0yjwYzJKJ0pTe@google.com>
In-Reply-To: <YQL0yjwYzJKJ0pTe@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Thu, 29 Jul 2021 12:01:00 -0700
Message-ID: <CAL715WKwFAPAFfZr=tEoW1QFLFosCtmstLskqxTKjiNZGUK-jA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/mmu: Avoid collision with !PRESENT SPTEs
 in TDP MMU lpage stats
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oh, definitely. Sorry for the confusion.

On Thu, Jul 29, 2021 at 11:34 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Jul 26, 2021, Mingwei Zhang wrote:
> > Factor in whether or not the old/new SPTEs are shadow-present when
> > adjusting the large page stats in the TDP MMU. A modified MMIO SPTE can
> > toggle the page size bit, as bit 7 is used to store the MMIO generation,
> > i.e. is_large_pte() can get a false positive when called on a MMIO SPTE.
> > Ditto for nuking SPTEs with REMOVED_SPTE, which sets bit 7 in its magic
> > value.
> >
> > Opportunistically move the logic below the check to verify at least one
> > of the old/new SPTEs is shadow present.
> >
> > Use is/was_leaf even though is/was_present would suffice.  The code
> > generation is roughly equivalent since all flags need to be computed
> > prior to the code in question, and using the *_leaf flags will minimize
> > the diff in a future enhancement to account all pages, i.e. will change
> > the check to "is_leaf != was_leaf".
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
>
> There's no hard rule for when to use Suggested-by vs. giving Author credit, but
> in this case, since you took the patch and changelog verbatim[*] (sans the missing
> tags below), it's more polite to take the full patch (with me as Author in
> this case) and add your SOB since you're posting the patch.
>
>   Fixes: 1699f65c8b65 ("kvm/x86: Fix 'lpages' kvm stat for TDM MMU")
>   Cc: stable@vger.kernel.org
>
> [*] https://lkml.kernel.org/r/YPho0ME5pSjqRSoc@google.com
>
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
