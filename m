Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4194165B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbhIWTLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242903AbhIWTLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:11:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0703C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t18so20223318wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6MhfHqgxlThEssqM6Lbe1kMMy4kGkDZOR9mG2o2gdQ=;
        b=X4QP1z7iiI5hkbsIx7r4uQqeXPESY6hX0M2UeFacZ/5hg+F0CHI6Wi0jTsFHQYP/up
         fHvyumRLKILODlevBqdsc6j2R24PbGe/6x3lEbgFpCSP4DyF+ICe9lFdGxYnqNqPhbjH
         fpdEkF65NvesbFgqaoQwKAzazOZbjZe6nb4jV6wbMuXgaQohlMmrDGcg7z927SJJbuFK
         lefeCVnKKxLwz8+SAu/fTWdlOokvZHa8KUNsCwJ61tnLEIXKCzW+Z8k/nRW7pWENunYb
         imSAu3YLOvkSVez0XnhPNDWeWEGirih4E3fMT7XYTTt7fQ4HXCjjpcXQ2FMw0zZRWAz8
         c5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6MhfHqgxlThEssqM6Lbe1kMMy4kGkDZOR9mG2o2gdQ=;
        b=1MvIId14jgPuA/4lB7e5a6XAwGEdp5HNHLRaqCAWMQh0V7rt/q+ry4QE38AKQTAj8q
         /ecBBueaGM40x7oxOM2y63Ma409vKQAwe5LmF+ctc8FOEEOHG5G/jV7SOnf5Z3nf+kw0
         DyI9/f/cdSWz5JX5+SIFPqk63vPSJNrtXOtXsOCsg10gNpyweJqb9Ta5JdxqJ9lojXNt
         0/pdzX2FLwWbGyB9NIdFhFPHy3Rr6iY5yas5GxPoFP6MUlKVY1h0TYXIQwludwbkbqfT
         e0lL9vVwlSyaXHLFFmp3iMonHQNmSQkNqqzm6Yp2roctdXZ3BCpIsY/sJA7JasNidIcO
         SJRQ==
X-Gm-Message-State: AOAM532KSN5XIt54JJDE03krFtJv7UccPM+54yBcRvCpCiNPh3azwhA5
        UwEHboyMgSZLZqqn27x8JD8=
X-Google-Smtp-Source: ABdhPJx7NOZHPhY/PGoyaoQS0R3Gn8XkL5MVYgf3QPDpdvWECP2ZataOamqKtYpUmEKvsLbfPp2KEw==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr7151931wrw.328.1632424175350;
        Thu, 23 Sep 2021 12:09:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cad])
        by smtp.gmail.com with ESMTPSA id e28sm6323591wrc.10.2021.09.23.12.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:09:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/17] staging: r8188eu: remove rtw_readtssi_cmdrsp_callback()
Date:   Thu, 23 Sep 2021 21:09:10 +0200
Message-Id: <20210923190920.3580-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923190920.3580-1-straube.linux@gmail.com>
References: <20210923190920.3580-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_readtssi_cmdrsp_callback() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c    | 6 ------
 drivers/staging/r8188eu/include/rtw_cmd.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 80257f5c55d1..0b5472558899 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -613,12 +613,6 @@ void rtw_getbbrfreg_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *p
 	kfree(pcmd);
 }
 
-void rtw_readtssi_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
-{
-	kfree(pcmd->parmbuf);
-	kfree(pcmd);
-}
-
 u8 rtw_createbss_cmd(struct adapter  *padapter)
 {
 	struct cmd_obj *pcmd;
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 84c9592b08ae..86819b0219aa 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -793,7 +793,6 @@ void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd);
 void rtw_joinbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd);
 void rtw_createbss_cmd_callback(struct adapter *adapt, struct cmd_obj *pcmd);
 void rtw_getbbrfreg_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cmd);
-void rtw_readtssi_cmdrsp_callback(struct adapter *adapt,  struct cmd_obj *cmd);
 
 void rtw_setstaKey_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cmd);
 void rtw_setassocsta_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cm);
-- 
2.33.0

