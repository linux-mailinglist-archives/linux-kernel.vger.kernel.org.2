Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00259451E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbhKPAf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344012AbhKOTXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:23:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DBA26329E;
        Mon, 15 Nov 2021 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637002225;
        bh=hqwD/FUK63W4kpGNOCRZRdrKqVexnJ6ZTfS+yIQapcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZNhsGNQk3rf7y00UAG8OI02xv4djA726rZwU4m5MGMoYyggqZkfrV5wirpD6mkT1
         Dwyw4bY6a+YugxT/wB8uWziEdjnykwmqSDubb6+7MKkVoCWqwnt8sE9vZVWmpX25Ba
         xy+0yXz8nST+Oj3QvHL86ILo2oQfcKlfYsOpKOtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fei Shao <fshao@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 452/917] mailbox: mtk-cmdq: Validate alias_id on probe
Date:   Mon, 15 Nov 2021 17:59:07 +0100
Message-Id: <20211115165444.109584912@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165428.722074685@linuxfoundation.org>
References: <20211115165428.722074685@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fei Shao <fshao@chromium.org>

[ Upstream commit 5c154b6a51c2d2d7f266b3ef49b7dd1dc8cb5b65 ]

of_alias_get_id() may return -ENODEV which leads to illegal access to
the cmdq->clocks array.
Adding a check over alias_id to prevent the unexpected behavior.

Fixes: 85dfdbfc13ea ("mailbox: cmdq: add multi-gce clocks support for mt8195")
Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index c591dab9d5a48..9b0cc3bb5b23a 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -572,7 +572,7 @@ static int cmdq_probe(struct platform_device *pdev)
 			char clk_id[8];
 
 			alias_id = of_alias_get_id(node, clk_name);
-			if (alias_id < cmdq->gce_num) {
+			if (alias_id >= 0 && alias_id < cmdq->gce_num) {
 				snprintf(clk_id, sizeof(clk_id), "%s%d", clk_name, alias_id);
 				cmdq->clocks[alias_id].id = clk_id;
 				cmdq->clocks[alias_id].clk = of_clk_get(node, 0);
-- 
2.33.0



