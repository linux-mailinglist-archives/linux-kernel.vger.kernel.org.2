Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB203FE54C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbhIAWL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbhIAWLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:11:24 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AE8C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 15:10:27 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h10-20020a05620a284a00b003d30e8c8cb5so989690qkp.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=ALl97lKhsbxJ/NiiAvNW+lyq6xZyCyUk+3VnN2UOJAA=;
        b=PhyJtRw/19bMj/3oy9PlGHHbFe4J7RbPe7eyKEJfjET0e0J4UVbE72Cv/sGgJZxSkZ
         EXPXMgPnNR6/TKiaON5k3jlvp+8xCctCPbpzzugG5Q2izHFPWUH8OKxnjP25nkwiArVF
         5FQI6GS63tNLwkgEW78e6oYmCK47cOVMBWMdFvxtQT0IFOzWkRc46zYiG32ABKP7rc/z
         ZOK7YER3+j/29k7iHEMYZ5hAYWlY/Q4MJL3aFA76H+iJ7FECKKi8/2M0D2r3yBWq9s2D
         O9qiGkQVibiVP54M6JeSd75bJ02Robd4iOE73+HZkrzdjGgaj2BMibNqbj/yTHQOTPHV
         J+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=ALl97lKhsbxJ/NiiAvNW+lyq6xZyCyUk+3VnN2UOJAA=;
        b=RYeWql+aQ/EEU14b6nCwu7z7g95g6t+TvrMrr6hYmmNROfxZBDaPOZFax8CGSkvmdd
         t0y1NyzjoizRROFw/LsYS3Y1Ne9EpxcPvulqZjeVDWs93nrtWH/MAPdt4ZAQxmLQa01N
         AvPG5T/CJNfwDFWgZUxLYc2IJ7MK/OJDu4eEexobwthd7Vvs6RGXlQg4oAiUiaGp2UaK
         S/K3hjGucPGX6W7Ov1qZRO9G/6TLPkLbekMCIO+T9ZI7yZOo7XIIuLqUXzUtymHbkngz
         021UVMr+VunhPXDDx3TwUHpXbsdtVcTLfPK50SkUvzwkpbVDAB5BfEkOa2mip/rSdjWz
         YTMQ==
X-Gm-Message-State: AOAM5331Ky7jsmBIUcSrcj9Zf5YpocWjYxas6yW1QB+eyhN3KP0QiRok
        GE+Cix/mzXI/duGPrnXjBCEBOaP9+gc=
X-Google-Smtp-Source: ABdhPJy2XduhtgCTgV3BaVLkTfU4bAudbwfcIULDKv3cwvK7W9UX0UY+9kA9Gimfys/Z1VWA8xfmQqI24Ao=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:9935:5a5e:c7b6:e649])
 (user=seanjc job=sendgmr) by 2002:a05:6214:c87:: with SMTP id
 r7mr2088190qvr.2.1630534226644; Wed, 01 Sep 2021 15:10:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  1 Sep 2021 15:10:20 -0700
Message-Id: <20210901221023.1303578-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH 0/3] KVM: x86/mmu: kvm_mmu_page cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 is from Jia He to remove a defunct boolean from kvm_mmu_page
(link[*] below if you want to take it directly).

Patch 2 builds on that patch to micro-optimize the TDP MMU flag.

Patch 3 is another micro-optimization that probably doesn't buy much
performance (I didn't check), feel free to ignore it.

[*] https://lkml.kernel.org/r/20210830145336.27183-1-justin.he@arm.com

Jia He (1):
  KVM: x86/mmu: Remove unused field mmio_cached in struct kvm_mmu_page

Sean Christopherson (2):
  KVM: x86/mmu: Relocate kvm_mmu_page.tdp_mmu_page for better cache
    locality
  KVM: x86/mmu: Move lpage_disallowed_link further "down" in
    kvm_mmu_page

 arch/x86/kvm/mmu/mmu_internal.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.33.0.153.gba50c8fa24-goog

