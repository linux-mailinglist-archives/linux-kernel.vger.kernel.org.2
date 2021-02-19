Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3831F35A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBSAbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:31:43 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:36268 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBSAbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:31:38 -0500
Received: by mail-pj1-f54.google.com with SMTP id gx20so3012461pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Fi3lkWmDbfwcEUbMyKdDvWBwmJ2EybxjUw9j5c75a9o=;
        b=onsQc2a0/FdbkTFIcXR4FCH/5UthbuHaVGdEysmWNoqa6mWQ4O3BfrVRRHaq/S+iIA
         4ZVh8304PvpRBIYNZ+MhD8Wt1uzEm3GVcExhFwp+/lAiT0UlpX+pjQ+eyOrDcfoQ4Wag
         X+QA6zK5x+jywqPyRAev1wMB5GKN2zTj1fcqga5TbLY6vDPvP/YmWAHSkEJNc+GB9pOa
         yqBby69rv7k7BEas/Nr6SSORUvNITRjix8+H+vafV4+vpa9fRK0vcHcHgz0qtnNxdwH1
         Hex3WK+yM0fhRz9fwk8AjB2G18PeKLJCLUOlC8TqS90gFvtjyupG3tQwt9APNRSccOoY
         6slw==
X-Gm-Message-State: AOAM5317L4cvug+lCdxoQBiPkBZmdROiRvPppiYG/o/kaMHb/LvlzHL8
        KcgGeOWvlc2EHkKdCyDxOuI=
X-Google-Smtp-Source: ABdhPJwfaO7wyk2x33cAYQilsTacbXLBVLzhAUmAcZS0JFW5RAsac8zjL2P5ggEQg9fMfYzh+Pn4nA==
X-Received: by 2002:a17:90a:1109:: with SMTP id d9mr6309805pja.94.1613694652586;
        Thu, 18 Feb 2021 16:30:52 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.17])
        by smtp.gmail.com with ESMTPSA id c26sm8485162pfj.183.2021.02.18.16.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 16:30:52 -0800 (PST)
Date:   Fri, 19 Feb 2021 06:00:47 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: i2400m: use explicit host byte-order types in
 comparison
Message-ID: <YC8Gt4sawUiuTTE3@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert le32 types to host byte-order types before
comparison

Signed-off-by: karthik alapati <mail@karthek.com>
---
i wonder how these could be false-positives
 drivers/staging/wimax/i2400m/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i2400m/fw.c
index edb5eba0898b..13207c985a87 100644
--- a/drivers/staging/wimax/i2400m/fw.c
+++ b/drivers/staging/wimax/i2400m/fw.c
@@ -191,7 +191,7 @@ void i2400m_bm_cmd_prepare(struct i2400m_bootrom_header *cmd)
 		int i;
 		u32 checksum = 0;
 		const u32 *checksum_ptr = (void *) cmd->payload;
-		for (i = 0; i < cmd->data_size / 4; i++)
+		for (i = 0; i < le32_to_cpu(cmd->data_size) / 4; i++)
 			checksum += cpu_to_le32(*checksum_ptr++);
 		checksum += cmd->command + cmd->target_addr + cmd->data_size;
 		cmd->block_checksum = cpu_to_le32(checksum);
@@ -506,7 +506,7 @@ ssize_t __i2400m_bm_ack_verify(struct i2400m *i2400m, int opcode,
 			opcode, i2400m_brh_get_response(ack));
 		goto error_ack_failed;
 	}
-	if (ack_size < ack->data_size + sizeof(*ack)) {
+	if (ack_size < le32_to_cpu(ack->data_size) + sizeof(*ack)) {
 		dev_err(dev, "boot-mode cmd %d: SW BUG "
 			"driver provided only %zu bytes for %zu bytes "
 			"of data\n", opcode, ack_size,
-- 
2.30.1

