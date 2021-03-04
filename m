Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D63132DDB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhCDXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhCDXTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:19:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99602C061760
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 15:19:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p136so332621ybc.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 15:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/tCag2eM5nibLNaUG4o5xV/pF/skcGVt2I4xreL6gfI=;
        b=LQXYw+cnQ5skNeBCxADkh40ZLQqdcnVS3py7rRwFSc5jFkf7xMzj9/kzaAN030I1cc
         ALcihEajKRdWwIjzVkdnEEJ5clsDxKQCKHquzcrv8S9dEvFia/6LDSqmEcIN11QY9L6s
         saub2b4HcnLstNNeZJqAxnWxq24Uy7PY/kp2g+fFrOD3byGvmkozYDdoNEj/CKOcCnzr
         mAe6R+sOd5omrR9C1LNlE2Xm/myYz5zAmPVWmxnMkeZ0NlyjRM2duTuxU/21B5qSsWFQ
         jaWvUqgeCXHh+Gdf8ecYjuYDFAHn+R3NKCwzyTigP2dz/HK4C6F8nONvHgpXHdCe/Efg
         uRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/tCag2eM5nibLNaUG4o5xV/pF/skcGVt2I4xreL6gfI=;
        b=PKfyAF83tYhIhPKaJFwvQP0pw1dHQxJSym1siYjWuxQbx1a0jtqrGfKB2wGuedUrmk
         AvN1JBb/FQPeKa2ieApeq/4uNUbA9vwL+PlpUGkyY+EAzyWmh9hVaOutvn2ENbyrDdGR
         BFCXz6G4OgazAFWPWcMMR5nBb/POIZ34olj4RNe4l+5r+/pqALNurz+zNRGh5pGlkuHm
         lrL+Qy694SX39muiriz1wgY6K8/z6PIaTP+itnRC7x1zxgfz1YF1oW0u/6dypiZQHggi
         bV4NKtJnbhKHkDSMS/Xfmk6nk4LYLQ/owE3gy5QpRlV0Yp4Rt5TJnN/5jhR+Npq3uB0I
         DN7A==
X-Gm-Message-State: AOAM532hX1JmPsNIppdMpPbwsJ+/IL0QpOQmG6/nJ95AsJemPxuan3HX
        DdK4lUrmSVDl6FozWOJWtK0vd9iFvsu8
X-Google-Smtp-Source: ABdhPJzCDUXR9u2rQTEwXTd/5pmu8kU2aaY9EivX2IsEE/Kg4Magvz6cMaCrKA0IcEd5OAkrrgrDlwzPON77
Sender: "vipinsh via sendgmr" <vipinsh@vipinsh.kir.corp.google.com>
X-Received: from vipinsh.kir.corp.google.com ([2620:0:1008:10:1b1:4021:52a5:84d])
 (user=vipinsh job=sendgmr) by 2002:a25:c707:: with SMTP id
 w7mr9662857ybe.225.1614899991739; Thu, 04 Mar 2021 15:19:51 -0800 (PST)
Date:   Thu,  4 Mar 2021 15:19:44 -0800
Message-Id: <20210304231946.2766648-1-vipinsh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Patch v3 0/2] cgroup: New misc cgroup controller
From:   Vipin Sharma <vipinsh@google.com>
To:     tj@kernel.org, mkoutny@suse.com, rdunlap@infradead.org,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, jon.grimm@amd.com,
        eric.vantassell@amd.com, pbonzini@redhat.com, hannes@cmpxchg.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com
Cc:     corbet@lwn.net, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        gingell@google.com, rientjes@google.com, dionnaglaze@google.com,
        kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patch series is creating a new misc cgroup controller for limiting
and tracking of resources which are not abstract like other cgroup
controllers.

This controller was initially proposed as encryption_id but after
the feedbacks, it is now changed to misc cgroup.
https://lore.kernel.org/lkml/20210108012846.4134815-2-vipinsh@google.com/

Changes in RFC v3:
1. Changed implementation to support 64 bit counters.
2. Print kernel logs only once per resource per cgroup.
3. Capacity can be set less than the current usage.

Changes in RFC v2:
1. Documentation fixes.
2. Added kernel log messages.
3. Changed charge API to treat misc_cg as input parameter.
4. Added helper APIs to get and release references on the cgroup.

[1] https://lore.kernel.org/lkml/20210218195549.1696769-1-vipinsh@google.com
[2] https://lore.kernel.org/lkml/20210302081705.1990283-1-vipinsh@google.com/

Vipin Sharma (2):
  cgroup: sev: Add misc cgroup controller
  cgroup: sev: Miscellaneous cgroup documentation.

 Documentation/admin-guide/cgroup-v1/index.rst |   1 +
 Documentation/admin-guide/cgroup-v1/misc.rst  |   4 +
 Documentation/admin-guide/cgroup-v2.rst       |  69 ++-
 arch/x86/kvm/svm/sev.c                        |  65 ++-
 arch/x86/kvm/svm/svm.h                        |   1 +
 include/linux/cgroup_subsys.h                 |   4 +
 include/linux/misc_cgroup.h                   | 130 ++++++
 init/Kconfig                                  |  14 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/misc.c                          | 402 ++++++++++++++++++
 10 files changed, 679 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/admin-guide/cgroup-v1/misc.rst
 create mode 100644 include/linux/misc_cgroup.h
 create mode 100644 kernel/cgroup/misc.c

-- 
2.30.1.766.gb4fecdf3b7-goog

