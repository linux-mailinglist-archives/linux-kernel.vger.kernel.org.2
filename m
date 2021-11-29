Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4678460B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376460AbhK2A0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbhK2AYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:24:10 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7BCC061758
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:54 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id p19so14714506qtw.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4mBYWbHSpfXgXH5cLbVWv6GtvARXh6hrvGhWRBfRo3Q=;
        b=vBIhkUnqu93IN6t2iVYf+Yh+Cg5TsidnqEoVA7yk1qBhNmhqaMwBWFN2K3ln0vp1/M
         iRJZHWGlgHUJX7RlaGtafoPIjfmp/d5yz9maV1/kI8Tra6YGZPUVx0niwbjgDJHqGfCF
         e0qsG2AzQbQdxKzHAolt8EgmJw2iTMqOlDdzJ8ticvM7LxZ9sruyfAPuoafLRK/ie7+y
         jY6mRpHvZduwNsb1+ZgE7pDpspr7UQ/usVtfbmImKjMK6ShLUoYCzrrAKogDsNLKCzuM
         NxZMw/VDp8jxcpWllwq88ub6htmy5uIw67iMhk7ndEdskGuZhEzS2IWQcPYMHYbPxgq0
         5Q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4mBYWbHSpfXgXH5cLbVWv6GtvARXh6hrvGhWRBfRo3Q=;
        b=lTeTnUvG9JHkwatClRTYgDn4uMtJu7B9XQdwdAn8Jwsy1nNKo2CR49vLtgeAvvVakh
         QvljU+0zsxRFATOdDTVlEvTDosnH2gJXkhocd0JoI8sqMityZocy5pTCZEBiLjgDnWMo
         IuIqcxONQATs0RlIMzlGUE515P711zlRxxtTXcVpkT71RT0rWAmVr+OYUi+vjTOKznno
         5VfAztvknLRiAi11G4FLUUxaBTJvJQnPAjZ+8YfpZ26nRG1uvOA+90Wlu+Xpnln5cz9b
         Vs3uXt9PaedGWYnD+YK1AsL7qIrqlZ3vEQ9UPspQanFqq7vBaPSeTO+EArHDUW28tLHj
         CMSg==
X-Gm-Message-State: AOAM530TYhdl/viitnPogtLkDbkxu9xXWN/ZnQ9OaGTnrRjjYwRZpCXR
        b7vDcqM/oNesgKfZdTPAKcwKCw==
X-Google-Smtp-Source: ABdhPJwl9JS6wEP/RQn+hZ2HpCnFJmMYvcdErkMsDQwUzC/5XfShVVPgpplqq9vc7Un1DCcGM2P1Mw==
X-Received: by 2002:ac8:7f0d:: with SMTP id f13mr39520459qtk.341.1638145253264;
        Sun, 28 Nov 2021 16:20:53 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id n74sm5681022qkn.83.2021.11.28.16.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:20:52 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] staging: r8188eu: convert DBG_88E_LEVEL call in hal/rtl8188e_hal_init.c
Date:   Mon, 29 Nov 2021 00:20:39 +0000
Message-Id: <20211129002041.865-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129002041.865-1-phil@philpotter.co.uk>
References: <20211129002041.865-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert DBG_88E_LEVEL macro call in hal/rtl8188e_hal_init.c to plain
dev_dbg call, as although the information is potentially useful, we should
be exposing it using standard kernel debugging functionality.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 001e4a198630..db87e91ab8c6 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -541,7 +541,7 @@ static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 	memcpy(pFirmware->szFwBuffer, fw->data, fw->size);
 	pFirmware->ulFwLength = fw->size;
 	release_firmware(fw);
-	DBG_88E_LEVEL(_drv_info_, "+%s: !bUsedWoWLANFw, FmrmwareLen:%d+\n", __func__, pFirmware->ulFwLength);
+	dev_dbg(device, "!bUsedWoWLANFw, FmrmwareLen:%d+\n", pFirmware->ulFwLength);
 
 Exit:
 	return rtStatus;
-- 
2.33.1

