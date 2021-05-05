Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A703237496A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhEEU2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhEEU1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F574C061342;
        Wed,  5 May 2021 13:26:52 -0700 (PDT)
Received: from dslb-188-104-057-152.188.104.pools.vodafone-ip.de ([188.104.57.152] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1leO6b-0003aS-6c; Wed, 05 May 2021 22:26:49 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/6] staging: rtl8188eu: don't block until cmdthread runs
Date:   Wed,  5 May 2021 22:26:19 +0200
Message-Id: <20210505202622.11087-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210505202622.11087-1-martin@kaiser.cx>
References: <20210505202622.11087-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_start_drv_threads starts a cmdthread that runs in a loop. It
reads a command from a queue and processes it. There's no need for
any synchronization when this thread is started.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c    | 1 -
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index 61d0342c76fc..955899f334e6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -181,7 +181,6 @@ int rtw_cmd_thread(void *context)
 	allow_signal(SIGTERM);
 
 	pcmdpriv->cmdthd_running = true;
-	complete(&pcmdpriv->terminate_cmdthread_comp);
 
 	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
 		 ("start r871x %s !!!!\n", __func__));
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 55ed721994a0..193895338cf0 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -330,9 +330,6 @@ static int rtw_start_drv_threads(struct adapter *padapter)
 					  "RTW_CMD_THREAD");
 	if (IS_ERR(padapter->cmdThread))
 		err = PTR_ERR(padapter->cmdThread);
-	else
-		/* wait for cmd_thread to run */
-		wait_for_completion_interruptible(&padapter->cmdpriv.terminate_cmdthread_comp);
 
 	return err;
 }
-- 
2.20.1

