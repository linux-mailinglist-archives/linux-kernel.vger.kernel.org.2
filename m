Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D9B320550
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 13:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhBTM1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 07:27:40 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:33553 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhBTM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 07:27:34 -0500
Received: by mail-pj1-f45.google.com with SMTP id lw17so5117573pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H9Ru2ZbdAQdDUxPfVhs1CR+d0Ly3rgFfBwARSfwqmPA=;
        b=UY5NzAURfCWnuPYUFPxVBr93gGmxfhEPXPP43D8SOo+MGJOHzEajqFwmJ2TaGSZuqc
         G77AXYOVPDQPaDTz3yZnK8FBwUiK427tAH+JcLLtCgRapGHqdHLf/JY6QSjzwfapNBxm
         47rDmOTWippSkOt9W7koPL+TWcfEJ266VVDpJO56brFdJH/wFO5uNzAhP1UPtwrBihRW
         okkpcoYDzZyI5qtrSNyZdIcETHChn4szBwIyJBhX+2pWFPZJkPQWwiX5emmke7Q9I1m/
         nSXxEW3IvyuYE6TMjmO5JoMTUTzDQb1E2BkyLJ/5UHZhyiFAbluOW0YiWDWpHpVhHgNS
         ClZg==
X-Gm-Message-State: AOAM5303SSVJeMaKQJ1fOpZGqrg79QBwcnYiQsNe5hBRHiLrR1hyrRab
        gOhKEU8RTnM4MSM27XSvi5k=
X-Google-Smtp-Source: ABdhPJxGPL7qGyT4nK1k/eBERoAK5bAEIU4O4G67GioCeHqTih2Vi81fKawX7e/GFJxt7uobDSeONA==
X-Received: by 2002:a17:902:b68f:b029:e3:b18:7a48 with SMTP id c15-20020a170902b68fb02900e30b187a48mr13549715pls.65.1613824014031;
        Sat, 20 Feb 2021 04:26:54 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.84])
        by smtp.gmail.com with ESMTPSA id x24sm11624615pjk.7.2021.02.20.04.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 04:26:53 -0800 (PST)
Date:   Sat, 20 Feb 2021 17:56:47 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shivang upadhyay <oroz3x@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wimax/i2400m: fix byte-order issue
Message-ID: <YDEAB/QatfBX9vQN@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix sparse byte-order warnings by converting host byte-order
types to le32 types

Signed-off-by: karthik alapati <mail@karthek.com>
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

