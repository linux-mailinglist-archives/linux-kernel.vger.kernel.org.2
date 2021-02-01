Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BCE30AA09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhBAOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhBAOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:41:08 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C66C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:39:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j18so12853603wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bM4mPrdGCmHIaP6sSEhqZR0ycPeA2MFnqRQ1Q2Z5NPg=;
        b=mapxxoizbqOdhL11CoWUraeZYOx5+PqR/p8mC5NxGcTDTQIuJkhsHdh1bXNCU9ADcZ
         j6YoODnzj2h3IFBHK/69d2IHLnPUZ2sF8zeVuWpjPwk8Y7LG0n7Km76U7zGNajBCrv1T
         m+SOn6WpVqUEDSpxdczlSX4Z6PThPVcue3a408x+5HNODq+4GBIt777xGiPS4YE0Z8QH
         +LrupyqH78BeEk1f1u2M9E8Wmt5u/us7gG6VawZa3ef/wYULl/Gwf/Q2I7HacgqCXnkm
         Oa+0Win/kSyStHptPyUH49e8bYY/4/LfJ9z5Nct7qfvSY42tZznM6I1xpb+YA1gggypV
         lA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bM4mPrdGCmHIaP6sSEhqZR0ycPeA2MFnqRQ1Q2Z5NPg=;
        b=Wq8LaoWecBiqkYOFSdbH0x3vtf+kV2VpBmPjZmbpW2kThcyu45OophSRBzk0oLuPkq
         DiqlWo8RgaShozWDfvuBlR+UnhnlHIs3c2mOUjF7+bJLNcPXT3aVlh4NLfVTYP2Utbof
         8yGCl05XO5xFCCxD9n4MEda5bgBhZkhDxejs3Tg4u9TG1/xmK8+13/Cj+dtGHmGuQ0Rm
         CyFWSkbBctH2BvboCkj6ek+Tu6KJt4VRabCn2u1yJhx2VOgZ9q9nZv5PhF/nzqFWhPDD
         oeVOCY+0WS+IpGUDTdhPNyxBJTEUwhWcdU8IadKc5adWpT5vtjdOEZuRI0p00WKIpFRa
         7hcA==
X-Gm-Message-State: AOAM5328iqyi6RlqfiGIAUlFJdv2+LVXuAjpaIcXJ/9sgIh6mFHNE7PK
        c1OiVhNfU28kOxmuDCTcKRmcOA==
X-Google-Smtp-Source: ABdhPJwSS3qcNCTIijeUJvFc07Hg1M5sq5oqgoWJwehXRFxKDf9xzf9DLuwxxWGKtYcpCq9CaQIcAg==
X-Received: by 2002:a05:600c:4fce:: with SMTP id o14mr10071229wmq.140.1612190387319;
        Mon, 01 Feb 2021 06:39:47 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id h15sm27301359wrt.10.2021.02.01.06.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:39:46 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <teheo@suse.de>, linux-ide@vger.kernel.org
Subject: [PATCH 03/20] ata: libata-pmp: Fix misspelling of 'val'
Date:   Mon,  1 Feb 2021 14:39:23 +0000
Message-Id: <20210201143940.2070919-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ata/libata-pmp.c:76: warning: Function parameter or member 'val' not described in 'sata_pmp_write'
 drivers/ata/libata-pmp.c:76: warning: Excess function parameter 'r_val' description in 'sata_pmp_write'

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <teheo@suse.de>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/libata-pmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 79f2aeeb482ab..ba7be3f386171 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -62,7 +62,7 @@ static unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
  *	sata_pmp_write - write PMP register
  *	@link: link to write PMP register for
  *	@reg: register to write
- *	@r_val: value to write
+ *	@val: value to write
  *
  *	Write PMP register.
  *
-- 
2.25.1

