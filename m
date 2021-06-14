Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B033A6717
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhFNMxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233673AbhFNMxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46D2461378;
        Mon, 14 Jun 2021 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623675070;
        bh=KJojPZ76HS+oJv5F7j19Dxh+YHv6KKvEy079YI/hJSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlpkbPWHCo7eEPnQfiLHhucTavdWwlvVh+ct6stqX6TZ5NXDXc8jYhZfnQcKnJ8ec
         jAsZfSFVioPYGNIzFdam7fU8p9e0eeIx7cYjMt6UWyk2N0Jc1NN2xmKhukiSpP/IUJ
         prWksBYTe7ILxxM7+pODMdU/y5SYjTgsO8OtzKU7s4O0kaINdoj2leDjOBXJwUXGS5
         5HbxwZbiBn2VP+lHRUGymv05PWL5ZRPcovUmFnMOAF7I5mFBVW1P7/wgMxiMw6C0/i
         AC6CcnT7PaAGapDG9Rp3jmBMlQYujh2Ta3Kjnz1xTnsXY4/2/fw1FqA87HztZbuqOU
         55BUQRTGBzLzw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 4/9] habanalabs: remove node from list before freeing the node
Date:   Mon, 14 Jun 2021 15:50:55 +0300
Message-Id: <20210614125100.17627-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614125100.17627-1-ogabbay@kernel.org>
References: <20210614125100.17627-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

fix the following smatch warnings:

goya_pin_memory_before_cs()
warn: '&userptr->job_node' not removed from list

gaudi_pin_memory_before_cs()
warn: '&userptr->job_node' not removed from list

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 1 +
 drivers/misc/habanalabs/goya/goya.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ca1a8ca24d4a..a46ec601a635 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5046,6 +5046,7 @@ static int gaudi_pin_memory_before_cs(struct hl_device *hdev,
 	return 0;
 
 unpin_memory:
+	list_del(&userptr->job_node);
 	hl_unpin_host_memory(hdev, userptr);
 free_userptr:
 	kfree(userptr);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 2a9b91d5c6ff..e91b730baebd 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3326,6 +3326,7 @@ static int goya_pin_memory_before_cs(struct hl_device *hdev,
 	return 0;
 
 unpin_memory:
+	list_del(&userptr->job_node);
 	hl_unpin_host_memory(hdev, userptr);
 free_userptr:
 	kfree(userptr);
-- 
2.25.1

