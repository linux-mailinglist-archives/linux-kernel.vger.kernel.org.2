Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828DF4607E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358923AbhK1RPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358580AbhK1RNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:13:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FAEC06175D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d24so31446775wra.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmYuAwim11Nia8KJQLIM3VlP7cUwEH2KKK7OvongJCM=;
        b=Nz4LOKjvzRH21Q5U9yrMJuMebrNlsaLpNFl7wBNxyKdpx5IveoJLTcHo+SFfZx8zyI
         /IMOn8ZrwtdEHNa4TimH4h8R8MrEV9lY3ksYSy3eTQrh+C0vRADrfNKgSQxK8oXNj7Jj
         OAsLnkVs/Gc74k3Yza7ZNwHkiYyvTee4i4ixglwukfcKGUpXV4Vp/XlheuwZhn6qnOC+
         t0BR4E3pxl9bgR7RKOXchi1oPdjw+5iRqYuGB7ItApZxEyDLBySCvmGT4h8MdFCuUnqk
         OLiK6X68rgVAFjmm6zLOImI93oSEzpd3ViHxKFf9a4pQTdrVqP0af2FgqwLjMQpAeymp
         sCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmYuAwim11Nia8KJQLIM3VlP7cUwEH2KKK7OvongJCM=;
        b=jDAPJplIUhS+TWZ4UpFgNoL7m6/b4exABXuRuH+4nJnvw3ZCwgzRjFPw2Xgs+utnz6
         ik0S8ue+s7erdnSHQpo7P1XbEndykFslQ/PSW7kCiv/AMBCB5KOyPRQP3K32CpPRo8kk
         zBfGwlq+LvOXSNdaTGLkOhzJkfXzX6gNlkd/o2Hh2hDI69CiHKkv+cRhirJ4JN/D1g5s
         dQxjvbqlC/N6XS0CrsvUmbC+aeYHzmpZDQcLCrYO+UZLKvIrqtCK8Tu+6t5ao8NYtEgv
         dSCPZ0jQE6ciN19ZQIFmirGnXoP4vYBU3HaN8fPh7b6eoxKfZD8cRv3v36VvDpA/ArJd
         y+UQ==
X-Gm-Message-State: AOAM532ET33g4q/+o14eqk8lDkQgLMHOId6B9APgmsC7uCuKZt0ueyMx
        POiQmhFxiMgyHEDDV7gVee4=
X-Google-Smtp-Source: ABdhPJywlOSAu4VWAh3iMKBs+zObErzL4UCihv1zRwNjRHEtX28SQYemISOrH1//FjEDfDQvQp+GNA==
X-Received: by 2002:adf:ed52:: with SMTP id u18mr27834325wro.609.1638119393759;
        Sun, 28 Nov 2021 09:09:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id n15sm18243845wmq.38.2021.11.28.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:09:53 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 08/10] staging: r8188eu: remove unused HW_VAR_RF_TYPE
Date:   Sun, 28 Nov 2021 18:09:22 +0100
Message-Id: <20211128170924.5874-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128170924.5874-1-straube.linux@gmail.com>
References: <20211128170924.5874-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After previous cleanups HW_VAR_RF_TYPE is unused now.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 04518e9838ea..9d6ce74d7c31 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1685,9 +1685,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_DM_FLAG:
 		val[0] = podmpriv->SupportAbility;
 		break;
-	case HW_VAR_RF_TYPE:
-		val[0] = haldata->rf_type;
-		break;
 	case HW_VAR_FWLPS_RF_ON:
 		{
 			/* When we halt NIC, we should check if FW LPS is leave. */
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 693eb32fe1a9..7385ebaaba5c 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -29,7 +29,6 @@ enum hw_variables {
 	HW_VAR_ACK_PREAMBLE,
 	HW_VAR_SEC_CFG,
 	HW_VAR_BCN_VALID,
-	HW_VAR_RF_TYPE,
 	HW_VAR_DM_FLAG,
 	HW_VAR_DM_FUNC_OP,
 	HW_VAR_DM_FUNC_SET,
-- 
2.34.0

