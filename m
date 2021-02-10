Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA20316EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhBJSjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhBJS1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:27:03 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E467C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:26:22 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id o16so2289016qkj.15
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=e/+smwaphYxpb2OBykRaiI2qxi+r1iC3TI9cKW9LQAY=;
        b=SBHmhZobtoi3KqCYzyV03uf8QCxFqDBqLqXozwb3/jdSQmszqqm9TiOh6dwoO0jqtf
         bBelHwWVkPhnpTt81RR2KVeERjmmK52LgFlViDjTmb0pUWAFWJySNdxqbEzuZZLsoxca
         Ryl1zbekb/Ayi6V0ZGa+KgMlWLPAujl4ETHZWu7nOsk24fRLu6mG3qzyt0hSTxG5imY1
         5S6nHum5lYGtJ9k/6X1+bAftzRodlEzz88hzLKcJFOusrfbud/b5iOKkHIQdCAp5+QbN
         nnkHBRkaORYgphz/FK/Q4E6DyxlN8s1SU6aYwwF/AHZDNh5pxMUK9H8IPO2/cOEr8mpf
         Q6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=e/+smwaphYxpb2OBykRaiI2qxi+r1iC3TI9cKW9LQAY=;
        b=tNcQBDZjMEEJwBk/O3EEeP5yE+6OzdDo5ISnDMjocm6NtmpviqNVyGtL2rTdWmbXFW
         HMbuDrKO7eRz3MiIiiwHnZZpgYWjmGHhWmZlRtw4tQnrhoWI3PCF4ujRQWWp1mwVTm3a
         R5X/a7ZUPiEYX9f3tVqrpOr2VkntsNUk/sLWU3RWkkl3PKyYOQypN+oDvjkb8hZIciuK
         0Pt5zjqGba1BDPBHl8XIHkO7QtPeQyEI6UJ5MjT2DIhRyI5fsDtxO6S+/TiaH7SbGxH4
         GWKCXaO2d3roAjkyPnqRH1bS/T5v/gaLokOvT+lxTfLw42GK/uftXoio1NhHpvdqWN2F
         3oAw==
X-Gm-Message-State: AOAM533Be+zi4RVyzZyb7ZcrF/+4eUs1G/vNyW2Xgs+WPtWcfPiJPrTb
        gpaqCPfmNE6iXEu6zfJKBzNwrfPyUVI=
X-Google-Smtp-Source: ABdhPJxIbp6/W2XHdD5AboBQyWQNYv/qugOTUPti7CdCCnJohaae/ys6EzLmx61wIk3rmhTJbVA8Jd5jWKY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
 (user=seanjc job=sendgmr) by 2002:ad4:54ad:: with SMTP id r13mr4104809qvy.48.1612981581338;
 Wed, 10 Feb 2021 10:26:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Feb 2021 10:26:07 -0800
In-Reply-To: <20210210182609.435200-1-seanjc@google.com>
Message-Id: <20210210182609.435200-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210210182609.435200-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 3/5] KVM: selftests: Fix hex vs. decimal snafu in Xen test
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

The Xen shinfo selftest uses '40' when setting the GPA of the vCPU info
struct, but checks for the result at '0x40'.  Arbitrarily use the hex
version to resolve the bug.

Fixes: 8d4e7e80838f ("KVM: x86: declare Xen HVM shared info capability and add test case")
Cc: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index cb3963957b3b..b2a3be9eba8e 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -102,7 +102,7 @@ int main(int argc, char *argv[])
 
 	struct kvm_xen_vcpu_attr vi = {
 		.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO,
-		.u.gpa = SHINFO_REGION_GPA + 40,
+		.u.gpa = SHINFO_REGION_GPA + 0x40,
 	};
 	vcpu_ioctl(vm, VCPU_ID, KVM_XEN_VCPU_SET_ATTR, &vi);
 
-- 
2.30.0.478.g8a0d178c01-goog

