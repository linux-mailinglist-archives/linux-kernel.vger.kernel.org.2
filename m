Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE53A8BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFOWcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOWcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:32:51 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:30:45 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so527267otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZakAu6vDnZNEmPvqktyn2oZMAH5BhmuwRP0pEeDFUA=;
        b=jCY7GJXJiumTS0wWAuQQNTFjKplqBjVFn5buIpNjm5wqI4A+WpuvrapJtp7KIemCr1
         ilDivDkTGRUrU7giBkX6lSYiPmOoc15w01fLye2zsTaDR58bMphtwzZDbHXUBx7i/MHq
         +3fi7VdsRBbVX0BFYKIa0P7EeemGUMbadQ5cpHI2Hs0lGUJyxKeUvGflJr45yWAkGZSb
         BE6S3o63B1gyBCepO8lcFAUu9ZgiZuNZBe8V25Dhu2JJNJPc5LUUXe5IhUQDXIlFLk/p
         VauRSOl5CgYVqMZHQt/w7pgfPfGlMVrxZZPvLm4nAawjrpM0LcDEdwj6Wmg9OIl28zLG
         dYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZakAu6vDnZNEmPvqktyn2oZMAH5BhmuwRP0pEeDFUA=;
        b=j5oFxyeAd3TBeHE5x9wh7+e1Kkb4iP3FPa10CtM/MYlXIGz4SRdxVIlWSU9JaIL3N0
         lzTZMKmajW9l0jzV6jFd5862zTYagDcS8bpz20tznREwSQAPtJYlJBXlm9iGk1A6lY11
         1dij6tN/jfZtPZN0EFCh0kg0DySQW6JnMlhmE5XgwAlLs9CZvt0vR5szkYTQ6VAUkBot
         2QZEd2Z1DE6wyz2mVWrXyyqf1fal3LFGnCh8UFsXy/b6jw4ehyCx7zXoatMc8pKVJkvN
         twucip52ChpUoGLJe970F0rEx/etcnE88NkVnzzhgWDVRaE6DbyqQZvTIqTEY/CrN/mG
         ybcg==
X-Gm-Message-State: AOAM530uJJIEAOHA0e/VTceHd8JKL/YsZ/mdoUykrpi8/qdClI8uKRZk
        AN0Gt+o0UV+AxzGiQ0BoNJGE1J9Pe7ffgPF7/SPf3Q==
X-Google-Smtp-Source: ABdhPJw/Imo0I1H0GN748qZZF4Cxgl5NMwVkBTCnbMJblZ3I/aaEBWHp2gzzrASSJ8HmI4myycopyDKSEeTrK++4s/0=
X-Received: by 2002:a05:6830:124d:: with SMTP id s13mr1175538otp.241.1623796244796;
 Tue, 15 Jun 2021 15:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210615164535.2146172-1-seanjc@google.com> <20210615164535.2146172-3-seanjc@google.com>
In-Reply-To: <20210615164535.2146172-3-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 15 Jun 2021 15:30:33 -0700
Message-ID: <CALMp9eRxA0zk9abXp-YwGJwO2QX-EvPfkS=CCCeLKFAcPx7soQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: SVM: Refuse to load kvm_amd if NX support is not available
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 9:45 AM Sean Christopherson <seanjc@google.com> wrote:
>
> Refuse to load KVM if NX support is not available.  Shadow paging has
> assumed NX support since commit 9167ab799362 ("KVM: vmx, svm: always run
> with EFER.NXE=1 when shadow paging is active"), and NPT has assumed NX
> support since commit b8e8c8303ff2 ("kvm: mmu: ITLB_MULTIHIT mitigation").
> While the NX huge pages mitigation should not be enabled by default for
> AMD CPUs, it can be turned on by userspace at will.
>
> Unlike Intel CPUs, AMD does not provide a way for firmware to disable NX
> support, and Linux always sets EFER.NX=1 if it is supported.  Given that
> it's extremely unlikely that a CPU supports NPT but not NX, making NX a
> formal requirement is far simpler than adding requirements to the
> mitigation flow.
>
> Fixes: 9167ab799362 ("KVM: vmx, svm: always run with EFER.NXE=1 when shadow paging is active")
> Fixes: b8e8c8303ff2 ("kvm: mmu: ITLB_MULTIHIT mitigation")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
