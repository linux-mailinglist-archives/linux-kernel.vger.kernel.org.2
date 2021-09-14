Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0440B9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhINVLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhINVLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:11:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810BCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:09:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i77-20020a25d150000000b005b1d20152b0so589297ybg.14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=0tC8bFk3p4vcp8Yy/yC7wnRUXQPWy61w0MWthDFBMp4=;
        b=XWxHyevG1+LlIOcsXiZNImp5zW3oiOEJAdNcdEJFKoLb0Z+tF+MSVKV7TLFBVCDP4o
         OdKB0DUZsYkFJRC1MZ1e62zaozsTuLIIZhYQybIY3IJTxC+2eo5rvnIj3YlSULgNLPeC
         2BdQJnqNeOrEP/ms2DmPPWlAXvKdFs4e5B23k061UL64xrYNvGuNeXhb2p9wq/NbHdVI
         emJGSnzKA2+4L1/mzAKS4x7mSc+e57RuQ3oNr7UeAUM8L15TYzkSsO8+F6G6NWG2wJbO
         seaDFcCS9cQMDZEbqvgu8xY01+J5xhlz17L5+AbymvkuVQrNFCJW59L052/7Z2QN9QsB
         tZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=0tC8bFk3p4vcp8Yy/yC7wnRUXQPWy61w0MWthDFBMp4=;
        b=UDZzXV3FlZ8XrERlWXDtZo2JKujRU9pmlrFsmTFACfI/u7R/jHRGOMjC/CyFHJCfPq
         b69GsRvGRxgBHXdEVNn9/cibVZVRCPC6bGOMsQPxNzWpVz+CKnwLv+USxEfdRzt1Fx4G
         thjCHEtSMDC8rktIKO/amI/KQG+3wzYoUYcFd8vsHcfbC2nwSljg0Hi1XFW676lOfM4P
         m23Wj14wejs9bDIXt+LnUAOyG+breQ94I2r659YJwTA4SVu/p7fxec2d77duLatOqa9K
         /jxU/sZjX1XM821SAHRE6MVxJWdE9AazYYctLlmMMyhiJNAmFy8KofYidUfkoZIbU0Q8
         L4aA==
X-Gm-Message-State: AOAM531ycQcq0mg0IikOrGXmro44WXcixiRu5aLPnUUWKoDXb8NRUbs4
        zJo/bPXGobzoMXo9alocf/7OWIP6y5U=
X-Google-Smtp-Source: ABdhPJwrkSWR+GGwKfCobwub1DNBfiYmHkez7gi7RRFc92KrAvVZR2OKLAaENdqKKtO1FZe6swootmI1HZ0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:d59f:9874:e5e5:256b])
 (user=seanjc job=sendgmr) by 2002:a25:9d89:: with SMTP id v9mr1754652ybp.8.1631653795787;
 Tue, 14 Sep 2021 14:09:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Sep 2021 14:09:50 -0700
In-Reply-To: <20210914210951.2994260-1-seanjc@google.com>
Message-Id: <20210914210951.2994260-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210914210951.2994260-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 1/2] KVM: SEV: Pin guest memory for write for RECEIVE_UPDATE_DATA
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Marc Orr <marcorr@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Masahiro Kozuka <masa.koz@kozuka.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Require the target guest page to be writable when pinning memory for
RECEIVE_UPDATE_DATA.  Per the SEV API, the PSP writes to guest memory:

  The result is then encrypted with GCTX.VEK and written to the memory
  pointed to by GUEST_PADDR field.

Fixes: 15fb7de1a7f5 ("KVM: SVM: Add KVM_SEV_RECEIVE_UPDATE_DATA command")
Cc: stable@vger.kernel.org
Cc: Peter Gonda <pgonda@google.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 75e0b21ad07c..95228ba3cd8f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1464,7 +1464,7 @@ static int sev_receive_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	/* Pin guest memory */
 	guest_page = sev_pin_memory(kvm, params.guest_uaddr & PAGE_MASK,
-				    PAGE_SIZE, &n, 0);
+				    PAGE_SIZE, &n, 1);
 	if (IS_ERR(guest_page)) {
 		ret = PTR_ERR(guest_page);
 		goto e_free_trans;
-- 
2.33.0.309.g3052b89438-goog

