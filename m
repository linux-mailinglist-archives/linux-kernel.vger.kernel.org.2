Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605B039A24C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 15:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFCNht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 09:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhFCNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 09:37:48 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106DAC061756
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 06:35:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so4673463otu.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSOZn7NeOxtNAr4b0FWuz+EfX/KEGNf2pixj/JYi27A=;
        b=b2ZiPMTMK0z2jIOFY2UNLrgwmt+7m8+y8A0XTLvoF9Z8GLkdoO4vh+/OkwfbxSPOa9
         E+VjhvpG2v0CzpGPM+fdgsMfJOxK5Oiix3ApM55K0ZBCiD8LbTACd1XYnwgDVRhll0XT
         m0UNRuKzJrIHCM1kVtG3vd+9/LMRZJmMAPnyjX2s2+JRUQWawHqxIkTEWxZn8cBzlWKw
         dyYTaRwg6biI8J70RfcYIX0vqQ5VipfmLXwJ8ymiUxSM0bW6iE4lgfFaUmtd888BIc83
         1bvMyhJZXdTr3nnBko1jytmqVKuMNm5N3jiREZuptB+HJ9yM8jb9TWlfxl6hagWc6rGb
         rAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSOZn7NeOxtNAr4b0FWuz+EfX/KEGNf2pixj/JYi27A=;
        b=CXY83gqDqD2APmc4Emf05GTKId11psLWVnJ5LUva3jdE7EYaglHgImPHVtnMsHSjfj
         g+ZwauYKRdDI8nLnODrEI/LZLDr446PcCEonaNKXGhxopkmOuX6eL7DX6SiXI6SBx2lM
         g/ZBbdnoOJeoUtpjKFtWQXOuK76CZdxugtScWlucjd288N4eYi4h3fTtYq71Gw+MkOg/
         YdbCvPkRDmpAm5mfA8QmdBhTLeijNAbPsxLkYrjg9JqvalCjNbE1T4gewKEs/5hd9/DI
         JWIbhk5+sqBeF0kVW0s6b/UUv8vlvF/WEFBN++NlAwyDTcuY5PaOt9moPRJq4XpWhRX3
         tqgA==
X-Gm-Message-State: AOAM532IXANsQRTMfbnfttP+pMCRhtsFRUZXl4QAjrOeHkF8COQ25rN6
        ZlXqKyTX63S5nQZnCnMdfRK5AuXxLA9fDmw4tkPXhw==
X-Google-Smtp-Source: ABdhPJyyRDeU6xsWT9ff4ufDNsEg24ZcRpZFsQAYVpwmpMHnLCT8tvYOzrcQqm8NpZv/XYnKbtEH+GzQCJG5rno+WkQ=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr30221203oth.56.1622727351073;
 Thu, 03 Jun 2021 06:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210525051204.1480610-1-tao3.xu@intel.com> <871r9k36ds.fsf@vitty.brq.redhat.com>
 <660ceed2-7569-6ce6-627a-9a4e860b8aa9@intel.com>
In-Reply-To: <660ceed2-7569-6ce6-627a-9a4e860b8aa9@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 3 Jun 2021 06:35:40 -0700
Message-ID: <CALMp9eSVK_ZszVS83H6vPN1ZY3BqHwK0OKAn_Bj4mUBJBqO4Bw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: VMX: Enable Notify VM exit
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, Tao Xu <tao3.xu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 6:25 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>
> On 6/2/2021 6:31 PM, Vitaly Kuznetsov wrote:
> > Tao Xu <tao3.xu@intel.com> writes:
> >
> >> There are some cases that malicious virtual machines can cause CPU stuck
> >> (event windows don't open up), e.g., infinite loop in microcode when
> >> nested #AC (CVE-2015-5307). No event window obviously means no events,
> >> e.g. NMIs, SMIs, and IRQs will all be blocked, may cause the related
> >> hardware CPU can't be used by host or other VM.
> >>
> >> To resolve those cases, it can enable a notify VM exit if no event
> >> window occur in VMX non-root mode for a specified amount of time
> >> (notify window). Since CPU is first observed the risk of not causing
> >> forward progress, after notify window time in a units of crystal clock,
> >> Notify VM exit will happen. Notify VM exit can happen incident to delivery
> >> of a vectored event.
> >>
> >> Expose a module param for configuring notify window, which is in unit of
> >> crystal clock cycle.
> >> - A negative value (e.g. -1) is to disable this feature.
> >> - Make the default as 0. It is safe because an internal threshold is added
> >> to notify window to ensure all the normal instructions being coverd.
> >> - User can set it to a large value when they want to give more cycles to
> >> wait for some reasons, e.g., silicon wrongly kill some normal instruction
> >> due to internal threshold is too small.
> >>
> >> Notify VM exit is defined in latest Intel Architecture Instruction Set
> >> Extensions Programming Reference, chapter 9.2.
> >>
> >> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >> ---
> >>
> >> Changelog:
> >> v2:
> >>       Default set notify window to 0, less than 0 to disable.
> >>       Add more description in commit message.
> >
> > Sorry if this was already discussed, but in case of nested
> > virtualization and when L1 also enables
> > SECONDARY_EXEC_NOTIFY_VM_EXITING, shouldn't we just reflect NOTIFY exits
> > during L2 execution to L1 instead of crashing the whole L1?
> >
>
> yes. If we expose it to nested, it should reflect the Notify VM exit to
> L1 when L1 enables it.
>
> But regarding nested, there are more things need to be discussed. e.g.,
> 1) It has dependence between L0 and L1, for security consideration. When
> L0 enables it, it shouldn't be turned off during L2 VM is running.
>     a. Don't expose to L1 but enable for L1 when L2 VM is running.
>     b. expose it to L1 and force it enabled.
>
> 2) When expose it to L1, vmcs02.notify_window needs to be
> min(L0.notify_window, L1.nofity_window)

I don't think this can be a simple 'min', since L1's clock may run at
a different frequency from L0's clock.
