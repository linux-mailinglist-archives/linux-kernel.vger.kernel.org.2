Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA1635318C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 01:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhDBXhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 19:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhDBXhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 19:37:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79CC06178C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 16:37:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i2so10904163ybl.21
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 16:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=xjVYK5mNQJ2/NN13VjJsOwPYAqepZgVgkk4SOaWm23E=;
        b=mqHeXZZ1B+Tm9h5UK2oztRPPQmzo7n1Fqx3Nx3sIENEHEfue7qDlNvha1zfD0T65nu
         HXzHhU0ZxJvDaW1xqMfkX/tGpIxCr2CSoJDpCwRuUKESNfkcQfmAyWo+hvaYv4iGr3B+
         97ZpXzK2pBA03CZznn+Bo4jT+UpvRhaNiazlvGqxIniysJqiHcIDGeXJPSphv8jIShyU
         v4izN/skFvnVuOrOMOt0M2+LjEtP4qk/fmqFs+vXL1eWVRPa0wmn+X0cJthKKzFq5+ig
         0RutQwQNeWIHMrOJbhBATnbC7IHrez2K0rySEQlQh5+EVLc7KdYxzBSrTCuw3REPfhbD
         RZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=xjVYK5mNQJ2/NN13VjJsOwPYAqepZgVgkk4SOaWm23E=;
        b=fDmNU6SrQWEqvrByOTETaRzyTEaNS670GogPb+X+Vt2dygoFNkA2TA2HB2moVGchQ9
         nkdNA7xZ5TZDLjy1Ahuxk+bnWgN9disRKEaiye2Tpbuc414cps8pHYcufOAhwv6LBYdu
         YCl7eGGW7I8kgVqBKOeuIL7rYd60hdEnkqs/TvcVT5ceobpBDlDUktaml07z+EWOBtZX
         8zPE9yOf3/uDf2Bw8stGYVgJCLfhU0DKAQPThcs9fpRre772OphY4y3H0n5xw66m3pZD
         hqcxWwtiJQkNYcRkN58fInBWyHSDjELutzAPslmfHJjPWHdVcEcmASQnPju0Bxtmhtif
         bhjg==
X-Gm-Message-State: AOAM530PXcFLpGdd3kgrUSTN41zi9tKdBUQfUptHhEPo2dZ0k5NeApA6
        gjSOoNsl9J4iVTyJA1j+M4c/YOQwAzs=
X-Google-Smtp-Source: ABdhPJwpzJvoUPM2VsTADsMCMUhBkIOf35+jqXhTBG7gS47Dz9zpQwjAxOQohrn+9EEBxcYlKKuTgGAKjwA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:24a7:3342:da61:f6aa])
 (user=seanjc job=sendgmr) by 2002:a25:e085:: with SMTP id x127mr14625429ybg.343.1617406634068;
 Fri, 02 Apr 2021 16:37:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  2 Apr 2021 16:36:57 -0700
Message-Id: <20210402233702.3291792-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH 0/5] ccp: KVM: SVM: Use stack for SEV command buffers
From:   Sean Christopherson <seanjc@google.com>
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
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing minor KVM cleanup to account various kernel allocations, I
noticed that all of the SEV command buffers are allocated via kmalloc(),
even for commands whose payloads is smaller than a pointer.  After much
head scratching, the only reason I could come up with for dynamically
allocating the command data is CONFIG_VMAP_STACK=y.

This series teaches __sev_do_cmd_locked() to gracefully handle vmalloc'd
command buffers by copying such buffers an internal buffer before sending
the command to the PSP.  The SEV driver and KVM are then converted to use
the stack for all command buffers.

The first patch is optional, I included it in case someone wants to
backport it to stable kernels.  It wouldn't actually fix bugs, but it
would make debugging issues a lot easier if they did pop up.

Tested everything except sev_ioctl_do_pek_import(), I don't know anywhere
near enough about the PSP to give it the right input.

Based on kvm/queue, commit f96be2deac9b ("KVM: x86: Support KVM VMs
sharing SEV context") to avoid a minor conflict.

Sean Christopherson (5):
  crypto: ccp: Detect and reject vmalloc addresses destined for PSP
  crypto: ccp: Reject SEV commands with mismatching command buffer
  crypto: ccp: Play nice with vmalloc'd memory for SEV command structs
  crypto: ccp: Use the stack for small SEV command buffers
  KVM: SVM: Allocate SEV command structures on local stack

 arch/x86/kvm/svm/sev.c       | 262 +++++++++++++----------------------
 drivers/crypto/ccp/sev-dev.c | 161 ++++++++++-----------
 drivers/crypto/ccp/sev-dev.h |   7 +
 3 files changed, 184 insertions(+), 246 deletions(-)

-- 
2.31.0.208.g409f899ff0-goog

