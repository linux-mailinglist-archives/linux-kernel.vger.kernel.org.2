Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD3B316EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhBJSiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhBJS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:26:58 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87231C061794
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:26:17 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id w3so2230425qti.17
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JZ1+OeX1TQvRpSX6JVWSAIUPwsDYxG2Z3TWK9Qe0O5U=;
        b=NfFuUEeo+s9u+tT8+c/ZsIpa4exSCJzAS5ypgoPfEefptNAPa7vv7w9wZsJhwDRjhl
         IHTvI2lAI2kDu5osP8WWLS6XaoWEKHwTo1wFmdudx2DDti0whx0MZ9ecqlRTcoQvwSHP
         UwBEe27vkJVFDsCrgO1lzIwnsZ46cBT2QqM8CXi0qiZe7dtnBf6gChHUWtI/MW8llzRj
         0727GsQbZwC62YlQdfL1A0va57Ey5Kb+wDjRh7Encx9ta5jnZMJ18/P+4X1T/J4qZD/3
         f+eglDIXE4QnxMrE3Bd4tROFQc5FtWEjKwsR48xU4EITj504ULALGIQE5EJC9y1eIVE9
         pk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JZ1+OeX1TQvRpSX6JVWSAIUPwsDYxG2Z3TWK9Qe0O5U=;
        b=AVQ5Ix2Orc/X0MR9i6mT63dNYuAVEgQ83o12uQS6MwC5/QVo1Jv1Uja1oU78clRIV0
         KDMvLI+5W6AADyuuJj1IGHR19euugJMqdwrXlKIUfXLNiup3j6j+GdeaF8fNviwPP+GN
         9mwS1Y+4VP6baKOzvxJu2BWidLZC1Kwcmt3qdbcS4y8ZeMWc+18ErFk1Ys6u2TYjmykN
         S3CZbl1eI74leOf9rK2tVCMjNhaQIC/KHYMQNSrOTUtxmk9xmKuOCIfLtwhOFaQVdIv8
         BzXb8s16Z0Nlxb4hXVptXA5oJk6qe9Z9slXwL6b0DkoY8LICKPQnghz0iNAfnZYlyc0M
         L8Rg==
X-Gm-Message-State: AOAM531mqZ9Evex2P0O5s9GTFq27YXAze8KKdyqnz804nR5HLpY+ol/2
        w1/MiI5v3/2a+4X3K0p9y/h2iYcfSls=
X-Google-Smtp-Source: ABdhPJzxWDnH96alg+/xCqZ29NSwweiSbYq+2GZDKyN3IOAUJdc5jlmCZGKSGBCfA+Ulq5gRHfJa+xRx7AU=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
 (user=seanjc job=sendgmr) by 2002:a0c:fa51:: with SMTP id k17mr425208qvo.29.1612981576645;
 Wed, 10 Feb 2021 10:26:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Feb 2021 10:26:05 -0800
In-Reply-To: <20210210182609.435200-1-seanjc@google.com>
Message-Id: <20210210182609.435200-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210210182609.435200-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 1/5] KVM: selftests: Ignore recently added Xen tests' build output
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new Xen test binaries to KVM selftest's .gitnore.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 1b32c97f8c82..3a84394829ea 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -26,6 +26,8 @@
 /x86_64/vmx_set_nested_state_test
 /x86_64/vmx_tsc_adjust_test
 /x86_64/xapic_ipi_test
+/x86_64/xen_shinfo_test
+/x86_64/xen_vmcall_test
 /x86_64/xss_msr_test
 /x86_64/vmx_pmu_msrs_test
 /demand_paging_test
-- 
2.30.0.478.g8a0d178c01-goog

