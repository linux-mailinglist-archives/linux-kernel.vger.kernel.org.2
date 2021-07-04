Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032893BAC79
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhGDJbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 05:31:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53141 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 05:31:03 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lzyQK-00068Y-RY; Sun, 04 Jul 2021 09:28:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arc: Fix spelling mistake and grammar in Kconfig
Date:   Sun,  4 Jul 2021 10:28:24 +0100
Message-Id: <20210704092824.34886-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake and incorrect grammar in the Kconfig
text. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index d8f51eb8963b..b5bf68e74732 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -409,7 +409,7 @@ choice
 	help
 	  Depending on the configuration, CPU can contain DSP registers
 	  (ACC0_GLO, ACC0_GHI, DSP_BFLY0, DSP_CTRL, DSP_FFT_CTRL).
-	  Bellow is options describing how to handle these registers in
+	  Below are options describing how to handle these registers in
 	  interrupt entry / exit and in context switch.
 
 config ARC_DSP_NONE
-- 
2.31.1

