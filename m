Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2C33EAA03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhHLSOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbhHLSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:14:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1323C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:14:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n200-20020a25d6d10000b02905935ac4154aso6767613ybg.23
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=PaSEFkv8nY5W54B7TNXDIBLFRXOHOQ5fVhWGiqJIlhw=;
        b=FvTv0MfDjkfbfLUitgb3JrTe3A8KG8l5ZdZ0WBE+5JOHiJrnH56LYlBVYMOhSzleca
         EbDuAQZYD42ab5gfyzzQMq6Hkn4AP/Tpo+jgNxahi/Yik5E4no+yPtPt68yE3z/nzbAh
         rRSTAdWXm4kbPAz+F4GsUwwT25DtRG9mjxHiyKeMX2ZZvWxPebv7gGBcb4z1BjUxiBba
         Z+xk02xo+bVeSOVJElGeu8LU6XQ3CooUuiu5FAEO50SaChzHzA6CEz1cuc/Q5peFjCh7
         2WGdWTtCHyEZJPRisJM6v7D0FsARCvt4fSrE5zgBEs6IwAcI8AGqxvGHzt0yH6vMsK7J
         kMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=PaSEFkv8nY5W54B7TNXDIBLFRXOHOQ5fVhWGiqJIlhw=;
        b=inNo9nGzLBSrkhmUuQ5xkMaNNzC1CRDwpo2LWV5jv7RJmtCD6VYSyBGRp8i9sAQJgc
         CIJR4N1tUyH2tTaLbjsMG/2FA4WBntRcvIRoST+CAuntyhPRlf2AdW1U+/VJyXyexYOL
         d/vlo049hQ1fxCv5PvUDO/FKU7JceAT94WbdRtqN+DUW4jNZBJvzS4BQ+ERAv5EZPEb3
         yP6QE65hgOfGJU9t5kBDpBfvII2MnLw5Fdlo4PsEIykkFgRSJyz1AiN9BxzrKoS54rQJ
         cK8KPiAi3GOoDHKPJGm2A7/LuiS+QnGJwNpY6mgB8eGBNAUKS4vykRNLuicscX4zGnsQ
         EikQ==
X-Gm-Message-State: AOAM530DOps/ISHV/8uzjX46dD4Hinno1PomYvTmMNT1MO2rnLl99pzf
        ebj2zOGjVBZwxur8k4c0rXg4FAD3qe8=
X-Google-Smtp-Source: ABdhPJy+Fj4AxkozJVWqQ1ecr6dzxUVj2Ju0s8v9C3yenHVw7nAymBPFVQNdUxa8M1n4IlckdfsrQnvvAJ0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f150:c3bd:5e7f:59bf])
 (user=seanjc job=sendgmr) by 2002:a25:bc10:: with SMTP id i16mr6048991ybh.73.1628792058982;
 Thu, 12 Aug 2021 11:14:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 12 Aug 2021 11:14:12 -0700
Message-Id: <20210812181414.3376143-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 0/2] KVM: x86/mmu: Fix a TDP MMU leak and optimize zap all
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 fixes a leak of root-1 shadow pages, patch 2 is a minor
optimization to the zap all flow that avoids re-reading and re-checking
the root-1 SPTEs after they've been zapped by "zap all" flows.

I'm still somewhat on the fence for patch 2, feel free to drop it.

v2:
 - Replaced magic number silliness with Paolo's much more clever suggestion.
 - Elaborated on the benefits of the optimization.
 - Add Ben's somewhat reluctant review for the optimization.

v1: https://lkml.kernel.org/r/20210812050717.3176478-1-seanjc@google.com

Sean Christopherson (2):
  KVM: x86/mmu: Don't leak non-leaf SPTEs when zapping all SPTEs
  KVM: x86/mmu: Don't step down in the TDP iterator when zapping all
    SPTEs

 arch/x86/kvm/mmu/tdp_mmu.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

