Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F274C436CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhJUVqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhJUVql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:46:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63B2C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:44:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y26so618924lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mymsjt3IaF1en1RXeUqLwvBY1YQnaGAGlUG+m084SWc=;
        b=qQhqVoSdEtJuPajOvdfoq4/zKjo9wDMZqOKgOF4nOQL7fa/7uK4HKjrubqGLx1jiMy
         I75yrFSWzVGue8mBSbRHRzXi9gwKqLbWt9CRDQJS5e3osuMmfKqpv2Drn0dEeZrMbxx8
         hmgfrmqzmOzlPnPKsBSREWVRMQo7HuVX1crSSO0qCceio3WhQnpsJr61UpVKNxd+w5ES
         S62W3mqlisibwvdCoRNOu0/wP9oP7Z8O3qTk3fgHGp16gqNRGQXCf2nLix9vIKbrxTJj
         k+n9vOMzkGTG+krc+bMRQMpgjlhBMLkxhYNhQaDJZT1TQqZJpsSNtzKOcUw8x/WOaTme
         lKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mymsjt3IaF1en1RXeUqLwvBY1YQnaGAGlUG+m084SWc=;
        b=VBLKhXkVjvuwJ8ar74deI9Kp2ZBlIDMWNtWP17HIU0D6wXpA/PDcllwj+4TmUA7LLi
         kZHn0VkhSD2xFRM8mZOaG4lMhed8ZpaQC5W5ykKYkvQkfUMZBq4kj/lhBZ/xXLgpEDyb
         5nNcXzrdQBfO+aN7rsff8Gh4zkoHBydktWT7VF8yVs4qXTSdseghiO9ooHGpgSQV9tar
         K04vLHukynmO4PiJsakwrDkW4SkSvKi+vqtF6eMzY9Zwca7+Hszn9z///ldkiYcb7iw7
         uwgxWAPGMKGiR/rCy2ejgYdHSV/qLtBc6E1GRR6ZtS13eeXS8DLzLdgcBktkmQUQQB2t
         +6xA==
X-Gm-Message-State: AOAM5308IozBqbEG+wLXFMV/gE/GRRQfHu48kvnFqifv01nw8QIQQfbc
        kI/lD70DaRhH4BdvAUuuqoXDTdPDV++VDSiRVaWHLg==
X-Google-Smtp-Source: ABdhPJyfgTLfySooP/GEpoD7UvNFdaO9xousg9a3yJbvR38aXYXvfTn68FqC9VOTAr+MU2ByznIP66S02LWpxMXOyvA=
X-Received: by 2002:a05:6512:a8d:: with SMTP id m13mr8064660lfu.305.1634852662938;
 Thu, 21 Oct 2021 14:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <75afef2cdfc3166b2ef78ad13e3a4b1c16900578.1625186503.git.isaku.yamahata@intel.com>
 <CAAYXXYyz3S_cc9ohfkUWN4ohrNq5f+h3608CW5twb-n8i=ogBA@mail.gmail.com>
In-Reply-To: <CAAYXXYyz3S_cc9ohfkUWN4ohrNq5f+h3608CW5twb-n8i=ogBA@mail.gmail.com>
From:   Sagi Shahar <sagis@google.com>
Date:   Thu, 21 Oct 2021 14:44:11 -0700
Message-ID: <CAAhR5DG-__2YfHjMUQ8hPdxJt+kDEbuvToEEcOFPPuF7ktd1Bg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 66/69] KVM: TDX: Add "basic" support for building
 and running Trust Domains
To:     Isaku Yamahata <isaku.yamahata@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Erdem Aktas <erdemaktas@google.com>,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Chao Gao <chao.gao@intel.com>,
        Isaku Yamahata <isaku.yamahata@linux.intel.com>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jul 2, 2021 at 3:06 PM, Isaku Yamahata
<isaku.yamahata@intel.com> wrote:
> Subject: [RFC PATCH v2 66/69] KVM: TDX: Add "basic" support for
> building and running Trust Domains
>
>
> +static int tdx_map_gpa(struct kvm_vcpu *vcpu)
> +{
> +       gpa_t gpa = tdvmcall_p1_read(vcpu);
> +       gpa_t size = tdvmcall_p2_read(vcpu);
> +
> +       if (!IS_ALIGNED(gpa, 4096) || !IS_ALIGNED(size, 4096) ||
> +           (gpa + size) < gpa ||
> +           (gpa + size) > vcpu->kvm->arch.gfn_shared_mask << (PAGE_SHIFT + 1))
> +               tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_INVALID_OPERAND);
> +       else
> +               tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_SUCCESS);
> +
> +       return 1;
> +}

This function looks like a no op in case of success. Is this
intentional? Is this mapping handled somewhere else later on?
