Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F236E35E353
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbhDMP7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhDMP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:59:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D62C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:59:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w23so10961467ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t80Ay0RM+FSktFuIVmdmHsgIKuVKC6dk8w1F4+C4e8M=;
        b=Q2lfUhHd0jGJMAVNDwb7Opdm+DyQ3AeqNzu23r3ykYgH/NA9048hTnRz8m32kSjeqe
         cC8YY2uu+ifsa8uoo32WCKYYRgnESPEZn/G/gdXHTDeaYnJ5HJh8TwaPWLMUkrfzI2jk
         3gjBiVnIACSyFMIcnUArUvNx3YnGzmqj7gNCdzuJ9y0C4nCUQdEjHmK9xdDweaiavT8T
         +Hivdj6cIIQntQukoQtlJnufFaEf/J1vrXVtbWAxyGYS6PyH3tKuMdD4edzGtHLlHzSR
         UJsHvdZALW/iHhfLAspxsycS7Hj+lwP+1x32T5HwZcOQEz3EPqepURZRGyjTgu08tX/2
         SBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t80Ay0RM+FSktFuIVmdmHsgIKuVKC6dk8w1F4+C4e8M=;
        b=r314FmTYQUCJP71gfG8sf2TGc68qBaGoIJYqGcvjjya0hknb+kwVQjuuGrP0dytkMr
         ZCFp06VGEijZghImXuk0VeAH5UDcH6ehtKkGWWEN0GOit5TxFeOjze3Mgp390sin8OSK
         5Nr4uJoxY97WSPksGIVKEKh1WDv6tgVJ8knwcdu5Y5krke/agwpUUIDT2JOjqk9NGHzP
         LDH5EAWqXteE7eM1SsBnRnCxTfg6nX2/X8Xtv/BbZdfhHuVJyqxy1bjiZwo8uhp9PJBE
         hboF3DI+L6fV0OYdtPrnPfk01+I1g95AZD64AZ9JvbcXAbYsXwK9TdLwBHPPTwpY8yhz
         2qDQ==
X-Gm-Message-State: AOAM532yXaW6YHtET9yYuVzmE5T3auXPGiSJn72azyEaxv6Ze6uSyXgw
        4rGnj0xX7/xDyr6y5c69uFs=
X-Google-Smtp-Source: ABdhPJwvcOcs6oBSjuASpP7E87KvEDv66H3z82OyfO6XgkjpRk7CZwks7HuotpHpEhqbcgt48hdlHA==
X-Received: by 2002:a17:907:3f8b:: with SMTP id hr11mr33680401ejc.477.1618329557497;
        Tue, 13 Apr 2021 08:59:17 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id a18sm2119910ejr.76.2021.04.13.08.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:59:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Tue, 13 Apr 2021 17:59:08 +0200
Message-Id: <20210413155908.8691-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the led_blink_hdl() function (declaration, definition, and
caller code) because it's useless. It only seems to check whether or not a
given pointer is NULL. There are other (simpler) means for that purpose.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c         | 1 -
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
 3 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 0297fbad7bce..4c44dfd21514 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -150,7 +150,6 @@ static struct cmd_hdl wlancmds[] = {
 
 	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
 	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
-	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), led_blink_hdl) /*60*/
 
 	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param), set_csa_hdl) /*61*/
 	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param), tdls_hdl) /*62*/
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 440e22922106..6f2a0584f977 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -6189,15 +6189,6 @@ u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
 	return	H2C_SUCCESS;
 }
 
-u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf)
-{
-
-	if (!pbuf)
-		return H2C_PARAMETERS_ERROR;
-
-	return	H2C_SUCCESS;
-}
-
 u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	return	H2C_REJECTED;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 5e6cf63956b8..472818c5fd83 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -745,7 +745,6 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf);
 u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf);
-u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf);	/* Kurt: Handling DFS channel switch announcement ie. */
 u8 tdls_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 run_in_thread_hdl(struct adapter *padapter, u8 *pbuf);
-- 
2.31.1

