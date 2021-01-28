Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF26A307D65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhA1SGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhA1SDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:03:53 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1DC061351
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m2so5041392wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bM4mPrdGCmHIaP6sSEhqZR0ycPeA2MFnqRQ1Q2Z5NPg=;
        b=QMd8ysJWDHZdQ5sbfXQG3sQzlvqAiSI5lr91/8U20X+H+I3kdNCkCJXHnQkgTYJu4l
         2w2rQvHn6a4fdnfbV8+Sq1xUAQLlDGIKpCtw5Kj4LGJtUsqufzAhSG3iHsJfGDGD0ENO
         FUYJ9UDZJOfwZ9CLljbkHF40uLscAogqmxILS11Y25FuP+g1mVCAq9n7zCg18V0HAOJZ
         8/qc91mGfJC0uKQPpJAehuePNEq0Hd3iLBecOKhJesV4mjzuP+FxT+Hi1EDQTqPXrpjp
         AR5qcxG8aIFT754quwEfLCi5oQn9mi2/HTVRDpoZiKkhbKZnELie6kUCvERc3c0kx75q
         YT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bM4mPrdGCmHIaP6sSEhqZR0ycPeA2MFnqRQ1Q2Z5NPg=;
        b=K6+gUCoyPhelRVSaOd91H39g5PgHtVzfR0b7M2qdwcqdpBGKX83LYqeJXd1ViKAbIZ
         vke4dCVzoalE+0kSwXyfbXh8R712sFzbAq+nEIt1MFv86q55iM2TkRWPmGPGSMhFyeEZ
         v0hJg3aKF/JtQp7S8jII5i5xLMWhFIrmUR3YA6TinKIlTXoqomewgItqpp55e0NGUIEe
         a8FSWV12+mQ0Pbj5kP2KKJaWMFZFTR7vcTWGtreE9nj3yQPDlBvS+TXdnL5+KRLW5KTX
         GHbeiiAfzUFHTmNNG2YHlwkG2HYEOZUabzTEjvam29TSyBgHcfm/06kWBYUAASUZ+a6/
         OTtA==
X-Gm-Message-State: AOAM530ci5c8Bz4l3K4uhAWmR+LWr4d8hxID1x/sogTIUOAtfqGAIS5F
        Abl9NYcZRU+JTauRTYgoMWwvfg==
X-Google-Smtp-Source: ABdhPJzt+efXXKYitxJSG0qkBeBvxKXFSW53cPvWKdkouaGicDhbubEjfCFFyjhotrF0vhCXh1dV/A==
X-Received: by 2002:a1c:3c04:: with SMTP id j4mr401685wma.177.1611856969662;
        Thu, 28 Jan 2021 10:02:49 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <teheo@suse.de>, linux-ide@vger.kernel.org
Subject: [PATCH 05/20] ata: libata-pmp: Fix misspelling of 'val'
Date:   Thu, 28 Jan 2021 18:02:24 +0000
Message-Id: <20210128180239.548512-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
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

