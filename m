Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1124633EC85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhCQJNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCQJM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:12:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A7DC0613D7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z2so1002845wrl.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bKVcoII/VExWgJlUv7/sN5c60FiIBMpvmlinKRnJimA=;
        b=MxXKhto9q9aaLM4LCO+LShWyhOUYRtAJedAKRvWFVJ4lyEZrFWIQDR7Cuhk1eUJrTz
         suzen/yOMRsiTSkMEzH3O79wsm9zWNVKldu0eGmN6WUhQOtfIJ1eHxggcJbluxeOP314
         Sq8r97Qego7DsLELU/HaMEr3KCt10tqRS3Mgu8s74sIl4htXqCk0hAUvnMpmOTIsh9wv
         u2xXkQBnHRnnuxhAYjKF8gOBdyKJEIjvLK0K8wV0EKaYTJRgfcToSL0YtwLGkwZY/ia7
         B358sXL6rbbgVIBaPmoScZTJonU4vYEblWpjJo2XjGaL1RdMnR7ATEaUdtk0dyfNRWSz
         OOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKVcoII/VExWgJlUv7/sN5c60FiIBMpvmlinKRnJimA=;
        b=VepDDxYeN7usfGBpCubCdn/XveIgh+AsVuiizBHKRt6W8cgx7KzDCYSaqU8VGUGY+0
         mjz4j3GZJRm+6eBDYK6GG5qOzFqvEus5hpSfE1vYD/gpZqmzuvCQzjLNGcRNFNksRAAo
         /hWGndO+d9gVnj0OE+B080ER2HwD//q7Xy44tnaCvNa1T4t2ugqPZ2y2D19/DQgBUxf2
         oYhjp7b0tlYDcnxMopst5/5hQfII7Lvsvuz83hy0AYglzBLoANLoNnI7IK50Z2dWYlu0
         nz4ACImrkt27C1/yJkjtGbwIn1PrEs6vmPjskCuYafakBdRtACUT0BZyRBof2NFgIZWX
         Fhrw==
X-Gm-Message-State: AOAM530BOcEp85b2HC4Ubm2ob3XW2JHc+lq10jfFuB8rfq6cP+13rkM+
        pQY90vpv3aaqQ9Yt2tsk+mZzpA==
X-Google-Smtp-Source: ABdhPJy4yS9D+aRU+N7H1kM68hnBC65Lc89Pi0NeqE56kh4j9u8k26hfS9Pt7vrAoBiI1ZBoTCQm5A==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr3403129wrt.294.1615972374378;
        Wed, 17 Mar 2021 02:12:54 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:53 -0700 (PDT)
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
Subject: [PATCH 14/36] scsi: mpt3sas: mpt3sas_scs: Fix a few kernel-doc issues
Date:   Wed, 17 Mar 2021 09:12:08 +0000
Message-Id: <20210317091230.2912389-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/mpt3sas/mpt3sas_scsih.c:763: warning: Function parameter or member 'sas_address' not described in '__mpt3sas_get_sdev_by_addr'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:763: warning: expecting prototype for mpt3sas_get_sdev_by_addr(). Prototype was for __mpt3sas_get_sdev_by_addr() instead
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:4535: warning: expecting prototype for _scsih_check_for_pending_internal_cmds(). Prototype was for mpt3sas_check_for_pending_internal_cmds() instead
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:6188: warning: Function parameter or member 'port_entry' not described in '_scsih_look_and_get_matched_port_entry'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:6188: warning: Function parameter or member 'matched_port_entry' not described in '_scsih_look_and_get_matched_port_entry'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:6188: warning: Function parameter or member 'count' not described in '_scsih_look_and_get_matched_port_entry'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:6959: warning: Function parameter or member 'port' not described in 'mpt3sas_expander_remove'
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:10494: warning: expecting prototype for mpt3sas_scsih_reset_handler(). Prototype was for mpt3sas_scsih_pre_reset_handler() instead
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:10536: warning: expecting prototype for mpt3sas_scsih_reset_handler(). Prototype was for mpt3sas_scsih_reset_done_handler() instead
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:12303: warning: expecting prototype for scsih__ncq_prio_supp(). Prototype was for scsih_ncq_prio_supp() instead

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
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 945531e94d7e4..23ecf2750ec79 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -749,9 +749,10 @@ __mpt3sas_get_sdev_by_rphy(struct MPT3SAS_ADAPTER *ioc,
 }
 
 /**
- * mpt3sas_get_sdev_by_addr - get _sas_device object corresponding to provided
+ * __mpt3sas_get_sdev_by_addr - get _sas_device object corresponding to provided
  *				sas address from sas_device_list list
  * @ioc: per adapter object
+ * @sas_address: device sas address
  * @port: port number
  *
  * Search for _sas_device object corresponding to provided sas address,
@@ -4518,7 +4519,7 @@ _scsih_issue_delayed_sas_io_unit_ctrl(struct MPT3SAS_ADAPTER *ioc,
 }
 
 /**
- * _scsih_check_for_pending_internal_cmds - check for pending internal messages
+ * mpt3sas_check_for_pending_internal_cmds - check for pending internal messages
  * @ioc: per adapter object
  * @smid: system request message index
  *
@@ -6174,10 +6175,10 @@ enum hba_port_matched_codes {
  * _scsih_look_and_get_matched_port_entry - Get matched hba port entry
  *					from HBA port table
  * @ioc: per adapter object
- * @port_entry - hba port entry from temporary port table which needs to be
+ * @port_entry: hba port entry from temporary port table which needs to be
  *		searched for matched entry in the HBA port table
- * @matched_port_entry - save matched hba port entry here
- * @count - count of matched entries
+ * @matched_port_entry: save matched hba port entry here
+ * @count: count of matched entries
  *
  * return type of matched entry found.
  */
@@ -6952,6 +6953,7 @@ _scsih_expander_add(struct MPT3SAS_ADAPTER *ioc, u16 handle)
  * mpt3sas_expander_remove - removing expander object
  * @ioc: per adapter object
  * @sas_address: expander sas_address
+ * @port: hba port entry
  */
 void
 mpt3sas_expander_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
@@ -10487,7 +10489,7 @@ _scsih_scan_for_devices_after_reset(struct MPT3SAS_ADAPTER *ioc)
 }
 
 /**
- * mpt3sas_scsih_reset_handler - reset callback handler (for scsih)
+ * mpt3sas_scsih_pre_reset_handler - reset callback handler (for scsih)
  * @ioc: per adapter object
  *
  * The handler for doing any required cleanup or initialization.
@@ -10528,7 +10530,7 @@ mpt3sas_scsih_clear_outstanding_scsi_tm_commands(struct MPT3SAS_ADAPTER *ioc)
 }
 
 /**
- * mpt3sas_scsih_reset_handler - reset callback handler (for scsih)
+ * mpt3sas_scsih_reset_done_handler - reset callback handler (for scsih)
  * @ioc: per adapter object
  *
  * The handler for doing any required cleanup or initialization.
@@ -12295,7 +12297,7 @@ scsih_pci_mmio_enabled(struct pci_dev *pdev)
 }
 
 /**
- * scsih__ncq_prio_supp - Check for NCQ command priority support
+ * scsih_ncq_prio_supp - Check for NCQ command priority support
  * @sdev: scsi device struct
  *
  * This is called when a user indicates they would like to enable
-- 
2.27.0

