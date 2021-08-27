Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC383F9D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhH0RQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237168AbhH0RQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630084533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9Gafj8sxsDqc97Bfoh5OIubdmjwxbqAMG/Cf5EW4CHA=;
        b=gcbXGuqDoSZ+MENPuOMvCLYGMotBqBnv2DxKZBdgIf5Co4o1JWcqA81aech99VxIAPj9nP
        KMWi5onRwPo5qAYdqsz98GTksJGYUWadJju+M8i07Y5nT7YM3tPpg3PVlHjaPybfK9hFzw
        h27RJqCvF/yzdK/CPGaiOGUZ0isJJeo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-NU81gqk7PYSTIID58oA9nQ-1; Fri, 27 Aug 2021 13:15:31 -0400
X-MC-Unique: NU81gqk7PYSTIID58oA9nQ-1
Received: by mail-qt1-f197.google.com with SMTP id e6-20020ac84e46000000b0029baad9aaa0so713609qtw.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Gafj8sxsDqc97Bfoh5OIubdmjwxbqAMG/Cf5EW4CHA=;
        b=eztmwU4qaBNHrbtVuQ9lf+xmjyQjoP9zqwJS9EoYnsDUFqIruYJeWz+4AwpgltPGh8
         jl0tDesoY6mm/gGGTbQczwnRQzdbTFm6FcO2HmebiGMmYlfFfnsYfopZc30xXehEOcEK
         29GrJ+zvgOyMED4SNuUV/RDBb55N/UmPdiIU2h0Dj0tSoS9s+UURUfytEYvKQFjX48PC
         zMKX4/xocDuu/7zJhXcWu0ivaRc/DK0Q7+uR7vLEg9kFu93vb3K3W21l5vXDnkHoD6tx
         piR9EUitQCO7qpYTGOHaUm0/NhExlfwcVej56eE8n+pQ/T6fq6agdHX8im4rqolGWh+3
         HG/g==
X-Gm-Message-State: AOAM530oBBQLbGgS91g+alcgwREWUPiIYtLsY9K9x/CUi9zzJUxxqLeY
        d6Lpipt6QL4b91/xPnCLyGyHnsmxHzbxdvn/TKWWGVie2Qrc9B6k8NzfuFfeHC/60nlLbveEYgW
        hQ62FwQlGuoR+XXEQa6yZ8XEu
X-Received: by 2002:a05:622a:650:: with SMTP id a16mr9368934qtb.157.1630084530828;
        Fri, 27 Aug 2021 10:15:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+mGVdS88FWRCD11ZTp8zbd10l92FiowGcA/FEWX67lzhyonxWS4Z0phgbqe+R7LCZiA3JOA==
X-Received: by 2002:a05:622a:650:: with SMTP id a16mr9368915qtb.157.1630084530614;
        Fri, 27 Aug 2021 10:15:30 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q14sm5119552qkl.44.2021.08.27.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:15:30 -0700 (PDT)
From:   trix@redhat.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] igc: optimize igc_ptp_systim_to_hwtstamp()
Date:   Fri, 27 Aug 2021 10:15:15 -0700
Message-Id: <20210827171515.2518713-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this representative problem
igc_ptp.c:676:3: warning: The left operand of '+' is a garbage value
                ktime_add_ns(shhwtstamps.hwtstamp, adjust);
                ^            ~~~~~~~~~~~~~~~~~~~~

The issue is flagged because the setting of shhwtstamps is
in igc_ptp_systim_to_hwtstamp() it is set only in one path through
this switch.

	switch (adapter->hw.mac.type) {
	case igc_i225:
		memset(hwtstamps, 0, sizeof(*hwtstamps));
		/* Upper 32 bits contain s, lower 32 bits contain ns. */
		hwtstamps->hwtstamp = ktime_set(systim >> 32,
						systim & 0xFFFFFFFF);
		break;
	default:
		break;
	}

Changing the memset the a caller initialization is a small optimization
and will resolve uninitialized use issue.

A switch statement with one case is overkill, convert to an if statement.

This function is small and only called once, change to inline for an
expected small runtime and size improvement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 0f021909b430a0..1443a2da246e22 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -417,20 +417,14 @@ static int igc_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
  * We need to convert the system time value stored in the RX/TXSTMP registers
  * into a hwtstamp which can be used by the upper level timestamping functions.
  **/
-static void igc_ptp_systim_to_hwtstamp(struct igc_adapter *adapter,
-				       struct skb_shared_hwtstamps *hwtstamps,
-				       u64 systim)
+static inline void igc_ptp_systim_to_hwtstamp(struct igc_adapter *adapter,
+					      struct skb_shared_hwtstamps *hwtstamps,
+					      u64 systim)
 {
-	switch (adapter->hw.mac.type) {
-	case igc_i225:
-		memset(hwtstamps, 0, sizeof(*hwtstamps));
-		/* Upper 32 bits contain s, lower 32 bits contain ns. */
+	/* Upper 32 bits contain s, lower 32 bits contain ns. */
+	if (adapter->hw.mac.type == igc_i225)
 		hwtstamps->hwtstamp = ktime_set(systim >> 32,
 						systim & 0xFFFFFFFF);
-		break;
-	default:
-		break;
-	}
 }
 
 /**
@@ -645,7 +639,7 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
 static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 {
 	struct sk_buff *skb = adapter->ptp_tx_skb;
-	struct skb_shared_hwtstamps shhwtstamps;
+	struct skb_shared_hwtstamps shhwtstamps = { 0 };
 	struct igc_hw *hw = &adapter->hw;
 	int adjust = 0;
 	u64 regval;
-- 
2.26.3

