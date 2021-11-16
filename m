Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0C1453112
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhKPLpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbhKPLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:45:43 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D9C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:42:46 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r5so11411723pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+eBFct8iAxHFKfCYs+KQCIyGjKvclEDAeXkIXTGgTXk=;
        b=ENIPt9NPK4NqiDnEBIo/t6hbh+6RVn2zwPg9sLXI9teJqv/p0S18Yln61hWffTVfbl
         yfZ3DAjcNRPJW6xejyVfeiaXdOHKMpaebJ8GQC3tAT0hHAS/2igy3/EsTMGn2IO5Ve+A
         VoUNLyWIVoc+imSjnqXum9JDJmVhvWdycCZlV2epkbw+/0Wpj13RJeSgTfI0JrZMaH60
         RDiZlgrUGLNporArM+LxPrkUHpwLVhGz5H7BQ1nFzBuJ7gnFNJ2T8FJGILoV/o2bxkwj
         qQTXvArrupVzHuoXc562LD372fz1FRH6nA1VdAqUN/uI7QopWm+k8ZM0xaAylrxEg2/S
         daGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+eBFct8iAxHFKfCYs+KQCIyGjKvclEDAeXkIXTGgTXk=;
        b=VERyuY+12QGFAhPMFV+iw/cwRlO15vuAxedJGj+TekhoOfvWHEnzrKyY6dMh2KNYOi
         UM9d84osTTxJbUBSd70Vy0HBC58Dvnu4sMzAEuV3tQhg6YdDAqjyCsJLGqDnb4oztmPG
         tdAJwB+3aLIsDbAAQ7tHJYWWMuzQgf2KKH7SodWXtyI3bPantPIjpMgIUx7hgaGV2hTW
         36VHCmX2pG4Q4VbABc5hL6yEYIT8rwhGgsStLTsNWHgh6yQXF/Q7whqiLtTx1J9C5//K
         M+7Xsd1ZSgbvBlThygRUE0fDj9IYN952QL5m5JyF/Kr47gz5uJzQkhNR6KTrG87P2NBb
         dhiw==
X-Gm-Message-State: AOAM532d/+bYoCLF1vuxKA7ZMyr7a/vqeTYuX6Qikmo77Ct2oIvYT29T
        oI64KlYUTHKEyRiGNOR3ohI=
X-Google-Smtp-Source: ABdhPJwN2a80DDnNchf2wIREA84QPNhruGC7rI4jBOeL9G0P8v2MKFpPvTiol4zZq/6Iz9FALdELjA==
X-Received: by 2002:a63:1d65:: with SMTP id d37mr4279998pgm.353.1637062965832;
        Tue, 16 Nov 2021 03:42:45 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id fs21sm2148448pjb.1.2021.11.16.03.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:42:45 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fw_cfg: Fix memory leak in fw_cfg_register_file
Date:   Tue, 16 Nov 2021 11:42:33 +0000
Message-Id: <20211116114233.29462-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kobject_init_and_add() fails, entry should be freed just like
when sysfs_create_bin_file() fails.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/firmware/qemu_fw_cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 172c751a4f6c..0f404777f016 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -608,6 +608,7 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 				   fw_cfg_sel_ko, "%d", entry->select);
 	if (err) {
 		kobject_put(&entry->kobj);
+		kfree(entry);
 		return err;
 	}
 
-- 
2.17.1

