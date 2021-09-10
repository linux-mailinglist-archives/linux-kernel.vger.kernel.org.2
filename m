Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB44070F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhIJSdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 14:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJSde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:33:34 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FABCC061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:32:23 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e8-20020a05622a110800b0029ecbdc1b2aso24307570qty.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=YlwJHJMh2bFF+3hFji05e3iWsWMwUqbd64h+Z7Bxs5M=;
        b=ioZoNuAlz7cfTX1k5y8m9lO6Xk7f78CUn6azVXQsTdJXQ8DkbpTtuQh45NqG3BGDni
         Y4CMRdkCkj5H4u2YyP1SGIOHXCya707iYNCKz7YOlC6bUZ81HT6ItWBK63+lNdygQOFN
         pqEVMo9cTxN2gqW1LN3YDd3kWkW6vzPHKmMsx0fJUNJEVpo5SQ5lIVe6s9Kwo2vKBFBp
         yYuIsNnQP2ffT3P3YdG2zt1jwJqTyIeyrTFwVx2wd+1BBJG6bA422YYQkq83hn73XzeI
         zK9rslV1gIZLHet3LiaXBPspSRwsDMjH0rCbD0vfyUGsaKJS5q2fZtgeRhsp+ljMrkKo
         wibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=YlwJHJMh2bFF+3hFji05e3iWsWMwUqbd64h+Z7Bxs5M=;
        b=yynoFIbX1H0ySuofj8HBUjmzsYKiY44vNLNMxUysCGHBNc5l5GbgQ9lzaf8/+IgYXA
         lIguGxsC2PGWcJAgFr71KbEGBaBbQS4iidoQyI+WILVlkq/fW+GXe02dZhJi/NlDeXzd
         V5SUZTgTBNDNfWyIhGj7IScDzHyCqnOg/lfenVtc2fKCPSqN4mgnmNxTB7kCbYQX0rBw
         h9V8ppI7IsH9UeceqBYvsXzZhbsJJL4hgMpebNU4Wc73XYrHJTacpyyKZthIjGPBcesj
         7ysQ/IFZfAueDd6Cz7bqBFV+5Wbiz2M4UR8vZW/HRum5TCnbUekoRJxLUFv11B1er4On
         BJQQ==
X-Gm-Message-State: AOAM531444/OofLJ9Z1VrPkgwJi9lBv9RLl0iNx253j9yyT/nMG3mD2r
        nTdn9PxYnvL8ACJ/gF2uP3tcvAMaUvU=
X-Google-Smtp-Source: ABdhPJzWExSuF+MjinbVRsxwC9Lyp9zTdd7mBSpwQ7g/RjOIoI5vTwLJq6p1qkJiusmgX6RQUF/8wgxepIU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:d1d5:efd6:dd3d:4420])
 (user=seanjc job=sendgmr) by 2002:ad4:5990:: with SMTP id ek16mr9653194qvb.30.1631298742637;
 Fri, 10 Sep 2021 11:32:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Sep 2021 11:32:18 -0700
Message-Id: <20210910183220.2397812-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 0/2] KVM: x86: vcpu_idx related cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop KVM's obsolete kvm_vcpu_get_idx() wrapper, and use vcpu_idx to
identify vCPU0 when updating guest time.

Sean Christopherson (2):
  KVM: x86: Query vcpu->vcpu_idx directly and drop its accessor
  KVM: x86: Identify vCPU0 by its vcpu_idx instead of walking vCPUs
    array

 arch/x86/kvm/hyperv.c    | 7 +++----
 arch/x86/kvm/hyperv.h    | 2 +-
 arch/x86/kvm/x86.c       | 2 +-
 include/linux/kvm_host.h | 5 -----
 4 files changed, 5 insertions(+), 11 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

