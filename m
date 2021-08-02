Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E203DDEB4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhHBRmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHBRmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:42:36 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C4DC0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 10:42:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so29948pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i80N/1f6I9wdo5J4KuddrAU0X8MTRP2GIMmztLtoIXU=;
        b=dGRKSl5y/DAV6pEvoYVK6BG58CjupMxOQQIPOWYGfyHlYASZDB/q3o/kekVW2nc9Qs
         9Q1geTJnsUiJcnSpdR6Kh5W4t2ooclWjzzmmJdL+Mlny6kcI/26xxP6ETd/MKXbFCrbz
         kCGIc6azYoMKmlqVPqepJ7LyLwJUMiQ4QdL21YGKs0C+baAdLk9yV6hHisS+UaVBJgTy
         jRhawnWQ4QPQCfr1odXFelfzdMU9r77iYlfE2GhNjPuQuYJPc86XKQG8ycoS/FCFrRcB
         SakrFlaWQvQ2jvwF/zgKQfabUEForM4wxSZZwblfyD6LDmHQLl+062TEDaHelSbO8/WY
         INBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i80N/1f6I9wdo5J4KuddrAU0X8MTRP2GIMmztLtoIXU=;
        b=iuIglot0+tksORs7bt2XTrPQpKwmOhd7kDWFvgxNcRhnOQV1BaxTmTvnQEvyqD+Xx8
         PL0l1kRfeMRH0iBea5YG812S5y6G3f4K6jrQ7r8Kl3WRgIi2F4LSn95bH47pQsFQpgfS
         EpvAuqCVhswVfuFOzMJ6d1Uw3obRMqhA/6DCWx3We8MgnQT6JB+F1+n8iOT7ECvT0MP3
         BC/oD8D6W6G6986D4qQL7IvhEq8VpFvwVtFO8IG5ncIzslm6UFWITq0biI/S3HMUaAPt
         hoAloA7gdJn0iCBA5hLo6JqjV/89nSBwS9M1LpPDFl8Uu4g7+8N7KQ4sn26C33xHJ77l
         kj2Q==
X-Gm-Message-State: AOAM53342fdd+n+oS8Jdsyz8Lp76YINeHOLiTDYz1Xr+SMu8BTgMgVi2
        xBRSk8xJ0SS24panS9GWP1o=
X-Google-Smtp-Source: ABdhPJyNmS/nD79RXC2wA494+zIcRoWi3FD/Y1aWTiFT7lJSDXNXoNm96xqRMGkGxWKjxyMTmMwwQQ==
X-Received: by 2002:a65:6a0d:: with SMTP id m13mr1664908pgu.356.1627926146900;
        Mon, 02 Aug 2021 10:42:26 -0700 (PDT)
Received: from localhost.localdomain ([122.161.50.148])
        by smtp.googlemail.com with ESMTPSA id t30sm14449236pgl.47.2021.08.02.10.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 10:42:26 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com
Cc:     dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: vchiq: Set $CONFIG_BCM2835_VCHIQ to imply $CONFIG_VCHIQ_CDEV
Date:   Mon,  2 Aug 2021 23:12:10 +0530
Message-Id: <da53207b24bc37f166b05c6835087becdc6b5b4d.1627925241.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627925241.git.ojaswin98@gmail.com>
References: <cover.1627925241.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before $CONFIG_VCHIQ_CDEV was defined, the vchiq cdev used to be created
unconditionally when CONFIG_BCM2835_VCHIQ=y. When an earlier commit
introduced the new config, its default behavior was set to disabled,
which might surprise some unsuspecting users.  Hence, modify
CONFIG_BCM2835_VCHIQ to imply CONFIG_VCHIQ_CDEV

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/vc04_services/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index 63caa6818d37..ad44b80f13ca 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -13,6 +13,7 @@ if BCM_VIDEOCORE
 
 config BCM2835_VCHIQ
 	tristate "BCM2835 VCHIQ"
+	imply VCHIQ_CDEV
 	help
 		Kernel to VideoCore communication interface for the
 		BCM2835 family of products.
-- 
2.25.1

