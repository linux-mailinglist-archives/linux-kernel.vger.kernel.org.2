Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04953338922
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhCLJtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhCLJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6851C0613D7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso14765849wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+AJW1JfC267V4VbkGwrESDS7kAwVhhZrAmnvaz3wpc=;
        b=O1HZG9pKPXhi2/2uiwV/azuDXxbonWJ0pNedzgmJEiFRhIQkSvNlPCUid4kweHF91z
         gIwDWMhccLBJn3mr9SNq22dYv5vjrLxtqCBbnGLnXzHjj0j/izHUjnbSUDaqtjkZip0u
         eKMZDX1Z+M81t7k5xu2FThyj7NIvdZCdn8GnFaVkac5N50OXJl34WlmHIUZwn0tElxUP
         HbU4Mle9vuxF+WHdnHO2zClocvyoCf1Pk08B0WDIKOVYiPjc1W/DurTXXurjCgUPpI0c
         LWBmdvyqQn00K10qB/WLDd+XY9yXUbZZ2p4Peqo1xJaKJG4IkY9Jvx8TlND1rZKFgGUr
         9EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+AJW1JfC267V4VbkGwrESDS7kAwVhhZrAmnvaz3wpc=;
        b=owZWAzyY0ZXU1hOjSnWVO4BlEpz+deLkADzpY91N9WpCqi7IW/3CKbRtfg1RZ5Ayh8
         cbBoXh7JdDNC8eMRuAOeMPQFSj3tBwV9/Cynp6A7atCCubwJI962lvu8XcOYm5cCM33v
         0OQU4UHpny9x3u6hf+l+NqY/LTigdh37tntspO6Ut1GPly2adA7uU2I6QnEEIbjiuOJe
         +ZVr6iGb4w1rWPThQgK4O1o0Bwef5QsYboyGKe6DPcsombfde/rYx8rrqf2CYRwuQ0An
         X3oeNTLSlO4l3fVwe0v4Y6JShNLPokhFtSJtPS8SFEO4O8sdShAgzQlaMjX1tKZTaoRF
         p/VQ==
X-Gm-Message-State: AOAM532nrt0oAVfvyvG/E4C4TS4Pie4J9+UMYkS8Bh5ArqItuzFnaP+B
        pRz0Wj5FwIbCRq/90ws1sKpS2A==
X-Google-Smtp-Source: ABdhPJxpw/RCjE9owSu66rCtUR4c1th3a9fvVIAYqX1Lww4ZY4U3NHVX1Vlu4MN2AKV/g9QyFj9MUg==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr12224316wmg.87.1615542489224;
        Fri, 12 Mar 2021 01:48:09 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-drivers@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 20/30] scsi: be2iscsi: be_main: Provide missing function name in header
Date:   Fri, 12 Mar 2021 09:47:28 +0000
Message-Id: <20210312094738.2207817-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/be2iscsi/be_main.c:4934: warning: expecting prototype for Boot flag info for iscsi(). Prototype was for BEISCSI_SYSFS_ISCSI_BOOT_FLAGS() instead

Cc: Subbu Seetharaman <subbu.seetharaman@broadcom.com>
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-drivers@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/be2iscsi/be_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 90fcddb76f46f..ab32ca535078d 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -4927,6 +4927,7 @@ void beiscsi_start_boot_work(struct beiscsi_hba *phba, unsigned int s_handle)
 }
 
 /**
+ * beiscsi_show_boot_tgt_info()
  * Boot flag info for iscsi-utilities
  * Bit 0 Block valid flag
  * Bit 1 Firmware booting selected
-- 
2.27.0

