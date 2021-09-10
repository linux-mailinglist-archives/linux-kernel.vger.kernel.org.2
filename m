Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4753E406A89
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhIJLM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJLMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:12:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABCFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:11:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v10so2075640wrd.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbseSWFL5SJsHF/L9qG3Ou9sIXvfgEprnI2+Eq5KFww=;
        b=qtMjiQS/BHfF2a83tjKl59vutDXgbbprFhZr4MrE63v3hmotUMw2vnWnNIJeNFx0ks
         eWD3G2R9nWG8lBU5i+4ct5aCkNgwARgLz7iDtSaHvWe7ryRh93PeOEgfrfCUHD/esyzj
         n/p/FyurTmRTF8Tvzj1iAz1MfL2QWATpp50ESHv59YJGbJ5/a4piwvYKnCi+JgR1gQsg
         dm93y5aULkrdiTPX2nhDW2zI6GdvDQ67vH452SbFabBUWCHnBfemRm/Q2bbG+KYK6oZ0
         03hqwsylB3kxkP3VxbdKICXg1sX1b5nlrKr8RPXTnXiS+P0gN1+qxIIvBH2AiybCfDLt
         PYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbseSWFL5SJsHF/L9qG3Ou9sIXvfgEprnI2+Eq5KFww=;
        b=p47mz6cHn1GufhQVhn+LHC9+nPBQqsnSHk06QVpVSUcOVC1k2Hpl+GHt+B3H33hQLT
         vm9c8HEnj6ZUTJ8WFV3Ec7aP4P36pQ1STu419t8IGGkosgJDoZcRY+jzoFA1DE/6cQH3
         1uC24hgKdbFqKtW8QmYzm7rj1YzKeHwf6MPfhvt9AhJ0PXToWcdzUsUlt7Tu7uhgE97N
         FQFijFNJFIWPxyRtr0yqSq4tzbjtMfKuQq9CKVrMlbcFf0AqrKA+Na14u/QkAROo4OjV
         UkudAG0VrYdWYK9czafPcuVTzvhW1n5uxcZpN22MTTnkNywEZTve/b9ADDVJ7/UfId5f
         JQdA==
X-Gm-Message-State: AOAM533svx2f9dLy6/LlHUdSVGrhHtNMVR8DHfrpmCRuYHHIubiaCEWZ
        OHfLXQDFVvTK4UMDKejxfQ8=
X-Google-Smtp-Source: ABdhPJxMHc6T2LFSVcmy/m1qT5YXajzfpSGj/YM6DY3CzGMMumSS3ofZFwg6Qbf9Ip6pFv/hx3WyEQ==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr9071827wrq.58.1631272299196;
        Fri, 10 Sep 2021 04:11:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id o7sm3848828wmc.46.2021.09.10.04.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:11:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/3] staging: r8188eu: remove rtw_IOL_append_LLT_cmd()
Date:   Fri, 10 Sep 2021 13:11:10 +0200
Message-Id: <20210910111110.4628-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910111110.4628-1-straube.linux@gmail.com>
References: <20210910111110.4628-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_IOL_append_LLT_cmd() just returns _SUCCESS and the only
caller does not use the return value. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2: no changes

 drivers/staging/r8188eu/core/rtw_iol.c       | 5 -----
 drivers/staging/r8188eu/include/rtw_iol.h    | 1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 08677552e5d6..ff08861b7acb 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -72,11 +72,6 @@ bool rtw_IOL_applied(struct adapter  *adapter)
 	return false;
 }
 
-int rtw_IOL_append_LLT_cmd(struct xmit_frame *xmit_frame, u8 page_boundary)
-{
-	return _SUCCESS;
-}
-
 int _rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr, u8 value, u8 mask)
 {
 	struct ioreg_cfg cmd = {8, IOREG_CMD_WB_REG, 0x0, 0x0, 0x0};
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index a07c3ae0bed7..bb2c9fcf8985 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -33,7 +33,6 @@ enum ioreg_cmd {
 struct xmit_frame *rtw_IOL_accquire_xmit_frame(struct adapter *adapter);
 int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds,
 			u32 cmd_len);
-int rtw_IOL_append_LLT_cmd(struct xmit_frame *xmit_frame, u8 page_boundary);
 bool rtw_IOL_applied(struct adapter  *adapter);
 int rtw_IOL_append_DELAY_US_cmd(struct xmit_frame *xmit_frame, u16 us);
 int rtw_IOL_append_DELAY_MS_cmd(struct xmit_frame *xmit_frame, u16 ms);
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index b428d0b36171..e3e43c8cd11c 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4021,7 +4021,6 @@ static int rtw_dbg_port(struct net_device *dev,
 		switch (minor_cmd) {
 		case 0x04: /* LLT table initialization test */
 		{
-			u8 page_boundary = 0xf9;
 			struct xmit_frame	*xmit_frame;
 
 			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
@@ -4030,8 +4029,6 @@ static int rtw_dbg_port(struct net_device *dev,
 				break;
 			}
 
-			rtw_IOL_append_LLT_cmd(xmit_frame, page_boundary);
-
 			if (rtl8188e_IOL_exec_cmds_sync(padapter, xmit_frame, 500, 0) != _SUCCESS)
 				ret = -EPERM;
 		}
-- 
2.33.0

