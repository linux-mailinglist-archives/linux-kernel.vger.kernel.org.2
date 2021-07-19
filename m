Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47EE3CE301
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbhGSPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242977AbhGSO4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:56:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81ECB606A5;
        Mon, 19 Jul 2021 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626708866;
        bh=kFwrrZiktRhJ3Qh0OY0gWhVFAGAgdLvoGwGzStoM7T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRpkP3KZmbP6sMqDn82A88iRdY0xfmb0zXfCdT2t1mF3K5ZBzYryS7YvP3nWgL3Le
         7iYAIw9/SfwbaWZWsBgZ4iJaUEuPANLtuZNZdxC33xB75lF+F6+edboXppkgcRNJyO
         NlzWydMzvm9qGId/Y8ydP7U7G8ozVDtP8Hr258T0lUlNUjyQWY6rlgVXWF/PLXzmNN
         AY0x47WeHZAwbXXt+wcdbwWEKHBW8WXI6mdIZoYqAjjEkYX5qEzh1zj4ZZQfm8R4Zi
         MWZEPqSk+OQeTS8kkwchtuLCVfD1rkTBNLRyXIrBT7V8xKkM1SGAimeohS9LS4mEnt
         ewwkM5lpkqXJQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/4] habanalabs: convert PCI BAR offset to u64
Date:   Mon, 19 Jul 2021 18:34:17 +0300
Message-Id: <20210719153417.4787-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719153417.4787-1-ogabbay@kernel.org>
References: <20210719153417.4787-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Done as the bar size can exceed 4GB.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6fc2234576de..815d7e1a7e6d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -931,7 +931,7 @@ struct pci_mem_region {
 	u64 region_base;
 	u64 region_size;
 	u64 bar_size;
-	u32 offset_in_bar;
+	u64 offset_in_bar;
 	u8 bar_id;
 	u8 used;
 };
-- 
2.25.1

