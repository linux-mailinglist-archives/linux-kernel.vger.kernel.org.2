Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548B933ECA0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhCQJNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhCQJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:12:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD961C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x13so1002585wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwQndVf+ajRvG7BvBjO6FK3EJF72tSCBcXH+xkZnA9A=;
        b=cAXpZfWbnwYLQJVEJPJuJoAGyyDL3+O2ZQp0SB0cXTfefaBs9II3OuXE5qb9u4u8A0
         drgxbimN1BySjwmM659Xhu+412YUtXOG5TYow2HC9+UKJttZw7bomixtpiO5svjxx14E
         7PzHl8RFlF1sHLB3rMiPLdpni4UoEGXwXeXBPdH/21QHhus1ulL9/VN4swFOA2+vo7O7
         hgpRqnuJWEjhOLve2tO8x6GGvBrmIoC6WcZ6zK7jYcFtGEZWZJrXzbQl4FmmjEjfxs6l
         waPhgQ38yYJ8KyF4IMEArZfPKRC+tb0kmDt+YhdBXkZcCOtI7kTsfjv9IFQrh9fORuZ5
         PhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwQndVf+ajRvG7BvBjO6FK3EJF72tSCBcXH+xkZnA9A=;
        b=JbIhDZT9Y+WEoR+TqX6vMqbBnCKMHI/ATZy9gYyBjFgnxtmR9uiDO1PRp2VpzVSBa+
         UmyVpPB0at/c8VyLhT4fYknxDyL/XZw0Nr9D5N9Zn9OtBi1b7qoy2wfhpnprtXqwqMwb
         zmRLC9sTM/gv1Qk8eLJHtEob9g8IVIrUMRLsC5zh9gYWb7nDDaJH9wt9eb/eWa2hiaK4
         z0sESL/fNn3sUMZERlrYZDM6IxfuwB8JucOct2TVyZe7LIwQYiGSj5KD8PYpf2vhmVIw
         tqAfcZPtItWLL8wyUY6DS2Wz983Ef26f5QxMTG/8byZilzY+zFJvFlIzbZYkF1/6iUcq
         9c2w==
X-Gm-Message-State: AOAM53112G2udndD4WodApiGRRo5Is7nY81ttm1Ug9rVtEoC6RtQuDhU
        2Y9LiCd5iZ1IV0qiM+vwLhnbYA==
X-Google-Smtp-Source: ABdhPJw0wNwtzWgZ2Lv4V+1/bBqKcq0BDja0ZIePOUdVVGVe+N152oGckEzVMK/3pw4K918+K+1yCA==
X-Received: by 2002:adf:fecc:: with SMTP id q12mr3245072wrs.317.1615972375699;
        Wed, 17 Mar 2021 02:12:55 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-drivers@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 15/36] scsi: be2iscsi: be_main: Demote incomplete/non-conformant kernel-doc header
Date:   Wed, 17 Mar 2021 09:12:09 +0000
Message-Id: <20210317091230.2912389-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/be2iscsi/be_main.c:4937: warning: Function parameter or member 'data' not described in 'beiscsi_show_boot_tgt_info'
 drivers/scsi/be2iscsi/be_main.c:4937: warning: Function parameter or member 'type' not described in 'beiscsi_show_boot_tgt_info'
 drivers/scsi/be2iscsi/be_main.c:4937: warning: Function parameter or member 'buf' not described in 'beiscsi_show_boot_tgt_info'

Cc: Subbu Seetharaman <subbu.seetharaman@broadcom.com>
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-drivers@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/be2iscsi/be_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index eac67878b2b1b..22cf7f4b8d8c8 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -4927,7 +4927,7 @@ void beiscsi_start_boot_work(struct beiscsi_hba *phba, unsigned int s_handle)
 }
 
 #define BEISCSI_SYSFS_ISCSI_BOOT_FLAGS	3
-/**
+/*
  * beiscsi_show_boot_tgt_info()
  * Boot flag info for iscsi-utilities
  * Bit 0 Block valid flag
-- 
2.27.0

