Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BD73A6A45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhFNPaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:30:02 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:42931 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhFNP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:01 -0400
Received: by mail-ej1-f50.google.com with SMTP id k25so17347507eja.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eENrFE65sb18aGa1Uvfu7nA7Z38lv6PqEmiZJci8iuw=;
        b=A2m6p1gf8L1eJQnBJaAIp4XXuJDOG6Wqm4bLiQeL0ABSKGalI+qbuANO/3lgSYCfUM
         4fPIaARCshsNqfc74+b07sRJe8VoSEmqgVBwK4zHhWYFuFGqVmvTRzsgDBVExdxHFml4
         rCMKgtFRxD3Fk73MlyMjtgD74iP/+/R/q97qK4yzwIpQmFAYkoVuxv+26STeu/dlMwCZ
         Jhu10XSxDRhoHTBf5LHOwhVjVBXOBAQuw3nD7SLhSo64uhNqQTpAx+haVLqEyy8i8Ad/
         Broev+j14nDSkwjLpm+AvvIcoPngccwUxG5vmzuxbEerOQxYmur6tRm80mcGw9rw59jg
         E+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eENrFE65sb18aGa1Uvfu7nA7Z38lv6PqEmiZJci8iuw=;
        b=auwaek512rdOBeJbuOOdzN8lBf0VOjZ4S7PYCKEqgfajA6mVBpIRMC6qJsh1nxjR35
         MxW5QAdB+XAPW16t32VV4LbslKeB4EwdI34LFNn6xiV599j8resfRpcd85w/RddW2eC8
         zDiEXPMPpeSXV5++p45LZfFeZp3STybjgogocg2J8TqnzHYI4kVtEjdI0OxH9UmHumXQ
         O/ZSZ/5drIt+6WUMI9xfyQHjXphRLBo3mAPVFB1f1Q2kqgSalQSQ/GFlJ+l96/YQoEKQ
         V9uz41qG+TkCxFa6gTpoD7jkyNcc68IjBa0svivbmlb/dvb5A1OBv5qh0R4li+C2Gi3J
         IeGA==
X-Gm-Message-State: AOAM531RWUzJB9Wg4zf+kWevZ/UvaBrYDIWxLwsoWdOv8loM+tXo/C1y
        4F3ULp/7KOO4T249wxd9fPW4QSguqTMxCLQy
X-Google-Smtp-Source: ABdhPJzs9VfMq5+Et4qPzGcZzrvGoiB2wet15vIy4GfVjZHrblHV2mXfQtzx3wKyZVQ37CfXEr5RPQ==
X-Received: by 2002:a17:906:1c49:: with SMTP id l9mr16040165ejg.39.1623684346515;
        Mon, 14 Jun 2021 08:25:46 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id h22sm9024630edv.0.2021.06.14.08.25.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:25:46 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 02/33] arm64: zynqmp: Do not duplicate flash partition label property
Date:   Mon, 14 Jun 2021 17:25:10 +0200
Message-Id: <6c4b9b9232b93d9e316a63c086540fd5bf6b8687.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

In kernel 5.4, support has been added for reading MTD devices via the nvmem
API.
For this the mtd devices are registered as read-only NVMEM providers under
sysfs with the same name as the flash partition label property.

So if flash partition label property of multiple flash devices are
identical then the second mtd device fails to get registered as a NVMEM
provider.

This patch fixes the issue by having different label property for different
flashes.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 4a86efa32d68..f7124e15f0ff 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -131,7 +131,7 @@ spi0_flash0: flash@0 {
 		reg = <0>;
 
 		partition@0 {
-			label = "data";
+			label = "spi0-data";
 			reg = <0x0 0x100000>;
 		};
 	};
@@ -149,7 +149,7 @@ spi1_flash0: flash@0 {
 		reg = <0>;
 
 		partition@0 {
-			label = "data";
+			label = "spi1-data";
 			reg = <0x0 0x84000>;
 		};
 	};
-- 
2.32.0

