Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB82F345096
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhCVURc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhCVURH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:17:07 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:17:06 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x16so9340806qvk.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcS5dQnvT0EiMWmTQeHKxUtGPVRxLUYjS83TJVzvx+k=;
        b=MDK780PDa68smMWy8dlBgBO1PT8Mm/nclrmBTOUsf+/+6uS2UU4D7XjM1CKAoBMCNI
         m+hTtLDuF6QSo4iSwAamrGHUvBE1m21GD1FKUqdhKgGRm3R2WM6ToZK2sur0Xv+ZGIf0
         lBmP/KyGYi/HW2XADCxat3UK3LYGnfdbr0a0NqOw5heZABYTzS5papkYBDEJD94CUUwm
         tUU9DG42JoWdlTzMSQBEiZ6ORiJD6FPOOQ6F95zSHzXM9Iw16VQBtenrGUxa5A9p9oas
         010SKR0FoPRb7nGby+ifI51atFOkIWkoRjo1Lma+k6z+DlRvf2KlwGHbKGJqBzoIJHXW
         S6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcS5dQnvT0EiMWmTQeHKxUtGPVRxLUYjS83TJVzvx+k=;
        b=Tv3WmFvqtnh8opbO7hwgmylhbIMRGOWm3eXQjtG53nGT2t2E+7q8/HNMLoPHIp4wIn
         uRcmXkpV1UbxGIttCe4ILQxDw7RJJ0NvTI8WB0T3gHO+WljdtYWV9spuzWf9Hll//NBH
         mql6eoWn/yaHOiLdDO2ocstNXTcNR9M6Hz+j7SnH16BuAwYuDdAgiCTP8adUWZaOuuHm
         z3LG7FLUJ57h1FW8RRkfL51Q06nIEMuryxdzoz76uGryZSpzgOgzCfXUY7PaJ6jBliIl
         eKu+oCjNi3adDsoimax8T20EpEmATu3ZDQDu7Mdx4qZbdXLaCL0Q3VWR71A/IuKfevmZ
         8PpA==
X-Gm-Message-State: AOAM533DWLAlIllB7k7UM/5aftt7F0VofXz0bmy0s83cbMwF8sFfRo8M
        bWLKCXIbV1Kkv1bj3l5H6Tw=
X-Google-Smtp-Source: ABdhPJxWjJ772wUsSBvj273tJJK9LFsIcXBnimb0hW8Ojb6Lm03STXD2Twf4k5u4V3OXiK336FQPvg==
X-Received: by 2002:a0c:908d:: with SMTP id p13mr1450243qvp.11.1616444225007;
        Mon, 22 Mar 2021 13:17:05 -0700 (PDT)
Received: from localhost.localdomain ([138.199.10.68])
        by smtp.gmail.com with ESMTPSA id y9sm11530620qkm.19.2021.03.22.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 13:17:04 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, unixbhaskar@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V2] staging: rtl8723bs: Mundane typo fixes
Date:   Tue, 23 Mar 2021 01:46:48 +0530
Message-Id: <20210322201648.137317-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/stoping/stopping/
s/arragement/arrangement/
s/eralier/earlier/

Plus one extra word in the sentence "the" removed.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  Changes from V1:
  Greg,pointed out my mistake of introducing typo to typo , corrected.

 drivers/staging/rtl8723bs/include/hal_com_reg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index 37fa59a352d6..b555826760d0 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -1002,9 +1002,9 @@ Current IOREG MAP
 	/* 		 8192C (TXPAUSE) transmission pause	(Offset 0x522, 8 bits) */
 	/*  */
 /*  Note: */
-/* 	The the bits of stoping AC(VO/VI/BE/BK) queue in datasheet RTL8192S/RTL8192C are wrong, */
-/* 	the correct arragement is VO - Bit0, VI - Bit1, BE - Bit2, and BK - Bit3. */
-/* 	8723 and 88E may be not correct either in the eralier version. Confirmed with DD Tim. */
+/* 	The  bits of stopping AC(VO/VI/BE/BK) queue in datasheet RTL8192S/RTL8192C are wrong, */
+/* 	the correct arrangement is VO - Bit0, VI - Bit1, BE - Bit2, and BK - Bit3. */
+/* 	8723 and 88E may be not correct either in the earlier version. Confirmed with DD Tim. */
 /*  By Bruce, 2011-09-22. */
 #define StopBecon		BIT6
 #define StopHigh			BIT5
--
2.31.0

