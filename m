Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0030AA02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBAOku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhBAOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:40:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75887C0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 6so16823868wri.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gat9ASy8Tcpn7xEHDYjYiqg8W2NDPEgsm5bh/q38djM=;
        b=fH2blJ/9WloA7c89067CkGeyLeJbGeZw97hzfm2jXLSDKqrGNCmhB0L6CaC6Zc6ufn
         kT9E8zZ2amBOvGyKjiU7u6EtNTshpZDBlKJZ9uiaqv561tbIbxQ+VLATlcCWlbW2IVfY
         JMm5X0w4Rs2ddWn+z17hxVYRLfJWpafg08jgGQwrPATJw1kl0hky35KbS9ZPBdg5EhyF
         Ye7J7RO7U8gfgqG7JFMjLgSvurKEtqr45gZcCreyIlJnnPL9N7FpwjO2jrhgL4YvQW2M
         Czqy/DUiI9GXpNu5zHk/OImSrwrqCGCU6e9gksGS/GERyHaCx8MUFfEvjyz4wCSv9h4e
         nTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gat9ASy8Tcpn7xEHDYjYiqg8W2NDPEgsm5bh/q38djM=;
        b=BVsQ8ontE1AYW3F1Z3H28bJbQGgudvXZwW7Jeg0lTOEeL7lVyJikFsn/ulWzMCF/cE
         xQW4I5nSyrUPlaIxZtd5C3xhpD3GfYcKVMn0DJ3g401ha/0G1U0DSY+uzL8Qvd8kd7ac
         P+LMwtEHYy6YBB8aREihYLrklgmWdR5JdLM+OIaSH7KGxBzEvMams7mUk1idWr1GQTMm
         Pc6ZX912j8BfDLRzQpoEKS4d+BDzo+XnMa884ZZ1gnFtnXWg8Amvhu1O4CFIGayObEeB
         zwhKonHYhJA0uCE9NC7gW2ZFinSeAIPJ51ZoBPSJ5e/JEo9TCUZFtnof/TLZcEptoQLw
         RmGA==
X-Gm-Message-State: AOAM533TmXox2Y2B4sz7nqlknK9pD4z4NbZECOI3xss4/v3jBpbnnJbT
        e+67hGCBjHd4/AIWLXyUS6aI7w==
X-Google-Smtp-Source: ABdhPJw+uU75gzUzR2FPFtHoivrzYTgwqNZQDYPKKKrkJsc+UJDKK4YBDEFjSE8aXRzHRkuVgLBA7A==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr18974135wrq.389.1612190386171;
        Mon, 01 Feb 2021 06:39:46 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org
Subject: [PATCH 02/20] ata: libata-sata: Fix function names in header comments
Date:   Mon,  1 Feb 2021 14:39:22 +0000
Message-Id: <20210201143940.2070919-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
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

