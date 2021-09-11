Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58107407840
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhIKN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbhIKN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A35C0613D8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q26so6849303wrc.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fEc5H1/dJK7kbB7Zq4oeHdHd+S6Nk+AiiBRDAVWQuQ=;
        b=csGDyJmNerJxVcvLyj+IxSvsY9ZKq72TUfVRzJQvXW8sGyyKBAqBksmEAvRZANkrnn
         ieHETmJ3FBekVAH24UWGA7bI1uMY8dXsaiN9+SfXQdrOoSCIIQ6bYIUn+WXTY2RjM8w6
         2/PYWv17AtRLR4fHuMUbvLnFRoB7ZHiwrBTlDYeT51MPePrHWyHwBRnhGlWtaD0M/2jN
         qJow20EPUUahE++2UsSeo1kWCJS+pompr8rliCeGdRsVGSPT+RQvEPRzaIhnAzYBPXT+
         KUnB5YPLqoLRcw0EWmft87Jnlp0ogX+CTPIof/hvkNqPXU3VE+lBPU3WDRNRDSi3qFH8
         aDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fEc5H1/dJK7kbB7Zq4oeHdHd+S6Nk+AiiBRDAVWQuQ=;
        b=ANHZjN2OiT3i9TwOZL/kE2Vw4atIfe17NmcPISsKaTdVGryXAR1jWPeFoA2jOhS5Sa
         xOsobExkF3xNqYqm90nd4B6IlWgDL8GiYnrNQd8vgeepB5RZ6Mys6+UVh0oEFQtkFkQ6
         +QktwlRQuxFGhGUXtH5qlhKZsUMXHwdFD10SG4CsW/ERW1SbJrLLyPgKV8YnT0Gbwjib
         QYZkK1m/ummp/UvvUtKHhP7a0mCq7wZuhcvDvxhExZt+RsDP0tWIvOenFkZZOLMShHs/
         1sLe0XuxwabsAyE9igcVlUFiKyGDrxqbWHIEJwanwh50VmVFfOJRiodfWLchspynlMy9
         QjPA==
X-Gm-Message-State: AOAM5321iuY/s38wem7d1D9DDEyUGJbnNwtzvtIkR+ockuloc6ciVJ6U
        ggrTi3aitao7K0hPWGzn/GM=
X-Google-Smtp-Source: ABdhPJxGPQ64vlPoB/Hp1CRBK1D6jbv4lJbBXLV4atGXBTFKhSpwdAuqqMVrS7ELBPHFdQiUdBsEow==
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr3086156wrx.244.1631366828524;
        Sat, 11 Sep 2021 06:27:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/18] staging: r8188eu: remove unused ODM_FillH2CCmd()
Date:   Sat, 11 Sep 2021 15:26:21 +0200
Message-Id: <20210911132635.30369-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_FillH2CCmd() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 8 --------
 drivers/staging/r8188eu/include/odm_interface.h | 5 -----
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index d45eacabfbd6..7b36584f0e6d 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -155,11 +155,3 @@ void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer)
 {
 	_cancel_timer_ex(pTimer);
 }
-
-/*  ODM FW relative API. */
-u32 ODM_FillH2CCmd(u8 *pH2CBuffer, u32 H2CBufferLen, u32 CmdNum,
-		      u32 *pElementID, u32 *pCmdLen,
-		      u8 **pCmbBuffer, u8 *CmdStartSeq)
-{
-	return	true;
-}
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 4769087b9412..9afc5178955f 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -130,9 +130,4 @@ void ODM_InitializeTimer(struct odm_dm_struct *pDM_Odm,
 
 void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer);
 
-/*  ODM FW relative API. */
-u32 ODM_FillH2CCmd(u8 *pH2CBuffer, u32 H2CBufferLen, u32 CmdNum,
-		   u32 *pElementID, u32 *pCmdLen, u8 **pCmbBuffer,
-		   u8 *CmdStartSeq);
-
 #endif	/*  __ODM_INTERFACE_H__ */
-- 
2.33.0

