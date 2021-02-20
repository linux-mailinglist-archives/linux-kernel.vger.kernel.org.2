Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB693320549
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 13:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBTM0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 07:26:31 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:33083 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBTM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 07:26:27 -0500
Received: by mail-pg1-f175.google.com with SMTP id z68so7118011pgz.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kfSr9wGDBaeTdPfP9BpaWnIALsMQibOPcyKNdfyx780=;
        b=Hokzr7OPJYb4xec7J9shF7IhvZibEa5I4U+3pDyREaO5MGeke1ln0sprEiw08lzlHV
         ULO6wbjoDlNE0NPVWRb6XBmcESEz1XXFYi2ZhVMdWR2oKxW6BMN0wEi1p2nMZUJeRELj
         d5MVpZzoQRuiuaGLIM42LVckl19bVmVUXmKmMJaGYhxeSOGNDpiRZuvkqvmVCjmwffNZ
         rGvVDvOC6aqYjxGsEvtUBTQvI3GNyndbD/3njI0RL/ZYeWFLkC46P6K7jajIMCfz7ZvA
         yV7sb/f7/vUHYg6Lsd753+pVtSUjtILHXtxyL05lFsNdbwwMSLTaou5BZ4quZFMQuRX2
         pNbw==
X-Gm-Message-State: AOAM531foOR71bZYkQ9Dj6fvCe4SmAMv+AbSqdWiHu95JMhQ8qjyojVD
        jWmh8uxinD5gWov0HP+AOto=
X-Google-Smtp-Source: ABdhPJzZ64Xpr7tvcYyCFMBE1WGAtudkcdluTRxySrO7x3NXG/cHK803UCNrV9OedTZW4CS2uiETpg==
X-Received: by 2002:a63:1f1e:: with SMTP id f30mr12622514pgf.141.1613823946831;
        Sat, 20 Feb 2021 04:25:46 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.84])
        by smtp.gmail.com with ESMTPSA id z68sm409492pgb.41.2021.02.20.04.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 04:25:46 -0800 (PST)
Date:   Sat, 20 Feb 2021 17:55:42 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shivang upadhyay <oroz3x@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wimax/i2400m: fix byte-order issue
Message-ID: <YDD/xqjmlibz72XP@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix sparse byte-order warnings by converting host byte-order
types to le32 types

Signed-off-by: karthek <mail@karthek.com>
---
 drivers/staging/wimax/i2400m/op-rfkill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wimax/i2400m/op-rfkill.c b/drivers/staging/wimax/i2400m/op-rfkill.c
index a159808f0..0f438ae6a 100644
--- a/drivers/staging/wimax/i2400m/op-rfkill.c
+++ b/drivers/staging/wimax/i2400m/op-rfkill.c
@@ -86,7 +86,7 @@ int i2400m_op_rfkill_sw_toggle(struct wimax_dev *wimax_dev,
 	if (cmd == NULL)
 		goto error_alloc;
 	cmd->hdr.type = cpu_to_le16(I2400M_MT_CMD_RF_CONTROL);
-	cmd->hdr.length = sizeof(cmd->sw_rf);
+	cmd->hdr.length = cpu_to_le16(sizeof(cmd->sw_rf));
 	cmd->hdr.version = cpu_to_le16(I2400M_L3L4_VERSION);
 	cmd->sw_rf.hdr.type = cpu_to_le16(I2400M_TLV_RF_OPERATION);
 	cmd->sw_rf.hdr.length = cpu_to_le16(sizeof(cmd->sw_rf.status));
-- 
2.30.1

