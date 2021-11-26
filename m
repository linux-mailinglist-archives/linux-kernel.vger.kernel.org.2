Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50245E908
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353394AbhKZIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbhKZIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:12:36 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A4C06175D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 00:09:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b68so8160806pfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 00:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YNKBs5usPgzpPqq6ik3NWOvzOHf+lZiBAS4akQ6+MM=;
        b=NWsHTunyuPmjiha7Z6av7nj9o2qg1IhGgN58uu6F+rlX/zgqST3eb2gvnZVJgpmu8r
         OTPEwjozqGVtTERphQ8dXtIVKXtQ3znSHxBdpE60nD+9HbNOy5vCw0uh2RNJEhapdj6U
         /9/4+HtwRnQote0pl/3Ma/daT0trFvHzH3Bs+nT+I1xj3unQ6vtAY1c3whVaZlaAj2nh
         sng3er8E7whvhBr4Usm74M6UjuhgdztPOoGcaWLPeZSEWhN5iAkx3b/kST0eFijVzX9A
         A8+d3EEgPeAk0pFUhZ195/gq98Q+Z9QunMAnhSR6mzTftQzlmd9V91eGy3poUPk5eCan
         292A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YNKBs5usPgzpPqq6ik3NWOvzOHf+lZiBAS4akQ6+MM=;
        b=YRjOlhh2GitJPnIa2Ts9ru9vN8dsGSHW+O+Fw9zjhd+bpeojm9pWmtvx19ED0JkQpi
         rI46o1jjk+QxuDIWtnWw6Y/2+Mp0EbIKw4bwfctlszfZCHP101oh10+SXPz0i5b1+ZR3
         H/eKBm2LhUBpTQjSdLzhW8uLr+snvEGI4v3p878cOkwSRC7W4vHC1spWACWj2v4DEKYd
         oKWyoMWUWj9iBo+EyTz1qb+009LxDIIj19i8hhZW6/iwWNHGAZM4r9k2Dd398tae40Gl
         WpxX17YoIkP8fSyDsb4y+hGoT+gf6yDx+vyVgj/kVYSx9f7V/Y74iMnukluKNlck6aRK
         JM5A==
X-Gm-Message-State: AOAM5309vsx1UssYXejBGCQHpULmDLN+7UU3SZM2IOM1WKDvRZcWj4pa
        2WxEY9/qQInrmVvMpQqv2wjJyMGCdy8=
X-Google-Smtp-Source: ABdhPJyLM8ggQ9gF6ni+vIW1jlOhqcC1ZVJyzFR8CwvkP9TPfGjR6d74WZa6pPppH5faU8j40tPzuQ==
X-Received: by 2002:a63:7c4f:: with SMTP id l15mr7168872pgn.310.1637914163509;
        Fri, 26 Nov 2021 00:09:23 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p128sm5743428pfg.125.2021.11.26.00.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 00:09:23 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, sfr@canb.auug.org.au,
        deng.changcheng@zte.com.cn, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] x86: mm: fix boolreturn.cocci warning
Date:   Fri, 26 Nov 2021 08:09:17 +0000
Message-Id: <20211126080917.75495-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

./arch/x86/include/asm/pgtable.h: 1394: 9-10: WARNING: return of 0/1 in
function '__pte_access_permitted' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 arch/x86/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..fc4801d1863c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1366,7 +1366,7 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
 		need_pte_bits |= _PAGE_RW;
 
 	if ((pteval & need_pte_bits) != need_pte_bits)
-		return 0;
+		return false;
 
 	return __pkru_allows_pkey(pte_flags_pkey(pteval), write);
 }
-- 
2.25.1

