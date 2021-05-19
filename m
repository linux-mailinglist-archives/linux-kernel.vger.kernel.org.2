Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484533886A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbhESFhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbhESFft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:35:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4AEC061344
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:34:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v13so6358648ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvCMRttPf/TJqIxdmSUmQm/huvf1KSvWFJ4QU8dhZnk=;
        b=CV3ss4X4zAfCIAxywB9c5q8IlVUT1MajJkdkgC6I1ntnX9+2t276blstc5JZXkrArs
         yG6PXbxxCaQ0iHrRO2CTgoomX4v1YH1TnxgirKjmSoB7LwA38t8GXd0yxCpGO+jhizJY
         PCF7+9P80QUYBMoNxT667Bq5uW5JSS98qs6K+3tU79MJ7ztOWwNCN1aL3lBTvIxK8BRi
         dFSxrAvLrdEYdHAsJTz4u1zb1PKZXrbXOPwhtXvEdHbVYsqHgiMf1tfFpDKsdjwxFi9U
         U0rHSGwE7UjiFSnHUbE2LatX+hxDXvouahNkVFQCUdb8bE6cOGB45YagFvOLcXi2IFbm
         oULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvCMRttPf/TJqIxdmSUmQm/huvf1KSvWFJ4QU8dhZnk=;
        b=EI9VEMiPl/vWlypSx6UtKS5S9aS3TpEMZtH53nPzLWI7CNeTbHh26HsEBN5VpJezpQ
         E1Jv7X0ioy63wPJRk+Bi9akSbwHFD78hcNtDPNQQVxiVKKk2myEj+OfwCkTqskTGfS6h
         Hmly0x89Nrk8yEE9Kz0m2d/beAdsLdOrWDpO2FeridsiOm+cc40BtcdpafouAWMa+TtF
         pV6RBbuubBd38QzUcPl0lMk55c3c5OSIN4A4orCHfhWCctIsSAz14Ld6sMw32RAbjLFh
         AIgWaDI6M4JU0D6EjtUzk1deoUy3W0NtaN/a85oCrIElhPV4AUwPSFH9DKvz1x+qTdOr
         PO9A==
X-Gm-Message-State: AOAM532LVnQJfQE5k/CM9CGmJI416EdlQ4orBMf5T2n8VUucS37vuv8V
        M+fTSuvfTY2SkBkGnfCJD7Vk74DHAmzs/85OYL7Iig==
X-Google-Smtp-Source: ABdhPJyo4fL8c9W5UWz7sAEOga5ZdnbLPesZtp5YMsbclajiI+GYH9FAyRMTx+a8zYcjrPDC8/Fb/X6r2ucNAVseJIg=
X-Received: by 2002:a17:90a:6f06:: with SMTP id d6mr9677207pjk.216.1621402466801;
 Tue, 18 May 2021 22:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-21-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-21-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 18 May 2021 22:34:11 -0700
Message-ID: <CAAeT=FzHOCDH3-vZWOx798x6pGekCgjD8w1m8xPbrPh-ddR+vA@mail.gmail.com>
Subject: Re: [PATCH 20/43] KVM: SVM: Don't bother writing vmcb->save.rip at
 vCPU RESET/INIT
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

On Fri, Apr 23, 2021 at 5:51 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Remove unnecessary initialization of vmcb->save.rip during vCPU RESET/INIT,
> as svm_vcpu_run() unconditionally propagates VCPU_REGS_RIP to save.rip.
>
> No true functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
