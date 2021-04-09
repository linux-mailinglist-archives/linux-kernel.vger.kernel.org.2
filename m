Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FFF35A5A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhDISU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:20:27 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:50970 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:20:25 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 14:20:24 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A3EB03F63C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 20:13:43 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=flawful.org header.i=@flawful.org header.b=W5fQs61k;
        dkim=pass (1024-bit key) header.d=flawful.org header.i=@flawful.org header.b=vWJAMXWS;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=unavailable autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=flawful.org header.b=W5fQs61k;
        dkim=pass (1024-bit key) header.d=flawful.org header.b=vWJAMXWS
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id juMtM90bmg-9 for <linux-kernel@vger.kernel.org>;
        Fri,  9 Apr 2021 20:13:43 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 303063F5B2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 20:13:43 +0200 (CEST)
Received: by flawful.org (Postfix, from userid 112)
        id 7F5A7E74; Fri,  9 Apr 2021 20:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1617992028; bh=d9+NVrEhCD/F0hqwPtTi0LWkrNwo6qZA/Ms9P1Fu/dE=;
        h=From:To:Cc:Subject:Date:From;
        b=W5fQs61k2qA8w4299LVpNjMKu/KMwVSAm/KD9wsQ51wXTojlqx8fNpbWZFJqohx1d
         TDE6xsGW1ykOGbH7CdRL6n3vNCimdv4lhoUW8lTNnXMipGo5tODKSYiAzSeb8Sh7Rk
         F08TyCsP4/+JxWPaWiifmTrry4x32RlHw+SuY7SY=
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id D2C50902;
        Fri,  9 Apr 2021 20:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flawful.org; s=mail;
        t=1617992012; bh=d9+NVrEhCD/F0hqwPtTi0LWkrNwo6qZA/Ms9P1Fu/dE=;
        h=From:To:Cc:Subject:Date:From;
        b=vWJAMXWS8k0oAnUQExQned5Wptkii57LjTBKwvRlPAMI1YVsn4yfgyBm47hLLqzP9
         wLJ0HZr2lszjuHIFj1jAnpMXThqG/jRDy6bmp9yJ3YiSUpE5vfzrF6ScmWL8LJpzNo
         aQiEAESB4hYsIK/qOu8ZTT2iAsk2wbCNPfkOEN+k=
From:   Niklas Cassel <nks@flawful.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: don't simple map sgl when sgls are disabled
Date:   Fri,  9 Apr 2021 20:12:55 +0200
Message-Id: <20210409181255.101847-1-nks@flawful.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

According to the module parameter description for sgl_threshold,
a value of 0 means that SGLs are disabled.

If SGLs are disabled, we should respect that, even for the case
where the request is made up of a single physical segment.

Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d47bb18b976a..b06e685d1250 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -854,7 +854,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-			if (iod->nvmeq->qid &&
+			if (iod->nvmeq->qid && sgl_threshold &&
 			    dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
 				return nvme_setup_sgl_simple(dev, req,
 							     &cmnd->rw, &bv);
-- 
2.30.2

