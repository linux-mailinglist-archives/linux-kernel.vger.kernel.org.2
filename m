Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59903D955F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhG1Shg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhG1Shf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:37:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA01C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:37:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q2so3744414plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HKHgCMwSYNJz7C9WSRJXjjx/3uDyYNDVr+Uqu/p/O0=;
        b=K+H4NOT7UUHHWFYAg9yiWvijMB3jBRhq9RKDe4Sw0tUVoBlNSi31/H8Vx5dXnoGdtD
         qTfvdqJSIdoTA+uIpWBTyChw86bjNLBD8CY8bTwBdCBVVnmkpvtwic4uxWxvvNmokmG4
         R+3J1v2qdBo9Wih4Cp4IAEU1TWGWIiaVdwLuyGrKZVWXr/DI+qdhRdeTIpfkXeOpcKPj
         b8SUUdghvlOlQPfzOgtvoCXNdMaz228nPiS/W8GAQJVC7KIz7SNw7Fvo+IvZWSfrghiZ
         s6JPVgpHlOREY5njZkFHuaURhMfo/SUJdgsLQON692tb14wxm3YvntBHFJIF9JvGphJh
         y5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HKHgCMwSYNJz7C9WSRJXjjx/3uDyYNDVr+Uqu/p/O0=;
        b=QjWxhzhrY0ZWcWRwQ+aFgyBKn/kfp8aeVGybZ3pb+YykRgJGveJ7ipm5GB+jKTvHTX
         zIvPFwkHrW0jNEn8l9EDM0rddpc5iWfWxr+MV+G7Q8WtAQCZ8SC6VCyS0JOd2AyexzZI
         Z+uMYa97Z2MCeW1BYttQPIS2PI7WLSRrHdSuT45jePMtuZnrU0UZr+l2xkoW7sfl6FdM
         mAOvDuLP+6ncCa8difsneCdivy+UhtpoETVNv3t89vhxVZ6NYYB76Fy2CGHLDZNhO5Xu
         HzLMaMA4Gyj37O1nU9CHiJtbVBbyBoHAusP3233+9K4ub9FqnZmXXhuuXPV4BHbgPwWi
         cauA==
X-Gm-Message-State: AOAM532G+lezEMkVf7mr6poHHNMYoB/XfiVb+/G/7H6Wn0NOvcppaurC
        M7zVkhKoBoadjNgOIuJJtu0=
X-Google-Smtp-Source: ABdhPJxO/VUIURLhsLeGRJkKZNHkyUMtKDGzQDbiP1kpXCHURdEVsbtOYulN+6SiojOs3ii1soumqA==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr10667054pjg.202.1627497453542;
        Wed, 28 Jul 2021 11:37:33 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.5])
        by smtp.googlemail.com with ESMTPSA id t71sm559021pgd.7.2021.07.28.11.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:37:33 -0700 (PDT)
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com
Cc:     dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: vchiq: Set $CONFIG_VCHIQ_CDEV to be enabled by default
Date:   Thu, 29 Jul 2021 00:07:16 +0530
Message-Id: <70d91b0482e19d7551d3258ea54c970c1b996317.1627495116.git.ojaswin98@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627495116.git.ojaswin98@gmail.com>
References: <cover.1627495116.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this config was defined, the cdev used to be created
unconditionally. When an earlier commit introduced this config, the
default behavior was set to disabled, which might surprise some
unsuspecting users.  Hence, make this config default to 'Y' to be more
backward consistent.

Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
---
 drivers/staging/vc04_services/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index 63caa6818d37..2b70c37cdd09 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -23,6 +23,7 @@ if BCM2835_VCHIQ
 
 config VCHIQ_CDEV
 	bool "VCHIQ Character Driver"
+	default y
 	help
 		Enable the creation of VCHIQ character driver to help
 		communicate with the Videocore platform.
-- 
2.25.1

