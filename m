Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C033B3AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 04:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhFYCGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 22:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFYCGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:06:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA26C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 19:03:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e78-20020a25d3510000b029054f20395eddso2098654ybf.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 19:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=xQRDM6/J2D4eDADoGmWzKeEbXMNF9GLnRB8eAq3RHPE=;
        b=U5LvPm3bp1NKN6H3GMMQT9XJ0K6wZ3vwy+JMC7eEyamYwnI68QEd1BhYqcDd1vrSYn
         b64fVO7ofcgGi5UUoSGZn1wSkljmXULS20gnLAANmN2yldn/LZQV+XcIXLw8+262sQaP
         FUsoMpGgfFHIomPsTeJtOmT+cLHsyyS+fARVocczVg4m8qoRmeBYytRIVp/vM4h0It8y
         TG2lzpnXKyLuQrTz8Wl2M0jSBDjhgCyFc1tQDq/vA171D0oQYBhokkeQk4RY19szjvnn
         4uOj6BUqJHNe5NsFE3ZQVhlzBz3D/ZOrXNXCJiJbRMkuHHOOq0D+IU63e20QVApilkFT
         w7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=xQRDM6/J2D4eDADoGmWzKeEbXMNF9GLnRB8eAq3RHPE=;
        b=laHVL0mlM26TJvjsZkp7Mj/BVEQ2TbdhwEfy+rhja7KvOcS8//fGnI9dG7p0etLtAC
         VW8N0lnmw4B+HDvhQNq85gCYop/nUz3u9DRf2ipLuudEfQMF2DnrXLNjXRGB1zRX3JO4
         Xk9/EDVqR4nlu7/jfH6kaFLWYyP95p+gTwK1s9QSYrPrf2TS1Uktr0iR8Qm69BA1T2fl
         ZU8x6K4paUdsp0PtV2+GKlpiRajGy/cTpdMbHVk4LOdMQroWj2XOsayhkMIEr0jP9KKw
         2JsyOjjMwSqxBehbnBaj8wXqnikArsQuc36cVudqqCWfoETFfnhYR4USaAnBMkGVKtUC
         q+Sw==
X-Gm-Message-State: AOAM532GRPDVKLtli93aDoIiyPE8Rf+fSvxFRlH7xpRlwopFpdUEt+tN
        yfoi+Rx3WAeaUxMQfjXYGY3rOF0D0LA=
X-Google-Smtp-Source: ABdhPJy/Gqwyphk/X48gqsBM/guV09WcDi/cUCG5i7HMh91SdRbyKlGX41wot4Btfr5RxqYWpPYutt0F5/4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:7c83:7704:b3b6:754c])
 (user=seanjc job=sendgmr) by 2002:a25:2612:: with SMTP id m18mr5009365ybm.183.1624586637944;
 Thu, 24 Jun 2021 19:03:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 24 Jun 2021 19:03:52 -0700
Message-Id: <20210625020354.431829-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 0/2] KVM: SVM: Final C-bit fixes?
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 01 reverts the C-bit truncation patch as the reserved #PF was
confirmed to be due to a magic HyperTransport region (how many magic
addresses are there!?!).  Hopefully the original patch simply be dropped,
but just in case...

Patch 02 reverts the C-bit clearing in the #NPF handler.  If that somehow
turns out to be incorrect, i.e. there are flows where the CPU doesn't
mask off the C-bit, then it can be conditional on a SEV guest.

I'll be offline for the next two weeks, fingers crossed I've undone all
the damage.  :-)

Thanks!

Sean Christopherson (2):
  Revert "KVM: x86: Truncate reported guest MAXPHYADDR to C-bit if SEV
    is supported"
  KVM: SVM: Revert clearing of C-bit on GPA in #NPF handler

 arch/x86/kvm/cpuid.c   | 11 -----------
 arch/x86/kvm/svm/svm.c | 39 +++++++++------------------------------
 arch/x86/kvm/x86.c     |  3 ---
 arch/x86/kvm/x86.h     |  1 -
 4 files changed, 9 insertions(+), 45 deletions(-)

-- 
2.32.0.93.g670b81a890-goog

