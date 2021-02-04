Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F260E30AA23
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhBAOpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhBAOmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:42:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDF9C0611C2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:40:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m2so12854076wmm.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=em+gLbL0BxMKq+E5i1mocv9ySIOeHFQQcLtILPjRTbE=;
        b=bYvX8DN6puR8b7BNSHbtD3EGzAX8GmRCTU9rZXqtMjFG8LsRvf5JgcpaN5Eg0SuSzD
         v99HFxVFAj4ouotyGhhoykw4QRJfl/7p+A2qApaZbAHT1nHbG7qnrUZ9f4puKZ7LT1tw
         IlB1YbGoj3a2T781/UyZ8YUsJmq92yP5RpBbBSWALaZ0a3O43XpW8mnCdZacEkinmW+3
         voPWPhDAVw+bGAy/2SlDMcy9MUs1jlwLqRz/f9WZJJ+o+T4KCR8gWp0NpxbTDNVe3gMK
         HtFGJNFUl3rO9Db476SSvjfd2gPKGcAR0ylzGjZJL2AZwnJcQ1ytaC/Bof4zUO577TxC
         Qg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=em+gLbL0BxMKq+E5i1mocv9ySIOeHFQQcLtILPjRTbE=;
        b=meTFOWN3OGVxJ6nigurnEinmM+jf55GXNpDAmQS7SPsFe9jF8cq4PfnA6ooIQ8Lm8u
         QoFDVpHP0tzG3yNgsvqaJWuWqhoerwuCSW3Ak+4o7Boy1UdMWKXFwbar6ssu7+rjYgx2
         9AjWNY8TTS7dHPNrN8xRD2aU4tFRnUNvfZIsD8JqD/5b2HHx6kpnULrmRmk+6ORbe7h3
         zqkABVbegDelHUvMALZsWizC6Sz/QYamyJzdZVoOMwui3Q9SdjP2MZmHY4E8f2Ay66o/
         GZUIlPPcK/aP3PDPMppEFqZqDH1g3/oUOc67WyQ7RvbUsRiVaGGtV7Y7QShqdEKKiK3n
         g/Rw==
X-Gm-Message-State: AOAM530t2SvkxMqe++3ToAtmtrO5Nf25y9wwFlVvlwHzDKNWsyIqPWBZ
        TfEOTY+k52af3ZIlaSHVYxsOGQ==
X-Google-Smtp-Source: ABdhPJyc08NDT3zH5UVhJCpxD73EWT+WifUl/TRZitj6I91P0mVM4NzVQNWwyLo3J7Rjs8SPDueCtQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr15422813wmc.162.1612190403647;
        Mon, 01 Feb 2021 06:40:03 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:40:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 18/20] ata: pata_jmicron: Fix incorrectly documented function parameter
Date:   Mon,  1 Feb 2021 14:39:38 +0000
Message-Id: <20210201143940.2070919-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_jmicron.c:135: warning: Function parameter or member 'id' not described in 'jmicron_init_one'
 drivers/ata/pata_jmicron.c:135: warning: Excess function parameter 'ent' description in 'jmicron_init_one'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_jmicron.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index c3dedd3e71fb7..d1b3ce8958ddc 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -120,7 +120,7 @@ static struct ata_port_operations jmicron_ops = {
 /**
  *	jmicron_init_one - Register Jmicron ATA PCI device with kernel services
  *	@pdev: PCI device to register
- *	@ent: Entry in jmicron_pci_tbl matching with @pdev
+ *	@id: PCI device ID
  *
  *	Called from kernel PCI layer.
  *
-- 
2.25.1

