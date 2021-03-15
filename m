Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C596D33B034
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCOKpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCOKpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:45:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83714C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:45:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y16so8431397wrw.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JkUqr4eqSLlIHqALxAhNIjo94t7X7mfAdvoNtfMBKoc=;
        b=kl+YyFfzyL7uHNgsdx0i7WD29arND119rdlyB6u6AMPQhgsGZNlPxY1BQ4XgzD3I9P
         Rt53DMFFauCs6ogybVC634SlKBtDgE1DkUcf1ggtKVD8+eF6KE+RxymUlRKrrlA1hHn0
         7ltWGcfMHUrH9hj+vP6DKRgRVLq6PRF4sE5DVYy8OSA1oP5VP8juL3DS5PPq47VQpTkX
         LUVIBGXpoPRcWnwRaTxinFBAmVS9WBabaetvHHuelzKz0JT+SKnmAkVQvBte7kPbg+cJ
         vsHJNi7UJVkr1a1qcaXQqiiGwPh/mHKB96O5S2IPGj+iRQsip69pwioHQOFu6nHb24uO
         uomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JkUqr4eqSLlIHqALxAhNIjo94t7X7mfAdvoNtfMBKoc=;
        b=bAC66OdLQKvJygKOEDj09Gv5AtVA51N8S+ZhDH6JkZlLh+wKlqTYoD4n4VvMIiIudY
         LGa3RznornDRKfvQoO9dqg+c4GOzsSHnViwIkgD8AKauIwZxqjdx4yi88zrMK7seuWDd
         nMhlPLKyMDQedHaBhcd5okBm9ezNunDKm8Xkny56E5VEMimRx6sDt39f+rBWbu/OgVY/
         EC+P44fg3GfsaWCimF60NIM0HZxF7nGzzdLUosoPPopBxbv7ciqyeewr6/CdKm06CsU2
         wqdtK5o4Xl2YakBawsgbIa8J/6N3HTjnX9MB2CyJzZeKvyIcIF7lMBwj51wIuwSX+2ME
         tQDA==
X-Gm-Message-State: AOAM530cy03ycicW8oRucGas2/Ww9SZAZ2aYUDLCuJSLXF/tNKWXenjE
        vmnEhKUJaCIia8otyc5tryDX4ZI4s8kb1w==
X-Google-Smtp-Source: ABdhPJyeSssCjMaD+v19KVUYAuX5OfF2vn0xh+fyu9YlwPcRB0mZu/9iwBlIj2NxH03Zp5NyFo/VRw==
X-Received: by 2002:adf:a3c2:: with SMTP id m2mr26871769wrb.195.1615805112121;
        Mon, 15 Mar 2021 03:45:12 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id s3sm18191381wrt.93.2021.03.15.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:45:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org, srinivas.kandagatla@linaro.org
Cc:     nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmem: rmem: fix undefined reference to memremap
Date:   Mon, 15 Mar 2021 10:44:57 +0000
Message-Id: <20210315104457.18140-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below error reporte by kernel test robot
rmem.c:(.text+0x14e): undefined reference to memremap
s390x-linux-gnu-ld: rmem.c:(.text+0x1b6): undefined reference to memunmap

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 642ddc699fd1..dd2019006838 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -272,6 +272,7 @@ config SPRD_EFUSE
 
 config NVMEM_RMEM
 	tristate "Reserved Memory Based Driver Support"
+	depends on HAS_IOMEM
 	help
 	  This driver maps reserved memory into an nvmem device. It might be
 	  useful to expose information left by firmware in memory.
-- 
2.21.0

