Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8210B40BC09
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhINXKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhINXKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:10:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF51CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:08:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 83-20020a251956000000b0059948f541cbso1058413ybz.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=PztszF2YIAOMGYHBfcW7r+pjCpLpLa/8v1KHPoNSnec=;
        b=Rlj3ZqyeNHZQujdEOAGUoCv/3iATsQKhJ0LnYDd7vpZR9odQDtf1XopNhrZLpRhumi
         mq99GaN6rKBbnLYfUd8Qlv3gu1woKcvxny1zJrHpZCuyuujaOkeraT/nPQWBsktZjwf9
         gmPznr2Ecj+nufK54yE9vFiAVVokApw+k55j8nnwqsae5uvARCZaqbwavCbOx2MRZX7e
         zaQB2W7vE+XFm+xFyU9fT3bFkrA5rthtsO75X9ACkBe/w2PD4mg1DNROicKXJaH5efYQ
         kYAJAoFjcOFBeUMafTQeebaFmJf6POsZETwvWQJPPz7Dvu4oVx07OUqOqlgaDMbENn40
         +yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=PztszF2YIAOMGYHBfcW7r+pjCpLpLa/8v1KHPoNSnec=;
        b=eYFjGwMmqLu4Mc6qCNIr8BzkJd8wD0RAtlibEg169atXfFcFMW9R9rH2ihMMOPktit
         rPaaHkhFTb/zxTLAursa8eZURzMAd6lu+d+eg1hF+FObsoKbd7hgjvOgVZHP4L7xHTAt
         iv0bbJw0hgtiq0/GSw5kUd5dA6rCe664O3X5FMciFKBxTEVhmhuJI247UwYeAPdMCfof
         mo7b5Vt5Qn6HQj3hxTB9FHl8dBhgD3hWg9m2SntUkswLirZNzxLUDzqp5j5SYWStFE2H
         Fwa82mYOpZe/fzkIXYjg7ebMQ3UN7oayRcr/GuywGYHhU3W6qKG5p4s3V1BECikntEw/
         wE6A==
X-Gm-Message-State: AOAM532McfgKOGfjxA/gZG7lHYWz4TxpzbBMK/UHDOVP4h/ctoKxaxjP
        pA3fENhjPUMV3u5GETN2bqBW5JMCtec=
X-Google-Smtp-Source: ABdhPJz/GPJsTRdRxM5UC2FowOQDmjcbLosM07pV/dhbRy68NKLqwo2+pG3RTdgSs8PlDrzd89hI5K2lRbs=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:d59f:9874:e5e5:256b])
 (user=seanjc job=sendgmr) by 2002:a05:6902:72d:: with SMTP id
 l13mr2314014ybt.168.1631660924206; Tue, 14 Sep 2021 16:08:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Sep 2021 16:08:37 -0700
Message-Id: <20210914230840.3030620-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 0/3] KVM: x86: Clean up RESET "emulation"
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dedicated helpers to emulate RESET instead of having the relevant code
scattered through vcpu_create() and vcpu_reset().  Paolo, I think this is
what you meant by "have init_vmcb/svm_vcpu_reset look more like the VMX
code"[*].

Patch 01 is a bit odd; it's essentially an explicit acknowledgement that
KVM's emulation is far from complete.  It caught my eye when auditing the
"create" flows to ensure they didn't touch guest state, which should be
handled by "reset".  I waffled between deleting it outright and moving it
to the new __vmx_vcpu_reset(), and opted to delete outright to discourage
ad hoc clearing of MSRs during RESET, which isn't a maintainable approach.

[*] https://lore.kernel.org/all/c3563870-62c3-897d-3148-e48bb755310c@redhat.com/

Sean Christopherson (3):
  KVM: VMX: Drop explicit zeroing of MSR guest values at vCPU creation
  KVM: VMX: Move RESET emulation to vmx_vcpu_reset()
  KVM: SVM: Move RESET emulation to svm_vcpu_reset()

 arch/x86/kvm/svm/sev.c |  6 ++--
 arch/x86/kvm/svm/svm.c | 29 ++++++++++--------
 arch/x86/kvm/svm/svm.h |  2 +-
 arch/x86/kvm/vmx/vmx.c | 67 ++++++++++++++++++++----------------------
 4 files changed, 53 insertions(+), 51 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

