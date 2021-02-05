Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A69F311AF4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBFEga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBFCbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:31:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED4AC0617AB;
        Fri,  5 Feb 2021 14:06:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fa16so3947568pjb.1;
        Fri, 05 Feb 2021 14:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jKvL0mVSUY7WhiJXE1najP+8YOEz8EBBJDLKRLoFS4=;
        b=C9N3z9t9x+VqFqqULcHfI0HKUSmkux2p3uVXqU6wlYTYMEQi0mGvcNv1GJFB7f0Ozm
         7lRszzUs5AqnJLCMdvI5U3/VsoI3yWTu9i1WKgYBpP8ZF0caE0RRKGQz8bqa3YZatnbA
         dxdOB7wd17N8oPS2o9vg5s6rtWYTB5udHqTuJLigyuLdCs8F3uF1PAWxA9VaxlL51e9r
         zX5JTOggxRB7At4JIjwhW/mDENIfn8pEVhmZGoBGLe/wUvlKM3veunprJzK34xCXDCaz
         q+UMf7owhg0Hgs4LdEfcPt+rhcFfP/OHvgkcFQAxvaTFhMSSivA0ANTfZ9Mbp6xY7uKd
         Ko6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jKvL0mVSUY7WhiJXE1najP+8YOEz8EBBJDLKRLoFS4=;
        b=cFbmriHeweyuTdZulk6/gpZj/opAuB1EUEYKR04JsTz+6jIASmTnt2/Ult587lBaxv
         Pk6sMTiEimZNADRPFkxJ3Kt0xr/qbu1L9bbQ0aSwT/vJAeNFcfQ/nllt6SdyfSaRZyPo
         BpajEMAH2I0PliHwvkpNTujGUb1axbxbVDlIU8/bz16bgD29/Kbe04XZFghGtFf6E8/j
         GSwGmf7zDWjmZQq1GOwHCVGj9XSf1Fb3zaAcl8OuOVvmHSJXsuf8JyiuV3FJYXHHeh+m
         I5YA8e8JBdA7L3VayjsBZH77s6gtpRH7k8DL6iXB73fnZ8iIfb1hVecqBnXADrI+qxIX
         fypQ==
X-Gm-Message-State: AOAM532CdgB5uUntmApPIVwzLyIARw7GrwuzrGGZxUpYhN1ZJZbwBWKX
        Daiq5rzbLkNWh7d95UB1FtGci7TBWVkNBw==
X-Google-Smtp-Source: ABdhPJwG++Ub96OHLDZvOnJ1HJyqed82R3DNnY3tzrSKJnsB9+8132bKNesmv9fGoedQYNG5ei72oQ==
X-Received: by 2002:a17:90b:33d1:: with SMTP id lk17mr6086550pjb.102.1612562817117;
        Fri, 05 Feb 2021 14:06:57 -0800 (PST)
Received: from amypc-samantha.home ([47.145.126.51])
        by smtp.gmail.com with ESMTPSA id s13sm5771676pgq.40.2021.02.05.14.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:06:56 -0800 (PST)
From:   Amy Parker <enbyamy@gmail.com>
To:     schnelle@linux.ibm.com, corbet@lwn.net, mchehab+huawei@kernel.org,
        tsbogend@alpha.franken.de
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amy Parker <enbyamy@gmail.com>
Subject: [PATCH] ia64: Fix style guide breakage
Date:   Fri,  5 Feb 2021 14:06:18 -0800
Message-Id: <20210205220618.611388-1-enbyamy@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some statements do not have proper spacing between their C
keywords (commonly if and for) throughout files in the ia64 tree.
This patch corrects this to follow the kernel code style guide.

Signed-off-by: Amy Parker <enbyamy@gmail.com>
---
 arch/ia64/hp/common/sba_iommu.c  | 6 +++---
 arch/ia64/kernel/machine_kexec.c | 2 +-
 arch/ia64/kernel/palinfo.c       | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 9148ddbf02e5..84a410f3e68f 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -139,7 +139,7 @@
 
 #ifdef ASSERT_PDIR_SANITY
 #define ASSERT(expr) \
-        if(!(expr)) { \
+        if (!(expr)) { \
                 printk( "\n" __FILE__ ":%d: Assertion " #expr " failed!\n",__LINE__); \
                 panic(#expr); \
         }
@@ -510,7 +510,7 @@ sba_search_bitmap(struct ioc *ioc, struct device *dev,
 
 	if (likely(bits_wanted == 1)) {
 		unsigned int bitshiftcnt;
-		for(; res_ptr < res_end ; res_ptr++) {
+		for (; res_ptr < res_end ; res_ptr++) {
 			if (likely(*res_ptr != ~0UL)) {
 				bitshiftcnt = ffz(*res_ptr);
 				*res_ptr |= (1UL << bitshiftcnt);
@@ -538,7 +538,7 @@ sba_search_bitmap(struct ioc *ioc, struct device *dev,
 		mask = base_mask << bitshiftcnt;
 
 		DBG_RES("%s() o %ld %p", __func__, o, res_ptr);
-		for(; res_ptr < res_end ; res_ptr++)
+		for (; res_ptr < res_end ; res_ptr++)
 		{ 
 			DBG_RES("    %p %lx %lx\n", res_ptr, mask, *res_ptr);
 			ASSERT(0 != mask);
diff --git a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
index efc9b568401c..8de286450578 100644
--- a/arch/ia64/kernel/machine_kexec.c
+++ b/arch/ia64/kernel/machine_kexec.c
@@ -137,7 +137,7 @@ void machine_kexec(struct kimage *image)
 {
 	BUG_ON(!image);
 	unw_init_running(ia64_machine_kexec, image);
-	for(;;);
+	for (;;);
 }
 
 void arch_crash_save_vmcoreinfo(void)
diff --git a/arch/ia64/kernel/palinfo.c b/arch/ia64/kernel/palinfo.c
index 78fa6579c9ea..ec2ff3e510c0 100644
--- a/arch/ia64/kernel/palinfo.c
+++ b/arch/ia64/kernel/palinfo.c
@@ -155,7 +155,7 @@ static void bitregister_process(struct seq_file *m, u64 *reg_info, int max)
 
 	value >>= i = begin = ffs(value) - 1;
 
-	for(; i < max; i++ ) {
+	for (; i < max; i++ ) {
 
 		if (i != 0 && (i%64) == 0) value = *++reg_info;
 
@@ -523,7 +523,7 @@ static void feature_set_info(struct seq_file *m, u64 avail, u64 status, u64 cont
 	int i;
 
 	vf = v = proc_features[set];
-	for(i=0; i < 64; i++, avail >>=1, status >>=1, control >>=1) {
+	for (i=0; i < 64; i++, avail >>=1, status >>=1, control >>=1) {
 
 		if (!(control))		/* No remaining bits set */
 			break;
@@ -613,7 +613,7 @@ static int bus_info(struct seq_file *m)
 	status  = st.pal_bus_features_val;
 	control = ct.pal_bus_features_val;
 
-	for(i=0; i < 64; i++, v++, avail >>=1, status >>=1, control >>=1) {
+	for (i=0; i < 64; i++, v++, avail >>=1, status >>=1, control >>=1) {
 		if ( ! *v )
 			continue;
 		seq_printf(m, "%-48s : %s%s %s\n", *v,
-- 
2.29.2

