Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07143C3C9D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhGKM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 08:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232817AbhGKM5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 08:57:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2001A6101C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 12:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626008070;
        bh=11mZk7iCtlUVkxs/nS14l++EoYvhcV/aMcQZ6pEIm2I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=l+mV6WDh7CfrspojXOK0M31iO3rnZC+uDz6drwC0WRF+ylKzHpaZqgvxweoZDGX1J
         NCLwp3fsTjevy2f+FxveaK/pYLPuntV46ljm246yYjmfwA/RE+z2KYfJ+XFfK7cMgm
         KbUzFu8qx9F6WJXNmusWFjdza4OR9TuPpiJNqp7PuXVFEBAadRfokRr+b8lQWZbnug
         f+qRijcM2Q9ElTRMDl9D1fkFQsPoVRwItG8peRsFQj+2SolYRMihNkdzrph6lD1IFX
         BnLDmbYfGBfyCnZjh+kFJP2+wqiTu+R2dt39GyQmgNOVMaYzM09zLB0SgoBYcNAsQ3
         uzOy7QGKr6l5A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] habanalabs: fix type of variable
Date:   Sun, 11 Jul 2021 15:54:16 +0300
Message-Id: <20210711125418.17533-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711125418.17533-1-ogabbay@kernel.org>
References: <20210711125418.17533-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, the size parameter in userptr structure was change to u64.
As a result, we need to change the type of the local range_size
in device_va_to_pa() to u64 to avoid overflow.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 51744e42b808..2c587af28f9b 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -491,11 +491,10 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr, u32 size,
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct hl_ctx *ctx = hdev->compute_ctx;
 	struct hl_vm_hash_node *hnode;
+	u64 end_address, range_size;
 	struct hl_userptr *userptr;
 	enum vm_type *vm_type;
 	bool valid = false;
-	u64 end_address;
-	u32 range_size;
 	int i, rc = 0;
 
 	if (!ctx) {
-- 
2.25.1

