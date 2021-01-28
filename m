Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19F307D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhA1SE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhA1SDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:03:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B427C0617AA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u14so5031675wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gat9ASy8Tcpn7xEHDYjYiqg8W2NDPEgsm5bh/q38djM=;
        b=b5xBeNFkkABV7SRryiujgGned41DWkKsqVPxa7b6HABsi9v4EUrkgIVNmNINQsl+t8
         3K1wC/j55Mcw3dh9HxtKtr9wr1Edho9KPRcRaBMuzsIWNMRHvnG9VC7UQ/EZo5EDaDHZ
         dzulJbBlu406tRkTlB+XK4O2lltBNCzfT5xxhYqDq45Ha80kBl/gT+k4FrKUFOyjqjE+
         vQJaGZqh1H9HuEB9Pt4yzLirEcsoed8yM9OPZmCI4FvezHyZewWmK5V/u8rL+osYuyZU
         /cZ2ZNh5YbHjjwuCse9zdVYkXE5zJBR7EVP/pvsMG3EsaNyri+Eu3IzsNwbJtgFbDjre
         KmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gat9ASy8Tcpn7xEHDYjYiqg8W2NDPEgsm5bh/q38djM=;
        b=LWlmnsZV0jx2j59uOgxc2J7BFEXwFqx24O6eGSreaogOOj/zHbv0ta6D72zdNHpuVc
         ueAKOCKZJGzl7bW7kM28d/r5n91O1bY0vy0dilMkl/eJH92GrPaDWgVjQATasUSkSgkY
         hgBXcDilSZA7VGUR+t8vew+eyQf6kFHewvix3hKaDg0s9mbDI/cp1OaBLscgBi+6UBpQ
         2zkWRc70d78CaEma+97HW/8eUBc1AweglsovoxVNa0yqK7cZCLe3QVeyXW2rF46YtVEi
         N+E6GV5QMD/KScO6snswtUULImVq7YhSu2wJ29GDU+2o2mljnZRdGPbKjYrzdG6zP2js
         qx+w==
X-Gm-Message-State: AOAM5302v7ez8xZ1KWZyhe3VlwR8Ai89bBrGQPc8nkKcUT5jaGOsS418
        Gi8gsXkXq0gLoaI1XSWSlHOw7jFzHIQglZf0
X-Google-Smtp-Source: ABdhPJwX8a9ezXdt3Bhrl3TVpigZPvvrLgEpT+OvBZe6ZFqkp3d9fNtfAqGIZNRobORWb2k6E6sy/w==
X-Received: by 2002:a1c:a549:: with SMTP id o70mr411325wme.71.1611856968288;
        Thu, 28 Jan 2021 10:02:48 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org
Subject: [PATCH 04/20] ata: libata-sata: Fix function names in header comments
Date:   Thu, 28 Jan 2021 18:02:23 +0000
Message-Id: <20210128180239.548512-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/libata-sata.c:1085: warning: expecting prototype for port_alloc(). Prototype was for ata_sas_port_alloc() instead
 drivers/ata/libata-sata.c:1140: warning: expecting prototype for ata_port_stop(). Prototype was for ata_sas_port_stop() instead

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/libata-sata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index c16423e445255..8adeab76dd382 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1067,7 +1067,7 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
 
 /**
- *	port_alloc - Allocate port for a SAS attached SATA device
+ *	ata_sas_port_alloc - Allocate port for a SAS attached SATA device
  *	@host: ATA host container for all SAS ports
  *	@port_info: Information from low-level host driver
  *	@shost: SCSI host that the scsi device is attached to
@@ -1127,7 +1127,7 @@ int ata_sas_port_start(struct ata_port *ap)
 EXPORT_SYMBOL_GPL(ata_sas_port_start);
 
 /**
- *	ata_port_stop - Undo ata_sas_port_start()
+ *	ata_sas_port_stop - Undo ata_sas_port_start()
  *	@ap: Port to shut down
  *
  *	May be used as the port_stop() entry in ata_port_operations.
-- 
2.25.1

