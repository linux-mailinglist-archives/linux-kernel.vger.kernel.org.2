Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874FE338921
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhCLJtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhCLJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:12 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AC3C061763
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id y124-20020a1c32820000b029010c93864955so15387424wmy.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpkWY6NYMS6c87pB2jsJw8HPR329QzV5UrX12nsDj8M=;
        b=wEt1svJzo8LCt1CK0YkcHzEp9mzT31n/KRFxH8GBCa+ZkDK7mTCQ6/IrI1AB8LsfBs
         cBDOJv6enLMbaGkrhloVBpJfmQepNFtuK4DIZOeYBcEZjOxGTE1GoqZWc8b81v1JMqlL
         1gpYWvaDUHBgmukaxGR26rUqjUKjKDJY/ufk0okiy0jJx3QAC3HRLhWIT8MaHT4L9PcT
         HL5kPw3S2/QfxNBxvOZk84oU1rXt452htkZIEK3XjCpxJdRFyRY/u3IiNJDGN0ZDebMG
         QKEZXA7HlQoYrNNGjSu41o/VO0OT1l3+RTDOD7XPT7VuLDDYZ3cYH0hcVhStVjv0QjWD
         6b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpkWY6NYMS6c87pB2jsJw8HPR329QzV5UrX12nsDj8M=;
        b=Al40kGMNBfMeQq099tlJfmwhZYVkXAxYV2xtD4kevoOqiODwI4PQ6F8NA0MIzAn6lL
         4xI/N+eViwshoF8LcG5LwAksMEb3eMHI9fpFv45medo/68AKR2Q71owu0iqEget5MgFb
         qnQ3O9pHoaYzBr+z8tRxH6s+UqjWxkmU9UorfRsd4JN94h8tYYrSI9BLGeXVOUJ22tnU
         /zPo3EdmKuFifDjZZnTvSPF2RbmNhOfIdrUhCvNmLXCxSAwEOgSU1+4cUO9laW76q1Bh
         lwWpeEbx7zwle1TTfsxwwwhgf5TGmKWMTUvp/h6kKg9dzmGS14hU2zBzC4f8TvYOe2Px
         DptQ==
X-Gm-Message-State: AOAM5312KPKPy80FysyRZTFwxfzKoGWa6irO36kpH3KNrWKyc+4/z0iv
        KteeAcKmT3fR0Q2sKgzlnBmWxA==
X-Google-Smtp-Source: ABdhPJyEd5LCtkwHhO/7yHRdoASg3ahqLZgAspTKJEitIN2uoQg5nqmfAk/BAPZoNagBLl5bLZxTaw==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr12124569wmk.63.1615542490036;
        Fri, 12 Mar 2021 01:48:10 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-drivers@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 21/30] scsi: be2iscsi: be_mgmt: Fix beiscsi_phys_port()'s name in header
Date:   Fri, 12 Mar 2021 09:47:29 +0000
Message-Id: <20210312094738.2207817-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/be2iscsi/be_mgmt.c:1270: warning: expecting prototype for beiscsi_phys_port(). Prototype was for beiscsi_phys_port_disp() instead

Cc: Subbu Seetharaman <subbu.seetharaman@broadcom.com>
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-drivers@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/be2iscsi/be_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index 0d4928567265d..462717bbb5b7e 100644
--- a/drivers/scsi/be2iscsi/be_mgmt.c
+++ b/drivers/scsi/be2iscsi/be_mgmt.c
@@ -1256,7 +1256,7 @@ beiscsi_adap_family_disp(struct device *dev, struct device_attribute *attr,
 }
 
 /**
- * beiscsi_phys_port()- Display Physical Port Identifier
+ * beiscsi_phys_port_disp()- Display Physical Port Identifier
  * @dev: ptr to device not used.
  * @attr: device attribute, not used.
  * @buf: contains formatted text port identifier
-- 
2.27.0

