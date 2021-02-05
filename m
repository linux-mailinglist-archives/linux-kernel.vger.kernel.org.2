Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B100310235
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhBEB0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhBEB0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:26:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939FC061794
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 17:25:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 134so5209316ybd.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 17:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=NsGpEfTu4cLzsz3Z3nvZ8Zvi7McRK3J13A5YbpGKONI=;
        b=un/5N8cNYxEeZsiNMb1emCSkI2N5/6aN39TfGWtS7yipr3Oa6xpCTVvHKcn/0QEsEP
         xVb8ERoQSJjuh8O9ZiSUcZrJcju+n8HDPrdAT2JkAZ//cbUo4mYGqC90FUcznM86z2H/
         /gXJnQvkXnn+201WR139QRYAAyFLF6TH+7HMZC+WMC0mdA9jAKETugZjklWwnIGQkuh9
         6ICAUgxFQ1G2BDssScdvAyiBbR83bZdcXvMZEcizbLe4MDYXA7pFKRNrpNh6wzo1H0Pd
         xR9U+tMF+E4m4auRphQulcnIbaiZZBJS34UPShsN+6M897R1g8G/3BEby9W5HUauY1Aq
         ShHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=NsGpEfTu4cLzsz3Z3nvZ8Zvi7McRK3J13A5YbpGKONI=;
        b=BNCyWEEMvWED6IuLPA6skmbTSUFF9OSsWAPhxWJ9R3u/D0kIZjjqvBDi3wYFWIL9eC
         o+Tlh3ZkkJuETY/4bZeHxpZYsIoA/Ahpez1RD5Zw2gwTQUAy++Hy0rpihh/sNA4VmSDy
         PgT2LWPnoe9UBS+ljk7V8JDH8sW8f77Xkd+8dd/4Tjj8Iau1Zf/ZUQuQkhwXs7kvzxjX
         YR0qW2qahWZJDQYQgMdTWQPXTIa3a0CcboM6EpydDNzTGbdqO4YznLDaV2Momc+2EpcM
         ApkSFoD4P5xPlJhCLzceYuroIOFBdXmJt/EhTI0B79O1O4iGGMP9nYGpM5mt0Ll1IbPR
         pwxA==
X-Gm-Message-State: AOAM532BUZHrFooM340DyN5k6EOfFYZXUMVARuehlr2P+Oo1B1UaYI/j
        Yi9uslL3CFELClAXy6CJJygnhiwgmdk=
X-Google-Smtp-Source: ABdhPJwPTyOHnU91Vvajo0M6B147oydY5Bm6+xq0JcJKv/A6snQt0S7F2CPWE4oQmJqlr415aX6UDN8c7N4=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:f16f:a28e:552e:abea])
 (user=seanjc job=sendgmr) by 2002:a25:b74d:: with SMTP id e13mr2844459ybm.405.1612488305988;
 Thu, 04 Feb 2021 17:25:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  4 Feb 2021 17:24:58 -0800
In-Reply-To: <20210205012458.3872687-1-seanjc@google.com>
Message-Id: <20210205012458.3872687-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210205012458.3872687-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 2/2] KVM: x86: Restore all 64 bits of DR6 and DR7 during RSM
 on x86-64
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

Restore the full 64-bit values of DR6 and DR7 when emulating RSM on
x86-64, as defined by both Intel's SDM and AMD's APM.

Note, bits 63:32 of DR6 and DR7 are reserved, so this is a glorified nop
unless the SMM handler is poking into SMRAM, which it most definitely
shouldn't be doing since both Intel and AMD list the DR6 and DR7 fields
as read-only.

Fixes: 660a5d517aaa ("KVM: x86: save/load state on SMM switch")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2e6e6c39922f..72a1bd04dfe1 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2564,12 +2564,12 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
 	ctxt->_eip   = GET_SMSTATE(u64, smstate, 0x7f78);
 	ctxt->eflags = GET_SMSTATE(u32, smstate, 0x7f70) | X86_EFLAGS_FIXED;
 
-	val = GET_SMSTATE(u32, smstate, 0x7f68);
+	val = GET_SMSTATE(u64, smstate, 0x7f68);
 
 	if (ctxt->ops->set_dr(ctxt, 6, val))
 		return X86EMUL_UNHANDLEABLE;
 
-	val = GET_SMSTATE(u32, smstate, 0x7f60);
+	val = GET_SMSTATE(u64, smstate, 0x7f60);
 
 	if (ctxt->ops->set_dr(ctxt, 7, val))
 		return X86EMUL_UNHANDLEABLE;
-- 
2.30.0.365.g02bc693789-goog

