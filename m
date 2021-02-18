Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21C31EBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhBRPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:52:57 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5209 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhBRNYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613654742; x=1645190742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B6DrFT1ZEou0D3mCrFnzhgoBXsLD8u2OUEwahoURYsM=;
  b=TZB5qeyin4f8D/fak1J3goMZ6tyiQ7FRSIW2LFbTiR5kM3jEIYWNC0fO
   S1vxBt1hjzA7lP2Pt3Zr9KNuTnVyYe1QyYfQkQ/qoaSRqWr6OJ5FDp3R1
   xY5W2POZmyJrnFpXgqxuq6iZ8GvnCRtaavVd5WmI41OkZ8nkumUf7Sx1B
   BMVkCRAIGgeq/X+2gqMlYLJkjnFnDdPDLqMBPn3fBMsVPtxjvxeNbJzkB
   70bBJGNHuZNjVYKTD7pa+ql1cboLw/aFpH1fdP52PQ8Q3H/gmZ4VVKlcu
   0TO24ufHTn+1chKHL5yFuYHZDRoSU9h17swNQLJVKAWQj867RGx4Z9w1z
   Q==;
IronPort-SDR: 8j0F21sGdJ+nXyFN63y4iknYslEbYO/QX8hYCflJy/9ip7sn9rJVqLz0f7U8ROKrkHRWx3KwEr
 li3BQyKkM2iK+5GETt2usqmxhpKb/Lwwn2wQPrcyIddl4HOQJwObLJGoVJ7smebxaA0vknORck
 k4CB+4mSJyZDjEictJQPruX+saJDmuac91gDkkRE8oeeo2yS9oJCe1G4wjn2X/Ac7dNAOxZaz/
 I2YPWtaIcZWp+Bc9XXrmToPCyqsTv32vkgrYOXUvHYbGciFlaxtof/VzAz0NzS8/h711q930Ed
 o64=
X-IronPort-AV: E=Sophos;i="5.81,187,1610380800"; 
   d="scan'208";a="264440629"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 21:21:28 +0800
IronPort-SDR: pMUYDV1ZU7fa0tH4VV3s1dqpctWB+gdLlMPsmTFJK+8em6V8OAbyd0kmo0pm5Z/aBJDkygqph+
 K4GSJ6DtcNxR6D8FN0OWtkheAEpEuwC408r97Cui+oU40VGgRMYtl4akG+anJXLeA3D+26aii/
 RO+DBQ0ZBETPGmbugFrNC9vMOwqn4lZcY5jmNBI9gJmEQucLIRAJmJfp58+m+VYb2FbrNNC8YX
 o5ky63tL2vybPnDEg5f5awhEKAfanH8uQ013yQaHn5zyW97aGp8i84qwXh5PlcHzgDNfNzio/n
 dogV252AXiDG/1RmCnIGdbUf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 05:02:58 -0800
IronPort-SDR: 8RJqXVcXLIET9cQsn2Kr9SkEwo0WPQ86vFh+bqYevi6u9GbJpabEPf/Eu6jreatZRtKKwnK4hI
 9Cn5gKvbn72iOkazNwTzg1JsP9H9+9BSFRNLHtORkSTBCiwiock9ltADDfjzAhpK5D+h1Ea/7r
 IC6mBa3d3BfRiDRvzRXbEViBTqi8Px2dxfXKWEXTCA+YUpuefY2+3pxg8Ef7sU9ZKgaklJsz+g
 XyIhmFMzDyEnSEaRghHPF/avorSikGUbJ9NCaf195j1uy+P7Dcs6XFZ7wFvJZRwi2mMG+0mM9g
 fEQ=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Feb 2021 05:21:14 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Bart Van Assche <bvanassche@acm.org>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        alim.akhtar@samsung.com, asutoshd@codeaurora.org,
        Zang Leigang <zangleigang@hisilicon.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Bean Huo <beanhuo@micron.com>, cang@codeaurora.org,
        stanley.chu@mediatek.com, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 6/9] scsi: ufshpb: Add hpb dev reset response
Date:   Thu, 18 Feb 2021 15:19:29 +0200
Message-Id: <20210218131932.106997-7-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218131932.106997-1-avri.altman@wdc.com>
References: <20210218131932.106997-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spec does not define what is the host's recommended response when
the device send hpb dev reset response (oper 0x2).

We will update all active hpb regions: mark them and do that on the next
read.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/scsi/ufs/ufshpb.c | 40 ++++++++++++++++++++++++++++++++++++---
 drivers/scsi/ufs/ufshpb.h |  3 +++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 3435a5507853..15755f677097 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -658,7 +658,8 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 		if (rgn->reads == ACTIVATION_THRESHOLD)
 			activate = true;
 		spin_unlock_irqrestore(&rgn->rgn_lock, flags);
-		if (activate) {
+		if (activate ||
+		    test_and_clear_bit(RGN_FLAG_UPDATE, &rgn->rgn_flags)) {
 			spin_lock_irqsave(&hpb->rsp_list_lock, flags);
 			ufshpb_update_active_info(hpb, rgn_idx, srgn_idx);
 			hpb->stats.rb_active_cnt++;
@@ -1446,6 +1447,11 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	case HPB_RSP_DEV_RESET:
 		dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
 			 "UFS device lost HPB information during PM.\n");
+
+		if (hpb->is_hcm &&
+		    !test_and_set_bit(RESET_PENDING, &hpb->work_data_bits))
+			schedule_work(&hpb->ufshpb_lun_reset_work);
+
 		break;
 	default:
 		dev_notice(&hpb->sdev_ufs_lu->sdev_dev,
@@ -1560,6 +1566,27 @@ static void ufshpb_run_inactive_region_list(struct ufshpb_lu *hpb)
 	spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
 }
 
+static void ufshpb_reset_work_handler(struct work_struct *work)
+{
+	struct ufshpb_lu *hpb;
+	struct victim_select_info *lru_info;
+	struct ufshpb_region *rgn;
+	unsigned long flags;
+
+	hpb = container_of(work, struct ufshpb_lu, ufshpb_lun_reset_work);
+
+	lru_info = &hpb->lru_info;
+
+	spin_lock_irqsave(&hpb->rgn_state_lock, flags);
+
+	list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn)
+		set_bit(RGN_FLAG_UPDATE, &rgn->rgn_flags);
+
+	spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
+
+	clear_bit(RESET_PENDING, &hpb->work_data_bits);
+}
+
 static void ufshpb_normalization_work_handler(struct work_struct *work)
 {
 	struct ufshpb_lu *hpb;
@@ -1770,6 +1797,8 @@ static int ufshpb_alloc_region_tbl(struct ufs_hba *hba, struct ufshpb_lu *hpb)
 		} else {
 			rgn->rgn_state = HPB_RGN_INACTIVE;
 		}
+
+		rgn->rgn_flags = 0;
 	}
 
 	return 0;
@@ -1983,9 +2012,12 @@ static int ufshpb_lu_hpb_init(struct ufs_hba *hba, struct ufshpb_lu *hpb)
 	INIT_LIST_HEAD(&hpb->list_hpb_lu);
 
 	INIT_WORK(&hpb->map_work, ufshpb_map_work_handler);
-	if (hpb->is_hcm)
+	if (hpb->is_hcm) {
 		INIT_WORK(&hpb->ufshpb_normalization_work,
 			  ufshpb_normalization_work_handler);
+		INIT_WORK(&hpb->ufshpb_lun_reset_work,
+			  ufshpb_reset_work_handler);
+	}
 
 	hpb->map_req_cache = kmem_cache_create("ufshpb_req_cache",
 			  sizeof(struct ufshpb_req), 0, 0, NULL);
@@ -2085,8 +2117,10 @@ static void ufshpb_discard_rsp_lists(struct ufshpb_lu *hpb)
 
 static void ufshpb_cancel_jobs(struct ufshpb_lu *hpb)
 {
-	if (hpb->is_hcm)
+	if (hpb->is_hcm) {
+		cancel_work_sync(&hpb->ufshpb_lun_reset_work);
 		cancel_work_sync(&hpb->ufshpb_normalization_work);
+	}
 	cancel_work_sync(&hpb->map_work);
 }
 
diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
index 13ec49ba260d..a3b85d2df224 100644
--- a/drivers/scsi/ufs/ufshpb.h
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -119,6 +119,7 @@ struct ufshpb_region {
 	struct list_head list_lru_rgn;
 	unsigned long rgn_flags;
 #define RGN_FLAG_DIRTY 0
+#define RGN_FLAG_UPDATE 1
 
 	/* region reads - for host mode */
 	spinlock_t rgn_lock;
@@ -215,8 +216,10 @@ struct ufshpb_lu {
 	/* for selecting victim */
 	struct victim_select_info lru_info;
 	struct work_struct ufshpb_normalization_work;
+	struct work_struct ufshpb_lun_reset_work;
 	unsigned long work_data_bits;
 #define WORK_PENDING 0
+#define RESET_PENDING 1
 
 	/* pinned region information */
 	u32 lu_pinned_start;
-- 
2.25.1

