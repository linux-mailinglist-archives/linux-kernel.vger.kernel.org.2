Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE022433A80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhJSPem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhJSPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:34:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC8C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:32:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gn3so269151pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ffl8pk9RGcstocogN9PvsC6AWGjD4hHoeEIJ6AobA5U=;
        b=XPxzycokZi44IAMRuO5xBojOvHyLirzpE4NVfUceUTJ8o/qB1XFnbvtrB6u4mAPYLQ
         FpZGKmV4hauxrAO8kCIToZDHGyDII/3L9e+rnxJyWr9EpnLbGsGrkK6tcBtg0syNwhFJ
         TqecIRrfv6FXE6rsed7Q4OgHt7czWMuVEqgC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ffl8pk9RGcstocogN9PvsC6AWGjD4hHoeEIJ6AobA5U=;
        b=MDrgvxem5EexaBZGLkGn4W2Dw8uVp+HuJHUDL4yHs5hOhhaJKfi4WdHBSgVAAAcgEo
         u91k/GtRwkeOzuZAMi5VwNM+GaPI/7Jd8lWl1fiqyRH4gnbI7qh7g8Bi/dA5KjeHxBHv
         CrqY4uLguqfUUZzex7cK8KZ3sef94jOie8hBUscAhgVer5VwK5kH99bShErLArkf0jyz
         DGh9tvo3yKgk9nXRFKRnt+YsJQ+CiZHqWcJRTsEaEQ9mBeHYDbIH3oQIWQUFPQlcFG1/
         k1o2grvib4jD8t0+2zHHmsoR39t19AlOJVLneXCEAtTLWH5Q78rk5nJXJXbfak7Uss4L
         fsEw==
X-Gm-Message-State: AOAM530s/cLVmGtrS7Pesv61D8xrf8rONGFcdqgIbFah0cj1LWOtpAEi
        ebDxeME2HcZXuOqa7ZD5A/sd8A==
X-Google-Smtp-Source: ABdhPJzk/QT0m2+16VoGKLZ8sjfJGeEE7JyXvQchG7LL+mVrhD6rB6eudQWAKg6OTwvQ4B0HqmDbJQ==
X-Received: by 2002:a17:902:b691:b029:12d:2b6:d116 with SMTP id c17-20020a170902b691b029012d02b6d116mr33496562pls.71.1634657542422;
        Tue, 19 Oct 2021 08:32:22 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:490f:f89:7449:e615])
        by smtp.gmail.com with ESMTPSA id v8sm3087474pjd.7.2021.10.19.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:32:21 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        David Matlack <dmatlack@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suleiman Souhlal <suleiman@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHV2 0/3] kvm: x86: make PTE_PREFETCH_NUM tunable
Date:   Wed, 20 Oct 2021 00:32:11 +0900
Message-Id: <20211019153214.109519-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new IOCTL which make it possible to tune
PTE_PREFETCH_NUM value on per-VM basis.

v2:
- added ioctl (previously was sysfs param) [David]
- preallocate prefetch buffers [David]
- converted arch/x86/kvm/mmu/paging_tmpl.h [David]

Sergey Senozhatsky (3):
  KVM: x86: introduce kvm_mmu_pte_prefetch structure
  KVM: x86: use mmu_pte_prefetch for guest_walker
  KVM: x86: add KVM_SET_MMU_PREFETCH ioctl

 Documentation/virt/kvm/api.rst  | 21 ++++++++++++
 arch/x86/include/asm/kvm_host.h | 12 +++++++
 arch/x86/kvm/mmu.h              |  4 +++
 arch/x86/kvm/mmu/mmu.c          | 57 ++++++++++++++++++++++++++++++---
 arch/x86/kvm/mmu/paging_tmpl.h  | 39 +++++++++++++++-------
 arch/x86/kvm/x86.c              | 38 +++++++++++++++++++++-
 include/uapi/linux/kvm.h        |  4 +++
 7 files changed, 158 insertions(+), 17 deletions(-)

-- 
2.33.0.1079.g6e70778dc9-goog

