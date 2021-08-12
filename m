Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383233E9DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhHLFHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhHLFHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:07:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777A9C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:07:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p71-20020a25424a0000b029056092741626so4966918yba.19
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=MGO3eu+69A+3zEDZ0OIrCDSLNnAJOWz2QBEh8ypXny4=;
        b=pMXZOmpnvS5i/V0QAPh96XFOGpXLFSzzsZFeGiZdpqM8zjUrBVg3VKjna/Shb588Dd
         5eIrJCjEVvhGW9j8lBuEC7SEiG5KX07w3I6rnaiK0ONN4VFoycjhmWcFtZmezYMFUEa1
         Nh8zEgBUBucCHVKVFTHWmJuMCAR5LlXJEPkBW8J4P7gFSWHQQpYWTGoKfqU4FkW4zHGP
         oQzFC5ip8cFLwdROTMLXnF7BjwbBII06aFtWRf0aSFQWz4cvV5FukS4mlKb2mlQ3/L5r
         tf7NfvuzDuWJ2CqHrgbbFUavMkc9Lg8cheb0Gnq5sEuKCs1MZ52KmsrKOONvgTmG1ljT
         R7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=MGO3eu+69A+3zEDZ0OIrCDSLNnAJOWz2QBEh8ypXny4=;
        b=noHiTDZFiRV9g+SwwiEKffgZA1jAf8ooLrAnTl7zdVeLYAlAGikGplkS6wQAPoIF3N
         DHgQIOkusNPZ8vOez+tEKm2Z4j9E+Y2dwlCSBxeeAfhqw8vhZQXXzHt6dUSLzx9Fg2+8
         T412pLYv1P39dJs+Z1BN17yi3JcIXUtYAHSdpDszLKUOIoe40RiEAUHbv5MZijRFI3qi
         +EPXIyAl/M14DaOfVo6JK7nWP0s9kCgxMoJHWX+zDeL1k7Vnbe6gMxnT7CzeKaSrKs9+
         MbmEgIrx+iJm9kVbIV5LW33UAYyxcAPWGE/RyZ5wMhFxO2/ucF3m+pgo6+auNi1a/65V
         KWYg==
X-Gm-Message-State: AOAM530OhtFArgt0GJDeYq+BkLJXaWioye5BMtgU6L+OK+eLFNGSzd2Q
        H2ucdXCtx8ncO5TV4XTFJTOWU3F4+po=
X-Google-Smtp-Source: ABdhPJy2bpn5nmxNeT8Kxp75pFIA5BDr6AUwfne0xwi3DUsnVFgvyDYUASTjCG2EcJ8IEGyzufyy5pjy588=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f150:c3bd:5e7f:59bf])
 (user=seanjc job=sendgmr) by 2002:a25:918c:: with SMTP id w12mr2048740ybl.226.1628744840665;
 Wed, 11 Aug 2021 22:07:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 11 Aug 2021 22:07:15 -0700
Message-Id: <20210812050717.3176478-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 0/2] KVM: x86/mmu: Fix a TDP MMU leak and optimize zap all
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

Sean Christopherson (2):
  KVM: x86/mmu: Don't skip non-leaf SPTEs when zapping all SPTEs
  KVM: x86/mmu: Don't step down in the TDP iterator when zapping all
    SPTEs

 arch/x86/kvm/mmu/tdp_mmu.c | 49 +++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 11 deletions(-)

-- 
2.33.0.rc1.237.g0d66db33f3-goog

