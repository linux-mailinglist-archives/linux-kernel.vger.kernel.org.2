Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D70307D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhA1SP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhA1SHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:07:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06915C061A27
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c4so3633030wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAIDQ52yty18Fyb/YeAsOfkiyO3vjgo1F5NJ+/twun8=;
        b=imMgoFtlkjloJ+OspitfwQCei1PhD4tUkQ8n4W661tybxoH12p9ephNZH/jRUaqGRl
         5G77kRHPX4TI9pHwjL2AK3CWnD9htKFzwuEftp/q1nAjFIrQDdAoo1D9J69T+s806X6+
         rOI44p2L0yKdO5cgFX9JW0YorcXDy56kJBh6vwDmW1KBzWIIxqYAeGwSLNmvjW9FFfOH
         3o2LBirukSDHYozGAycnTpuREqSe50YP3RZNsxMH1kKywBJf2Kq3FlKRZRIg3a41+aY2
         jO75FNUh9Jf1ztHPdyxcQBXXeEQZSxOAdu68p0LUMQEf9Qvn8RXUEff3lY/ngv4F1pcQ
         YluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAIDQ52yty18Fyb/YeAsOfkiyO3vjgo1F5NJ+/twun8=;
        b=Piy/2H52Xbzb88H1AzmrBiYUoo9u3Y0ui4l6KylQFf/IlVOZ58gNqdBfq5eEHzfS4K
         EV9KeCTyu5YB7fktgn5XCQNrHpL3DZgfqQkfJU3u+8xOFWUBWDXmVZsRZw2a/lNdadRN
         6hWOetltCmM9a0IosDnN3G9dTTq+JGEg3p+21DxyHrS5KBGxkK+0YPaL7U97kalDU7Df
         YQY+U3RgAEfyFabLVtdz4gHTcM0umgfucGJTQDPULOGDAk7xAMZI+zZk84jw/v0HSc+9
         NPIYy94bJ2D8mIs51ppA2tHpNkgPCYEa/HwQVR+Bkn0hjVH+a+Te+vU1Lq9+cYCBc2VZ
         Zgig==
X-Gm-Message-State: AOAM531HiSA7LcNr1dneINC2NJ7WdBfeiOt7E1jWuseA1wZcoz0KEQ98
        OgZLZqQ1MCYA05ug5SIdnKlgkg==
X-Google-Smtp-Source: ABdhPJyVgNtveW+MCIr6+u0POnj/CePkkyGFEb/lmovqSafnYMRpj3kHzr30TDzgukgfeEjN28RSGg==
X-Received: by 2002:a5d:524a:: with SMTP id k10mr307969wrc.394.1611856985730;
        Thu, 28 Jan 2021 10:03:05 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:03:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        CJ <cjtsai@ali.com.tw>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@redhat.com>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        linux-ide@vger.kernel.org, and cc <htejun@gmail.com>
Subject: [PATCH 19/20] ata: pata_ali: Supply description for 'ali_20_filter()'s 'mask' param
Date:   Thu, 28 Jan 2021 18:02:38 +0000
Message-Id: <20210128180239.548512-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/pata_ali.c:119: warning: Function parameter or member 'mask' not described in 'ali_20_filter'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: CJ <cjtsai@ali.com.tw>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@redhat.com>
Cc: Clear Zhang <Clear.Zhang@ali.com.tw>
Cc: linux-ide@vger.kernel.org
Cc: and cc <htejun@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/pata_ali.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index e18aa02f89530..557ecf4661022 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -109,7 +109,7 @@ static int ali_c2_cable_detect(struct ata_port *ap)
 /**
  *	ali_20_filter		-	filter for earlier ALI DMA
  *	@adev: ATA device
- *	@adev: attached device
+ *	@mask: received mask to manipulate and pass back
  *
  *	Ensure that we do not do DMA on CD devices. We may be able to
  *	fix that later on. Also ensure we do not do UDMA on WDC drives
-- 
2.25.1

