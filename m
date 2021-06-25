Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144613B3DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhFYHnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhFYHnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:43:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB028C061574;
        Fri, 25 Jun 2021 00:40:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so3656188plg.6;
        Fri, 25 Jun 2021 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ak4It9MsAaf8gTmUjfk7OqroHrSMpNp6aLewzuoe870=;
        b=sOmZYSIjpQlknoMSJkaw5PkOMVn1PdkStlQALfl22r7uD5yYITQze8FqovvDJ23Nxi
         Cdlj7qH0jy3dVrmotZ1HHX1M8h7D7Vj01NhRqZfJ422QDc5LjO/t19ks4xQO+Uk9kBwk
         5UlQl/RSWpOTiHaBz3RkkAifYPN3xwxNK8sg4YFFz9DlNrptvKui8k8XD7cLiHJo5M4+
         fsQRnqrL5xem26YnKWVmLcOQV4451ieEoeF8gzZqKPipg1cGsjApOGyyHi0739fjgWcY
         fyfY5KRznnALDGyy9Re9/5DAs476IOF3BmZf5SsSM4BBsyIklNMPAAbfkRI/89M7z0JL
         ZE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ak4It9MsAaf8gTmUjfk7OqroHrSMpNp6aLewzuoe870=;
        b=HkvKg85alXjju/0E7wG98+r5Ui1dxVworaAx6vDw0N1gq9CcKqR/G6xhQDSVtIQP0F
         2aopmlViDmEhRwDBAuOZRN5zkrHb/BqxZ4jebXphnI+hxjS85fzUyCcPlucL0IgKytrc
         JLxbu/zAJxFqMyhu5BvNE6xeQD1KPxonVtOtoMdeaNIMo8PdYxIBNXTSV7zdKi3YBTRT
         AHtt5vQXxzUzbyeKoI0PACNUsqqqrbv0uu+RTior+ar/vkOHSC4XUBMh/Z6/t7q9oUK+
         pPLGHNLubqh0r7vD368+XEGzqntCABRjunmRLJBy54YsM0cqKRXL8x3Nyt5a7MFXIPr/
         Zu+g==
X-Gm-Message-State: AOAM531jHBxsBBNLFLlk1YN+DOZqMHnIGywZ2vTd/cgiPT4mPYRpPBz0
        klHOhn6KfdZ5z/+UhhTS/24=
X-Google-Smtp-Source: ABdhPJzrpfKopSv073SsVvH6mdLIBivdk+tfVAvdFG0tEDC3YKj7V33SFsdfZwVAiQxCQHCqvlx4Uw==
X-Received: by 2002:a17:90a:a790:: with SMTP id f16mr20048620pjq.176.1624606852228;
        Fri, 25 Jun 2021 00:40:52 -0700 (PDT)
Received: from localhost (95.169.4.245.16clouds.com. [95.169.4.245])
        by smtp.gmail.com with ESMTPSA id q66sm4683605pja.34.2021.06.25.00.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:40:51 -0700 (PDT)
From:   George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@inspur.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, joel@jms.id.au,
        George Liu <liuxiwei@inspur.com>
Subject: [PATCH v1] ARM: dts: fp5280g2: Add KCS node for LPC MCTP
Date:   Fri, 25 Jun 2021 15:40:31 +0800
Message-Id: <20210625074031.32576-1-liuxiwei@inspur.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: George Liu <liuxiwei@inspur.com>
---
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index 1752f3250e44..66c0542b2694 100644
--- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
@@ -300,6 +300,11 @@ &lpc_ctrl {
 	flash = <&spi1>;
 };
 
+&kcs4 {
+	compatible = "openbmc,mctp-lpc";
+	status = "okay";
+};
+
 &mac0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.30.2

