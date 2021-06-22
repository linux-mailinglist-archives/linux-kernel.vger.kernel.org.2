Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA343B046B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhFVMcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhFVMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FCDC061768
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so2172358wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuMF6VsqpQHGen6pDrwB6pK2wNwSSnPLXzA/6UmoJDM=;
        b=iZsILL/SQTeES+u8n1pX1NjLIwD9N8e2hYo4nMg+LqThin36zGQSwa+Iv1lCiNYN8d
         mqFqNwOpOFb5CRDZennsFRE0CTWBUQebMJL/oznsBt3wFl1nP9Gmfmkki8oyScdj6XOW
         cRVrBQRSTIFtz+/K9ILFRGV/i6I7vjOyu7efMwR+w2w8//Ezv6Jh5X5FipP5fReVxvlv
         cG7XwHa/bGebpqQikTUQ/NMFZAaRk95FYFNKtBbxbIaGKCXgVArN/f7FJ33Untuly1ta
         vi3SBSNKHwnkdgzAHTlehps02RRA5KNneRjQF6P79RLa0DIRteWqnDtqSgR5C7hDw41t
         Pgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuMF6VsqpQHGen6pDrwB6pK2wNwSSnPLXzA/6UmoJDM=;
        b=kNurrjBFievHzeEA9FSbmXjrdtnRB1+6yPj6ZlgsGp91uqFZb4/rDH6iTucT/xcSmJ
         WCsYj6kNwi5S50tlHkp8iu2AZHGGYA54aitLXIf6zOV9ohz3Z8n+cDycayCccTpcxcVW
         Btg/iJoMB8L3K1t7fSQtSpImPo3DRSfMWVg9BAKPJ+8/odfMg3GecVD0TF4lV636BAa4
         FEszcyVDKv13IMVql2WTBkiCzrddu9WxMk1NXRzR3uQFKQ62JXXohmkVzdHa+L6mNSgr
         Z1MDydgv5fpLzQEhBfbxUOlcEHf+UFBxhOg6Nhmf9GM7PCFiQB076OJsyx8fAEX89psP
         PjDg==
X-Gm-Message-State: AOAM531F6fO1c/2pFGw1sGh3mREgziL2EoLy462xLlpMVEawLag8k7SP
        knaaoSHJbFI9W+EBKlstUMAMbtIjlKfSjg==
X-Google-Smtp-Source: ABdhPJyaximZXWTula4U/AFuaDbPl3aanncYQkfQiiFv+1RalFE0Xbp4Qy2jUGFPXyxjoKon23mF+g==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr3996874wmc.102.1624364991526;
        Tue, 22 Jun 2021 05:29:51 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id b18sm6028018wrx.45.2021.06.22.05.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:29:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/17] staging: rtl8723bs: remove 5Ghz field in struct registry_priv
Date:   Tue, 22 Jun 2021 14:29:30 +0200
Message-Id: <2d01d07bfad725fd8fd6437a3abe9332a781bd4e.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused 5Ghz field in struct registry_priv.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 2 --
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 02df5bd8f575..895c41526164 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -171,9 +171,7 @@ struct registry_priv {
 	u8 RegPowerBase;
 	u8 RegPwrTblSel;
 	s8	TxBBSwing_2G;
-	s8	TxBBSwing_5G;
 	u8 AmplifierType_2G;
-	u8 AmplifierType_5G;
 	u8 bEn_RFE;
 	u8 RFE_Type;
 	u8  check_fw_ps;
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index a06c8b1beb01..648456b992bb 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -289,7 +289,6 @@ static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
 
 	registry_par->RegPowerBase = 14;
 	registry_par->TxBBSwing_2G = 0xFF;
-	registry_par->TxBBSwing_5G = 0xFF;
 	registry_par->bEn_RFE = 1;
 	registry_par->RFE_Type = 64;
 
-- 
2.20.1

