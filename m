Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7478A3EDE97
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhHPUZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhHPUZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:25:23 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90D2C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:24:51 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id l16-20020a0cc2100000b029035a3d6757b3so12651394qvh.14
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=g9/o/9z4zsHt0A4xliRLw6qm1WgAQq/NIv8diVlT8V8=;
        b=Na3X8WB7HU4+Q6rnHbcbEUye2yyaMseyJnz+LAjXQqSHQ88sIut7dcBkUtIvj5yhwc
         Qh9OamjchJgGSoPW1u+0tow9mQJgUyZa+mm9ZTwwnTkOCfgvVpqx/U0Nchu8VA+SpdBq
         nH1pUu/wDwfzNKECulGVxKPyIpva3VxJ97CmiP7zHpT0fsO6DeRWlR1BPb9LusFYUGKF
         zemhX6whtx4nl7UcGBgmYqbxxfadoJFdSBrHA3Hn+PjKHP3Vw4zPyURNaT5XDwpIZl1K
         fWJZtzTAb3p/oAriDfOGX8Qv7HEV0vRtryfhpjq7LEVn0iDeCXMebHWwDq1D2ozwKtwc
         I7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=g9/o/9z4zsHt0A4xliRLw6qm1WgAQq/NIv8diVlT8V8=;
        b=i3fRPxtQoNNruAZlQObdFdG1/xF/3oOYEuIC7gBRBZv0zVi8HRHu1fk5T18j3hVTKz
         dQHaAa+po3MzDNeEX7O2qThMBM7EedUG/4uoF6XLN8DLF1l9YUGaf5LeQfoRLcqXt3wH
         XWpBmCYpLk9rwxQfG8bibQJqCMDWXoeNB5uAaJsTovEyOjd0ZD+YdTXjkWhbOIAfYb0c
         8FXu9VxnyMvrJRQCIC++9oNs7XNjBub7rmPfSqGMQJX/IaMUwrqn+ohRAEsB7L0mRLjk
         9YZifV7SpWm4ygixed/KL6GPsbiXxcaRRNPx1NSe8rY2wwZYJx2fk7CQXr6JDz++Y5cl
         yt8A==
X-Gm-Message-State: AOAM531V7R3m73Lkd5lKPQT6ZAT6REfyve0lfubRBocSnO+crnV3LjxL
        Lj3XMNz7Gur3WCS0F/jEQCHUN/BJPKo4
X-Google-Smtp-Source: ABdhPJwyQSwjPkR0qaUuTjnATtBd/G0GgK4bzkRXvZ/+QgTGS2i6L2iov1MK4VgKXMwVdCMhqbzs5CiyzQUN
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:ad4:5dcf:: with SMTP id
 m15mr560462qvh.35.1629145490981; Mon, 16 Aug 2021 13:24:50 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 16 Aug 2021 20:24:38 +0000
Message-Id: <20210816202441.4098523-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 0/3] clean up interface between KVM and psp
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alper Gun <alpergun@google.com>,
        Borislav Petkov <bp@alien8.de>,
        David Rienjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, Peter Gonda <pgonda@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is trying to help make the interface between KVM and psp
cleaner and simpler. In particular, the patches do the following
improvements:
 - avoid the requirement of psp data structures for some psp APIs.
 - hide error handling within psp API, eg., using sev_decommission.
 - hide the serialization requirement between DF_FLUSH and DEACTIVATE.

Mingwei Zhang (3):
  KVM: SVM: move sev_decommission to psp driver
  KVM: SVM: move sev_bind_asid to psp
  KVM: SVM: move sev_unbind_asid and DF_FLUSH logic into psp

 arch/x86/kvm/svm/sev.c       | 69 ++++--------------------------------
 drivers/crypto/ccp/sev-dev.c | 57 +++++++++++++++++++++++++++--
 include/linux/psp-sev.h      | 44 ++++++++++++++++++++---
 3 files changed, 102 insertions(+), 68 deletions(-)

--
2.33.0.rc1.237.g0d66db33f3-goog

