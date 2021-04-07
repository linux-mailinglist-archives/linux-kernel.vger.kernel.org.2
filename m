Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD787356DD7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347881AbhDGNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347761AbhDGNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDBDC061764
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p19so9069495wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Txc1kWdRYk6a2hQeMj64FaQrg0Tgz5yI7LLoGGXJ7FM=;
        b=SYyiFmQplvpRdaIsyuGVpDCawn1fixSvY/KeLfQubcw+D2cMe0Dgz3Cxf1jxlWvm41
         2m6hb8RCiZe7A2lwxcAephoj5FCB3vmduKZ4BcyAtVZXNVmux8O9mMC0azCwv5+HMHNO
         oOarHRFhSlF44CJLLqCXoSHQmaonPQ2N6LOQX2AB+qO2YmcnwsxQamau35VU+Yk3E2qR
         a7bNSxYcEI74MpkbQHXXvmTepc4cjU9teQ2E0hoZEtgc5MTHFWGfRm1igAzthRYA4hT6
         VdIjLNkCjlPlM31AsJS31KMPYh8JOBLpcxefcx1djkBwPD7CM5wTq3acPd4g38eHC5+J
         ilIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Txc1kWdRYk6a2hQeMj64FaQrg0Tgz5yI7LLoGGXJ7FM=;
        b=GRtcJgJ6W0wRX61o4BoI9Ai/NVZXHFvZxCFUgXZm6G0/yM+BmfBtkQviy3uq9WWyoz
         UnCWzBkr1hx+rtO/qIpwrvWatjz6pFgPxJvdTln41HVJEemKthiOSR5tQ9dKrq++2ACH
         tSgjSSQyO+rSDuk6S+a/JYniUsdU/i8ea48YKMx0OBeY8wJ5XYBIMp79VQhihzujScS+
         NreivjH11wVa2XXIoeuilSJC4+OGrwbEPxY9Or8S+9ZWnC7TOnZ+t0b4Mcvtz6Koem4K
         qZjgL+6+64LE1KUFKUyYGr5mhnOozQ+M6S1j4qfTPliiHEKVFmGEVhAUELcZo7dX3T48
         azEQ==
X-Gm-Message-State: AOAM532G1YV6aoy3H3TSd+ozHegwgD0lfG/5DolAR1kRNdZqXeuJI6i6
        CTdsm1EEt5bbYp1RnUDTO+s=
X-Google-Smtp-Source: ABdhPJzwBEjAnbYy1dOxWK7C+RYfX1pbRGnzavR6UdZYIaJRE966xjAwJ2mbSfg11JNYvZLwGpkqPQ==
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr3175454wmq.11.1617803410351;
        Wed, 07 Apr 2021 06:50:10 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id s138sm8810675wme.8.2021.04.07.06.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 09/19] staging: rtl8723bs: remove empty for cycles left by DBG_871X removal
Date:   Wed,  7 Apr 2021 15:49:33 +0200
Message-Id: <fe758f88ef6d6eaad9762d16d78dcfa876fcf654.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty for cycles and unused counter variables to suppress
compiler warnings.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c      | 4 ----
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 71ec5af0455d..2d1201b70ab1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1454,10 +1454,6 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 
 static inline void dump_rx_packet(u8 *ptr)
 {
-	int i;
-
-	for (i = 0; i < 64; i = i+8)
-		{}
 }
 
 static signed int validate_recv_frame(struct adapter *adapter, union recv_frame *precv_frame)
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 2f6516283248..5d103d33a128 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -571,13 +571,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 
 		memcpy(buf, pie, ielen);
 
-		/* dump */
-		{
-			int i;
-			for (i = 0; i < ielen; i = i + 8)
-				{}
-		}
-
 		if (ielen < RSN_HEADER_LEN) {
 			ret  = -1;
 			goto exit;
-- 
2.20.1

