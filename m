Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10F3759E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhEFR7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbhEFR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 13:59:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB50C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 10:58:31 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i141-20020a379f930000b02902e94f6d938dso4044211qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=SUMsUAFzIemUpIBh2rroEWqtHg/B5XRDxbgXqiS7JYk=;
        b=OJ1k0E0Z3EM1Jd+PqZlqiUTHRz2VbvEyk6Ph32nc1oQ3BxdvTn5XfcAi7cXOr3sbTL
         bj5hLwc/CkfTcjm30F7Wf9VihsDtH86hu32xeB6qM/07sGUXbx0bsVxw7cll6pmlK9cv
         TTBGm++H8aMhgmnNCFvz+6JE/SRMUYMrya2QcKndzRlY40mp/U1GKxu9jgTYAwlS1Tkw
         1U2gkPnYH2IVUlYrD38OqdkOXxLtALL7jCwo2lt9k6L1qTxlDQvgwzsGxKMCcAAR7Dmo
         XH0sY17LEmePiS++VIktKhcohJJf8SBCZswQD3NKvi63MGsrEQt7ltfJjNYC3r1GekPU
         /jIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=SUMsUAFzIemUpIBh2rroEWqtHg/B5XRDxbgXqiS7JYk=;
        b=QGSPllnFQUtIgXyL+V/rubxIiDme0Gbiq4eNV0ewJ2ngib5rZW9Twlra3U8H/Uev7I
         WEQQDrfm11vvBW1GywRzibSO3N8dL8Nlgy1+1nNgvJ3l3GMx+OMEcfLDS+DTd+1tJoX1
         woeabZ5EeIFFruEj+4s+EBstkFdfNkE16W35nwCBEKVuPat0cZOrYs5gGwHI0PV0vg7m
         XMWTsXQEeInLOn3aij7ombqPo5fExkYDlVBRwsmrOi0XvfKuH1dTyiTiM+4D/39fXwri
         ZCDW45gCspy2GkJVu/8KPF9py9dE5PQZFIiC1Cb1tlBvDV9qbEd8LcZiW2ejHzL68w+D
         plnw==
X-Gm-Message-State: AOAM531LPz91AXEd+Mm7xpD4QYY9r5SRVKrzbfTrJnoeznt8dR8DAloO
        po9pGa8aNofgL653vEWKg/8f8hxJE+E=
X-Google-Smtp-Source: ABdhPJx0cGg+sprFiauhsjPcfoixOwxTfbfmSMeTmduPX7FT15DTHEoDsTXgjDcfPTxqQJ7rr3Iu/+6OeBg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:818d:5ca3:d49c:cfc8])
 (user=seanjc job=sendgmr) by 2002:a0c:c3cd:: with SMTP id p13mr5775763qvi.4.1620323911188;
 Thu, 06 May 2021 10:58:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 May 2021 10:58:24 -0700
Message-Id: <20210506175826.2166383-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 0/2] KVM: SVM: Fix error handling bugs in SEV migration
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steve Rutherford <srutherford@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for bugs reported by Dan Carpenter, found by static analysis.  All
credit goes to Dan, the bug report all but wrote the code for me.

Compile tested only, I don't have a SEV migration sussed out yet.

Sean Christopherson (2):
  KVM: SVM: Return -EFAULT if copy_to_user() for SEV mig packet header
    fails
  KVM: SVM: Fix sev_pin_memory() error checks in SEV migration utilities

 arch/x86/kvm/svm/sev.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.31.1.607.g51e8a6a459-goog

