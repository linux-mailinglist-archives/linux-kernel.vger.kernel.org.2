Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655B7359B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhDIKMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbhDIKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:04:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC5AC0613EE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:01:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mh7so7701848ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcNI82rCMeXgGwcR22vG+oCInfi5++z99L+5L1TkCVs=;
        b=vcVaSBJug+0P7UtjNbujQXQSgpOq4w+MPspd8A0AGaHWhbhGFnOfPrriEgkDHATEpe
         2g/zhPDJT6452PkRfVS0lGpBV9i5KwLa89Dwj44BqybqfTCHSegkpjumq7mV7lMmph9x
         nBjQ928F8CTDVM1q4grGSVOcnXpOxazpnWwUj7bI7tXoNp8agLsSILwCjAbSt4J/utgY
         LmwZpvQDWdoFmY+w5rhUR2I3iNm99UpfTI2Qx/AEa0NxBLP4weLWPbvVZWHU9x9jc6EQ
         +d+NyK4OdqCdvoLlc3+lV2QZdsjYUeO3PfxCviYg61l1fFMDZmWHdgMja4QhyPJgiizw
         X7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcNI82rCMeXgGwcR22vG+oCInfi5++z99L+5L1TkCVs=;
        b=KtDuRiWZA+gmjRa6+94xci1KcJfBOL1+GxAM89nkzXMQSWOpASSTTUVH3Q9UrMLlwE
         CFNsvoH2GkY8BUbUrGjiQctYGQArvv9xw0uP/T96CXTJQoLEej/XoMQb9rZeHLwM2pvZ
         0GExeRT3blmpf0NYYVLAtOhSbdon+CQnUaOWereNbMLPhmyiTLPh2GhXX+WKcd672A+t
         QENVnK9pjc4tvyBREDJnDurwEpm2/XNv3JB/0iG9LnLLZJGohX7A2ahzgDCUgjIxwFpK
         mKsPViSKaN5lNf2/4mBZe88oGT8YBWQ/h13DL4pV6CBeR58RW6Mpjzq5IHnofIThONkf
         tq5g==
X-Gm-Message-State: AOAM5325dQOZjjKvhSASNOy24ID/oKduim9f1nhN8d5hmw8nNx6PmRwM
        pIGG94nocztUzhZreAWXI4g=
X-Google-Smtp-Source: ABdhPJzLAqJwjB6L6RerairFq05LNKr1UIpIpGMQLLCkvWyeNyfh0HRr+Dn/B39QWmI4lm0IL1ALDg==
X-Received: by 2002:a17:906:d555:: with SMTP id cr21mr8759440ejc.66.1617962508613;
        Fri, 09 Apr 2021 03:01:48 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id yr16sm63761ejb.63.2021.04.09.03.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:01:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 01/11] staging: rtl8723bs: remove unused variable in core/rtw_cmd.c
Date:   Fri,  9 Apr 2021 12:01:29 +0200
Message-Id: <509eeb1c4a7fcfc37b69cb8578ea146b95b50864.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following kernel test robot warning:

   drivers/staging/rtl8723bs/core/rtw_cmd.c:
	In function 'rtw_cmd_thread':
>> drivers/staging/rtl8723bs/core/rtw_cmd.c:390:16:
warning: variable 'cmd_start_time' set
	but not used [-Wunused-but-set-variable]
     390 |  unsigned long cmd_start_time;
         |                ^~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index baf8b1e0f43c..e94eb1138cf1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -387,7 +387,6 @@ int rtw_cmd_thread(void *context)
 	u8 ret;
 	struct cmd_obj *pcmd;
 	u8 *pcmdbuf;
-	unsigned long cmd_start_time;
 	u8 (*cmd_hdl)(struct adapter *padapter, u8 *pbuf);
 	void (*pcmd_callback)(struct adapter *dev, struct cmd_obj *pcmd);
 	struct adapter *padapter = context;
@@ -438,8 +437,6 @@ int rtw_cmd_thread(void *context)
 			continue;
 		}
 
-		cmd_start_time = jiffies;
-
 		if (rtw_cmd_filter(pcmdpriv, pcmd) == _FAIL) {
 			pcmd->res = H2C_DROPPED;
 			goto post_process;
-- 
2.20.1

