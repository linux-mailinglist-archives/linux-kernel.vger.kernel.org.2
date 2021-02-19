Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33631FF95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBSTw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhBSTwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:52:25 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26715C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 11:51:45 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id g24so4826650qts.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqokZIMMK8aC34B+KeiFCW275H8P/pPHySRTbbLs8og=;
        b=iwXazviBnhZbDsAGWJ5xN0xWYMsrMY8hW7aaidkSL8gG1ktLKKJah9783TJZe87anL
         8OfebB7HAKZsup0izD0dbrIlIJWaMgevxubMMovv6zDmMhg/jEnnbEeLhecN0TiiKIso
         CvXPxhwxSDLdF8P5D5er1s4ghaYtBCoM66oGhRPEyH6L8XmVh+8PK8o7ZlX1VxXN4Uj/
         EKboaR1l/m8sINFC29RhOQ8AMm5xA6xBUKR9zsnxIVBNscMLtCv34LtkOJNKGQdEqiSn
         +mkIIWRi/ZVWR4bU/sNKM8AMr7e6Vosp8BlvU1nfZBlEAoffJIuoQaW/nuvVtMj1IRid
         CKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqokZIMMK8aC34B+KeiFCW275H8P/pPHySRTbbLs8og=;
        b=M7YE708SS5tms5xd8h4YDRqi8R1mSMbti475rY0q4D617lOqIxjBwxt9SRuzHDyIoa
         b9WaogZWO+M/UgTZbiT8ZhSjyAK/vAwMM1JTiXDNJAVmbnJv6nZH4B7npbT1OHIXs8yh
         K6tHplW/2hShqwkMmuHxT6xjqZY0sqEzBF482OLo+SRpk6N7/16on+bfWJTMQHdaErOB
         yrnHi+3S38ADy6sYJ6bZ0RV43+2l6KbPLDKszZK+xDy5iXqsLttxMPlOgfDM9HdZwMns
         0fjTsmxvhfD74tR+I8RgteKxHqXLcz7ZTNigxX+asx1LiRX7/AuDLMhpnPjmUOFOKCc3
         mdeA==
X-Gm-Message-State: AOAM533SycWkqRyPGgks7TnTIarER6FzRb+zkKRqsK3QvKnh4QMwMeYM
        fPIMB/yRK6wBju2rd/e46Fs3Ag==
X-Google-Smtp-Source: ABdhPJx20Qu9QiZKnKzdV1KMAiyS4BsADc5EBP+5RQ4Gig0FhAXp9osZQT5d3yaqLiMvIbDB8FNsAw==
X-Received: by 2002:ac8:5995:: with SMTP id e21mr10295910qte.294.1613764304102;
        Fri, 19 Feb 2021 11:51:44 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id b7sm7022848qkj.115.2021.02.19.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 11:51:43 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-arm-kernel@lists.infradead.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        tyhicks@linux.microsoft.com, will@kernel.org, james.morse@arm.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Subject: [PATCH v2] kexec: move machine_kexec_post_load() to public interface
Date:   Fri, 19 Feb 2021 14:51:42 -0500
Message-Id: <20210219195142.13571-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_kexec_post_load() is called after kexec load is finished. It must
declared in public header not in kexec_internal.h

Fixes the following compiler warning:

arch/arm64/kernel/machine_kexec.c:62:5: warning: no previous prototype for
function 'machine_kexec_post_load' [-Wmissing-prototypes]
   int machine_kexec_post_load(struct kimage *kimage)

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-arm-kernel/202102030727.gqTokACH-lkp@intel.com
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec.h   | 2 ++
 kernel/kexec_internal.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9e93bef52968..3671b845cf28 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -309,6 +309,8 @@ extern void machine_kexec_cleanup(struct kimage *image);
 extern int kernel_kexec(void);
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
+int machine_kexec_post_load(struct kimage *image);
+
 extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 39d30ccf8d87..48aaf2ac0d0d 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -13,8 +13,6 @@ void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
 
-int machine_kexec_post_load(struct kimage *image);
-
 extern struct mutex kexec_mutex;
 
 #ifdef CONFIG_KEXEC_FILE
-- 
2.25.1

