Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6728A343A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCVH2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCVH2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:28:21 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD20C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:28:20 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 30so8154159qva.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 00:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CvJ6rom7YY2JxgL5QXExmKWi8Tr3HhiQ2VBpZ1icLU=;
        b=SiQfXqrqlzmrCUMHKASQWt/0u6+96Y5/LcPlFGCMf8Cab17PPKKdPQvfumg5aZTlCy
         8/JbezXtuqAGbDZxDRl/G7oXcoseIcf1TtRJGH5Ix/3ZEs1rHNuEahrvh6VI1mx8o6Mv
         6sY+5kB2p1hLdCYcbqN0srYlz72HMT2H82bvqe0s0z9pI/YaRp3xCpDeIVoD1tZOQXJa
         kpsvU6Zizo4MYMMckPRsmgAH4A4GLdDzFw+SD2ag+vRWCxTzKfrRF9qBvidoxcAODlmG
         LW7fbkPR34t6mUB54pOn6G3R8wMmtGiwOLT+y7tiRzWYxcLh/cGk/JkKd4NNiufPsFdj
         sGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CvJ6rom7YY2JxgL5QXExmKWi8Tr3HhiQ2VBpZ1icLU=;
        b=p0Ov3wIoBt4MRLXjciIyT5mmRWB400TYe8ZQN7Swv+DTyM+MHiQiPqczf1WqL0/AvK
         8eer9ZrI+Pqsnl54BLtjJ/IN7OyUqUD8lAjx72lzfKShgrjCOD1YWJ0pM/GXkzmKBxuT
         mBpzNDQxK1HpVvAlhtxrTiAzYAysowZ5PVi7v82JQjr3T7DccfXdcN4hyGSMboyNvYTX
         5bhbSqvFqAWbt42qSzwvoPk8tx+ML5z2nJFNS5NZcx+gG48Q2M3uFyv5Jqguy/GaUjTl
         k+i2tXnsi/XxEt58Hwp0GbN8kYpd73UlddSD+/2ujF3wNJqE5zi82Nl+sJemJN/WRBbd
         KjuQ==
X-Gm-Message-State: AOAM532pbtKto9j/Iqpzi3A2wEYuqcW990Ov25bmC5k0UMdeBA24TO7j
        1AkyzEcOzUjT2bqEp4XoJzk=
X-Google-Smtp-Source: ABdhPJzmvIxJ+RmsW2s9tucclxBW8v59ePG5gdZ/syrVIxFipW+9lPVSWodnmVlgakaE+QknBpyqWg==
X-Received: by 2002:ad4:57a5:: with SMTP id g5mr20239805qvx.60.1616398100037;
        Mon, 22 Mar 2021 00:28:20 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.221])
        by smtp.gmail.com with ESMTPSA id d68sm10258251qkf.93.2021.03.22.00.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:28:19 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, unixbhaskar@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] staging: rtl8723bs: Mundane typo fixes
Date:   Mon, 22 Mar 2021 12:58:08 +0530
Message-Id: <20210322072808.996970-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/stoping/stooping/
s/arragement/arrangement/
s/eralier/earlier/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_com_reg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index 37fa59a352d6..0a01a216d572 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -1002,9 +1002,9 @@ Current IOREG MAP
 	/* 		 8192C (TXPAUSE) transmission pause	(Offset 0x522, 8 bits) */
 	/*  */
 /*  Note: */
-/* 	The the bits of stoping AC(VO/VI/BE/BK) queue in datasheet RTL8192S/RTL8192C are wrong, */
-/* 	the correct arragement is VO - Bit0, VI - Bit1, BE - Bit2, and BK - Bit3. */
-/* 	8723 and 88E may be not correct either in the eralier version. Confirmed with DD Tim. */
+/* 	The the bits of stooping AC(VO/VI/BE/BK) queue in datasheet RTL8192S/RTL8192C are wrong, */
+/* 	the correct arrangement is VO - Bit0, VI - Bit1, BE - Bit2, and BK - Bit3. */
+/* 	8723 and 88E may be not correct either in the earlier version. Confirmed with DD Tim. */
 /*  By Bruce, 2011-09-22. */
 #define StopBecon		BIT6
 #define StopHigh			BIT5
--
2.31.0

