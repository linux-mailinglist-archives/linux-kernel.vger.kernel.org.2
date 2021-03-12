Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90533890E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhCLJsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhCLJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD21C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z2so1404669wrl.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9wGEZYJoAIhx351pyXi5TmAw4uiOf0aUU7wFJx73AA=;
        b=aT+b5fgyqnDqnX7G5hdmSnKGdVhd9/KtvR4wfW6CaqISTqzo1QWxh7kdAkq/1Ibjpc
         qpeXdoXLK6hueG+4qGj7plD0J70Wm6rd7ElVOEdFvRCj+mkkj3PZhzhmztTfbNTphipW
         028VkRDg4vGaTVotU4tB73nUGkhIrqiVKJLNMeSPqwzStwybxdzQ/9GiL1+hIqnPH/7f
         axRG75uF9535F3DGUbQUqCymVWkQxv4cB6m37A4LC9BW9qSUE+JQcYK3g7jHEYARZLlf
         gYZThZbE0Ym7c7yMJ2i7NYSIQBXiLSD673ZvEOP14ROber75e9NknV+mVPrJfy1u1Kwz
         8tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9wGEZYJoAIhx351pyXi5TmAw4uiOf0aUU7wFJx73AA=;
        b=FEuII2uPn3c+ilJ24gpDa6ew2x8cpYPeOyimG2NpoEY/Ag2oLv0ksOghQMNonry9OT
         CtpuUqNDOVzVPcU/uC0jgqBdUSBAHrs3pk5jUXMNbx9PPUYLAx7pOxPr5DgnKpnV8rfA
         9tWJb3/AKHcaJ/cZSqgOo+BDvP1Y5Me0Bf/HSR89aq+z7c3FtgSCdAZxQbirlNEokZAO
         +Q4GzjjmsJ5HMUOz/PGiOXHPF68AGsO3h0SNOYPCwdz+OQyxSZP7pow9cLKr3iBFkgoQ
         LrYKMIIdGS0g7nGqH9aAQc8pytbNAjnKEHlnapp6HVshTxF8Uao0oJoTFAYeIDBvl8yZ
         Yoqw==
X-Gm-Message-State: AOAM530IafNQqCLh2ficIayxCBE8jhLKKx8Jgc6hkPpZslwKVBOU1lnj
        mBQ2R4EE6yuc6hMci78+7FbrGQ==
X-Google-Smtp-Source: ABdhPJy4jSKuKcRpT3rqMHJb0ZPqCblkctt5Ebx8UNzjoft9Q7wfdmHUGu0Dun5/0VYuxQw+cWMWrg==
X-Received: by 2002:adf:e482:: with SMTP id i2mr13034372wrm.392.1615542480270;
        Fri, 12 Mar 2021 01:48:00 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:47:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vladislav Bolkhovitin <vst@vlnb.net>,
        Nathaniel Clark <nate@misrule.us>,
        "Nicholas A. Bellinger" <nab@kernel.org>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 11/30] scsi: qla2xxx: qla_target: Fix a couple of misdocumented functions
Date:   Fri, 12 Mar 2021 09:47:19 +0000
Message-Id: <20210312094738.2207817-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla2xxx/qla_target.c:6476: warning: expecting prototype for qla_tgt_lport_register(). Prototype was for qlt_lport_register() instead
 drivers/scsi/qla2xxx/qla_target.c:6546: warning: expecting prototype for qla_tgt_lport_deregister(). Prototype was for qlt_lport_deregister() instead

Cc: Nilesh Javali <njavali@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Vladislav Bolkhovitin <vst@vlnb.net>
Cc: Nathaniel Clark <nate@misrule.us>
Cc: "Nicholas A. Bellinger" <nab@kernel.org>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index c48daf52725d9..67c6a2710360a 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6462,7 +6462,7 @@ static void qlt_lport_dump(struct scsi_qla_host *vha, u64 wwpn,
 }
 
 /**
- * qla_tgt_lport_register - register lport with external module
+ * qlt_lport_register - register lport with external module
  *
  * @target_lport_ptr: pointer for tcm_qla2xxx specific lport data
  * @phys_wwpn: physical port WWPN
@@ -6538,7 +6538,7 @@ int qlt_lport_register(void *target_lport_ptr, u64 phys_wwpn,
 EXPORT_SYMBOL(qlt_lport_register);
 
 /**
- * qla_tgt_lport_deregister - Degister lport
+ * qlt_lport_deregister - Degister lport
  *
  * @vha:  Registered scsi_qla_host pointer
  */
-- 
2.27.0

