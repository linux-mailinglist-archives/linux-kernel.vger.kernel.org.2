Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162FB43A497
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhJYU1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbhJYU06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:26:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FC6C06965E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:13:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso19323597ybj.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=p252xG12hm36TVtMBIc5o9CfWgJnI3e/NiInHiVMTig=;
        b=Wu2LLRdbO75g2MJEjWRIADkGRjmCiBhAy+jmAo12Tyf2ZcqCPI3jN66i6zU/hhGOxm
         LUInj/1ds2YyRdBRfWxggtTr7grJ+wUJ4BGGwSkxpwdvawfPLM2PuALkxw5AoMbP15hI
         bLD8OPrKoKD8EG4UNeGiB2JTL37INIyc/igaGDXkCIPEHz9LWohzT6OwdnC09uinshXF
         Gh2TRmOY9A8kv/z16HHblrmBgXhOhDj/2071nNoZi8uxPRvsvStMdThVj1qHM6/aH2OZ
         7TryXlS9W+6Tdtie8F9EeDx6vgcSKPKjKSE2Wewa6n2uqU8ZDgygICpvaCEFforQxAfQ
         a0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=p252xG12hm36TVtMBIc5o9CfWgJnI3e/NiInHiVMTig=;
        b=NUqoDvtGEn0UVu4AZ3kDN2ReQjmHn2+YLaD6awxjthU4JJXsChZBfVXH97SUccxx0l
         CiQ0ALP6i4BARQRHR/Zkb9F5nVprQWkysvqFLj8G2zkNn4liSkofkBeWAggPTHc8nmeS
         1/R8yETx6lKtuEyGXqic7TOaaLWubas3qtzH3U0PZsfs+PJTYtxoy43KgV9NHksT9qvr
         4WUMgDWrRpfpjx2CV07991MjCeOH9pnZc97LlIxE5j/n/cNwA3wgT3j9Lo8EgOCxHtyE
         vsb2y01ny530s4ns6u7R5PHMVRvoCAp0kdHepiPG/OyloUBh6kmFmsOJ8Qfwb1HLbPkY
         dc0A==
X-Gm-Message-State: AOAM530DBBWGPY1huJka8eGieR6GO+DNc67Mo7EdfGqKrXJ9tzZlUfRW
        Hd63HKBGvFKPLfcCDO3ndA6tHTPAxJA=
X-Google-Smtp-Source: ABdhPJyX1C9LS3NtwtpDtNnMk+lszKwoChWvg8vLnJhbeYZcGMMZYmwcnXkklyY2MclrLQtdcdHKETzORiU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ffbb:dc28:15d8:6cdc])
 (user=seanjc job=sendgmr) by 2002:a25:2cf:: with SMTP id 198mr9129871ybc.205.1635192796287;
 Mon, 25 Oct 2021 13:13:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 25 Oct 2021 13:13:10 -0700
In-Reply-To: <20211025201311.1881846-1-seanjc@google.com>
Message-Id: <20211025201311.1881846-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211025201311.1881846-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 1/2] KVM: x86: Don't WARN if userspace mucks with RCX during
 string I/O exit
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

Replace a WARN with a comment to call out that userspace can modify RCX
during an exit to userspace to handle string I/O.  KVM doesn't actually
support changing the rep count during an exit, i.e. the scenario can be
ignored, but the WARN needs to go as it's trivial to trigger from
userspace.

Cc: stable@vger.kernel.org
Fixes: 3b27de271839 ("KVM: x86: split the two parts of emulator_pio_in")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b26647a5ea22..1726812f31af 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6948,7 +6948,13 @@ static int emulator_pio_in(struct kvm_vcpu *vcpu, int size,
 			   unsigned short port, void *val, unsigned int count)
 {
 	if (vcpu->arch.pio.count) {
-		/* Complete previous iteration.  */
+		/*
+		 * Complete a previous iteration that required userspace I/O.
+		 * Note, @count isn't guaranteed to match pio.count as userspace
+		 * can modify ECX before rerunning the vCPU.  Ignore any such
+		 * shenanigans as KVM doesn't support modifying the rep count,
+		 * and the emulator ensures @count doesn't overflow the buffer.
+		 */
 	} else {
 		int r = __emulator_pio_in(vcpu, size, port, count);
 		if (!r)
@@ -6957,7 +6963,6 @@ static int emulator_pio_in(struct kvm_vcpu *vcpu, int size,
 		/* Results already available, fall through.  */
 	}
 
-	WARN_ON(count != vcpu->arch.pio.count);
 	complete_emulator_pio_in(vcpu, val);
 	return 1;
 }
-- 
2.33.0.1079.g6e70778dc9-goog

