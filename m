Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61E7424045
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbhJFOlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbhJFOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:41:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13552C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 07:39:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so9517998wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLdbSR9/I9UWE4egIELKXu7JM87M2XfBH4X1udQ+ZO8=;
        b=jD+TV2IZP6qsQuH03DAH/ZMWUXB4e/5vLES3oQSkseG3yAtg2pSmk+aBsW1wrqRVdv
         GOZ4Ljk8JBMhD1d5aQchNa6gqWDCHIcqYdSSNTl4//ZsGs/9dKNg3BU9FhcvtVPbxtjt
         2UOwNemogzniGxGuxzuQpMNTjYzrxPQZixO9w1srW7DsiE4tHywDtqZibvTKg0QL18JQ
         nqBA3hZPg6zzTgA/v0RbY6+RPU/X0f8GXGMX+f4x9cs/p1P478w1CwMV6zUPUfhIXWCg
         +R4hc75F0YxxLfpphEW5HAfrc66fQfzsn2thkE/2Ll+xm13ZwaeYeAmxS6fyNwJXVfHn
         NOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLdbSR9/I9UWE4egIELKXu7JM87M2XfBH4X1udQ+ZO8=;
        b=QpZedYpYVD1jA4n+/vJ6gddgEUXp7J/+X23EcBa/KTOnPIyDgxioR1zKLP5iGov/hM
         bnJgVZz1HUKqrJ8pv2Rd4sm3dBDKXxwo4bhHX40nR0/65Gz12aNQYk37EEuJ4QeI4Iix
         qtYyvgXXzT33H22QL2oILRbLT0o4tX8Gta+z0q/J+2HIzFhmdjB9w+u1HkxhK8xRFeFq
         pRpVJgN4lncMFx8Hk9tcERrC8MtWtnyoNoe0Hr/tXfdusMChPTxYnWGunWv2mFa3p3RQ
         /dazpHU8DIlQK3TeM2aIxSmz3/k9H8zJ8vjJlVCKWCdTZlFZKma16RwNZvcNRHKMcwTO
         MWug==
X-Gm-Message-State: AOAM532jMLpPdnOiBY+D8ZzhAQekTXIYEhfIzIA+C6slb95Dnwfm/pJM
        7DATGCSMami3P/ud8ohHkqc=
X-Google-Smtp-Source: ABdhPJykIB0WVfubWtk5f4EQngbvyhBx4yZfpBccR0mL1BHAt6DWuoxboQZEHd3HHbWfzEMfQFSuYA==
X-Received: by 2002:adf:b348:: with SMTP id k8mr28057726wrd.435.1633531175684;
        Wed, 06 Oct 2021 07:39:35 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id d7sm21313944wrh.13.2021.10.06.07.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:39:35 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix typo in testing/sysfs-class-cxl
Date:   Wed,  6 Oct 2021 16:39:33 +0200
Message-Id: <20211006143933.129960-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repeated worlds: "the the lowest" and "this this kernel"

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-cxl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 3c77677e0ca7..594fda254130 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -103,8 +103,8 @@ What:           /sys/class/cxl/<afu>/api_version_compatible
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
 Description:    read only
-                Decimal value of the the lowest version of the userspace API
-                this this kernel supports.
+                Decimal value of the lowest version of the userspace API
+                this kernel supports.
 Users:		https://github.com/ibm-capi/libcxl
 
 
-- 
2.25.1

