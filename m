Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E4320AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 15:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBUOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 09:05:16 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37682 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhBUOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 09:05:01 -0500
Received: by mail-pl1-f172.google.com with SMTP id p5so1117679plo.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 06:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4mC5MODCK06jyeNOqSfzPWm9rkZjhjLLWSUaFuOWeQ=;
        b=Q7/eURoZifJMqRI6qQ+fQ5dgh0wjE8YueT8JoeF99AlrQcqE5d2ujY9cjC+x6T9/W0
         vhhOTpPHX5ki43YEvJY+pQhReJB6+ogwCQfLPGp9uwmS2JjKvnehf+PsS+bSDpEfMMD1
         NLe4tHslU6vkdyXVVNItZlxBvPTp6lYfnMdnsVpRAKGC9ZUTHUaozH+iDej+wI6ZziIo
         5yM3/BIzI4JLxvxrXOUKZ8DUXE7P0nadiHdQrg9pVJ2l2wJjelqYk5N2Gqql8+b3+2Ra
         jNWlUwsvaJ81s4nmU5VHWT3ssk+C4PmTnUQhJrISfyN0ngZCwCvKcUbnMfBiojO/OaMI
         g4BQ==
X-Gm-Message-State: AOAM532QsVOjxBdP49HRhdfDhy31UG5tHAn2c3vaYJUm4ruI9rjYV5Nn
        3Xvc50+aNSTEAFi0gtjtuZc=
X-Google-Smtp-Source: ABdhPJxe8j4ShuC/BDyNc7tnbifTWbXEkS+8meATRydYNQBC75uMQoB0LKzc3om4fjnA7LjH31PYVQ==
X-Received: by 2002:a17:90a:9918:: with SMTP id b24mr19001146pjp.127.1613916260664;
        Sun, 21 Feb 2021 06:04:20 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.12])
        by smtp.gmail.com with ESMTPSA id d12sm14376906pgm.83.2021.02.21.06.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 06:04:20 -0800 (PST)
Date:   Sun, 21 Feb 2021 19:34:16 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: wimax/i2400m: fix byte-order issue
Message-ID: <0ae5c5c4c646506d8be871e7be5705542671a1d5.1613915981.git.mail@karthek.com>
References: <cover.1613915981.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613915981.git.mail@karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix sparse byte-order warnings by converting host byte-order
type to __le16 byte-order types before assigning to hdr.length

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

