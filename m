Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDF530AB7B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhBAPdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhBAOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1660CC0612F2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y187so13406780wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAIDQ52yty18Fyb/YeAsOfkiyO3vjgo1F5NJ+/twun8=;
        b=qbYFQrEymhU8IyMyd/W+xyHgEQS2ALYVHHu3Tmj3qxjxObq+xE7GMPhYo/3nV3cd0M
         ixDzbn2zT0p+kMc8QZsuiA0ERK352J/+GcNUjkSyKyEEhsSzFiVO5FlhQoUY7nSRzaFh
         XmVLFlfxHvX74H3Y1amefFPvgpi9eTCHXUVB2ryU4PWC2IlV1Qk6+CF2SuWAu8RaqTYK
         eiD0LcqRMTvjUjtgQITUtKJ1+j/eDT3ul7E5b1FhQSSKuQzZyHKPm0CAAYiEboMo2EQE
         rDw6lpdnu8UPktc1UKCLMzIMun+bgsZenUqIyLyDN18GnXvO6vOjHV5e6la/pwmrTPQt
         0y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAIDQ52yty18Fyb/YeAsOfkiyO3vjgo1F5NJ+/twun8=;
        b=ROlCtrHSTPIxgMdPTAw9acx0xK4bC3+QI/JapvTQnwlWh9VE4ZBIhhv0v+Zdgve3dh
         K3KKO1eihq968N8KiHfj/ph1dNMALFhtBxmNV01ld0RAOEWXzGPK0CQtoClCA9wiWOPV
         7YQp/tz0Z4QLsbls6AjKd8AWpjj6qDyd5PzyjWDokPkwWHnMkCjq3vV/66n2jkZ9cLRK
         kUrIdyZ6f9vmhEEqcdkpjpwbuw1i8ppg5uQLj0urGapevn+v5XkOJspO1rmjkEv/MgyR
         X3Gnj0tfJOToJ0itt2l8Fb8h9v2ci9usZghTCKkniaDmOPpqZ2H93MBTtq5Yjib+c2mI
         1A1g==
X-Gm-Message-State: AOAM532DDxV+gjUL8KZCnibWWPtuDUe87LgrfPZQw0Iw2NmEmK7XY1nG
        ruZf/SV2gI1nxa6j1/h7w5G0BA==
X-Google-Smtp-Source: ABdhPJyigSkulBFJW/jNpdf7+2zKlUAzb6spDNuflsbOwKmOfK+waKamOJQYIESQRrdt2LY7eekrUA==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr15072829wmh.38.1612190395853;
        Mon, 01 Feb 2021 06:39:55 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        CJ <cjtsai@ali.com.tw>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@redhat.com>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        linux-ide@vger.kernel.org, and cc <htejun@gmail.com>
Subject: [PATCH 11/20] ata: pata_ali: Supply description for 'ali_20_filter()'s 'mask' param
Date:   Mon,  1 Feb 2021 14:39:31 +0000
Message-Id: <20210201143940.2070919-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
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

