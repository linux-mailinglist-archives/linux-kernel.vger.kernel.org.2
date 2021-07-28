Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42603D9560
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhG1Shk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhG1Shj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:37:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75923C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:37:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso5449083pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/GUsHiEOi8pxx5BgkWQTDzqvSb76Y9K2dEa3vpQ2Ew=;
        b=bEB2XxcUOEeJcy8i/cl6wtbs8VTUqJWxy5q6ELQJfiH3MWg7tTFr3J8MAH4UCbj3iY
         96CcsaP75w6R3VmXObi/aZOddKA7ILsBAle+0VekhsgEQDrB1grYlhzmOH0vA0LmDiyy
         HuVH+lZhAg6z7ttsa+VaL1s6wj3cAnHidYeX2Wsw+X9Or2E3A5Zb9NIrkfC1+B8N9rY4
         KhL5j+aH/5iYC3+OKu0zRocNPdB00ZYp3X3jQtCYbh894F1mfhRydjdEQPgGZREk6dYx
         V+ZnGO8qmh6tHwzxr8XgI+izgSWjHQisosM/hCC4ucXAdjCyhVGVUV37xHb/1TXb4qy9
         bkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/GUsHiEOi8pxx5BgkWQTDzqvSb76Y9K2dEa3vpQ2Ew=;
        b=kDtCWuUVci3nN3MHfpNO2WtIL+XKUmJuMs/FDwAtJVWmi1njxAGpbbTiNtZq9RdH4Z
         9jlacmNI1QCJ+VNejSKRRSv37Yw4J52uzrHX5VrhsRpeEUAeALl0UDIbfPJn7HSK2qlb
         q+yygg7ndffQvYkvBhzDA7X4QbN4vZyai6UnNoK1IBq37RfDVwEb2e28qm9QQF0I/LuY
         0M7BrNr0yLjyDrFetUvWZlzBXNGJb8inNosqTBSvm3uaVyEJ/evtnkI8ZLyqbHISvqw9
         4lOVOT2MZgfIPaEVZqMLKQ83QHvRYvJjbOPW3K7ZVmaQg/ZcQ2XJ3M1OTn4ZNchxc4di
         1kRw==
X-Gm-Message-State: AOAM5310Q6HxktHh9NQGvCP5zFZN8wYRtyWB9KgFAlO/xzphkCT4+Ekm
        GTloQfRWZZlXXyB1DBf7g0w=
X-Google-Smtp-Source: ABdhPJygT5kY4Hvlg3aGDih8JDsDffrs3sZtH2XQFUbSav9nzRcJOojn5hMrR0Prd3c5qrIiH2JA7w==
X-Received: by 2002:a17:902:d217:b029:105:e265:65c7 with SMTP id t23-20020a170902d217b0290105e26565c7mr1051678ply.16.1627497457076;
        Wed, 28 Jul 2021 11:37:37 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.5])
        by smtp.googlemail.com with ESMTPSA id t71sm559021pgd.7.2021.07.28.11.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:37:36 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com
Cc:     dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: vchiq: Add details to $CONFIG_VCHIQ_CDEV help text
Date:   Thu, 29 Jul 2021 00:07:17 +0530
Message-Id: <9c9c128b41e31d6bebe646e052aa05c44b19eb83.1627495116.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627495116.git.ojaswin98@gmail.com>
References: <cover.1627495116.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some details to the Kconfig definition of $CONFIG_VCHIQ_CDEV to help
make the motive behind it a bit more clear.

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/vc04_services/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index 2b70c37cdd09..cb02d8a4cb74 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -25,8 +25,12 @@ config VCHIQ_CDEV
 	bool "VCHIQ Character Driver"
 	default y
 	help
-		Enable the creation of VCHIQ character driver to help
-		communicate with the Videocore platform.
+		Enable the creation of VCHIQ character driver to help communicate
+		with the VideoCore platform. The cdev exposes ioctls used by
+		userspace libraries and testing tools to interact with VideoCore.
+		This can be set to 'N' if the VideoCore communication is not needed
+		by userspace but only by other kernel modules (like bcm2835-audio).
+		If not sure, set this to 'Y'.
 
 endif
 
-- 
2.25.1

