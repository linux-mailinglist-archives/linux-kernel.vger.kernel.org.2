Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B06327F77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhCAN1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbhCAN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:27:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6066BC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 05:27:07 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l12so16147546wry.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XTQYvzenTvAy+uzJCG3RPCHtA1WmUP3E0AtneiJNGY=;
        b=Gmj4Jvo9jICmWc2pFSDtMVB76Lbb8gRC6Ty+B04Dn2d/dk0hbMYQEqJUmHFpt+77q9
         Jsn1OOzbczH7qxbGvgSHzIiwHJ0zYmVOUTJsvGM4ShrTn9kq0ZmbEwBXn0I9KCxMpgGZ
         ccgiTKE1ORTIa54/B+QOm9YqiWNP49LhOhEZ+NMLgZSzmk5mMDiX9OdJbyV1hgw5ySXt
         X172HtSbHDdHUSfBu76roE/r26QP5OhA49z8PZvZxdQ6PYH7klWR3/Qp8nZg8lIs84Xf
         6kUr53onk/MunaCynNOW1Magv5ssOiQA7WbH+lJefpcCHSc5O70fNN/0rP2RpSE72KwE
         cRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1XTQYvzenTvAy+uzJCG3RPCHtA1WmUP3E0AtneiJNGY=;
        b=Xwy0k8Eh27HhohC903s+c3Vj2xKmx7Pk4NglgGhwZX4gpYBhYuaZguZXktN9pGzSPk
         9DrgXDEbURN6JMSEaMS/QAEovVtUGmbb7Za7fhv7D0QgPT6GA3w2GWAH+VBcpPdry5NI
         gI3xXIukrD5p9RqryAZAgofRcGYquFJQIsazbIy2Y8AVYKK+ZcZJ3SPzJcp0TSxYebd5
         zTvCrvQg61nSy1tUk74oLyjiqCBqP/2C+Yb2HDzE30dGSRHXZVGpeZxOi/KS6XEDhdF4
         5NdN2gI4mXOKLyceHv4a1746egnVQrfHJJ/gc773OH8Dk1tr/aK4eJHYuCwc3ndCuAs8
         HfoA==
X-Gm-Message-State: AOAM5330Lgx0gHzLV9nCg7VgqRqpHe4QYuHQCeSyWmq5b/2gISCDAQOn
        97FFVVSbc267qmNvtiophhyqQNzCzbO1gwXm
X-Google-Smtp-Source: ABdhPJyOEoYKKJ0kUS7Rk4hNwpcSBxHgqnu+ej6Kl63ww7AtMPsjhbnikAn1Hi5GE+XQxy8NqpAiXA==
X-Received: by 2002:adf:f2c3:: with SMTP id d3mr17094844wrp.380.1614605226099;
        Mon, 01 Mar 2021 05:27:06 -0800 (PST)
Received: from ubuntudesktop.lan (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id p10sm11253288wrw.33.2021.03.01.05.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 05:27:05 -0800 (PST)
From:   Lee Gibson <leegib@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Lee Gibson <leegib@gmail.com>
Subject: [PATCH] staging: rtl8712: Fix possible buffer overflow in r8712_sitesurvey_cmd
Date:   Mon,  1 Mar 2021 13:26:48 +0000
Message-Id: <20210301132648.420296-1-leegib@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function r8712_sitesurvey_cmd calls memcpy without checking the length.
A user could control that length and trigger a buffer overflow.
Fix by checking the length is within the maximum allowed size.

Signed-off-by: Lee Gibson <leegib@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_cmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 18116469bd31..75716f59044d 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -192,8 +192,10 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 	psurveyPara->ss_ssidlen = 0;
 	memset(psurveyPara->ss_ssid, 0, IW_ESSID_MAX_SIZE + 1);
 	if (pssid && pssid->SsidLength) {
-		memcpy(psurveyPara->ss_ssid, pssid->Ssid, pssid->SsidLength);
-		psurveyPara->ss_ssidlen = cpu_to_le32(pssid->SsidLength);
+		int len = min_t(int, pssid->SsidLength, IW_ESSID_MAX_SIZE);
+
+		memcpy(psurveyPara->ss_ssid, pssid->Ssid, len);
+		psurveyPara->ss_ssidlen = cpu_to_le32(len);
 	}
 	set_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
-- 
2.25.1

