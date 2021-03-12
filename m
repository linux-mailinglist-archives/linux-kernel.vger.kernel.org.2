Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC6338927
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhCLJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhCLJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E064C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:03 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g25so3392398wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JI6G3CFZx8fwaZ+wMXfyA1uTc9sykYtKryE0jb27AH8=;
        b=LvZZjQqh+hYVHovFbGfa2YimjbNcopAKf2FZ41k0JafVuhVFK5teA3JpIbZo04IirG
         T3FE3HwLMHe3hRd4f1e7pYFuzKcngzqClIHRJv58wKOf6YLyHr3oW4NEZFrlvIPqiAAD
         umvPHJzcpzO3EazANHiX3Z7AWtRY+KMq52oDleuaqE9FW91NrAZefDoeKN0dTnaSosX7
         2x2qTmSphRDpvMTdnfVqbdq2Tp0ry+NQoyXkK+cxZOn14bKVik5jWKcbf0LTIfBpgqwi
         qvPSsYPc25e6pL72RE1CUAk1N+qZT0yk5IYUEdanwW0Ul3rymue2UDxEZXoyyu9DE5ab
         7TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JI6G3CFZx8fwaZ+wMXfyA1uTc9sykYtKryE0jb27AH8=;
        b=EX8nqL6cjfUq42YYrqAPf649sQzu71xbx2mzZSKkg6IHCB1ZkjqTa7nTIDgsXuw6sF
         2usjOUq8vdn7ICrax74Krt3jVAvRWUqbfBh5AHLtloDKDEzVUcAoHTveWMrMz6qR1Nhs
         983bXv+QuErP0iFvnlFhnH9EPWRR9SvAAPg3JYPVUx9STR1qlmss0fFkidNTkeQlKwtG
         6m3T+5yc/IqcjSoo6CpqyPuGOtjGX2bxHfhrkUPtyJrQH7NMJFH0Ad5HPJRZ+I1KRTig
         5zF6IF6KnXy48adpvtn/MfMTARNBuMX6prYGY/HAHd3XHZw5nCo6v3CT/gqynqh2uX9B
         DO6Q==
X-Gm-Message-State: AOAM531NOirIcTBJRxg3OJI4r0I/CU6vQdcg50O9ZbcqMV+Zi3isYyyK
        iJgs00qF4pO3Ca1HcK0QpSUgBQ==
X-Google-Smtp-Source: ABdhPJwgu+dYkUSJIPzhrkavhgPa19SJxwU7Gw7kkrY+EIpO5oTC5zDDwsUJvZSioQsoR2R3olJXOQ==
X-Received: by 2002:a1c:9817:: with SMTP id a23mr12073936wme.57.1615542482068;
        Fri, 12 Mar 2021 01:48:02 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:01 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 12/30] scsi: lpfc: lpfc_debugfs: Fix incorrectly documented function lpfc_debugfs_commonxripools_data()
Date:   Fri, 12 Mar 2021 09:47:20 +0000
Message-Id: <20210312094738.2207817-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/lpfc/lpfc_debugfs.c:405: warning: expecting prototype for lpfc_debugfs_common_xri_data(). Prototype was for lpfc_debugfs_commonxripools_data() instead

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index ec5328f7f1d41..c23a535ac89ac 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -381,7 +381,7 @@ lpfc_debugfs_hbqinfo_data(struct lpfc_hba *phba, char *buf, int size)
 static int lpfc_debugfs_last_xripool;
 
 /**
- * lpfc_debugfs_common_xri_data - Dump Hardware Queue info to a buffer
+ * lpfc_debugfs_commonxripools_data - Dump Hardware Queue info to a buffer
  * @phba: The HBA to gather host buffer info from.
  * @buf: The buffer to dump log into.
  * @size: The maximum amount of data to process.
-- 
2.27.0

