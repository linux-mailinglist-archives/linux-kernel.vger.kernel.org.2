Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0414165AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242874AbhIWTLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242839AbhIWTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B20EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i23so20216779wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MzoxEizOiKTdQlbLPE4ISoR0sksiFjl8q0469VNUERA=;
        b=dWSh5qJhBHwoX9NwQwCb3+Bh6jDWCO1pxtusyfD+8TEmS/gFJ0JCsDRjX86GC4RjEM
         hUopXF2eJchTP/XvO/K4CTB8fchzccjrHsaFjPPCwNLBGYRO61Y54hkIs+pHiAq3P/kd
         f8ZAIgn5dVHLDjQlTCzY20ORCcqxDFJ+L7xXjDitIfle2nRD96pJRbOd0HBreHmLlVSx
         zht2d4OzJSzOv9qcAoVfe/MI3ZA8ENKDJJp2jJ12vAMVsY8qRSxPkANyvQHjOmnnO6t9
         juj0fUlXhC8div7y9CZIigFcFENE/DXCCWqMoe/sZcXA8UAbjOw87eRJ2/8/n5/pOuQT
         9RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzoxEizOiKTdQlbLPE4ISoR0sksiFjl8q0469VNUERA=;
        b=mP3DyGnIyeyCdETz2C3NIkmELTYBuzfYqqqos4Y+4leFJLt2uc5TpxRSUDxKidGjls
         xozt14CMrUE8ymx/GeDJIFHIPRiTeuRvo/W8/suGMdEd/QpK7Y/ViUsqjW08ZfmqxTCe
         5mxUcHUd0wwUN6b/stlOrVdhGHnWasIx4LN0+3XSyfcsbxM/V8rQULfJayb1iIi/Omap
         UJSW2W/2s3AGSVq0EG6PuyuYUr9awCMcjJX4N5jEoJtvEp1o97C1IkIKrejcYusIgbO5
         xTWQetBHoWqUAVOlcAUpym4aEAfxOOBDEHIkOGq0U/uYlzMNjHlPAhKxf1D7lkZamdAN
         ggeQ==
X-Gm-Message-State: AOAM5326rN9E8NXva8pEXZKrqn2cIFyWQhamk2AijDse5/ULfJtWzsXP
        fTTnNcTVCnVdLM8CE3R42m8=
X-Google-Smtp-Source: ABdhPJzpulFnnGvLbveJzQLXFpfK1GSDsWZayohOh2WgxjEhzbRkydD79ZVPSCL9usr5LYseYSogkw==
X-Received: by 2002:a5d:5684:: with SMTP id f4mr7217444wrv.148.1632424170103;
        Thu, 23 Sep 2021 12:09:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:29 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/17] staging: r8188eu: remove rtw_cmd_clr_isr()
Date:   Thu, 23 Sep 2021 21:09:04 +0200
Message-Id: <20210923190920.3580-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_cmd_clr_isr() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 8 --------
 drivers/staging/r8188eu/include/rtw_cmd.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 3a70776f3304..4b149425cff7 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -213,14 +213,6 @@ struct	cmd_obj	*rtw_dequeue_cmd(struct cmd_priv *pcmdpriv)
 	return cmd_obj;
 }
 
-void rtw_cmd_clr_isr(struct	cmd_priv *pcmdpriv)
-{
-
-	pcmdpriv->cmd_done_cnt++;
-	/* up(&(pcmdpriv->cmd_done_sema)); */
-
-}
-
 void rtw_free_cmd_obj(struct cmd_obj *pcmd)
 {
 
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 90ebe1eca896..7923749ae7bd 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -89,7 +89,6 @@ void rtw_free_cmd_priv(struct cmd_priv *pcmdpriv);
 
 u32 rtw_init_evt_priv(struct evt_priv *pevtpriv);
 void rtw_free_evt_priv(struct evt_priv *pevtpriv);
-void rtw_cmd_clr_isr(struct cmd_priv *pcmdpriv);
 void rtw_evt_notify_isr(struct evt_priv *pevtpriv);
 u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType);
 
-- 
2.33.0

