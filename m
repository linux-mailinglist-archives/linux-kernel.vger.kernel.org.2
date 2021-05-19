Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9596338868A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbhESFc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbhESFcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:32:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560E3C061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:31:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 27so7338465pgy.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DnmuvHtt1deacPj+Snj8/pH1mY4iAhMVnQylVRRVpd4=;
        b=YOYmwA+DVk1bcQT6/IoU5pCTF3kHLLxBFH9sLDHox2JEITBzlViWyoldStr+ZDARZJ
         jun3TazxYuYvkvEZlOX/H5atpgG6E+5WJ/DMSWdYCQ6DV/WU3ZsqDUikxOiVpaezO0Hd
         LqCqFsm2XEtqeEaTz+hqdLrSHKVFOP1i3FwGbpcfUnydUJpHhfc+sMHuybhReOc5yHRY
         JgAwh5VhnWI/srdEtdRwqPclPGfnlceW/cqUFUZsXEiJsxkAxD7iSpYhlLbumBj04vKX
         Ew91emGCyayOoZi0ap3xiGBS5W4NFCXUUhKdhysToqZjwk+kDkT+rWzY/RTbAppEFIm5
         faCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DnmuvHtt1deacPj+Snj8/pH1mY4iAhMVnQylVRRVpd4=;
        b=n6sTqm40nXubKCZWmH8qsXQAAOgIriohmURa4lFe9kSznr6meripu8W4t5Xul4SbAE
         sWE0bHyzxkQWunlmFAfeEs+vBBlPnrvscfmLsE7yn0QUeMm6ti3LBLPkTGSbKtHltWJ7
         wXk6JOTNnPlVNrU0AWVrS9xpeQffDtIcTJMUEBLYCPmrKZbr+IB904DGcu6uL7TAmnQv
         blBcR/p5hD0dBBpKS+ZcOwsROZwj38AWc4XI2ocsxiWcSCZ74dNYF+WNsNxzViSj3vfC
         tVk3GkmI+FStG1VzpoOftOx5AgrtkhZSSol74y40OSAEF1vWfOP96RkqEPOmBbgTtsE2
         ZcjQ==
X-Gm-Message-State: AOAM531kxvkkMeZDFOh1GIQB0KJ4COHhWiHTULgdh8nKDduXx1L4fSXL
        jI8aYUmIJgUZKjaZxAi572sY1KOCNDByA4kamZONXQ==
X-Google-Smtp-Source: ABdhPJyY8L1qAcYiWqdvUh7sucWMbUwzJ1wGxlGFjyzvD2pl6+Tt+mOnsWwgi3N8b7qFkA8bMEkFqAE2EQrtmOaQOik=
X-Received: by 2002:a63:4f50:: with SMTP id p16mr9103143pgl.40.1621402262794;
 Tue, 18 May 2021 22:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-4-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-4-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:30:46 -0700
Message-ID: <CAAeT=FyD1ueKWW9h9TBwr_WJNmpb0=9z6rrsyP0u3T=g8UNNfw@mail.gmail.com>
Subject: Re: [PATCH 03/43] KVM: SVM: Require exact CPUID.0x1 match when
 stuffing EDX at INIT
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:47 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Do not allow an inexact CPUID "match" when querying the guest's CPUID.0x1
> to stuff EDX during INIT.  In the common case, where the guest CPU model
> is an AMD variant, allowing an inexact match is a nop since KVM doesn't
> emulate Intel's goofy "out-of-range" logic for AMD and Hygon.  If the
> vCPU model happens to be an Intel variant, an inexact match is possible
> if and only if the max CPUID leaf is precisely '0'. Aside from the fact
> that there's probably no CPU in existence with a single CPUID leaf, if
> the max CPUID leaf is '0', that means that CPUID.0.EAX is '0', and thus
> an inexact match for CPUID.0x1.EAX will also yield '0'.
>
> So, with lots of twisty logic, no functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
