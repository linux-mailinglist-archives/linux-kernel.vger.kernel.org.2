Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537A2320B6C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBUPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:31:55 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:51207 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBUPbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:31:52 -0500
Received: by mail-pj1-f45.google.com with SMTP id gm18so1754854pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 07:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4mC5MODCK06jyeNOqSfzPWm9rkZjhjLLWSUaFuOWeQ=;
        b=rp3BpP8KP81s7pZzWCzMJiPOOmiunF3vaojcQhBQVlrTLVqsthDAiwZmkBEcYVJjf5
         FEgku8/evxL5aX1ysEuzXXgycRZcqCpWNS7rO6jE6MWpsWTL85sS0AmQJzu2ulicm6tF
         akCyOs0zSribwg6vF0BkfZwzWJxQCJxTP7Cso2OhamjecRJZewwMFt+20lJxXul2DXwe
         staQYbItdQqDYj4gDmsZQEZj15ZvyPUzzt1QjUFkzYlWOvW/1OocdRk9u162kDeUlNgW
         1b3NKoJA0OcEzrSOMGrkRJBT5ExCV2zY//58odtQAc8P88XkkHHRAuaGAs+r1pWP04/C
         28OA==
X-Gm-Message-State: AOAM533tQSFPLYsIDAxxGTPAkDoxluZInob2umD4dEuL58S32FfneXnN
        rvXtf/RzD8GhweP0O0PTXZs=
X-Google-Smtp-Source: ABdhPJxWm8B6PhdNK6eHSyEJYmv+ol5YYlcRFrGhdJvgf86fc8srcahaizaIN4OpNqiN/lY6Uuycug==
X-Received: by 2002:a17:902:bf03:b029:e3:ac31:9c6 with SMTP id bi3-20020a170902bf03b02900e3ac3109c6mr15725830plb.55.1613921470823;
        Sun, 21 Feb 2021 07:31:10 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.12])
        by smtp.gmail.com with ESMTPSA id c8sm5418812pjv.18.2021.02.21.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 07:31:10 -0800 (PST)
Date:   Sun, 21 Feb 2021 21:01:05 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: wimax/i2400m: fix byte-order issue
Message-ID: <0ae5c5c4c646506d8be871e7be5705542671a1d5.1613921277.git.mail@karthek.com>
References: <cover.1613921277.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613921277.git.mail@karthek.com>
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

