Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F439338924
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhCLJtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhCLJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:10 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909FAC061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g8so3402988wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0xQIWF0LqpD3ejHYQPou8t3hq+GeNU8H9TybOS2LNw=;
        b=q2zFcK2T+TxsaTWb70uP9QaYJfcqs56lOphfBvEwLp5T+od0++x7jWfkS3N6zDqP1L
         qfrcuCzphl+61KYfIle1u5Jda0b8igwFwYOcT43OmZkc2osvqakwuqrh8ZgbURqQ9Dss
         jgbURjjvTli938VDvDY4rMASxyCo0HWwo9zA594QXXmhWoBLIyTmftN/B6MyNwV5OH1N
         Du+tn/W6mRebDhhFDV7pFhYls1ZJy4BCI+CVK73ajDwr1hAFh4sWlAvAfqVW9qUqO7Nj
         Z/4iGzWUVGsPv4AYDL4UDDq/gXq2fszpi9CmXMEofBKQVQatVdfrDoK5c88Oym6aosbX
         B1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0xQIWF0LqpD3ejHYQPou8t3hq+GeNU8H9TybOS2LNw=;
        b=ZF+KH7C3kAMHels+P1DCT9LaEuLu+AjI8zjEQQtygld5F/WFe0cu83WmjbTvV8CD9w
         F1Jdq/19dRf8VgWX+pich/gh0J7mahqUw2oYE8ouq1Jpz4l6N9Lr56uJnxbI3/U34umz
         6ookJwV073E2rOquvGuNnw7tuyPpnA9TjUZwsrru4zXT8nikS/6sXRdVwqwpyvgvOD2B
         sRQNYQrrDNz15YFhMQRT0Odv6C1aRlTmMK9OJIs15qZ/edz67PSNHjnTcSz1s/QgXg/q
         ibMEOW+EzPx6eqykj9Uljvu2bH09jeok46brv9lNSqdWExp1fi00/SyJBzVLuUTL/iIp
         n8ig==
X-Gm-Message-State: AOAM5303gNcA3jX/E9kHJwdM3ahjGUvnul38T94yD7oZ2ZK+e+/5jn9X
        s89uN0wriA7DwuAABM4pDdyhgQ==
X-Google-Smtp-Source: ABdhPJyAIadfdHvWxeWQbQwmY00KbvO0nwtdrsrc6gYF6g1mmfhjr/y+Yh6/XWzTSO/vdh+vzZH7hw==
X-Received: by 2002:a05:600c:4150:: with SMTP id h16mr12249165wmm.120.1615542488358;
        Fri, 12 Mar 2021 01:48:08 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-drivers@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 19/30] scsi: be2iscsi: be_iscsi: Fix incorrect naming of beiscsi_iface_config_vlan()
Date:   Fri, 12 Mar 2021 09:47:27 +0000
Message-Id: <20210312094738.2207817-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/be2iscsi/be_iscsi.c:312: warning: expecting prototype for beiscsi_set_vlan_tag(). Prototype was for beiscsi_iface_config_vlan() instead

Cc: Subbu Seetharaman <subbu.seetharaman@broadcom.com>
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>
Cc: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-drivers@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/be2iscsi/be_iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index a13c203ef7a9a..0e935c49b57bd 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -295,7 +295,7 @@ void beiscsi_iface_destroy_default(struct beiscsi_hba *phba)
 }
 
 /**
- * beiscsi_set_vlan_tag()- Set the VLAN TAG
+ * beiscsi_iface_config_vlan()- Set the VLAN TAG
  * @shost: Scsi Host for the driver instance
  * @iface_param: Interface paramters
  *
-- 
2.27.0

