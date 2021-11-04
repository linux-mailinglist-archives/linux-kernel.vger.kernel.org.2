Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18B3445979
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhKDSTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:19:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42017 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234101AbhKDSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:19:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 97B505C0189;
        Thu,  4 Nov 2021 14:16:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 04 Nov 2021 14:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=w8SXwluvnftokouhNusEDuQ9l9
        65fakiYdRXEaqZ+LA=; b=U28rfx9+l9/4rOT0qSHPgOSkSlloPz1exkNbkEOuQl
        WXImsCRHuJS9utWAJBIYFn3TmJ5PBYfd1PZ3EatlbR1/BD2EFEIiBBGM4gI0uBkt
        OvA/E2L92OvBnyxf3oUK87FTmnE/U0yOi/Z0X2XXv5HqpkyonnBFqJEThqNbuCmS
        yXK7QxU59PGq6NCnUiV2Ef14/NOXFPR4tiqxCSBSbAfCHBS/LTPlPGg32VKJ94su
        pfcpIR4UdJnRuy/aK7ydB0jp07iPRJ2VkNvHJ/zJsZBWl+C3uW9VQWGQAetqkoSi
        HSKz5KeS0YNgbXVHnXC2zo4MUh8yF7Egpul9YespX5RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=w8SXwluvnftokouhN
        usEDuQ9l965fakiYdRXEaqZ+LA=; b=MU+jO1rqTbu0uKtQgR9/YhVZeC6qL2tqd
        421R5c+BygvoF/gm/3tSKU+Y545x23pL86IOlUKYcwSvGsOC0C7uIJ1QtObhsII7
        Y2781RvsgSg0bP0NESX36pQUOT61mqfktaISM+slacOC1kiukSgYPNrUz9+MHmIU
        evGe0HUF/mdmLsl7yHEs84WzUPJ4CysnZ/SNNZppJOmcum77PxxsxCxTcV9zlCS+
        OnX4mPOdpToVbYdF2tmXJMvQWCXtBBFc/VL/zxT/6FmLfEJRQ2yVbnP16qwTsUQi
        F1ZUwubs3Mgf/8F/QCmgNddCgk4rE0usOqgld/uKBmfv8GFrVlB7g==
X-ME-Sender: <xms:dSOEYfzZrHeL-8cu4X8Qz8jnADdUiKjc5k9pZ7kp6vhH-_7POKHg8A>
    <xme:dSOEYXRUtwR_6ga4sa7gW07R5Uwtwx7DREttvHeuNBP5RMsF0AjaLok2CuvmMfIfD
    kT4c7yKiImeZb36plU>
X-ME-Received: <xmr:dSOEYZWFPyJEXdDTQM-tgFVEGunip8-4j1-QFAFa3QneGNElFrrPjCWNJu7-D8Pq9DexFSItsigY3wWOFntIl3Gmf1viVVDX-dolNNqGsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhsucfl
    vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
    hnpeefveelvdeikeduueffteeggeefhedvffffjeeuueeludehvdegjeevjefhtdetheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
    hirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:dSOEYZgqT0d0BNH_x_Mhs0DApjGzczegnFGy7D6XW7uZcYlfjsWEsg>
    <xmx:dSOEYRB3Xc31TxZ3I9Aq8f71xKcZZnGb2n-qrf5eGg8_S0oFviLZsg>
    <xmx:dSOEYSKuao2SOSO0uxzZIixb4e0__BJgjOjgfSbHh0RsZyLnGkCXoQ>
    <xmx:diOEYU4YmoNg58WLRhb3hHRrdRVCz7zBHK5ClkAdbhP7Y3MLJU0GAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Nov 2021 14:16:20 -0400 (EDT)
From:   Klaus Jensen <its@irrelevant.dk>
To:     linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH] nvme: fix write zeroes pi
Date:   Thu,  4 Nov 2021 19:16:18 +0100
Message-Id: <20211104181618.864157-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Klaus Jensen <k.jensen@samsung.com>

Write Zeroes sets PRACT when block integrity is enabled (as it should),
but neglects to also set the reftag which is expected by reads. This
causes protection errors on reads.

Fix this by setting the reftag for type 1 and 2 (for type 3, reads will
not check the reftag).

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 drivers/nvme/host/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3825b596ca16..532bad4de025 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -914,10 +914,15 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
-	if (nvme_ns_has_pi(ns))
+
+	switch (ns->pi_type) {
+	case NVME_NS_DPS_PI_TYPE1:
+	case NVME_NS_DPS_PI_TYPE2:
 		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
-	else
-		cmnd->write_zeroes.control = 0;
+		cmnd->write_zeroes.reftag = cpu_to_le32(t10_pi_ref_tag(req));
+		break;
+	}
+
 	return BLK_STS_OK;
 }
 
-- 
2.33.1

