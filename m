Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83A32CABF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhCDDOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhCDDOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:14:06 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1353C061574
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 19:13:25 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 192so10888846pfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 19:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihoKSZ2JtK+MDtefdQWwboq2xXWO3Hg5YVvclpQVx5g=;
        b=P1RKrCmcyt72RM+mT5U3wv+Y6ZCAlh1TDPusj76xHpMxld6aqdApN0VbV6bdw1UOTm
         RwOKeE1skOWwGJn3D0e58HcwuqTf3nX2MbV9WtlXH55e++I8cFj4CvqjnCZ2AAbYMd00
         MzGMed8W5X6pfJFE0kHgF3lbvu4E0N1KmycLLuas+Qe9Jv8mCzS8fTdSHoulSI+FHp4h
         rygNL3TCbzSo8MlPG232oDXtcw4aetTXMzFRpPpJNdeDfXOAVD8LZUKtYjqCRye7uQCy
         glpyo58HUH7nytBHPr3kB90vcgdxNIV+bYTIzSWTsNjc8D2wXTUSC9OvwkJMcOlDlVg3
         S5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihoKSZ2JtK+MDtefdQWwboq2xXWO3Hg5YVvclpQVx5g=;
        b=mwr0+hU/wmOch1l9XvWFDcMMCHALl37xCQ1y5xKyouFb01hLhdTOGccynZrWbdFTSJ
         wC3TM/9J9geD+M1vAPkjJRCPskvLi5krRSVUTBmATuAvkSynbCT8nlDjNyAId9Llpzby
         bhTWO+0ikeX0HC/3szP8Kv8oZCaCmmjj14RiuZHa8NfG3RiJ9nG1hnq9+bMkiSwVsj2Q
         drMrKPA5BdXi7je0UnWodQxZJNH14fvKewuE9GFmEosgV+DdqVMvXNgvh7TYLWvmFqs3
         LT/wuRuwSYGqQucni2MSzqWsLzwHdEFnwg+lMZHY4Yjes0W/0aJ18JJrptkVc15dF/hn
         Gt4w==
X-Gm-Message-State: AOAM533sDgoAOkx+VXCStZXGcBcgjkkYiwUydTx7aja1WtmL/qeDdNzc
        afyhx217GmfhRcyY+9tUUW8=
X-Google-Smtp-Source: ABdhPJxRoYgeG9aLI7U1DV8vNSoXvmH+4j6ry8B4mBA8KTEj9Gza8qAiTHGa1ohkLtxDB9OAhWWRug==
X-Received: by 2002:aa7:93af:0:b029:1ef:1bb9:b1a1 with SMTP id x15-20020aa793af0000b02901ef1bb9b1a1mr1078028pff.49.1614827605544;
        Wed, 03 Mar 2021 19:13:25 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id 192sm23447754pfx.193.2021.03.03.19.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:13:25 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, zhang.yunkai@zte.com.cn,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/powerpc/include:fix misspellings in tlbflush.h
Date:   Wed,  3 Mar 2021 19:13:18 -0800
Message-Id: <20210304031318.188447-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Some typos are found out.The information at the end of the file
does not match the beginning.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index d941c06d4f2e..ba1743c52b56 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -79,4 +79,4 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	flush_tlb_mm(mm);
 }
 
-#endif /* _ASM_POWERPC_TLBFLUSH_H */
+#endif /* _ASM_POWERPC_BOOK3S_32_TLBFLUSH_H */
-- 
2.25.1

