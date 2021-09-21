Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B404135C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbhIUPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbhIUPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:05:18 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0537C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:03:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a15-20020a0ce34f000000b0037a944f655dso227610472qvm.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L/4OnH+mvURjID3uqU8rRzyG0pt7Jf+RfI2TY4GAoXI=;
        b=H4W4p4bFnJk+FJOYa/Qnb4t8nVwi8/HlId2FwiQtRMq7H9DWq6d4oaRvFQoZRitZBk
         bqGX3I4mhy+dYHHLPAubIAoSpsT5VcyyUkq4aqQD8+9n19TxVZ9/R/2mamtGtNLDqSE+
         TbTkuQhMbOfm0b6QuUMu5xLJAgK1a2h0skpwXVybU/UI2qjgHKmGSeGPJQt7Gl3jFLva
         miI3Oa0CpypicCSwy7lrJlYRjio4nc9zOVo6mPPNLA5kKd51zIYQzEH5PnuHEv4z8eTQ
         DZGlrmLxBnYz1kAX9lQiobRDD5NLDO6iEGt7ySDhnS/klDX0OJf/NJf8Re5Kn6P8sGuw
         KmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L/4OnH+mvURjID3uqU8rRzyG0pt7Jf+RfI2TY4GAoXI=;
        b=pdlek1uABFPSp7I3HEG6+VO/5cZS3FgofVlSftQ/anDuVXvvgcBKRpXfbYSCd0oTPm
         XcLiYKm2E6gRvYiH6BFN8c+PaQWiwyn/uOSg+jGX5sR1rzyWewXr9bdglR6OYOypO9VE
         ImD0KSMMvLHiyrHipmicD+jMhryO439ZQoZ1eMi/5u3iv4g3o9qP2+cIpF3OCpk8Z70x
         u/doeXQtGWPCFKmaUO4qLn91Vok3z2s0bdJ2YadPPR4jMyQadAikDDoOcE3CSyhn5ZW5
         zpOBf1UGpMAeTD09KkRwCCvSaHEVb6pbUeadUn2IwT5K3ceQrvV+Kw8AROy6v8+H7iu9
         XrxQ==
X-Gm-Message-State: AOAM531pZGvBHbOD5FM8SFu9O8lxduFWHBAoLj3GusSsUdq/NUaq3dzo
        sXdvps5Ib8c2xMUMv9VhpQ3jteomIuM=
X-Google-Smtp-Source: ABdhPJwyigU/yedPn5sIeu7x1QhC+eZ6eI+96ciiH5rsz2vjvx3LRS/q6oazu6NYhNDLS/oir5yx9h/zi70=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:784b:c8dc:f1c:ecde])
 (user=pgonda job=sendgmr) by 2002:a25:afce:: with SMTP id d14mr38390368ybj.14.1632236628868;
 Tue, 21 Sep 2021 08:03:48 -0700 (PDT)
Date:   Tue, 21 Sep 2021 08:03:43 -0700
Message-Id: <20210921150345.2221634-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 0/2] KVM: SEV: Allow for mirroring of SEV-ES VMs
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Nathan Tempelman <natet@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To mirror SEV-ES VMs the mirror VM needs to call LAUNCH_UPDATE_VMSA
before the original VM runs LAUNCH_FINISH. This allows the mirror's
vCPUs to be encrypted into the SEV-ES guests context and measured into
the launch digest.

Peter Gonda (2):
  KVM: SEV: Update svm_vm_copy_asid_from for SEV-ES
  KVM: SEV: Allow launch vmsa from mirror VM

 arch/x86/kvm/svm/sev.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

Cc: Marc Orr <marcorr@google.com>
Cc: Nathan Tempelman <natet@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Steve Rutherford <srutherford@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

-- 
2.33.0.464.g1972c5931b-goog

