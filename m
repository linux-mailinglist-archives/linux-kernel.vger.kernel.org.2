Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF9413D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 00:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhIUWYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 18:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhIUWYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 18:24:08 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8886C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:22:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 62-20020aed2044000000b002a6aa209efaso3576459qta.18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=Q20iEess0fifQ1UuQbXOXFqiUUzry/ZTlIcm76UAWxM=;
        b=JfW08WvwR5NppuckDbGBjuYm/qfKFPNTAZMbHjE/W+axyhP3dc87K2dMjwCziGbrNR
         5Qhg0J8NmGL98SrOSvD9+8fWKrNBvaBv4Bb712hBTDXdcAkjRaecIZM3yTmnh/YCLd1j
         j4567Vp0WodpV5fuJ38h92olkRvx4Hh61wgCKUVTrypmncIQgF7Ri1gQk00SQi/HSyow
         FU9+od8W/IBrgXjkjHAVl9RVO+lIOxAvuEQlvTwimT1f12eK4eJcULYfQ+OhzITQA4SX
         BCUUCMylJy5CnztKQ+q2PhL/PAPjBBJ/v0LuXubz46t0KKEapi2MizSOXqYgukZgXHs/
         NGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=Q20iEess0fifQ1UuQbXOXFqiUUzry/ZTlIcm76UAWxM=;
        b=ruDiwTjSQwEs4DsNNG63qbWDRvHqC6lYVmRXD05tCsyRDD6ANHvaRWXOQ8SkCc8mCB
         5XBpWKvMtOsZ2aWjVWMc8zAv7VkU7/m6Tsqev9XgzGvsXDgPQMmoJ2KnYDHNyk3URQHc
         hLJO5Yu0lT23bku7ue8JzokD046iJaQcpeTeogyzj8e65xDKg7opqe10V3j9STZ2poc4
         OifCB369zFjAJcIECTlmb1vEeJeWAyZaVxtJ77U/fDcNUu50QFVLUhuQwuhvFnuJYMKY
         wfG9OLyw9rWtv+otw0lFFPDajw/yqDLWKBGiGUBK99YrNOzBhHmkLEtkvDPC9ajRFi29
         S3+A==
X-Gm-Message-State: AOAM530s0T9gFJrVQv93SagiHv7jy6gPauHCCU0Zl7alAZBf1skBiuws
        +3q+JEK2I9t3CD2se++5WOWcdWkjgfE=
X-Google-Smtp-Source: ABdhPJyWLleGn2Q9uDNlTmU74iPlGeJ9AoH7VeL2KdOBb7ybZB1A31L8xwxPOwizMhE7GlKn0cZbRD9sBg8=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a25:ea51:: with SMTP id o17mr38809433ybe.192.1632262957862;
 Tue, 21 Sep 2021 15:22:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 15:22:29 -0700
Message-Id: <20210921222231.518092-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 0/2] KVM: arm64: Clean up CONFIG_KVM vs CONFIG_HAVE_KVM
From:   Sean Christopherson <seanjc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an oddity where arm64 can end up with KVM=y and HAVE_KVM=n.  This
doesn't cause problems today as no generic code that supports arm64 uses
HAVE_KVM, but that may not always be the case, e.g. I stumbled across this
when exploring hiding perf's guest callbacks behind HAVE_KVM=y.

Sean Christopherson (2):
  KVM: arm64: Unconditionally include generic KVM's Kconfig
  KVM: arm64: Depend on HAVE_KVM => OF instead of directly on OF

 arch/arm64/Kconfig     | 1 +
 arch/arm64/kvm/Kconfig | 9 ++-------
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

