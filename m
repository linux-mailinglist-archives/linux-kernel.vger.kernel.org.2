Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72633C392
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhCORJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbhCORJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:09:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:09:10 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k2so34208288ioh.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PM0AOv7hR2q7y6qMzYZR/71bbo2GAhaoJjNSG+Jn9vI=;
        b=XPVddlj/y9FfagcJIbWAAqZ3K8DsC1HETVSpnea00/4CXVu4LWPuBklrfJjIaw5r2g
         PoVpawn/vSW5ZDVCgGFCI3w6ubw86AtUhIBdr1DoOrF/ZVwV3/ImN9I3kTp6RjGPR7cT
         Clyo/B4oGI8gyDMlwW31NFSz5gFoQOtG+yN+L8SN8fzkDRWJkxRN8FH/DX7QRCTCxM/A
         oNkMos357ahqhb7wgx7eqQnBAupzYwqY9NgJn49bt73nQdn5FvAI8RBsygXvvtCOAEz3
         XBJY1JQf58qtNMP6fCZKOHfyWXh7Fi2CKpYzg60DlMt9MFRLA7AlxjgDy/vD3j3ytDF+
         Ex6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PM0AOv7hR2q7y6qMzYZR/71bbo2GAhaoJjNSG+Jn9vI=;
        b=HItHvnbzOadPmL0M/3lqoS7mL7ANeoDh59zo85GiXP4AqQ7qjOsy/ZfyioVD+28c5/
         Y+brl/V970dM4rbEDpDAvIuX3DqcbOS2MQaMA2vV8qZGRz0sq8n5Uios59Ov/PFIlhhM
         mVhwt1r5U4IV/YkbtsHRF5K0B8OIQC3wdanEuXbK13SFdEDJJWF/cnfYcNfNwWPOdwRK
         cLVgVaVsXGdXS3LRVazn5tfsxyxXlzcfTB6FF1rx9Bb9gvVBpGyHvnLLI9l1T+GhREc+
         Zt6VdmWPfYvndypWItI4oTknbs3Cizim2OmPGhe8hPfvcXvtq2askzcaBGVRsBCnV/6x
         kLAw==
X-Gm-Message-State: AOAM531+cSI7VdCKxeOaLU559swTjzfxpIQn9n1eRPFjIYWexw4V2ld7
        T52ooJbOJUgibrMcug2nKl4zp9coCO4ch3lb6HQg9w==
X-Google-Smtp-Source: ABdhPJwo0RLf07s4jCWFCOBKdsbS3gt1d6KD2G+UGPHhDUd6hNzjV9TWdeVk+RyqVLPTMceCsBlrLVTGl4DHnqIUjVc=
X-Received: by 2002:a6b:7f4d:: with SMTP id m13mr426365ioq.134.1615828149903;
 Mon, 15 Mar 2021 10:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210311231658.1243953-1-bgardon@google.com> <20210311231658.1243953-2-bgardon@google.com>
 <YEuKx6ZveaT5RgAs@google.com> <cc472f99-f9f0-8a63-c38b-31a650b4a39c@redhat.com>
In-Reply-To: <cc472f99-f9f0-8a63-c38b-31a650b4a39c@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 15 Mar 2021 10:08:59 -0700
Message-ID: <CANgfPd9SeD4Vt3MW5HsipvrZmYsO8XyP4bU=ni7u8Ws84rXKzA@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: Fix RCU usage in handle_removed_tdp_mmu_page
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 7:43 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 12/03/21 16:37, Sean Christopherson wrote:
> > On Thu, Mar 11, 2021, Ben Gardon wrote:
> >> The pt passed into handle_removed_tdp_mmu_page does not need RCU
> >> protection, as it is not at any risk of being freed by another thread at
> >> that point. However, the implicit cast from tdp_sptep_t to u64 * dropped
> >> the __rcu annotation without a proper rcu_derefrence. Fix this by
> >> passing the pt as a tdp_ptep_t and then rcu_dereferencing it in
> >> the function.
> >>
> >> Suggested-by: Sean Christopherson <seanjc@google.com>
> >> Reported-by: kernel test robot <lkp@xxxxxxxxx>
> >
> > Should be <lkp@intel.com>.  Looks like you've been taking pointers from Paolo :-)

I'll update that in v2. I was a little confused because I was looking
at the report archived on Spinics, where all the domains are xxxxxxxx.
Didn't notice that all the emails had been redacted like that.


>
> The day someone starts confusing employers in CCs you should tell them
> "I see you have constructed a new email sending alias.  Your skills are
> now complete".
>
> Paolo
>
> > https://lkml.org/lkml/2019/6/17/1210
> >
> > Other than that,
> >
> > Reviewed-by: Sean Christopherson <seanjc@google.com>
> >
> >> Signed-off-by: Ben Gardon <bgardon@google.com>
> >
>
