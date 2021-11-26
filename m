Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6351C45E887
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359297AbhKZHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbhKZHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:36:48 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A772C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:33:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id m15so7433133pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16JkrWDW1ZCw0t6XTkGKvbfqjhoCsrZm+BanXO7M8jI=;
        b=TI7OKLRL67Pzowfz8nXQFKpdm8VNcmKpmmy4JAL3d4i5FvKldYz2bfUiSypTQnVv9i
         GrRw51CykemIzXCMBksmRlzveMH/GpKTot4LSRC241yJ57miRRcKqe3GJEIMKcmLThwS
         zApuSJvEoDhy/q3AQDBzdalrHKCz2ft8Y36Y+qvdaJ0J3gULm68CVLxi5S+fbdF5W/l4
         7oiZ64Y7MvblA3AubxRXfSv3feUe43jpvxVQsI+Vd4PRQQ7s1yHwp4aW8BVktiqKJU37
         8ZvOC6tcO0WGdaoEXrkfybGGPlAnQ1oOUZCsIBTuh1oL79PwozBov4jAivqsfqDts6E4
         Ww4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16JkrWDW1ZCw0t6XTkGKvbfqjhoCsrZm+BanXO7M8jI=;
        b=FAufVdn2cT7E45xHkeVXJoHfMt819VJCVPEVHTCZYl/puNwpvhYGb9ZPQMH0LErcvb
         UzpVW282w68eT5VIf7+082vdGo2I4pe133VKBwzjOUhiX0bE2Yv/xrt+OnZAcx2R2yEE
         wfycBx2muv6A4km0Q3EfqD/LN5a23gLAmYpTR83FrTbWfTirxst4RYEW0rVd0OMF+qPl
         vL/wMzPXabkDWU5MAZL/ZttWsOQfgJOtvYpr8DsQD7/iDcW85sFVw2C/uDhhlfA20wvN
         mT3x4dIuAuEMrseSoAq2Ue50I3gFHzh9Y44s3/oIeFPdXfdVxhn9m1SDktbN/kdxhn3C
         +X0A==
X-Gm-Message-State: AOAM532n3ZsHWgGK0RHe3oYoMWjPhEZaNKeyJRV2Jj1vdNmeTno8HUVN
        H1TlnVkrWiUrKgCwBzRP90Q=
X-Google-Smtp-Source: ABdhPJwaNrXxoADCPvu6ovFJDPA/SAP9b+qZtdY2bjLoXOTNb4BfjfzbLDKAQsopNwyHgXD8o/vn5Q==
X-Received: by 2002:a63:7141:: with SMTP id b1mr20374573pgn.321.1637912015895;
        Thu, 25 Nov 2021 23:33:35 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c6sm6317825pfv.54.2021.11.25.23.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:33:35 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, willy@infradead.org, rppt@kernel.org,
        dhowells@redhat.com, shy828301@gmail.com, maz@kernel.org,
        guro@fb.com, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mm: fix boolreturn.cocci warning
Date:   Fri, 26 Nov 2021 07:33:27 +0000
Message-Id: <20211126073327.74815-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 52ec4b5e5615..6765eba52dea 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -383,7 +383,7 @@ static __always_inline int TestClearPage##uname(struct page *page)	\
 	TESTCLEARFLAG(uname, lname, policy)
 
 #define TESTPAGEFLAG_FALSE(uname, lname)				\
-static inline bool folio_test_##lname(const struct folio *folio) { return 0; } \
+static inline bool folio_test_##lname(const struct folio *folio) { return false; } \
 static inline int Page##uname(const struct page *page) { return 0; }
 
 #define SETPAGEFLAG_NOOP(uname, lname)					\
-- 
2.25.1

