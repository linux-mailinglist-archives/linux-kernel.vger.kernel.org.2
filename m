Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F320B3C6BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhGMHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234393AbhGMHzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50F9061288
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 07:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162754;
        bh=ogKJBW05YKGgRpTrAJOE091/ccC5yoK9fAaHCnFl4kg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JiOk0j2AJXBEsQwqLNvFxfChbPOKyv+iuVBCYLTQsfsay6hhLCOsNhLc4PAxNoaEI
         t4+gvUE9RmswJQCNvA8jajUgd+zJDJMZkIkRVDjfu3T9lxTge2UaoDIEJtQA3DdFac
         iGx/LQh0S51qzyHVxnIrfz0XF4NLr3YkunKTGja3s8INrFURYt3Re6lkNScySHcoEL
         AIqWsmajtyQt++wpnc+jl1NJBJjxz0u0kc3x7sQTsGl27rUBBDpx+cRkErCCGQ9zXs
         3k23P73JPc4ylqo+4TXz0gITFU1AevpvGdQZUCKEfhN3f0SePJk/ezK/BybLiO7H2r
         Qct+ffyCOCDPw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] habanalabs: update firmware header to latest version
Date:   Tue, 13 Jul 2021 10:52:19 +0300
Message-Id: <20210713075226.11094-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713075226.11094-1-ogabbay@kernel.org>
References: <20210713075226.11094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new fields regarding interrupts communication between driver
and f/w.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index d762bb2f1204..1f296784fa2b 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -345,7 +345,9 @@ struct cpu_dyn_regs {
 	__le32 gic_dma_core_irq_ctrl;
 	__le32 gic_host_halt_irq;
 	__le32 gic_host_ints_irq;
-	__le32 reserved1[24];		/* reserve for future use */
+	__le32 gic_host_soft_rst_irq;
+	__le32 gic_rot_qm_irq_ctrl;
+	__le32 reserved1[22];		/* reserve for future use */
 };
 
 /* TODO: remove the desc magic after the code is updated to use message */
-- 
2.25.1

