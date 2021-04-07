Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549C5356DD2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352628AbhDGNuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347651AbhDGNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBA5C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so1133814wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEYszmz1b6maXp+qOcJyOQv8oWJtKUU4rpksSTFfGVw=;
        b=UcZDaFWnP3g8gAyuC+WyXUyrsH55ns19PRfWEg2viGGYJZXcRPknZyLIgfF+0PVD34
         12BOEtuq+gTzocetdWjHBW1mtSMNj/Ul73q0tP5mlhu08sip/mj1sjBjJDik+GTHSkCq
         iCxc1mJE0NYuEGgSRg7HHjzum7ciIGB/MsrXtxRFysDKaLS6qhD2wWzy3ZHXtG2gPmpB
         wJ5mN2sdTGTDEpIgzkuXui7cyHsWk606qAGe9NfyfhFamdoX2GempSgjjDUFnKIyNGmr
         MonuoMjI4o6XpRXYtimmGeSM7aiKKfgZOPkn9RVsT4Jq3PPg/hcGJ5QpTxP4tV8qSeNr
         PP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEYszmz1b6maXp+qOcJyOQv8oWJtKUU4rpksSTFfGVw=;
        b=aTRnGDsBeZ0nH6oYDOHxBGMqOzbvVe5/QQCfOnMVylEOCTXgs3ZsYPHUp5RPTgzU+t
         +If6bXflab/z/rc/zfZhKV3Jiqi3pjWPrTjneaUR5m7rdQxrtGvaEeDO+e0E9M6OV6RU
         5KxicA1t8RI+w/+xqmBygwdnppxN2dX8xCHBy755xNYQMXv+24Bvvud0YAXmBm5wXm75
         JbV4sacFkdgn4zTTBsFimrukPKAPGx0HnKnN0pX8iyy0npe/AW2qKBiXCgioRiTFVvyn
         rySWb1wv36xxj98uof3XiQUHqDzYmQJRQaFYzD03fpK1FwHulOEotxOXoz4qvnwkBEuS
         HCzw==
X-Gm-Message-State: AOAM530PcUEbw6SL0wSz79pIRYXrlzMQ86/B3GnkxWP+ZnJynsZfE0Fi
        t1J748ulXCcNH+7cssgxiXA=
X-Google-Smtp-Source: ABdhPJwgwfzyxR97wHTllkeb2iJrQcs9jcqP/JgFOW+j61f8X21lfyBNE125AAI6BOEVc6vD5qTDNA==
X-Received: by 2002:a5d:61c7:: with SMTP id q7mr4566781wrv.215.1617803402827;
        Wed, 07 Apr 2021 06:50:02 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id h25sm10387338wml.32.2021.04.07.06.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 05/19] staging: rtl8723bs: remove DBG_871X macro definitions
Date:   Wed,  7 Apr 2021 15:49:29 +0200
Message-Id: <53632cddb1da639c84fa52c2818904b0e1298a6e.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DBG_781X macro definitions.

Remove all of the DBG_871X logs as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged, so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 6639d79cd7ec..4c159c1a0747 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -131,7 +131,6 @@
 	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
-#define DBG_871X(x, ...) do {} while (0)
 #define MSG_8192C(x, ...) do {} while (0)
 #define DBG_8192C(x, ...) do {} while (0)
 #define DBG_871X_LEVEL(x, ...) do {} while (0)
@@ -197,11 +196,6 @@
 
 #ifdef DEBUG
 #if	defined(_dbgdump)
-	#undef DBG_871X
-	#define DBG_871X(...)     do {\
-		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
-	} while (0)
-
 	#undef MSG_8192C
 	#define MSG_8192C(...)     do {\
 		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
-- 
2.20.1

