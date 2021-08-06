Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB73E23FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbhHFH3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243598AbhHFH3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:29:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D486C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 00:29:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so21281025pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 00:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evRELab/od3swzEnyTJ3kCERyJYRDRXXFndzUan6iHA=;
        b=tbYsSF9Gj2dWly5tH6AC9JckCFsXnKWBP/P9FnU13Rz/8pLt3kXrkZaByErdagtHA4
         zR49GIhQnVw8bWVhHnDPEpKlCVU58ENLM6JGhXCSJvoOy7x/fDARzBhwfrZkzX7fCNx+
         o33UIn6eCLUZpwsYFPKG7WQZ/lMeGge6WzRqXKt4x2VdMA5vN4aWoStFE7B1cTHd6AEM
         O9EjTFLvGMldnX7Imz7sbFfc4FrMObxFjspuhoYK+srtSVv9TUwDOlau/1xOMrzPozzc
         o8CV8eTcEDIo/xWHY35rTb7U7AHL+ViTz5D02N6hypbYGUe/hVJt8HzI0sNtCKCKbeKJ
         dfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=evRELab/od3swzEnyTJ3kCERyJYRDRXXFndzUan6iHA=;
        b=mhm1oxDonjHP8M+CC521nZiPenvlNpeltKwFOZaaNVpgwgCQcsHeIRB8AQsvvFwfYB
         2hkrf4fzdJOLxvFT5R9lbo+goaAh/8ctpmFoR3EKr9kSRQEM8HNF8ZyyEZm32I9S0Jzg
         nK6BFWLOS/QSWWLdhaT/MnfMEqASdZLUjR67R2MfN3l1uEncxy0vMp1zrbVMXkEXvAt0
         W7AJ4CQA+dilp5D4kQ/IUBgAjzdlAbBIUsqmIVuhfd9rEqqkrRFoLvuTRIBnYGdlMwWY
         jIEWZSdflqXJNvokJt2kiADeQc7K8LojwzPt0p+hufJkWAF97pMBIkXAZCo59u7/w2Kl
         5Yxw==
X-Gm-Message-State: AOAM533sOxVidxyTyFnV384okZzdecEvSXRMPeTDAnOxznbQQaYLVBHP
        Zrw/ySaEZww8NIf68J79HFNspiqJIGw=
X-Google-Smtp-Source: ABdhPJwUt7aN1ooqit1gYE3cEL/HYXHDrWhq1Xi+B95bugTeka8nlWJsNSF8y/ZAayJgFT5XvJGw2Q==
X-Received: by 2002:a17:90b:ec5:: with SMTP id gz5mr8743648pjb.77.1628234940772;
        Fri, 06 Aug 2021 00:29:00 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g23sm9951576pfu.174.2021.08.06.00.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 00:29:00 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yong.yiran@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     yong.yiran@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scripts/sorttable: remove duplicate include in sorttable.c
Date:   Fri,  6 Aug 2021 00:29:45 -0700
Message-Id: <20210806072945.636611-1-yong.yiran@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yong yiran <yong.yiran@zte.com.cn>

'sorttable.h' included in 'sorttable.c' is duplicated.
Remove all but the first include of sorttable.h from sorttable.c.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
---
 scripts/sorttable.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 0ef3abfc4a51..cb080c71a66c 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -188,7 +188,6 @@ static inline unsigned int get_secindex(unsigned int shndx,
 /* 32 bit and 64 bit are very similar */
 #include "sorttable.h"
 #define SORTTABLE_64
-#include "sorttable.h"
 
 static int compare_relative_table(const void *a, const void *b)
 {
-- 
2.25.1

