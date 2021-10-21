Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53AD436C80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhJUVPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:15:47 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:34068 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232108AbhJUVPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:15:45 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Hb0Zb1rpKzJS;
        Thu, 21 Oct 2021 23:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1634850807; bh=9qJIpqSRA2TmEhczLiLWEbnxs74iZkhXFYaprf7wcOg=;
        h=Date:From:Subject:To:Cc:From;
        b=YsNPKc11TT4AECsARtGuGsiyJpLpDG3T0qIKGqKgoXT0dgV1ZJsPAWB0sTAN9NA4V
         3n42Qdq/89g9hvdw8IZtTyNU4hYYEvx1eXti2DThV3lre8oBZ3nfVdp6EgF0lfG6uX
         vwpU+3SBi1IcS2kNNEh9J0LOfyEpxml/ELkwIm1sOPdqQHSvr5Ih7uK/cIQEcLV66d
         /xNSrRoKnmlAV/XzFmwtHsC0TVj1Bw74Y9eZOS213Eu8SuWBMY8I4FfKuURcSSAoBW
         1JbLvTxNY0VVdsG6IS4YazPJdFb6TOcQqGswy6xbRKgZoj5bL1rkglkN3ehvy3a4Hv
         vnEYPEqWzG6tg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Thu, 21 Oct 2021 23:13:27 +0200
Message-Id: <f0c83405252d9f0b92490087ee76806bc7e51e0f.1634850725.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] dm: log table creation error code
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Help debugging table creation errors by adding the error name in the log.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/md/dm-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 2111daaacaba..017522439e78 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -706,7 +706,7 @@ int dm_table_add_target(struct dm_table *t, const char *type,
 
 	r = dm_split_args(&argc, &argv, params);
 	if (r) {
-		tgt->error = "couldn't split parameters (insufficient memory)";
+		tgt->error = "couldn't split parameters";
 		goto bad;
 	}
 
@@ -724,7 +724,7 @@ int dm_table_add_target(struct dm_table *t, const char *type,
 	return 0;
 
  bad:
-	DMERR("%s: %s: %s", dm_device_name(t->md), type, tgt->error);
+	DMERR("%s: %s: %s (%pe)", dm_device_name(t->md), type, tgt->error, ERR_PTR(r));
 	dm_put_target_type(tgt->type);
 	return r;
 }
-- 
2.30.2

