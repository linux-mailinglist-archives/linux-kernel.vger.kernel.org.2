Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73F337346B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 06:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhEEE2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 00:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhEEE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 00:28:30 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA62C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 21:27:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q2so1058518pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 21:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkdJ7jdjHyuclShdANsqX7WPCnDkiVjMoelEcVTWBS0=;
        b=gR3LsznuyMIGgTZilvyx0JbzPUtgRaDl77q4aHnJG9jj2xRpGmUuKNGJmmDri8x6AB
         1rx+OC3k+00tTkLIB0hsHQr2xUbgzHtK1opdiINI1vQ1MRP1Zt9ppArBgVelELnXR2UT
         VKjYZuOFWLL10Q6ZgngjkAfpOQaYSId/h3eJ3UOTMxiLVycyZrQ6uzZYv1QWVdwp2X1Y
         UVgku59UHziHV0a/0Ukn9h8lWrJ0tMc/u8iqfVnV/a7jsZxhto9jRLq+A0GlU7ib+oGP
         9oX5E8rMCfiMYzBJe1ttxKAvMxK3fdGoIZDfmPLXdNqYp3wl7+HQtoofT7PoZrGXv65c
         mIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkdJ7jdjHyuclShdANsqX7WPCnDkiVjMoelEcVTWBS0=;
        b=oum5PFzbtMw5FXyVqzw9RfYMF42wjYd9y/xKt4fm3zY9HZiyNl/lTYV6pCT/GxCwqh
         6KqEiQ8+xnU8+nj2iOEAOjt1BGgExAVOB476cVVt/9SyApEc9FhHEWZAdPOlmmO+jJlJ
         cHn3FTfdPW8uUZH01xdaKA2dJjzcyrXbVEA/evsWrtX3wUsfwo/VqNoWkufS1BAzwrkj
         3+UMC7EGGiY8gNdP+14UDnh5PVdyrrwRvBAfqQYpzrO7CS3LMr6ROZP08IGbS+C5nexP
         uCjP4k57gkkzJsJU5sSgPMJDM//Vq+M7cTQQLSFfXQ6ijStMusxeMy80uxCHiEzrDuO6
         BDrw==
X-Gm-Message-State: AOAM532x0OPcE8/R5U0MSVCcj3f9QQBI4/IMdt/wli5lFR8Czm7RVdAU
        ZLdkKrhEwPcyPZZE3Rj6EMJ+j9H2seYBI4mGDR9sng==
X-Google-Smtp-Source: ABdhPJza8kErNiYiPhF4FsjxuCaUWp/dAsMXwZIhcTVBemm9n0WZjL+SoMALzGDgzOMRk8qkAZVeoJ4Cn6BCROM7Soc=
X-Received: by 2002:a63:4f50:: with SMTP id p16mr26300372pgl.40.1620188829494;
 Tue, 04 May 2021 21:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com> <20210504171734.1434054-4-seanjc@google.com>
In-Reply-To: <20210504171734.1434054-4-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 4 May 2021 21:26:53 -0700
Message-ID: <CAAeT=FyA_0NDX0BqEkBwXLOY6vm3XfkYJmd9bpRNSza-2i42wA@mail.gmail.com>
Subject: Re: [PATCH 03/15] KVM: SVM: Inject #UD on RDTSCP when it should be
 disabled in the guest
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 10:17 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Intercept RDTSCP to inject #UD if RDTSC is disabled in the guest.
>
> Note, SVM does not support intercepting RDPID.  Unlike VMX's
> ENABLE_RDTSCP control, RDTSCP interception does not apply to RDPID.  This
> is a benign virtualization hole as the host kernel (incorrectly) sets
> MSR_TSC_AUX if RDTSCP is supported, and KVM loads the guest's MSR_TSC_AUX
> into hardware if RDTSCP is supported in the host, i.e. KVM will not leak
> the host's MSR_TSC_AUX to the guest.
>
> But, when the kernel bug is fixed, KVM will start leaking the host's
> MSR_TSC_AUX if RDPID is supported in hardware, but RDTSCP isn't available
> for whatever reason.  This leak will be remedied in a future commit.
>
> Fixes: 46896c73c1a4 ("KVM: svm: add support for RDTSCP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
