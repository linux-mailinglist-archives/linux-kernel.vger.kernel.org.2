Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4633A8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 00:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhCNXeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 19:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhCNXdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 19:33:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD1F364E6C;
        Sun, 14 Mar 2021 23:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615764812;
        bh=iQIOz0/vb0PZ3swqfz6ye0xnB0TWNZy1nXhv1AHxHAs=;
        h=From:To:Cc:Subject:Date:From;
        b=nE/zKomAAhWUClRPEKcV6JT8dD3wNyqeCaxD8wlZOuzFiwBpYXdyGyZIRCGQA5OB4
         roXXVbTbaLn3Ul+CDFiVPTgspbAZ6WhTgolMNANHNNnoTK9cIqEEunAwYNknvNMZQv
         wzP9psaT86abRw4XlSop7W1hYO+3xgEx9y/DtgFhhUJtDmH9Hh/2mVp+qyo79mC5Yj
         1E2NYyK7sOuKFAnAVPO9gnsTUq2HifxrU/mO9KJmMGGTrlzW30wMKNSClp+3LwT2gs
         Eo0Zak8BoisrRnLhOw2PHGpLrnKI9Q9RRdjPXK1EoLs9R9FC5qhwutZCwDvm8ryLwW
         Kv0C9glLQk7/w==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 0/3] Refine mtk-cmdq-mailbox callback mechanism
Date:   Mon, 15 Mar 2021 07:33:20 +0800
Message-Id: <20210314233323.23377-1-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk-cmdq-mailbox use proprietary callback mechanism and proprietary
error number, but these could be replaced by standard callback
mechanism and standard error number. In addition, use cmdq_pkt as
callback data to prevent redundnat assignment.

Because client driver still use proprietary mechanism, so keep
proprietary mechanism until client driver use the standard one.

Chun-Kuang Hu (3):
  mailbox: mtk-cmdq: Remove cmdq_cb_status
  mailbox: mtk-cmdq: Use mailbox rx_callback
  mailbox: mtk-cmdq: Add struct cmdq_pkt in struct cmdq_cb_data

 drivers/mailbox/mtk-cmdq-mailbox.c       | 24 +++++++++++++++---------
 include/linux/mailbox/mtk-cmdq-mailbox.h |  8 ++------
 2 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.17.1

