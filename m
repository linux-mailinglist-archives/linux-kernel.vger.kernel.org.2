Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6483752E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhEFLQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbhEFLQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:16:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B22C061763;
        Thu,  6 May 2021 04:15:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d4so5171596wru.7;
        Thu, 06 May 2021 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MT2OIJc0hWlPnCiaadINGKimv/o5gd+Xz7S2c7tjZ5A=;
        b=h2C/opMO/xlErlLNdiKWB3MBoV9Axf3M2fUjM5MeerPmbEYvsRMkdruuYJ+Us0E5yq
         FT/fa11B721XvsrdmV6OvnjhXN/xlJV5b2XuhiTGHANyvmiejdl8nMKH58WacAG9RTRz
         SwtigXWJKmFu+uwaQFVuMYeshCZgBeEdpYhfMP183k7c8uyMcXLS1uKBUpUPT1FoqJcL
         A/muttqnqY2WM+XULu4FuRtd6y2UXI9udvDwYHZAGYunuKQnbr7toKT2EMyT6wSZXGj4
         0SThp8n/d6QywFcL8KaXTmFex/ziy1EpTG8pHgBvVtPTeJSpBtbsCmOirP+4mpdZ0Irc
         ydNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MT2OIJc0hWlPnCiaadINGKimv/o5gd+Xz7S2c7tjZ5A=;
        b=YvLzIi1z7RhxFgPzEZfw2IqeAe74GOBOGGhzi7xfeiqrpHSLZIhLiAnCPPx5RfxL2f
         YsvpbURbnkSu4HKcBQ6/kbnLoh4AXbyTVMkB8hZZf8pqRgpoLqZ8r2c0kvcrBjRpkyq0
         xeUWnvoxPghO9PaFNah/Lc3Ehqtz6L2vgDw1hQCzy4G802DeynLW7637ql5VOdWduCql
         hIHQz0R6wBr0XqoT5Q1k7taf8czMfhOKmkUNb52pTpQTjdILlL+vlK6L08W0GJVG3QkT
         eScfBDyL5QTqvaOHfkITcqXt3cQ9W8TvcZyaIT+Czhde3b++3fj+lu8MLdvPT2Ov8az5
         6I2A==
X-Gm-Message-State: AOAM530TfH8BxgJGxVRxnacaYdWSVKcuCUml/ZSpGDeqMasw0kh5ONHg
        Ok8AchD/s5/dIhUFryIknG+LUfR2L3tAOA==
X-Google-Smtp-Source: ABdhPJzGyRIuyk5j7KRK+KqSfoclECQr1Gfb2VaxcdMsLESXtKRSzk91U979iL7Z8FNB3REDhwBNRA==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr4479506wrn.122.1620299739235;
        Thu, 06 May 2021 04:15:39 -0700 (PDT)
Received: from localhost.localdomain (231.red-83-51-243.dynamicip.rima-tde.net. [83.51.243.231])
        by smtp.gmail.com with ESMTPSA id u5sm3642433wrt.38.2021.05.06.04.15.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 04:15:38 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, kishon@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com
Subject: [PATCH 5/5] phy: ralink: Kconfig: convert mt7621-pci-phy into 'bool'
Date:   Thu,  6 May 2021 13:15:31 +0200
Message-Id: <20210506111531.21978-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
References: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make dependant on PCI_MT7621 configuration option and mark
this pci phy configuration as bool which has more sense.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/phy/ralink/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ralink/Kconfig b/drivers/phy/ralink/Kconfig
index c2373b30b8a6..ed0c71eff2c4 100644
--- a/drivers/phy/ralink/Kconfig
+++ b/drivers/phy/ralink/Kconfig
@@ -3,8 +3,8 @@
 # PHY drivers for Ralink platforms.
 #
 config PHY_MT7621_PCI
-	tristate "MediaTek MT7621 PCI PHY Driver"
-	depends on (RALINK && OF) || COMPILE_TEST
+	bool "MediaTek MT7621 PCI PHY Driver"
+	depends on (RALINK && OF && PCI_MT7621) || COMPILE_TEST
 	select GENERIC_PHY
 	select REGMAP_MMIO
 	help
-- 
2.25.1

