Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD28F345EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhCWM6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhCWM6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:58:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hq27so26928751ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bk7L2JiHDOx/IGuh0r9SJpyYVpnH5cwXAynzQTVb+fA=;
        b=evIvxGk8F6FMbM/wbZcq3iLealOF/+nq4mwaFSYfQulJ2VV14TR4njINb5qdTmmo5I
         jIq1dc/uoser/WZsbEzzsAGbSX9+nxrHGt9s8Z4OUhWgt334Rvxa2wP7OM9EnAyULlMH
         CPjFfUK/ZiNIJmzVWDBeq8lTKIpGsVZVEp5n9OS8uTPFxXuN0nXNP5k4trK+6Xm/ychC
         1VcfrImW7RzmPdyeVimMnS+URBQjZdaXKioHRm5up/naEfm23+IyJW2Vh+NMY6ULlQw+
         6jUbndCo82mFGNtZtTBHik+wRKIaYz302sWKCDbgX1tlvXmDwnLqzyOjYpBB8GTGnam7
         PucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bk7L2JiHDOx/IGuh0r9SJpyYVpnH5cwXAynzQTVb+fA=;
        b=sxjzrgfx/1Ne097IFTab+Z61uPYrNbSksJ9eTxjJy4jJImPsqFZeYTuJn/Mou5pjYG
         +Wrafw36CikI9MJek8L8wPCdF/ifA+kuOgvpW1eGbyQcFQx671aU1VsDkNoi5NJD9xbO
         ZFSVodceYWOyg9ljrHwN6O60bBODtYOf395P1o0H/pbky/HrCX3oTy7HPq5uPQB+15zJ
         bmL9xBUvhDWDg6D/0/7PgL7iKwjd7YdydqCC0Ci/B/acOpIBQovtf63jmbB7OHUcBVyR
         u9BLzVt2aoBahjyZP0pPVSGc8d1rBRyF3a4fZ4Kb79zwnOoqovAvgEff1tQIABbEdKc2
         zeFg==
X-Gm-Message-State: AOAM531Bn7BkzP0x9bAnWJL0yzZfl18KQLcsorEwB/6Str7ZtDtB+TFz
        kmPN26PcKI5OBmDd7Jl/fIU=
X-Google-Smtp-Source: ABdhPJzvBMpe69lE5RczGwx1OEqElK5/Saz9R1hrYXUna8Yi62WFIySfbS54PrBZmhTWCZlkLgH/AQ==
X-Received: by 2002:a17:906:110d:: with SMTP id h13mr4841823eja.357.1616504295130;
        Tue, 23 Mar 2021 05:58:15 -0700 (PDT)
Received: from agape ([151.57.211.10])
        by smtp.gmail.com with ESMTPSA id q16sm11051013ejd.15.2021.03.23.05.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:58:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 1/9] staging: rtl8723bs: removed function prototypes in core/rtw_efuse.c
Date:   Tue, 23 Mar 2021 13:56:28 +0100
Message-Id: <e9137945e66eccae8f2ae3eabe720ea648262eca.1616503354.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616503354.git.fabioaiuto83@gmail.com>
References: <cover.1616503354.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
35: FILE: drivers/staging/rtl8723bs/core/rtw_efuse.c:35:
+bool

removed two function prototypes in core/rtw_efuse.c and
made definition static

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 32ca10f01413..3701336e7ff6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -32,12 +32,7 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 
-bool
-Efuse_Read1ByteFromFakeContent(
-	struct adapter *padapter,
-	u16 	Offset,
-	u8 *Value);
-bool
+static bool
 Efuse_Read1ByteFromFakeContent(
 	struct adapter *padapter,
 	u16 	Offset,
@@ -53,12 +48,7 @@ Efuse_Read1ByteFromFakeContent(
 	return true;
 }
 
-bool
-Efuse_Write1ByteToFakeContent(
-	struct adapter *padapter,
-	u16 	Offset,
-	u8 Value);
-bool
+static bool
 Efuse_Write1ByteToFakeContent(
 	struct adapter *padapter,
 	u16 	Offset,
-- 
2.20.1

