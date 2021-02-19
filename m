Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275A231F34E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 01:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhBSAWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 19:22:48 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:36720 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBSAWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:22:46 -0500
Received: by mail-pj1-f52.google.com with SMTP id gx20so2986300pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 16:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Fi3lkWmDbfwcEUbMyKdDvWBwmJ2EybxjUw9j5c75a9o=;
        b=ROfLYDKWKJWYDIQfa8C5KDt+tG69Kyg2wktcT6nNby3NXNyddcVpZslydpL3aRMrVn
         l5/h4HCDpTrYoe4eFxVo/NC26miqBmJyEENx/zUDBto2GT8hqlmDc0ElbhZR38rF/VCI
         ViJQErkY9XJ8tW4+toBjxAAPB1vUdKoCvhc61DTSGoZGE2+yj0n7TPXlbzjTXvUpgvVl
         OB+aGWV527yhBo/f0bagEpqzHRXz7FANITbdksxGe8FfT0vxOTpABxGig20UOfVkCdZa
         U9b1GcDSXHC+aG/pnEw5TW1kScn057ngf+obtoB6k495dE4oinoBEvk0Z8vy2KpYsNE2
         GIsg==
X-Gm-Message-State: AOAM533Ih3EBlJzBrKpraUvLB8855BJFBqRWBcXy+/JsFN8HZqoIWBYa
        VwmcZEUiHbY+Uh9D71HT+0E=
X-Google-Smtp-Source: ABdhPJzXj0ujLA8CBLnyVfKWNJix0HkkUPqXGCuTNHkObdRGdYHeows4ZIX7h1jjdA0bH6//g446Ww==
X-Received: by 2002:a17:903:141:b029:e3:9ade:bbe5 with SMTP id r1-20020a1709030141b02900e39adebbe5mr6594391plc.6.1613694125431;
        Thu, 18 Feb 2021 16:22:05 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.17])
        by smtp.gmail.com with ESMTPSA id 11sm6944525pgz.22.2021.02.18.16.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 16:22:04 -0800 (PST)
Date:   Fri, 19 Feb 2021 05:51:59 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] use explicit host byte-order types in comparison
Message-ID: <YC8EpxR+ZVYQlshH@karthik-strix-linux.karthek.com>
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

