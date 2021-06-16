Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ADA3A94DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhFPIV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:21:57 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:54416 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhFPIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1623831589; x=1626423589;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=twN47ShxHvne0ZTgJPFRcqwPGlPklxkV8eYYhOW9sgM=;
        b=cu8t+X0qIBTaObPhasZGa6OeDRaoEX0Yk/N9DgpHxbhd+jS1i3zp5RKVUmgZHxjV
        whjNpAe5d39qJYRtG553daMjZTzcfvL05S0hltO5Wk+RVA2hb19Vy5vVKQBPfDvN
        tPXekKlSKJgPo6O5DHwDwFMtFNTVRCqvaCPjOpCYu84=;
X-AuditID: c39127d2-a9fbd70000001c5e-5d-60c9b42527a7
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E0.AE.07262.524B9C06; Wed, 16 Jun 2021 10:19:49 +0200 (CEST)
Received: from lws-ybas.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021061610194945-972463 ;
          Wed, 16 Jun 2021 10:19:49 +0200 
From:   Yunus Bas <y.bas@phytec.de>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning to debug
Date:   Wed, 16 Jun 2021 10:19:49 +0200
Message-Id: <20210616081949.26618-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.06.2021 10:19:49,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 16.06.2021 10:19:49
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJMWRmVeSWpSXmKPExsWyRoCBS1d1y8kEg50/tS3ufz3KaHF51xw2
        ByaPO9f2sHl83iQXwBTFZZOSmpNZllqkb5fAlbFl4Se2grPsFc/fb2FrYJzL1sXIySEhYCJx
        cP129i5GLg4hgW2MEqs23mSFcM4zShy9v4MRpIpNQFHi/O23QAkODhEBM4kf9yNBwsICQRK7
        9xxiAbFZBFQlXi74zgRi8wIN3d/8EGqBvMTJtYeh4oISJ2c+YQGZLyFwhVFiyaprLBBFQhKn
        F59lBrGZBbQlli18zTyBkXcWkp5ZSFILGJlWMQrlZiZnpxZlZusVZFSWpCbrpaRuYgQGzOGJ
        6pd2MPbN8TjEyMTBeIhRgoNZSYRXt/hEghBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeDbwlYUIC
        6YklqdmpqQWpRTBZJg5OqQbGskUVv5eeXXjIQVRylVHXzC//ji5LktG4uKBdQ/fHzuSpVwsv
        e1gsDo4ud2qUmPu58qDIJ4ULJ5Qu9S3d/tDj/7+3Co/ivgr3pMUe6dmdmFBwWun6GwHjf+K3
        ytpL5l3m7/E69mel4fHPBWEeC24G2R0R4pm1Ozosyj7qlknjyfA81c+MLwWPK7EUZyQaajEX
        FScCAIhu4zIGAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MFD-core iterates through all subdevices of the corresponding
MFD-device and checks, if the devicetree subnode has a fitting compatible.
When nothing is found, a warning is thrown. This can be the case, when it
is the intention to not use the MFD-device to it's full content.
Therefore, change the warning to a debug print instead, to also avoid
irritations.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 drivers/mfd/mfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6f02b8022c6d..e34c97088943 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -213,7 +213,7 @@ static int mfd=5Fadd=5Fdevice(struct device *parent, in=
t id,
 		}
=20
 		if (!pdev->dev.of=5Fnode)
-			pr=5Fwarn("%s: Failed to locate of=5Fnode [id: %d]\n",
+			pr=5Fdebug("%s: Failed to locate of=5Fnode [id: %d]\n",
 				cell->name, platform=5Fid);
 	}
=20
--=20
2.30.0

