Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937674175EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbhIXNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:35:58 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37914
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346452AbhIXNfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:35:40 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8A09F40198
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490446;
        bh=c2rr929hp7ctSTiZFzB7IuYuTf+oD1xck7mUQWU9nKU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=EYaakHyGVLyVB5CRwdu2s5kUtL1Cc185Ba0Ig3jCvvhBSo0u/gqqFYvcEu7OmJH44
         +R6HGKj1qj5qnsOu6vTIjasMeyaXe8/GecKbJPHWQLQ8wW2LEtMDiVsUOeDqWtKeJG
         pZC7fa2AU+p62DPjOGD3r9wKfEkDHIrBYYyFkOmBDWhX3UdOLsmiCXw11FNHRd8Vqr
         WelM6jTuJnsAHOQRh073vqPfjH4e5kJaq5RQJ0IzeRFrpF1+2st/k0Bbbmw1VTp7Lg
         T1zgSxmD9dAOxLdeJz07Yn/2rJv/5xVUlcMjGc3qN65k3PdtYwvyD1G1cq9mMPJjzm
         svoO/ftl4beFQ==
Received: by mail-wr1-f69.google.com with SMTP id e1-20020adfa741000000b0015e424fdd01so8106786wrd.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2rr929hp7ctSTiZFzB7IuYuTf+oD1xck7mUQWU9nKU=;
        b=6Ln/hOoA1OnxhWYu5BSv7dqI2yCX96h5HZr7wHoDKBh00IbQGxGlqsB6LpJdp2WnBa
         t4FpsTXy/IXjEq3pe548FGPDWqHn0S8Ao5GwIwxR7Mc4rCq+ZpqhlPaDtS96rUQXLQUx
         i+9eO0kQnb7W9qBqumEvZAz54Tf8uCk+Y3vxKopVbZoENQU/+p7rFHcocje9a6pG2fsp
         1Da65qDCe3AG5wn5De5wNxetD7EiiukDQ0qw1DlNAu1inKwQr5lmnW+Kw+fgye2jpboM
         VGwTTsmeFfj97nv3TRgP00JrOVOBouk3rDjaMzgJYPtwLnZFyHMwn7W2c4v6A37sUjAs
         LA6A==
X-Gm-Message-State: AOAM532gM3kuHlKpEtJqG5x1D+sfXeS1YfaoDSvm+Hlp3rBSFpx92T3l
        A2Qjce6bTtqAySAtazjFcqixkIBxMmyjs1mjciiJib9kyKIbMi8gk8suv72I9C6dULSC0UOsqBg
        xJQ8z69g+krvQ89i9Vs0XgnTCyNHKRncNMsKKwbq+Ww==
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr11692857wrc.102.1632490446223;
        Fri, 24 Sep 2021 06:34:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySuTDFUNbQADkW2VZazPIKq+SvCnkBXNyrcbBg66KNezbVsPSVOuYyd/Q+oowjMRif6TMaRQ==
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr11692842wrc.102.1632490446106;
        Fri, 24 Sep 2021 06:34:06 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id j14sm8068533wrp.21.2021.09.24.06.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:34:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: exynos-lpass: Describe driver in KConfig
Date:   Fri, 24 Sep 2021 15:33:32 +0200
Message-Id: <20210924133332.112092-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ca0edab91aeb..722a7aef4266 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -417,7 +417,9 @@ config MFD_EXYNOS_LPASS
 	select REGMAP_MMIO
 	help
 	  Select this option to enable support for Samsung Exynos Low Power
-	  Audio Subsystem.
+	  Audio Subsystem present on some of Samsung Exynos
+	  SoCs (e.g. Exynos5433).
+	  Choose Y here only if you build for such Samsung SoC.
 
 config MFD_GATEWORKS_GSC
 	tristate "Gateworks System Controller"
-- 
2.30.2

