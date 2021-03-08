Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367FE33165A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhCHSkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231395AbhCHSjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:39:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F3AB65224;
        Mon,  8 Mar 2021 18:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615228786;
        bh=mT8VJEbqh/T9tT513yzWGnBW9ztkw306QRS8Nh7q1f8=;
        h=From:To:Cc:Subject:Date:From;
        b=QNyg+8ch2lftsvJ+jANzV0lmVGA+AZ7Vh7xQRtWC7gTGXu3tNQrLLoCSULnGsksFS
         gs8B9ELK6687VKS+RD4wJrt5q0cszu0ST//Ety3Xv+HOlhxcYnNzAPzYav/DaY78nA
         kpFcSjH9uICiubgfzfqejQkvDwTUBhfnFDP36VSXY22uDHnqZ39lw1T+MU0238yNGt
         8+Y0jxGSaIvTOFZt9Tfq9KuSl4QOZdZ/PzrDIsvjjPRGbPbUKhxX06055PBv3zMLPl
         VfuctXUYw13zqJHWx5adVyrb8SZxe0HJWZrfS17Mi/xXalJI0I4Pd+XHGP+yGQ3zdg
         p2gUpJBExw3vQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com
Subject: [PATCH] arm64: defconfig: add support for Intel's eASIC N5X
Date:   Mon,  8 Mar 2021 12:39:40 -0600
Message-Id: <20210308183940.1489379-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Intel's eASIC N5X platform in the arm64 defconfig.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d612f633b771..f1fffade222e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -45,6 +45,7 @@ CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_ARCH_MXC=y
+CONFIG_ARCH_N5X=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_ROCKCHIP=y
-- 
2.30.0

