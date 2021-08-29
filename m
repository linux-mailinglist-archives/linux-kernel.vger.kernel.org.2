Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB73FADBF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 20:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhH2S1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbhH2S1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:27:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A3AC061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:26:44 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 32-20020a6315600000b029023caa2bfec4so537363pgv.20
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=0s+J0FoTz000T0KyOSCIu+jqJcGw7rB/F2gcU8W68SA=;
        b=LJl8g3525LcIzsqI/sC3r/SovHCtB1SDH0oE2B53z1RfD+D2KTwaB6D4NRtP4lIqfE
         2MD0KNSDRDMuEjO1ByRNhIog77+Tr7SPo+Mi/uUNHucoqM8Vek8TB/XDPYOXcJfqBeUA
         xcFqmM+J4pjMSzWEY9mNgVuhIizIw5uUg3rCwkY5nrJInDuqpo0AAG63G9fyQK/XFB0Y
         ve9G3I4hgkjX6f5cllz1ipiDu60591I6Zy+qrA7S5tw3HtoQanQxuy8bQtMbQBhQ3ub9
         Uoj8ZWZ4/DdDb9cQLRYkqoIJKUkNzxjlq0C7eIqGHBn1kfmFK0kpu60PHKRRUkZMYTKJ
         GTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=0s+J0FoTz000T0KyOSCIu+jqJcGw7rB/F2gcU8W68SA=;
        b=t+pT79w3pagsA5mAKEg6GF5zzbCrLCnS0cnb0LQemWPCQwutUA24ZrC4aiMynj+lMI
         C3pkSJ3AlTbdpqzuNgXaA5G/ggd8urYUEOpXCwVK9FaTU+sTx0uI3Nm8CuufnGZPLd09
         1EKBtvSMMASEejGkHPcKOYlNeznc+zRrDi1+6+rAu/t529Kp2GnRX5UQKXXpG3rJMIp3
         nIDjrwSifVOjTpzH/A6H4hfsVmp3ejsqQmP0zHWSql66xNM2lmZzYfUWP3hPuBs164kQ
         Th2LntCK5xL3F9xCvkUJJLJl3IMaaSififnDqz1U2sNXarjRJyJVcs/mJxFUgstghI83
         hqqQ==
X-Gm-Message-State: AOAM532rHkZR7NOca0lMvaGkXEbkdZkl0vCVR96fyea5jp/BnJvAN7I6
        TTfg79mpqO+gwZGuoqmZD/64Z7pAf3Q5
X-Google-Smtp-Source: ABdhPJw1DU9dSesfkuwP2zEXSBFs/W+wjmB/LzckxIfSnQqdDinIdpfKRCrYKbAo9MFuqATvXzM/2ZxEb3ZB
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:902:7145:b0:137:2e25:5bf0 with SMTP id
 u5-20020a170902714500b001372e255bf0mr18171121plm.10.1630261604164; Sun, 29
 Aug 2021 11:26:44 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Sun, 29 Aug 2021 18:26:39 +0000
Message-Id: <20210829182641.2505220-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v2 0/2] selftests: verify page stats in kvm x86/mmu
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Peter Xu <peterx@redhat.com>, Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set leverages the existing dirty logging performance selftest to
verify whether the page stats work correctly in KVM x86/mmu especially with
the consequence of dirty logging.

v1 -> v2:
 - split the page alignment fix into a different commit [bgardon]
 - update the TEST_ASSERT conditions [bgardon]

Mingwei Zhang (2):
  selftests: KVM: align guest physical memory base address to 1GB
  selftests: KVM: use dirty logging to check if page stats work
    correctly

 .../selftests/kvm/dirty_log_perf_test.c       | 44 +++++++++++++++++++
 .../testing/selftests/kvm/include/test_util.h |  1 +
 .../selftests/kvm/include/x86_64/processor.h  |  7 +++
 .../selftests/kvm/lib/perf_test_util.c        |  8 ++--
 tools/testing/selftests/kvm/lib/test_util.c   | 29 ++++++++++++
 5 files changed, 85 insertions(+), 4 deletions(-)

--
2.33.0.259.gc128427fd7-goog

