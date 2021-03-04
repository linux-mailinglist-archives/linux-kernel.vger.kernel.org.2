Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC832CA86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhCDCoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCDCnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:43:40 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 18:43:00 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id s23so5836882pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 18:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9XOASjZi/B+/Tdwk2J3ZNUj0y7LUvV1fcbGUGMVUVQ=;
        b=jKnyWjMFC/FhozUcL9k4EFK6CGCMb8g4drCfBpEMtFEzQz1ZaB65OpQR0DhGOw4I4H
         dDnK4AGrO8ehFSbDCC78cw/VsKRF9aEgRlrspuUgyEeG1KPNSRzn1wHGjol+KRWFDNnq
         marKQZUVwgoGZuJZCW9DZb7ePiTqhuC4PITlF3pIXRVjzXpkGLqO6D4BUdhgc9pv5c4t
         UR5KJZn651nJwuqBu7k4Xs6XW9I21QyKFi0FmKN7X1xvF64cQ3PQc2DWsXR4n4EGd1mw
         OiemnJrB25gLUWpWShpai57xC9OUYk2zeaI709ZXoXd/SegSHcjcEupXslQB75x4Ym08
         FbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9XOASjZi/B+/Tdwk2J3ZNUj0y7LUvV1fcbGUGMVUVQ=;
        b=kd1MeJ/AL0WZzyLsK78L3hI9vnZvzmwRhEAHNL9nos2J2waxGH3Y2PKk4ZtdnSMPY8
         4ph+yxVNc5s5ZwYCNvJkuK07vdYP+VItGhBd9LzS5PR7QpHs25htlkng+TuLdAJdqq78
         Bvik/3NOghVG3gQYH49RkQkbVcXNDkUdYiYfXeO36k1ign0QFaeDC8hb38TP02xVeg2a
         qU2UrCWH6jmbr4ZT5uyLAamFPHvGLV5AK7cBagstFwjJ8MhcIUE1IK6qSLhL9iQryiyu
         5sconaG34hcsHl40HGgqxE1Ykjd45kq0pdYBfwIZSZ+34qABylW1Cfignb+6lAiECk2Y
         t8qw==
X-Gm-Message-State: AOAM532WhayNenAlwZFL68E5q2LupikhruRRfbAuKkepHeZ1LYp7dOn9
        fLVo5J72LBk5GVBCbrXVMH0=
X-Google-Smtp-Source: ABdhPJye1qLaewI6IUQ0dDIT3PhMsjFm31Z9Qc/lnYueo/RHFFUZBjoR84pSVYn8cMj5JyyGFUaJGw==
X-Received: by 2002:a17:90a:4598:: with SMTP id v24mr2185607pjg.102.1614825780360;
        Wed, 03 Mar 2021 18:43:00 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id h27sm19068913pfq.32.2021.03.03.18.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 18:42:59 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        clg@kaod.org, aneesh.kumar@linux.ibm.com, rdunlap@infradead.org,
        ganeshgr@linux.ibm.com, zhang.yunkai@zte.com.cn,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/powerpc/include/asm/book3s/64/: remove duplicate include in mmu-hash.h
Date:   Wed,  3 Mar 2021 18:42:51 -0800
Message-Id: <20210304024251.187564-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm/bug.h' included in 'arch/powerpc/include/asm/book3s/64/mmu-hash.h'
is duplicated.It is also included in the 12th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index f911bdb68d8b..3004f3323144 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -18,7 +18,6 @@
  * complete pgtable.h but only a portion of it.
  */
 #include <asm/book3s/64/pgtable.h>
-#include <asm/bug.h>
 #include <asm/task_size_64.h>
 #include <asm/cpu_has_feature.h>
 
-- 
2.25.1

