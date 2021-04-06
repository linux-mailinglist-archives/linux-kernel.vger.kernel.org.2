Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66CD355A1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbhDFRSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbhDFRSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:18:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B33C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 10:18:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 125so18090052ybd.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=2QVarXwWjfAQ6D128GVf+WS0ZBaSudzPxzhf4vjW9Pc=;
        b=RzlDtRxBkXkLYNyInRsipPHgQI+EUlsswpmhz7RqwzjyAtRO5C9CPPWpjLTorw4/ag
         QpOPm5hG55P2oRNMWitz44qrKmz5bBmdnZcjjhOiCu0faVVLgZHbOgEJrPbqxWsMEbMb
         QqSythYmiBIiBAZFEAGg/yAmaus7Ei0C2t6lzEEMJaJ7iHVCuSARwIMkHma3v9FNSodX
         BwPrZHyrtwxeiQtWy4EsDaZUrWgW9IuU6Nu6vFaV89xfak/0Cw2wmVsntgf1DBMUogHO
         Jpd7y2sjb5Wo8FWjMKWzkp9YKCbPtgrZgodM4ie2JdCgVJN+PwTjgxaKdVquyvBD8aWN
         x0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=2QVarXwWjfAQ6D128GVf+WS0ZBaSudzPxzhf4vjW9Pc=;
        b=XND1wfuWB992X0slqSVed7ylYzkPA0MnZ0yJRPdOu4mqAgZR9uQNEy2JDMl4N30d97
         3jg1bTOQoTtGNvfCBeVfNekKIe/jJPJgMWrYtK7qUIiv5BKYLW/vxwSPwlxVziWP5nuT
         HJn6EqWLZxxD9S9iALcYcaIPVhxi8fVRcwdvIhe5TAdYCpdGUIABsZgHe+dEp1sCJrs8
         FUjytqTrk5QshSHih/VCO9+arZGzeu8r41s1JhGmeX/XCMEeMVZ8MM0lz//Ziy6J2oGr
         LI/G8/sK7JI26q0EX8o0eyjG2i9ZkFpQnqAzMABqW0p1U8i4Ma2dUfvSxrnDI3QJmuag
         kVJA==
X-Gm-Message-State: AOAM532sQKW36COc74ZYTAz6B7kBygWl/x8xcghU9Y4fx/NRLF35Efu6
        gh8I9J1zC6gpXIHNHu318xbCqtzpb/w=
X-Google-Smtp-Source: ABdhPJx0P56RiIuz/a4w5YDahtfmvb66qqZAu2XOJs8zEcjT81edWLuMZVNWSJPcP+l7dOYSkfOiIIvC5DU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:24a1:90fb:182b:777c])
 (user=seanjc job=sendgmr) by 2002:a25:1186:: with SMTP id 128mr43976001ybr.59.1617729494045;
 Tue, 06 Apr 2021 10:18:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  6 Apr 2021 10:18:07 -0700
Message-Id: <20210406171811.4043363-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH 0/4] KVM: SVM: A fix and cleanups for vmcb tracking
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cathy Avery <cavery@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Belated code review for the vmcb changes that are queued for 5.13.

Sean Christopherson (4):
  KVM: SVM: Don't set current_vmcb->cpu when switching vmcb
  KVM: SVM: Drop vcpu_svm.vmcb_pa
  KVM: SVM: Add a comment to clarify what vcpu_svm.vmcb points at
  KVM: SVM: Enhance and clean up the vmcb tracking comment in
    pre_svm_run()

 arch/x86/kvm/svm/svm.c | 29 +++++++++++++----------------
 arch/x86/kvm/svm/svm.h |  2 +-
 2 files changed, 14 insertions(+), 17 deletions(-)

-- 
2.31.0.208.g409f899ff0-goog

