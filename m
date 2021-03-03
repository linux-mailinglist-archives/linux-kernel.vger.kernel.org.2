Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D0232BF1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577770AbhCCSA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359741AbhCCOum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:50:42 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB85C0613BA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m1so6591971wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySODZ2632aeayKlQPyHeudZTc8h2kJ2bKUfsQdptsf8=;
        b=cUBgEPDjKYhvu0dZiA4icyJA4vYab4lZb6iX/nQJ2sOJUYF/AQq3BkXozRnfCXXyZf
         C5lXrtJF48Tk/3a5M7tUI+AiDfrXocEW5VOVyqrEz/158Yyzs0rDJt4ZJsjiLM0B+zIp
         mooa1IFW/sBUw0tkpWtuGZln6XSKuxzDukJyRyh0FM4Z56DeAHP4aCdRNXkhUvwKV1qq
         Ra7tgXvQscr5N0phsB/kcKVu5DAxsOKX2KyMN4jivihgcgMJvu3jxSd8EKJxkxd7hfyQ
         +61uagjqC+STaS0xxSqAo4Mw4/XeNrP+k9nQnWJ918DiYvwJdZis0YTzimsMrlXkRBXG
         b6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySODZ2632aeayKlQPyHeudZTc8h2kJ2bKUfsQdptsf8=;
        b=Oll/VqrsU8ARP1hrNh184nOtXI2LgssBk12zguCJPMdzYBTYtlPJA94H+g6fa7NLVV
         8JFdqNB8q39SrSCYwjPCH1/fL8t141PbQaAMYQ2HugDn0YD9fLElB4kTlTiYYuAV4ITK
         AH9dWcJqbMkbM5FdwxVEeM3WFH0DwLwzLRYKkgJB+tOdFRGojqkkGv5MfflyVJ5MXkG4
         6kMlOv9AHw0KPzHLBTPAZHA6rRBm42A2vw9pJnkaAzJHEx3/aIjUWW9i9Y/Hwa1kS7SL
         DC12JIbLRXK/A8niZVH7WenyhC0NC3SxWFBsPOzi999rrUAcwCIlaixpZ9p3fh+5ewOf
         wrKg==
X-Gm-Message-State: AOAM532UNds1un025HYTbNCd7K9aSUgiqkQ/qUljuXP+xLWYVOy82Z7K
        leNsAys78/pAi+CJF7Edfx4llw==
X-Google-Smtp-Source: ABdhPJwRUXmasnEMFe8nVPXeu7uGCy56SCGhP6kMptpmGfqtmkZqKvMv/OK5kAcnTJUUuGMzy2RHiQ==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr5447864wmg.97.1614782846325;
        Wed, 03 Mar 2021 06:47:26 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:47:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 19/30] scsi: qla4xxx: ql4_mbx: Fix kernel-doc formatting and misnaming issue
Date:   Wed,  3 Mar 2021 14:46:20 +0000
Message-Id: <20210303144631.3175331-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla4xxx/ql4_mbx.c:47: warning: wrong kernel-doc identifier on line:
 drivers/scsi/qla4xxx/ql4_mbx.c:947: warning: expecting prototype for qla4xxx_set_fwddb_entry(). Prototype was for qla4xxx_set_ddb_entry() instead

Cc: Nilesh Javali <njavali@marvell.com>
Cc: Manish Rangankar <mrangankar@marvell.com>
Cc: GR-QLogic-Storage-Upstream@marvell.com
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla4xxx/ql4_mbx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index 17b719a8b6fbc..187d78aa4f675 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -44,7 +44,7 @@ void qla4xxx_process_mbox_intr(struct scsi_qla_host *ha, int out_count)
 }
 
 /**
- * qla4xxx_is_intr_poll_mode – Are we allowed to poll for interrupts?
+ * qla4xxx_is_intr_poll_mode - Are we allowed to poll for interrupts?
  * @ha: Pointer to host adapter structure.
  * returns: 1=polling mode, 0=non-polling mode
  **/
@@ -933,7 +933,7 @@ int qla4xxx_conn_open(struct scsi_qla_host *ha, uint16_t fw_ddb_index)
 }
 
 /**
- * qla4xxx_set_fwddb_entry - sets a ddb entry.
+ * qla4xxx_set_ddb_entry - sets a ddb entry.
  * @ha: Pointer to host adapter structure.
  * @fw_ddb_index: Firmware's device database index
  * @fw_ddb_entry_dma: dma address of ddb entry
-- 
2.27.0

