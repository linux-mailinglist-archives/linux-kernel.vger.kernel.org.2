Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31C3329A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348268AbhCBAnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 19:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240294AbhCASic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:38:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAE1B65215;
        Mon,  1 Mar 2021 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614619347;
        bh=HJhdCytrX5gp8j5V7AoZ59/hPH5zV/DAbys+BT/9kvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEywQUQjOyAL2gWL+74D09IZ7PfOjClS0Qh2Z4fuXxLJtHncg3ph7NF7MhBYHw73M
         ZTHmX7hXbVc91HxnC3nPNG1uOEQ0zYAUWaepfu4JvvXmbX+FKalTYER561A4OAStdS
         82Nr/IU2JEShcwE1aoyUc6vlDgEvEflJaRkzj9Q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 420/663] nvmem: core: Fix a resource leak on error in nvmem_add_cells_from_of()
Date:   Mon,  1 Mar 2021 17:11:08 +0100
Message-Id: <20210301161202.655738236@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161141.760350206@linuxfoundation.org>
References: <20210301161141.760350206@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 72e008ce307fa2f35f6783997378b32e83122839 ]

This doesn't call of_node_put() on the error path so it leads to a
memory leak.

Fixes: 0749aa25af82 ("nvmem: core: fix regression in of_nvmem_cell_get()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20210129171430.11328-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a09ff8409f600..1a3460a8e73ab 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -576,6 +576,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 				cell->name, nvmem->stride);
 			/* Cells already added will be freed later. */
 			kfree_const(cell->name);
+			of_node_put(cell->np);
 			kfree(cell);
 			return -EINVAL;
 		}
-- 
2.27.0



