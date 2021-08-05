Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8727A3E1EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhHEWlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhHEWln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:41:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA43C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 15:41:27 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u25so9474330oiv.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6BTOjcwKtKl0uQi0y8Ng/8QeGorP9K0iLhSOOFlArw=;
        b=QaHjuew+SIOlrssVbOYT0yWUXJGg0GXSpEcSq01oThCukuydoXGMNJ+aYOKtFOZZ8V
         0l+MJWKPubU4yWxEnDYYtIPrjvHBVapwuLp1lzuld7cFgQwLFVt0TjKjrKjjSYSMeN2s
         2a/j4uEILP+krg3gNJpyArZkXie5smI2nnc1WWY6Q75XCoxwof7qfNS6zE5q36tWL+g9
         Q4m5hE2BPofrCNQeHmmixvWevrtp2CZzOfKuIArb1oZC4s41LdokuitbV4mfBBq5k49e
         hkiUfanTbhpRFiUoY0PpCSEzwtNn6RP01EtZLjuQ8/IRFfeZOnmUqKbOezkadebBihE+
         3HGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6BTOjcwKtKl0uQi0y8Ng/8QeGorP9K0iLhSOOFlArw=;
        b=idzrYNHzAA179IOXHCUSwdex6dvDoKqVb9WrIsnxlnicvdf6RbtC0k4J94e0exwGpU
         rwzZ1BGTX6UGB6ZJx+U68JHXjmBygyYLAQVaT3e4wOyvxfn6vGmo1b5ZlnNLr3cbQEJt
         920vfc2hA4zGOXzKxV7rhigTXvJ6xQQXx12KhvrYNC053vATeTnxUSHQORmRLMRDDq8O
         H1hWpIvRfe5m1/wsq/brYhL3sMJvMRAyb7PWivJiNU3HGEug3eX0m03O2ToVsa5TcZMl
         KViAL7KcYAlepM/G3LyRE8+FJKud8ywQ1LmbC+BF744r4VR+si4GQhhk0Dp2w2EPWeOV
         HS1A==
X-Gm-Message-State: AOAM530MnPI33QjGAcihEVjj7EC982/RNCwUoR9cU89nkqhVkCUz8Kdg
        lZfIxibNknDP1xGcJjiyAC898QyaptvuvGbWg70zXg==
X-Google-Smtp-Source: ABdhPJwvo6Dlk68BubLUOKlYbKPP4T0XkImWMs4hnKt+7rmO5CD9g6pn8afWlK1rdkN+6LKPiOgB6s1KlUGlJ8DtN/4=
X-Received: by 2002:aca:6704:: with SMTP id z4mr13052848oix.13.1628203286750;
 Thu, 05 Aug 2021 15:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210805151317.19054-1-guang.zeng@intel.com> <20210805151317.19054-4-guang.zeng@intel.com>
 <YQxns0wQ74d4X5VD@google.com>
In-Reply-To: <YQxns0wQ74d4X5VD@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 5 Aug 2021 15:41:15 -0700
Message-ID: <CALMp9eQ-ZQQ36F9ffTL7Y=r_2k-wzFjade--3TKBwC2vomH2YQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] KVM: VMX: Detect Tertiary VM-Execution control
 when setup VMCS config
To:     Sean Christopherson <seanjc@google.com>
Cc:     Zeng Guang <guang.zeng@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Hu <robert.hu@intel.com>,
        Gao Chao <chao.gao@intel.com>,
        Robert Hoo <robert.hu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 3:35 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Aug 05, 2021, Zeng Guang wrote:
> > +u64 vmx_tertiary_exec_control(struct vcpu_vmx *vmx)
>
> Make this static and drop the declaration from vmx.h, there's no nested user (yet),

I assume that this feature isn't actually virtualizable, since it's
based on posted interrupts, which are not virtualizable.
