Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45D3C1E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 06:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhGIEkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 00:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIEkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:40:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4993C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 21:37:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so374546pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 21:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/LklQaJdTOXWeUT+mprxaDKrVkD8A9UO7oJUzmViNQ=;
        b=BG8tocLa4Fc6GVIjbj/83MmQ562w43ne1yivFCQz30vkd1c2tWv5D71ctj9JMn0a/s
         3wZbh/hEhgz+vSrVvnrhuxUH9Rizx7klC2gPGSSX658M5KU/uGIgxQsLZ4tLgMU56Apd
         b3soeKez7tuOdGuGTWH0hrCgVZXgsByXKESZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/LklQaJdTOXWeUT+mprxaDKrVkD8A9UO7oJUzmViNQ=;
        b=WReZBr7skLHJaOJOJixcH4zEJqV6b+BxLucD+paKbzxQyMSybw+0lvM8BrikGhFehc
         pJ0UHo+3XyFv6NOkZJBb3eQV2mbxrfmETybOykcoWmyC1acRDa8BarWZDOEjv6FAbiwO
         AmaF8xBr1r3M+q3UYqPNvtDdENzDqRi7q+bECihrWJerpzjrFsPvOQAks8tzq6OggcmN
         sNK2e9jsUw7wII/X8ya01UWuhCr13IBmnTlYxeNDXcj0Sx4cNsf0p7nZnkaTjNlz6D9F
         HZnqsgolUyfH0Qb9hY6lUdogoHmlX+fpBI8qd0NkkCR2uJvwrIZH/co2vzBZAbKM+0Jv
         eAJg==
X-Gm-Message-State: AOAM532quwSazLzpGYDdnQUUjBBi+3ZAjT+5oaiw4QDUsQKDxvum2W26
        UdFoaUv6lFRgOYTCIKG3e394Zg==
X-Google-Smtp-Source: ABdhPJwQ4+9mQudHLFskGBug4FzGh1FHXv+U9yzd3L1gcLu6YE9FOXHurMSqd0ktQwQkYJA/TWJ0/Q==
X-Received: by 2002:a17:90a:ff0d:: with SMTP id ce13mr2922178pjb.157.1625805453217;
        Thu, 08 Jul 2021 21:37:33 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:a30d:fc4:7834:ee08])
        by smtp.gmail.com with ESMTPSA id y4sm4420760pfa.14.2021.07.08.21.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 21:37:32 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Suleiman Souhlal <suleiman@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/4] arm64:kvm: teach guest sched that VCPUs can be preempted
Date:   Fri,  9 Jul 2021 13:37:09 +0900
Message-Id: <20210709043713.887098-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch set adds a simple vcpu_is_preempted() implementation so
that scheduler can make better decisions when it search for the idle
(v)CPU.

For sched benchmarks please refer to [0].

[0] https://github.com/sergey-senozhatsky/arm64-vcpu_is_preempted

v2:
- 5.13 rebase (static calls, etc)
- simplified and reworked some bits

Sergey Senozhatsky (4):
  arm64: smccc: Add SMCCC pv-vcpu-state function call IDs
  arm64: add guest pvstate support
  arm64: do not use dummy vcpu_is_preempted()
  arm64: add host pv-vcpu-state support

 arch/arm64/include/asm/kvm_host.h | 23 ++++++++
 arch/arm64/include/asm/paravirt.h | 19 +++++++
 arch/arm64/include/asm/spinlock.h | 18 +++---
 arch/arm64/kernel/paravirt.c      | 94 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/smp.c           |  4 ++
 arch/arm64/kvm/Makefile           |  3 +-
 arch/arm64/kvm/arm.c              |  3 +
 arch/arm64/kvm/hypercalls.c       | 11 ++++
 arch/arm64/kvm/pv-vcpu-state.c    | 64 +++++++++++++++++++++
 include/linux/arm-smccc.h         | 18 ++++++
 10 files changed, 248 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/kvm/pv-vcpu-state.c

-- 
2.32.0.93.g670b81a890-goog

