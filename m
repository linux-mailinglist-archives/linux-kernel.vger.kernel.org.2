Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F021352D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhDBP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhDBP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:27:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50B0C0617AA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:27:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q29so8028853lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V63UJPQR8b6EdyZmr/3VnRg5RBlmH2w6E7wlm6bMVko=;
        b=AuePuZL2bSIcibmAXbe3zRQxKxvR7sR9qfnsCDZXQjjYH2y03TELhv0GebMP8hJhJV
         NdD0lX0LVuiK5iFVcEkhiqhX3Tu/wwne8RjfT1xLXVafjf5Rli7LniDVUZEM0SYLkp7l
         XkFieKDi3UOd1cBwCHVl2eVma9pWmLYpNi2k1nfenF5yzKF+9OkpbkIoH2vepOv+TQoC
         OPuUiz5gYqYLuzvtOt5iHfoCbSyCqMShaXS/gtgBCABTb5ZPVjn2AUjwrXw0ouX/nvPj
         Uvu1WZiHdAdsEnA8S7jgQom9BqntEETfUpqIfIuN9t+tBOMNC/GMvRVHrWHEFxyShl9N
         VQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V63UJPQR8b6EdyZmr/3VnRg5RBlmH2w6E7wlm6bMVko=;
        b=Wc2GNr+ozKmC7ekiNb1TTwAWpsEnD//QrnNQyu65VRglcCwrnn3aDqmpBixnlx/Oua
         W9zew76F75Zc5XSmc2z7D5PnvHzktPi8skrlCDMEU1JB3rj1bome9oPblMN7hZ8wZEXT
         SWdJ0UH7m1KeKXKYF0dZnTCg2PT+1c2pwYviRE6GMIMzc3gMqIAxzDgSox1ADyvA5v7+
         Ax82lzcRnCNA3qGrc+xUnTBGGG1Gj5ZUGUFNczU5PvUDSRCWW9rRBMrVakKFU++C0Prb
         ZLF6tt2bnjp/vWuJ2kLTK0hQ/YJalMPZtkXgnqkCxU+GBohU1VcuQY+JKIwfMNv9kq0g
         +Egw==
X-Gm-Message-State: AOAM530z7MPrgOBfGKzdRdFIBzWW5kCd/QPfGdwFmgJmIaUOaJcwh6O7
        PdXpdXgwDcjd+G9bcXCHBTek6A==
X-Google-Smtp-Source: ABdhPJz3LE/aOX7pwxBVzyg+rwnlssxsmbNBVvY5MbgA2FQBPHQiqlCe2VwBUkDjdtmr83SspcKJDA==
X-Received: by 2002:ac2:4c0b:: with SMTP id t11mr9139607lfq.241.1617377220305;
        Fri, 02 Apr 2021 08:27:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h62sm885645lfd.234.2021.04.02.08.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 08:26:59 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 465C4102677; Fri,  2 Apr 2021 18:26:59 +0300 (+03)
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
Cc:     David Rientjes <rientjes@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv1 5/7] x86/kvmclock: Share hvclock memory with the host
Date:   Fri,  2 Apr 2021 18:26:43 +0300
Message-Id: <20210402152645.26680-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210402152645.26680-1-kirill.shutemov@linux.intel.com>
References: <20210402152645.26680-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hvclock is shared between the guest and the hypervisor. It has to be
accessible by host.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/kvmclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index aa593743acf6..3d004b278dba 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -252,7 +252,7 @@ static void __init kvmclock_init_mem(void)
 	 * hvclock is shared between the guest and the hypervisor, must
 	 * be mapped decrypted.
 	 */
-	if (sev_active()) {
+	if (sev_active() || kvm_mem_protected()) {
 		r = set_memory_decrypted((unsigned long) hvclock_mem,
 					 1UL << order);
 		if (r) {
-- 
2.26.3

