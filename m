Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7DA3408D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhCRP1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhCRP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B3DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id 61so5957940wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLrf/idKSuBG9Z4aKpcHo8trBmwta8+HIak4S9z56K8=;
        b=fDcwuv3P0lFTUn+bj8GgIp2qLgsGKDW/5flGP5oCIg7yXTZCT7LVpeosHLeERsr2GM
         jEXaQtr34wW4tX6XbiRiOL9ZrXYtegAwrk0X7hJmCBFL9+2+zcDeQcBOtCezyJ6J2Gac
         tZBCS0OG1QssV0Ogvcee+o+ukgfIgksogEY4+AZQlcouY3nkGxekphnOQPmrJJgblunC
         ePnWqZHXR/VoNv5dRPo+nScNqBLa5BjoA0WTJlIhPrdLCMyf1D95Fq4zBen6Gs/s+qE5
         /GQc94BW7hnru5K8DzrjzUZS5j0j9dIdVsbjkvFEM+isJTCrO98Ur0rEeHwVlaTR+r9r
         au/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLrf/idKSuBG9Z4aKpcHo8trBmwta8+HIak4S9z56K8=;
        b=tOjmAw+yJtE9jx+JiLLaf4I4ItDZ11LgkPs1tfGTDmEoVg34Zp3L0G02FAJXVRA/mI
         q/f5t+pLwimbxfkbVxpPbMWtjHzii1rGe5aaxz7+oLXbSil2LrqzSmpaf6ZRnFZHyRAG
         F858aBcgWynflS4t7d1Edy0rFvkfoYMPUYAePRn5yTsHg3z1y7AdKzd4Ozrypr/Q1qHO
         62EoPtysfSluAcFJRfZ2GMj4Ntl2Fvm3kFkeJbFPyNwMvhcFgz/iU1hjQla2TU2X+25I
         zdUU16BP6hNhT8bx4chQ5OUoc7sZJXl/bktdJ4ODFfHTyy7UAonkogarmcAVxEvpGfN7
         vgVQ==
X-Gm-Message-State: AOAM5321QzB20UF+JMwd2OuCq9/y5758UhFH3HOD47fGfe5BJmrOyre/
        /GerZBmRs9oKXA/Il4N1MKI=
X-Google-Smtp-Source: ABdhPJxSnNwdUos1T6LcbZlV69qRT2hYhSbx//fPL/GHuqsCwS4RhA2qxbuEZCPlWACnUKH9aCEuwA==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr10018255wru.316.1616081231143;
        Thu, 18 Mar 2021 08:27:11 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id p17sm2389189wmd.42.2021.03.18.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:27:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 11/15] staging: rtl8723bs: remove unnecessary logging in hal/rtl8723b_hal_init.c
Date:   Thu, 18 Mar 2021 16:26:06 +0100
Message-Id: <20210318152610.16758-12-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1685: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:1685:
+/* 	DBG_8192C("%s\n", __func__); */
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1722: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:1722:
+/* 	DBG_8192C("%s\n", __func__); */

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 9bcceb13ca2d..cc7f9af680b1 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1681,8 +1681,6 @@ static u8 hal_EfusePgPacketWrite1ByteHeader(
 	u16 efuse_addr = *pAddr;
 	u8 repeatcnt = 0;
 
-
-/* 	DBG_8192C("%s\n", __func__); */
 	pg_header = ((pTargetPkt->offset << 4) & 0xf0) | pTargetPkt->word_en;
 
 	do {
@@ -1718,8 +1716,6 @@ static u8 hal_EfusePgPacketWrite2ByteHeader(
 	u8 pg_header = 0, tmp_header = 0;
 	u8 repeatcnt = 0;
 
-
-/* 	DBG_8192C("%s\n", __func__); */
 	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, &efuse_max_available_len, bPseudoTest);
 
 	efuse_addr = *pAddr;
-- 
2.20.1

