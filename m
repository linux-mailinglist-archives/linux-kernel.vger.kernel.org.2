Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F744BDB7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKJJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:22:02 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34847 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbhKJJV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:21:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 757523200A2F;
        Wed, 10 Nov 2021 04:19:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Nov 2021 04:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=4Vx7Jq/3ygdLtgCNIWs2uX60JH
        95t2qVuIdyOj4xUtA=; b=hMcdhu6DhNINAStaSvRMFyrCr0m3lf8eG9VVkvcZrk
        lCKnMYaEpmO4+/3qOxJIdnRAnJQM7TtYADCGB1JhKzvqILyPzGyH/TQ5sfeDH2DM
        NbWZKqdXTgFq4/PeiW1DJtd++9wm133f7lWvN+5iHVrrXTXB/BQkK13lgVvRMIm2
        LrTE34vIePLITLbTFN1t98E1t2LlrfCYc+c1v/yjqhKX6AZZnkyxcdV+FwBaTu+o
        nXgi8lPN14zir3Asf3EAvc4bOkFZGsL+gHhHVuvfESh5eVymydWdydhKQ5CbKItY
        1Z6RCi5bH1UQUJUjc3wwMvrKBbU3L0kkIdrjdiFWkxHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4Vx7Jq/3ygdLtgCNI
        Ws2uX60JH95t2qVuIdyOj4xUtA=; b=ew/cZYORECEutDEnGTrywLYcGYbRpKBfs
        VSIlX9f99dYXu1vf31gMD1MMBVtoLnr5ApR4R1OaF0gByaeZ1Erh7DNeaxqYfQZZ
        T5p2GGU4hLv2549tvzRfQmO9xg7xtKoe2HmG7zTWFWrjb7v4X3pkWDMMNFYTfObN
        guWwruRJT66sm+4egDRYxbgk11WH+JlCgYRuRmLHxLduvJD5VOwE6DTyfjxNzZOl
        XQzhlhH2OEm91MSu0KeM3GCQ6q1+1FuvVQagNn8EFqGhEX/A7onffnSXYkw6zwfW
        DjSrDLHU2pQzkouadEJTu5xzkGin/oGbCauLCyVSQ54CPINCVjz8Q==
X-ME-Sender: <xms:jY6LYUSdzS0_7J9eeRmuu5LTvXgKFP9XelzinDnAYue3Mu1IEMSQYA>
    <xme:jY6LYRwqfXbZbJPQIszBSSlDmZFDXrxCo1hR7OMmOG7Tz1jgjHTvN2YponB27XzdR
    pFqGUIuiG7KlXcLvmE>
X-ME-Received: <xmr:jY6LYR1uUPiY9ovt7wTdXS9BsUYxC8W8u9T5AUM-Y-3ilHdKiQBygagLLtCFxNIg0U53ltR9dIxdgKi7Zsh5P-LhQDTSe5fyjhMqcGzrIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
    nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
    epfeevledvieekudeuffetgeegfeehvdffffejueeuleduhedvgeejveejhfdtteehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesih
    hrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:jY6LYYBczOpUGb7CMbSOzvq6jPPB8Q5m3ruhlLFLZJbEa04V4QuHfw>
    <xmx:jY6LYdgmYhYisu2S12UraAwiA7J0QciTou-fHZKq-ZcmDj0s_OsjPg>
    <xmx:jY6LYUo2t1Yx9dllKau2uarJ2OsOpM7-PU5rXZtEfcKn2BVuw9cRaA>
    <xmx:jY6LYbYl3TGWpFWtnN27KfWLG_eF_7yP1so7JbQHh-f2N-2u1z1BnQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 04:19:07 -0500 (EST)
From:   Klaus Jensen <its@irrelevant.dk>
To:     linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v2] nvme: fix write zeroes pi
Date:   Wed, 10 Nov 2021 10:19:06 +0100
Message-Id: <20211110091906.20958-1-its@irrelevant.dk>
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
v2: also set PRACT for type 3...

 drivers/nvme/host/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3825b596ca16..41885ecc69fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -914,10 +914,19 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
-	if (nvme_ns_has_pi(ns))
+
+	if (nvme_ns_has_pi(ns)) {
 		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
-	else
-		cmnd->write_zeroes.control = 0;
+
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE1:
+		case NVME_NS_DPS_PI_TYPE2:
+			cmnd->write_zeroes.reftag =
+				cpu_to_le32(t10_pi_ref_tag(req));
+			break;
+		}
+	}
+
 	return BLK_STS_OK;
 }
 
-- 
2.33.1

