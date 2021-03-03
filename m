Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F34732BFD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580284AbhCCSdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236283AbhCCRLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5pHfgks8bE8qlKvv/oEckSFicNRsQyVV+w+PZ4/ahE=;
        b=T8FOLQdxrTY/X5fVkLoIRGFggzB1pf8IzWutXvl/nT5HbMv1YAAH8MWDCsO9L4zIUU2sSP
        YTNGxFKitJVtkO45OITcRqZimnNuP4hi5pdb1OEMpPagp6CyvvD3txnC0NYaghLzA/IAh/
        fxC1UEYqTIAzwkQTqJmsDIh78sOPZbw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-nF-Rdx01PKar1AQ7x3jrMA-1; Wed, 03 Mar 2021 12:09:56 -0500
X-MC-Unique: nF-Rdx01PKar1AQ7x3jrMA-1
Received: by mail-wr1-f71.google.com with SMTP id g2so6129701wrx.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5pHfgks8bE8qlKvv/oEckSFicNRsQyVV+w+PZ4/ahE=;
        b=GNWG6V1ReQSnn2DPMhkLt4q3DelmhuqOR7SopkwuDGtasARo7l+NzaaC2BOeoAmJBv
         g6UMIbnaxQgnepnlJCiEtCR1THOJC1i9q3q9Zn5ocVY+oge46s2PSTuEW/te9TlbBcqi
         jovh9XyhuO9GWdKcoQL/R13wWBpTadEe/46tMibBxjFdF0wBnktqY2y+tQDV0J7A56/y
         cjWhoLREqsPLj3kQgWxrmBaupN9tYVCYyWlP0phIjsfOv5qRDFxPNfRTMtbZ9CU33uQw
         qwz8xsO/vJ6rDQC+mzNwUPOvwm07XAzzTXUnzplXkVtCbRKdyG+bdxcY4dydAiUfHQ4s
         Rfaw==
X-Gm-Message-State: AOAM530cl5YcRkTo5TmUe7jseJKqD81IYJa88LRqJvF9LS4l5blLVLfC
        SsGrAM5Dq1L1LoqcDkFLBOAFFviHC0KiDy5NHIyHM3Trjr4oplcHANm8MuHGdwwC4I40tjeEdaQ
        jyXcLG0G8bwIyJG4pJj2YLtBSM0Cv79f/9XsNglgznUvB/yhck2HWUKsK4flxxfN7hl0mTMXRe3
        /Z
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr60136wmb.20.1614791395431;
        Wed, 03 Mar 2021 09:09:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAMudXXtDkJMo6R18P9LAM27S/BaFG0DloKr5DpvCDqGgJlTHuTm3VI8TM8m6dVxwzx+MgOw==
X-Received: by 2002:a1c:61c5:: with SMTP id v188mr60113wmb.20.1614791395166;
        Wed, 03 Mar 2021 09:09:55 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:54 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 12/13] objtool: arm64: Ignore replacement section for alternative callback
Date:   Wed,  3 Mar 2021 18:09:31 +0100
Message-Id: <20210303170932.1838634-13-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64_CB_PATCH doesn't have static replacement instructions. Skip
trying to validate the alternative section.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/special.c | 12 ++++++++++++
 tools/objtool/check.c              |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/tools/objtool/arch/arm64/special.c b/tools/objtool/arch/arm64/special.c
index a70b91e8bd7d..ed642bd6f886 100644
--- a/tools/objtool/arch/arm64/special.c
+++ b/tools/objtool/arch/arm64/special.c
@@ -4,6 +4,18 @@
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
+	if (alt->orig_len && !alt->new_len) {
+		/*
+		 * ARM64_CB_PATCH has no alternative instruction.
+		 * a callback is called at alternative replacement time
+		 * to dynamically change the original instructions.
+		 *
+		 * ARM64_CB_PATCH is the last ARM64 feature, it's value changes
+		 * every time a new feature is added. So the orig/alt region
+		 * length are used to detect those alternatives
+		 */
+		alt->skip_alt = true;
+	}
 }
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7750f6342855..1999d1f1967a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1293,6 +1293,9 @@ static int add_special_section_alts(struct objtool_file *file)
 				continue;
 			}
 
+			if (special_alt->skip_alt && !special_alt->new_len)
+				continue;
+
 			ret = handle_group_alt(file, special_alt, orig_insn,
 					       &new_insn);
 			if (ret)
-- 
2.25.4

