Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DC31741C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhBJXNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbhBJXJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:09:31 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5ADC0611BD
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:07:07 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id y79so2937843qka.23
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=i/onZ3KiqIHBpv3eMUYx1zyRXltUgIE1V0UnnfUHTlU=;
        b=cduvZoyAs6pKakf+DUM0JAes2PTO8Xs8SjSx1xNAQRHLUo21knOelo8gzCqGwDHQqB
         KpP8TQfaQ9yfySQnM6cjOuNQvYt32rnyADYp42LMjK6RdTFJ2l+huXmQKxBDCHeAxkbE
         v0snVtPybCrxaPnQfXhkc+FzGqFk7EmHzgwtTNC0D8r6b7cYlVA1KXdsG9t7nqC0gTAn
         tyC1xAVjrMUsD8INIhne/bi2tsAdfhFmmtnDGoIuln/MNT1aqZBwDVdOtXO9p8LZCpX3
         PBRUIlbJ3OQ4K1YsvOrElg48KybP6ODa07Qo7GJY2WoaJ1U2YMBiJH6U/QM4CWcHclqd
         i8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=i/onZ3KiqIHBpv3eMUYx1zyRXltUgIE1V0UnnfUHTlU=;
        b=tcsP8MmV0bh9cCvi8bybTeJybNI20bDF+VFJXIRXCcBsJdSan5ufOGVnZ+SvZJDjvT
         LINLvxrNSok59wgTfNVW6E7umbT4JZ4ANeAAmPM5/fbISNkQTESSqInpWfc/luieEYt/
         lqVkJO3OSyCbTxH+cTQv9AzpZGW6P58pqdqs6dSdlg5D6DTS6ytRTs4JTZYGMh7ySdLh
         BWjaqiLwfvc6w+ePwsMIiNufSbttSqo/RyQFc/K37wzUaVGmZagc6+ioUufl7HWscdcY
         L2Zoszwwr1nyNcb5cBX8Jb6PDoBd3hvP7xJJiLpdEqscsI/uadzIO2Fu50FgzZQlBzKF
         +tig==
X-Gm-Message-State: AOAM533XlxCrb8OQQAARduyKtrywgXGvuOOsXNvJbnXTbl5z3aotT/Jd
        O5ORRV9Tkl23ubLtxAc2V/aqXcBrXOE=
X-Google-Smtp-Source: ABdhPJzGJXgDaZRgmcj37pw6FCoVQ458rPN2FxbCfzyyF0dPrmlaITMAuJKlttUJ5rXiMxCAJaeo4VbIPeY=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
 (user=seanjc job=sendgmr) by 2002:a05:6214:10e7:: with SMTP id
 q7mr5120746qvt.16.1612998426830; Wed, 10 Feb 2021 15:07:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Feb 2021 15:06:25 -0800
In-Reply-To: <20210210230625.550939-1-seanjc@google.com>
Message-Id: <20210210230625.550939-16-seanjc@google.com>
Mime-Version: 1.0
References: <20210210230625.550939-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 15/15] KVM: selftests: Get rid of gorilla math in memslots
 modification test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the recently added perf_test_args.nr_bytes to define the location of
the dummy memslot created/removed by the memslot modification test.
Presumably, the goal of the existing code is simply to ensure the GPA of
the dummy memslot doesn't overlap with perf_test's memslot.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/memslot_modification_stress_test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index 5ea9d7ef248e..cfc2b75619ba 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -114,10 +114,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	add_remove_memslot(vm, p->memslot_modification_delay,
 			   p->nr_memslot_modifications,
-			   perf_test_args.gpa +
-			   (guest_percpu_mem_size * nr_vcpus) +
-			   getpagesize() +
-			   perf_test_args.guest_page_size);
+			   perf_test_args.gpa + perf_test_args.nr_bytes);
 
 	run_vcpus = false;
 
-- 
2.30.0.478.g8a0d178c01-goog

