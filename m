Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAFA427919
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbhJIKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244550AbhJIKqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 06:46:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B7C061755
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 03:44:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e12so37609343wra.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeHYn5tnLdQcq9Fqd1snlk2LyN3sqtAimn27J8fXZ8M=;
        b=XiCmyyBwIJtD3mlwUT43KN5+igYcBd/QlQGUGFuq3qxu+BTIWdb/rz2s67HfR5PM6U
         U6gCYfYLrVRyzltlNviNS3ICiPr1ILdmVpu3Dk/sn2GX1hgDjHt/m646CxmSjpFH5KiS
         KweCz9JqycPCqBV+oyX9EGEIQhQZvvTAF/pBqjWHck5ZQD+sa4Dc05idVMlI5xSocvXL
         7q/bCc/t4ShBybX/OBXNyOCRFhcskLEM0dFXZzUIPGkFF/KgD4XmnsnPN5MKlVLJ3zC9
         eimDUu8y7QhaO2B+TUc4ObNdoUjkHtlkLOH30+rwEEtQntKqvaQuJV3pdcnSJ3hj9Hvl
         Q06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeHYn5tnLdQcq9Fqd1snlk2LyN3sqtAimn27J8fXZ8M=;
        b=iuW+8KpOXQaF6lBBZdm4cniri1GkHG955PbhsAF1CEpj27/YdKZafm8X3zRMoxZHH2
         monVi6tKn3mhAip6RCoGPGeqA/wIe+CkPF25xwsCN9paQcXk6g/bviMycz/7wOnAx2wP
         6SnugUbbmPBx7YCE1sGhmj83qYeFDGiB8YPdDR1atgrl2ZsWGRNUh75Vy61T9uUb01Vy
         4LVPPLzZ+ewONfTuX/hAVJcre/dbeW5BrLQayLFUJ1JUHxBUlqUFl2YzCo1AwmycA9tI
         nLyYpqGwdzBIZ7D6JjO50RZVwiI1oEeiDrVgrYUL2DDRHhdlzPXR5sy8n0BL+xHR2ujf
         v9tw==
X-Gm-Message-State: AOAM531oK5Xb3a3A+XfNjZHvZTZ6lGnXYBj3UcrXUfM3w4PuUOPmtI8h
        ZxX24BmbSBXKfXz1+DTrSkrb2qePDtc=
X-Google-Smtp-Source: ABdhPJyplmLbI1TAqIyFfApqUyRfzKNin1jP5mjIvDfYR3OpTc6Mc43GoEBtjDSLf4SnFDW/pls33Q==
X-Received: by 2002:a5d:6dce:: with SMTP id d14mr10636990wrz.363.1633776275191;
        Sat, 09 Oct 2021 03:44:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d0b])
        by smtp.gmail.com with ESMTPSA id a81sm1905431wmd.30.2021.10.09.03.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 03:44:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: remove enum _RTL8712_RF_MIMO_CONFIG_
Date:   Sat,  9 Oct 2021 12:44:19 +0200
Message-Id: <20211009104419.8811-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211009104419.8811-1-straube.linux@gmail.com>
References: <20211009104419.8811-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum _RTL8712_RF_MIMO_CONFIG_ is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_rf.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_rf.h b/drivers/staging/r8188eu/include/rtw_rf.h
index fadb141c6945..7ec252fec054 100644
--- a/drivers/staging/r8188eu/include/rtw_rf.h
+++ b/drivers/staging/r8188eu/include/rtw_rf.h
@@ -69,17 +69,6 @@ enum	_REG_PREAMBLE_MODE {
 	PREAMBLE_SHORT	= 3,
 };
 
-enum _RTL8712_RF_MIMO_CONFIG_ {
-	RTL8712_RFCONFIG_1T = 0x10,
-	RTL8712_RFCONFIG_2T = 0x20,
-	RTL8712_RFCONFIG_1R = 0x01,
-	RTL8712_RFCONFIG_2R = 0x02,
-	RTL8712_RFCONFIG_1T1R = 0x11,
-	RTL8712_RFCONFIG_1T2R = 0x12,
-	RTL8712_RFCONFIG_TURBO = 0x92,
-	RTL8712_RFCONFIG_2T2R = 0x22
-};
-
 enum rf90_radio_path {
 	RF90_PATH_A = 0,		/* Radio Path A */
 	RF90_PATH_B = 1,		/* Radio Path B */
-- 
2.33.0

