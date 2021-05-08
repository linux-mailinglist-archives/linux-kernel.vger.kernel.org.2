Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6083377026
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 08:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhEHGpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 02:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhEHGpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 02:45:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F6C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IUdJpzfcUQrbGs8gOEcPs2QSu3dpd5pDe7fekBGX9S0=; b=r5IKz+Jx2v4f1Yk7oEgF1f112j
        DdAU9jlIEyKPy175CZ7xpITUdTa6bn3KZE1ecuIZmkZ57ASVtH6hjCtM3IPKrkPLgH4Lnl+UGxgp0
        WL6s5RJP+MInIE6I/oMdiuds3XktnpzrHQXkxAAcvpFvhQtsNN4s+cSRuPyl8fTvFQZF80CfPoJ7/
        BJ15DZfiW0RBRzIbyCvsJ68dlOmVlw6DQY72+K8xWs6Jviv2hBIxupcgzABTQZoJRCzlwhx8A4sgi
        wsfswgUM4KuP4WrS5Eusb4rhIRRGjl9zUV36Xv85PDbnPBB7cvP74Hf7bb3tA3bfIPDgkmDbQtFuk
        lqI67A5A==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lfGh8-007PCK-9w; Sat, 08 May 2021 06:44:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Subject: [PATCH v2] soc: tegra/bpmp-abi.h: drop a duplicated word
Date:   Fri,  7 May 2021 23:44:09 -0700
Message-Id: <20210508064409.20387-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "or" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vidya Sagar <vidyas@nvidia.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Timo Alho <talho@nvidia.com>
---
v2: rebase & resend

 include/soc/tegra/bpmp-abi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210507.orig/include/soc/tegra/bpmp-abi.h
+++ linux-next-20210507/include/soc/tegra/bpmp-abi.h
@@ -931,7 +931,7 @@ enum mrq_reset_commands {
  * @brief Request with MRQ_RESET
  *
  * Used by the sender of an #MRQ_RESET message to request BPMP to
- * assert or or deassert a given reset line.
+ * assert or deassert a given reset line.
  */
 struct mrq_reset_request {
 	/** @brief Reset action to perform (@ref mrq_reset_commands) */
