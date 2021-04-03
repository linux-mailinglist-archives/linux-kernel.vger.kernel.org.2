Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23657353298
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 06:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhDCErn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 00:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhDCErm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 00:47:42 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6CC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 21:47:38 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v70so6913123qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFzzeoYGIYM+Xfkak8/IpQyVsC5/nvHs2bkK5Oa/t/0=;
        b=BeLySV4UP6e/bZzYcAGFuSRV2ttfncOLKCv7kCdyvqbToM6/3qN3MEpSI0suLKkAK0
         L8nN+Ll6VW7JIeKt0QJ90ALS8+rBjNtpmIf14hSVHZUqzj1Udu82I6n98AZ7pkVr1xPA
         mxgPAiu2iD/LAidHsrgh0imzbEWAKXaLr5isJTjkF+/4lLyg9BgLXt3g7f+3YEC/GWTc
         oL92LzcdyfeWnxEfSUFvW3YhTGdv2vi1UCuh+A5npkdChv+fuMsF4i+RdVXBTByIn3Ln
         1BhAcokZGJRFztDrBX9s67IYNUeEqUoH8sq8PESmDDZ13FI7LORAYFwGG3Me27nZurrI
         mKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFzzeoYGIYM+Xfkak8/IpQyVsC5/nvHs2bkK5Oa/t/0=;
        b=HQhTKpQCZBuCqUHBJaD+Sw2aZgdcqy6MEPtfaVAA4+MJzURHMCBltuQh2wDti6tFFO
         xQtTYP8/Pf3ZDU6DC94Y7XUV0Iq6vDM3Nh3JxW8mggHxVE7JS7xqBGIQNGfw/MNgpbDn
         4tvqsMOrPOu4hsDmeakYW1eoUo9AbXq3wxaYXOKr+WhSKL4akih/VKniCqcwGTDMmhDd
         iUkXTSY1l0x16W7OMFaQmQwCOEWO/vlA3g+qzvfcVlJRU/V2BytBZI3yF/GK2SGUm5pU
         zLm+eCbBqw77X/Yhn3kyZNtII1lYDHk4i5K23LFJ5h36y3AyeMTQPjORkl2mYRTK6+bZ
         0zOw==
X-Gm-Message-State: AOAM533TgJuXbhpcxGzKBFhYwdMxXE7tyWuAJBOk2trcMuw0823f9/t3
        asKrOLWcawCZgXG2gnFgeZc=
X-Google-Smtp-Source: ABdhPJzVmB5fMmygyRPBYzgXL0b39Kfow519VPYd+WzlXM9rPt1dCpEZvW1lnMiKnn4wVFuetyuRSg==
X-Received: by 2002:a37:8cd:: with SMTP id 196mr15535425qki.434.1617425257870;
        Fri, 02 Apr 2021 21:47:37 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id k126sm8800598qkb.4.2021.04.02.21.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 21:47:37 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v3 1/9] w1: ds2438: fixed a coding style issue
Date:   Sat,  3 Apr 2021 01:48:13 -0300
Message-Id: <20210403044821.390485-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403044547.390226-1-sampaio.ime@gmail.com>
References: <20210403044547.390226-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an if statement and, if the function goes into it, it returns.
So, the next else is not required.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 5cfb0ae23e91..148921fb9702 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -154,11 +154,11 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
 
 		if ((status & mask) == value)
 			return 0;	/* already set as requested */
-		else {
-			/* changing bit */
-			status ^= mask;
-			perform_write = 1;
-		}
+
+		/* changing bit */
+		status ^= mask;
+		perform_write = 1;
+
 		break;
 	}
 
-- 
2.30.1

