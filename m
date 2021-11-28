Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB440460974
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358555AbhK1TkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52552 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbhK1TiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C17E361117
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5FFC004E1;
        Sun, 28 Nov 2021 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128090;
        bh=lZJVhlRuzX5tOTemnBIbf0kPQNwXHwtcbSdcpmrD6bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQbWG7aQrbDQXKi91dLzIymcJtJKdDpFD5yfSqnJa8o06K/IAMrpHmusyZfCh4Yy4
         8yZnytsFakQ4EjdXYscEjA28/U24ey2FUBg4ILbT5mudMIbDGeIcLv6VaALOWd+F1G
         YCbKNhbSFcYd6ftkqEsR4dWya/L+9bFY4rPgrB6gR1ig7q4qaphbtxuzf2mzmdftxv
         tQJirBAh2sckYT2lP4tkAVB2rk3oQnWzbpbYTfL+e4sB9Mwn3eqqBW4sndst/ApGdI
         u2surR25cP80tpPQznMFYU3FRsaWNsRWQ/oGZtaWyby+Jk5wHZ1N6qPmXgR6EDwTiW
         3CAcTxl7Yib6A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 08/12] habanalabs: change misleading IRQ warning during reset
Date:   Sun, 28 Nov 2021 21:34:31 +0200
Message-Id: <20211128193435.266534-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Currently we dump the physical IRQ line index in host if an event
is received during reset. This ID is confusing as it means nothing
to the user.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 96d82b682674..9fd4c18e274e 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -246,9 +246,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 		dma_rmb();
 
 		if (hdev->disabled) {
-			dev_warn(hdev->dev,
-				"Device disabled but received IRQ %d for EQ\n",
-					irq);
+			dev_warn(hdev->dev, "Device disabled but received an EQ event\n");
 			goto skip_irq;
 		}
 
-- 
2.25.1

