Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929393A2FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhFJPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhFJPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:55:01 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C69C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:53:04 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id w9so14929585qvi.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HusublkSZRMk4OjQy2DcQtE3Z9YSNom7wG4laSKspA0=;
        b=ITnZzhyTiyw/n0L4w2kDSbTCfd2L7qkxkJgBIGxepm1BXqVRFFjAWK5tp77xThGT25
         MDBr3T0Tbssa1OlhYm/hRSBKdvPStmnnr8Sm1bdvhP6f9yMh88lbZDHka88iL83PZ5J7
         LQtH+nfBywi1Dvxp92eXhsDzJbd47tbf5A9UfK1k+rWeOO553auSMSJ59lJmLnM4nc1/
         e9gw06bAolgV4kRX09rWRimwN9MdS9UEGAdBPa2jB53KBmzrY5Fv/Fw21PGhaMmCG/dR
         TGXQZ0huH6FK+2bbQlzxFC6d76fFPHvj8eK/RnUS9EQgo1X4N92QG1xlxx8lo3NTNUWa
         qAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HusublkSZRMk4OjQy2DcQtE3Z9YSNom7wG4laSKspA0=;
        b=GsMkel1LU53pyE/Bl87X1WzISAaLdhlCXyvigFAEiWLimgSRFfAYuZfHdIRAScVQ25
         d3pFfs9t4Fd7Y3tlhEVsIcJHuaIA7zdgZB2ANzXHyFa5OMMMWWmjnhuq1F2CnSfjnW9Y
         OB+8VTJbq5RkFsr2ScZmmcM3eEqTNqNyBGldC/DIR6Ip/NjSwraIgb3HK4NobeQ4xmI3
         i5eUTIIWcmKjGnQxJGCmf9uJcpc2o8S/zY1TiC/W5/h8IhrNT9psCKKny3N25kQegcYE
         f90dR+BvIEZ9f7787sZVQlcJbVJs4OawYTQbki0JbNUf9SEry7c9Z08RNJvpjtbPEmHX
         K0pQ==
X-Gm-Message-State: AOAM531VJGBXZlDBQdVoSR96e3Z+M2cRFKqm3S43zVHG/6QvzV/yw+XD
        CHaRiSPRxiq5AT97Qv7rmS8=
X-Google-Smtp-Source: ABdhPJxdVRbHLKoMuzqaLSpGm6XCLXlaSc9JD6JTXJnQmdwnSnk0sBic6XKOUWsiZfHfJYWLDkLXXg==
X-Received: by 2002:a05:6214:e4d:: with SMTP id o13mr222755qvc.19.1623340384180;
        Thu, 10 Jun 2021 08:53:04 -0700 (PDT)
Received: from ubuntu ([191.96.170.82])
        by smtp.gmail.com with ESMTPSA id e127sm2564302qkf.62.2021.06.10.08.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:53:03 -0700 (PDT)
From:   Philippe Dixon <philippesdixon@gmail.com>
To:     hdegoede@redhat.com, Larry.Finger@lwfinger.net
Cc:     Philippe Dixon <philippesdixon@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8723bs: core: remove whitespace from beginning of line
Date:   Thu, 10 Jun 2021 08:51:17 -0700
Message-Id: <4fa641ac2f1fc1b1952c0f3265723289ef711ee9.1623339773.git.philippesdixon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623339773.git.philippesdixon@gmail.com>
References: <cover.1623339773.git.philippesdixon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:

WARNING: please, no spaces at the start of a line

Signed-off-by: Philippe Dixon <philippesdixon@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 347c043f5305..04956ccf485c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1339,7 +1339,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 static void dynamic_chk_wk_hdl(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv;
-    
+
 	pmlmepriv = &(padapter->mlmepriv);
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
-- 
2.25.1

