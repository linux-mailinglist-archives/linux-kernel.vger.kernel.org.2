Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483FA3FB07C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhH3Epa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhH3Ep1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:45:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B1FC061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 21:44:35 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z1-20020a17090a170100b001966f663358so1458676pjd.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 21:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=oodor33zXZID7+EDPaMLdaXriO6EPtv4VT7suMCPUFc=;
        b=vHTC72Qkrb6zBeLMMn3lBfhsXUQ9UQPyIyegWNN1JXe4ubCVcI3dJim5vcspN65HI4
         jYRqR6eRgMFo2VgQfhPzt9CS66u/TR+Mz4D6jzj61p0bgXmD3ZGS5os4C6fX1EqjViWf
         S7zb7KDy7oemZP4WYajHxwc5FCygHQjIC0PKS+LMY/3DEmU9gmUJfjIpS2MDwz4m5gTI
         cb2UZDG6IRHcYTazEILvCJBP0XN6Yp7MqmPUfpMr4lXNJLB5TF/1UTgX6sRUiQwaWq+x
         9XEga/8HZSLEjA7hiXTM5WD90JR9/7SZeqDDODXEDe7mLh4sEJCJC5MxHbJbWid/+E+S
         iguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=oodor33zXZID7+EDPaMLdaXriO6EPtv4VT7suMCPUFc=;
        b=kxO8mo1HYo687//zmc0LFO4ESyKoCmUQsML7J8xMro99tXDYoDGCuPwWN1zas7GC98
         RAn/JDIZagdk93zZRQNv0UmiapgYXkIecwqVhfg7/uYS5jIlfq3Tta/iJENY/VQ7qV37
         ARofWKkm0lrYDMzZTjfjRvOTISngMYS/eFxCTg90BQil1FAGibRDNR7t6RoZY6SF7t4S
         tOlh0O51PcvY9KZW6SU+4rVnCcSJwvs/ALfnKO+iRxsKCcSmrGvVwDk5/AgSNDyjkk95
         17loe7u5vJdJZjNSiam8cOsl9VCvSkvZBErUWWFyzFefP/gLatXjoJ5cm95eqWA9nDhB
         i2mg==
X-Gm-Message-State: AOAM532K5T26KpDJ3ltilVpXh7dXHNtXGrjzlK3sVHx8mH+1sMS90dgX
        X32UP+H76mUG8Av+eGWgAaVJK+1d6etR
X-Google-Smtp-Source: ABdhPJwN2yW+X7kXCpEB8IPaNYBNCohGFxevhPXdo2rvXvlrkSplvLC/qFABOYAceVkY7x7m7TkDWXK4+31/
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a05:6a00:1245:b029:30f:2098:fcf4 with SMTP
 id u5-20020a056a001245b029030f2098fcf4mr21279591pfi.66.1630298674441; Sun, 29
 Aug 2021 21:44:34 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 30 Aug 2021 04:44:23 +0000
Message-Id: <20210830044425.2686755-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v3 0/2] selftests: KVM: verify page stats in kvm x86/mmu
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

v2 -> v3:
 - fix the build error. [mizhang]

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

