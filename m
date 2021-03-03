Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2C32BF14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386234AbhCCR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244888AbhCCO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:59:06 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F3C061764
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:56:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e23so5419761wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nA9wVETTE+l5uPS+DZDdIXSJ2iBKhK6p+7XSOzWKHSU=;
        b=hlS4E2IDwIa1PMDMgxwXk7gU4hEHRXkOuLGlqiLu4q8Vnuj6pH7JtS/qQLVXpnKl90
         jnGBdcO/Gr4aSLGNkDEUBG8KLMfkXL2zN6cOZp73fWqZ0o+YTbhOcJE8ED7cHKeemwqw
         w3cBksK1PxnCZnTJgzjSLZ5+B/h5Rn4kOFnHn3XDR4h9TnP80XIoIoxZ/hrQM2RU6z3r
         faXhSuWnEe89E/lKDVJYBfI6yXz5XWNzg4EDOrlv7ubnqClNVacBehfpGyFoJ4uG13KW
         iWEvpR4Xp21nuOsQnDaCMSp+CAIFQiWhrj2uw/U1x+Z5ddWrHb+z3Cyb8CNWnm5JU0wH
         UDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nA9wVETTE+l5uPS+DZDdIXSJ2iBKhK6p+7XSOzWKHSU=;
        b=E0sde3tZAndEDKf95k20lgoMo2QjYErXb7yKYN73l3r8KqLvJgA52VDTCY22xRIk5d
         ZSIpDyLTl/MEWkYwedRXdy1AR6p3aiaDNujrWIcN5ERnGbY8ufakMeDfaZzfh/hlvVml
         04FxJunLkt9X3rCUxIdVUzM7TBixDYksThymaZ/wZ6Bd/MmCKZHqxnbR1Piu8tRGlxro
         cc+V46BlVThWnHAjPguvRZVKRg3fbUINLBASmJM0M0JTscCu7iK/EFGb8LGDUi3mxy5C
         qMeAPMT1xPTrWRFosip+a+lOFmC+7IRBakTwbeApJt28D3c3v3vOTTNAXHdF6OtVwHpO
         Pd3g==
X-Gm-Message-State: AOAM530wRGZSrHDYgs8XpHJFxXcuadOGDu5BG8GTY6mSNGgBTXp+yDuL
        roq0TsbZGHQP3sPRx6uqpJcsO2p34+BkXw==
X-Google-Smtp-Source: ABdhPJxDDcx0g9CaC/EPknkMQfkF94FQ1DT/mhH9ELNTWFxUSu+zitclXAEe8hBFA3H3IpwbEltmTQ==
X-Received: by 2002:a1c:8005:: with SMTP id b5mr9580831wmd.130.1614782878600;
        Wed, 03 Mar 2021 06:47:58 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@avagotech.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 30/30] scsi: mpt3sas: mpt3sas_scs: Move a little data from the stack onto the heap
Date:   Wed,  3 Mar 2021 14:46:31 +0000
Message-Id: <20210303144631.3175331-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/mpt3sas/mpt3sas_scsih.c: In function ‘_scsih_scan_for_devices_after_reset’:
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:10473:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Sathya Prakash <sathya.prakash@broadcom.com>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: MPT-FusionLinux.pdl@avagotech.com
Cc: MPT-FusionLinux.pdl@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 38 +++++++++++++++++++---------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 7bd0a57e5b928..945531e94d7e4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10219,8 +10219,8 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 	Mpi2ExpanderPage0_t expander_pg0;
 	Mpi2SasDevicePage0_t sas_device_pg0;
 	Mpi26PCIeDevicePage0_t pcie_device_pg0;
-	Mpi2RaidVolPage1_t volume_pg1;
-	Mpi2RaidVolPage0_t volume_pg0;
+	Mpi2RaidVolPage1_t *volume_pg1;
+	Mpi2RaidVolPage0_t *volume_pg0;
 	Mpi2RaidPhysDiskPage0_t pd_pg0;
 	Mpi2EventIrConfigElement_t element;
 	Mpi2ConfigReply_t mpi_reply;
@@ -10235,6 +10235,16 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 	u8 retry_count;
 	unsigned long flags;
 
+	volume_pg0 = kzalloc(sizeof(*volume_pg0), GFP_KERNEL);
+	if (!volume_pg0)
+		return;
+
+	volume_pg1 = kzalloc(sizeof(*volume_pg1), GFP_KERNEL);
+	if (!volume_pg1) {
+		kfree(volume_pg0);
+		return;
+	}
+
 	ioc_info(ioc, "scan devices: start\n");
 
 	_scsih_sas_host_refresh(ioc);
@@ -10344,7 +10354,7 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 	/* volumes */
 	handle = 0xFFFF;
 	while (!(mpt3sas_config_get_raid_volume_pg1(ioc, &mpi_reply,
-	    &volume_pg1, MPI2_RAID_VOLUME_PGAD_FORM_GET_NEXT_HANDLE, handle))) {
+	    volume_pg1, MPI2_RAID_VOLUME_PGAD_FORM_GET_NEXT_HANDLE, handle))) {
 		ioc_status = le16_to_cpu(mpi_reply.IOCStatus) &
 		    MPI2_IOCSTATUS_MASK;
 		if (ioc_status != MPI2_IOCSTATUS_SUCCESS) {
@@ -10352,15 +10362,15 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 				 ioc_status, le32_to_cpu(mpi_reply.IOCLogInfo));
 			break;
 		}
-		handle = le16_to_cpu(volume_pg1.DevHandle);
+		handle = le16_to_cpu(volume_pg1->DevHandle);
 		spin_lock_irqsave(&ioc->raid_device_lock, flags);
 		raid_device = _scsih_raid_device_find_by_wwid(ioc,
-		    le64_to_cpu(volume_pg1.WWID));
+		    le64_to_cpu(volume_pg1->WWID));
 		spin_unlock_irqrestore(&ioc->raid_device_lock, flags);
 		if (raid_device)
 			continue;
 		if (mpt3sas_config_get_raid_volume_pg0(ioc, &mpi_reply,
-		    &volume_pg0, MPI2_RAID_VOLUME_PGAD_FORM_HANDLE, handle,
+		    volume_pg0, MPI2_RAID_VOLUME_PGAD_FORM_HANDLE, handle,
 		     sizeof(Mpi2RaidVolPage0_t)))
 			continue;
 		ioc_status = le16_to_cpu(mpi_reply.IOCStatus) &
@@ -10370,17 +10380,17 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 				 ioc_status, le32_to_cpu(mpi_reply.IOCLogInfo));
 			break;
 		}
-		if (volume_pg0.VolumeState == MPI2_RAID_VOL_STATE_OPTIMAL ||
-		    volume_pg0.VolumeState == MPI2_RAID_VOL_STATE_ONLINE ||
-		    volume_pg0.VolumeState == MPI2_RAID_VOL_STATE_DEGRADED) {
+		if (volume_pg0->VolumeState == MPI2_RAID_VOL_STATE_OPTIMAL ||
+		    volume_pg0->VolumeState == MPI2_RAID_VOL_STATE_ONLINE ||
+		    volume_pg0->VolumeState == MPI2_RAID_VOL_STATE_DEGRADED) {
 			memset(&element, 0, sizeof(Mpi2EventIrConfigElement_t));
 			element.ReasonCode = MPI2_EVENT_IR_CHANGE_RC_ADDED;
-			element.VolDevHandle = volume_pg1.DevHandle;
+			element.VolDevHandle = volume_pg1->DevHandle;
 			ioc_info(ioc, "\tBEFORE adding volume: handle (0x%04x)\n",
-				 volume_pg1.DevHandle);
+				 volume_pg1->DevHandle);
 			_scsih_sas_volume_add(ioc, &element);
 			ioc_info(ioc, "\tAFTER adding volume: handle (0x%04x)\n",
-				 volume_pg1.DevHandle);
+				 volume_pg1->DevHandle);
 		}
 	}
 
@@ -10468,6 +10478,10 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 		ioc_info(ioc, "\tAFTER adding pcie end device: handle (0x%04x), wwid(0x%016llx)\n",
 			 handle, (u64)le64_to_cpu(pcie_device_pg0.WWID));
 	}
+
+	kfree(volume_pg0);
+	kfree(volume_pg1);
+
 	ioc_info(ioc, "\tpcie devices: pcie end devices complete\n");
 	ioc_info(ioc, "scan devices: complete\n");
 }
-- 
2.27.0

