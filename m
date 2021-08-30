Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77FD3FB585
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhH3MFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbhH3MFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:05:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B85C061760
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x6so13855689wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0jDxgei4bh80NCLp4kQich3bBzgtekPwpab1aROVMA=;
        b=BBgEqipmitPtbVUNsXX2Kq5QeHyTLZgi7d0daWdiZaIk5olsLqbMGRgC9a1yWcmqx5
         lEd6FxiPRPWbd6F6YZfV6vFWQhmXTs7n52t8XBHwAB9OGygaIWa09y/wdSr1vRgf4By1
         e6MStKrqu8UiEtJ3aM1sB4LChxNWa3PKkvqZWEaiVf6xao1U6RLMa5+IVw95MaOvPwpd
         5VgbZrG9UlcGIYBUA3SUjknQQf5Yab4Qc/JX0/5y2vGI2vD648ZYvCMnFXRnU5Jb1eqk
         0TfH34FHkIq1m3992g39rcsmZS0hkNJoGl2DNPru9PQTekTeXasUFi7AV6tcugUXgB7r
         Ug0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0jDxgei4bh80NCLp4kQich3bBzgtekPwpab1aROVMA=;
        b=OGey9QuS20zk8nfY9p6/GXE/GoLuWQKz2n1i0xIiV8A6+ZzsEDmr6kgE1JEYK+MK8y
         JP7eFC24uZcOoAqS04qbRTFkSJzVJfNET+1+JP436fnonNC3rxKcxaWcXjERm+m/Bgx1
         9TU0vfF5OftYG+ddQoH9dgAOs+u/XXG2Jg8dbUuaIJE7tsFyTi46ExVZKRjX1oDWciSm
         rIbMfRR5vWNYkKdfDKbn+N8fMh/77Dnhtn9mcNf/+y9+FYMirBT12XlZetEicdlMjssl
         GtbIb+fn5tr0Ve9VxDbR0rlCQT1066J8inrZxGpeOFGc/iV6QiEaXLVFaZqUMsiAfpHa
         OhWw==
X-Gm-Message-State: AOAM532JzQlD3yat4irGlpPD0BLuOQPBmVeKBIAm7HlEY+0UNTrRAbFM
        OHtoeFnPmdWoiEJQHFyCwx8=
X-Google-Smtp-Source: ABdhPJzU9Y5T9Rt+/Mx31P67fcJNFbQxxad4gcD0jDuEpao0l6WJ7dsEED2vVJOjcSrBYeX9zIpWbg==
X-Received: by 2002:a5d:6301:: with SMTP id i1mr24714033wru.423.1630325075524;
        Mon, 30 Aug 2021 05:04:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id f18sm13184195wmc.6.2021.08.30.05.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:04:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: r8188eu: ensure mac address buffer is properly aligned
Date:   Mon, 30 Aug 2021 14:04:14 +0200
Message-Id: <20210830120420.5287-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830120420.5287-1-straube.linux@gmail.com>
References: <20210830120420.5287-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the mac address buffer in struct eeprom_priv is properly
aligned for use with functions from <linux/etherdevice.h>.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_eeprom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index 9f8a9c070339..fb591a764dac 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -99,7 +99,7 @@ struct eeprom_priv {
 	u8		bautoload_fail_flag;
 	u8		bloadfile_fail_flag;
 	u8		bloadmac_fail_flag;
-	u8		mac_addr[6];	/* PermanentAddress */
+	u8		mac_addr[6] __aligned(2); /* PermanentAddress */
 	u16		channel_plan;
 	u8		EepromOrEfuse;
 	u8		efuse_eeprom_data[HWSET_MAX_SIZE_512] __aligned(4);
-- 
2.33.0

