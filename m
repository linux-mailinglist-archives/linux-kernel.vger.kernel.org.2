Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943714078C0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhIKORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbhIKORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 10:17:25 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF92C061757
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 07:16:13 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP3nd-0006bt-3B; Sat, 11 Sep 2021 16:16:09 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 12/12] staging: r8188eu: remove unused variable b_hw_radio_off
Date:   Sat, 11 Sep 2021 16:15:21 +0200
Message-Id: <20210911141521.24901-13-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911141521.24901-1-martin@kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

b_hw_radio_off in struct pwrctrl_priv is not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index db049fdd1bdb..69ea7925feef 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -70,7 +70,6 @@ struct pwrctrl_priv {
 	struct work_struct cpwm_event;
 	u8	bpower_saving;
 
-	u8	b_hw_radio_off;
 	u8	reg_rfoff;
 	u8	reg_pdnmode; /* powerdown mode */
 	u32	rfoff_reason;
-- 
2.20.1

