Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A17331CE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhCICTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhCICTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:19:22 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC95C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 18:19:21 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u1so15263694ybu.14
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 18:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=LHP3MFoVQ43/Gdu+SGGU2Is+rQZvEboJW+kRfZtIQZg=;
        b=v7urjtWEjHOqyhANz7nFw0kaPm9raBppEFnZDYvx7qFQqJzsK8pdL4gt4ZnZw/bHT9
         Cp9xkaguoC80WQZYY9gWD0/uB8xuBN8vwlY60QiSyE8LI20slrRP/qbxo3PuwcVWciAY
         ng31rfT81AbR94iBpRSLzXwObL/sfr6cIMDSLrlukpe+3PG7Oko6cb3o5+OgccuAdctd
         Fm0iWBv2F/fAsngBn+anutmUzokyADBbBbo2vU9nYH6MpnMOPRnx1QNJy4VUVmWwHmHe
         q8qsUi1C5D/6pAqx+yZIa1pNcyo4oHyqbNeySKRCDdab+bM8r+ZLhAsTrOPmH6DBSM3B
         hx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=LHP3MFoVQ43/Gdu+SGGU2Is+rQZvEboJW+kRfZtIQZg=;
        b=Cul44yWVxdYQPbY1ZoWq1duAv+/qAkqx71A5uu/ncQNRQcRd10DpfLW5nJDjXUPuZX
         ldAsvHJjg/ElD/nm8I+yVaD77ONcVjswnHsmwerLpEIZA0UbwQiHg9Btf3MwoLyx+sk+
         E1IP39Fvp+6Ihwi/yUO74PQngY2rfVn17Z7CFQ5oeebVIz0AwtU1SB3dyllJEqBcoyFO
         HK0yVU6mb73QvtQ7+lnBalyMu2p3L1JaWF+P2lGrSnh4VMaqx+lCPNW2cxoLsEsvLLQL
         ffC+8BS3HeHnLvtmdRDhVrVnwD/4hSVVo4ozHvj9iB/V8vnYfeANtupuTjsdPMjoXxGB
         AsCQ==
X-Gm-Message-State: AOAM531y3zI8KUn4XWgG1zmaDJP8VtEYvwQrIaHsFvaKFa6/To4aJYVJ
        vdvDomW8PSQGeQ9L4JNJeWxtvXbCcGc=
X-Google-Smtp-Source: ABdhPJyq27oip7hDkYlMjMkztlsUexbcEDv3n7XSxHWiJPIx5Qg3sDA6iE+hYLdwyQZ/M+0JF+uyBqQmSSY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:8:847a:d8b5:e2cc])
 (user=seanjc job=sendgmr) by 2002:a25:3bc6:: with SMTP id i189mr19775166yba.31.1615256361119;
 Mon, 08 Mar 2021 18:19:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon,  8 Mar 2021 18:18:58 -0800
Message-Id: <20210309021900.1001843-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 0/2] Fixups to hide our goofs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please squash away our mistakes and hide them from the world. :-)

Stuffed the MMIO generation to start at 0x3ffffffffffffff0 (bits 61:4 set)
and role over into bit 62.  Bit 63 is used for the "update in-progress" so
I'm fairly confident there are no more collisions with other SPTE bits.

For the PCID thing, note that there are two patches with the same changelog.
Not sure what's intended there...

Also, I forgot about adding the PAE root helpers until I tried testing and
PAE didn't work with SME.  I'll get those to you tomorrow.

Sean Christopherson (2):
  KVM: x86: Fixup "Get active PCID only when writing a CR3 value"
  KVM: x86/mmu: Exclude the MMU_PRESENT bit from MMIO SPTE's generation

 arch/x86/kvm/mmu/spte.h | 12 +++++++-----
 arch/x86/kvm/svm/svm.c  |  9 +++++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

