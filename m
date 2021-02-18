Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF2031F10B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhBRUay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhBRUas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:30:48 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4919EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:30:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u4so8084359ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ox1btvjGk59rM0iFdC1MHmi/BBw9yMa71c5TOfzav7s=;
        b=oI7R0pzgj9KCnSqzCOvslhBEo0GGB5hHCweLk5DtPp5Cj5n4hPHS1HJfhcdN+iL7Fl
         AHOAs3kJSozfHSUF8+a0vhU0YfMMPhATR0zGI45IgTMsPU8trzzZytlOH/15f0mKeVAd
         kx4VntGnpixMMcikvIb95fLwsxqUKRUP8JOE9QkVh2XxSR1lXNUxKmwxtJrVz93VyD3I
         02jpKH1SQqCrVZokIFl/efxaF4jV6ZCRFQS5L9qiZ3kC4LKCz1p3veA/evu0/yLCx8ZP
         3qY65bQSxrmlP3Hq9m2v4s7ECBOvVNm49ANlCxpGNy8txmwVPpTrqWQFjkbalubmXx1a
         Xfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ox1btvjGk59rM0iFdC1MHmi/BBw9yMa71c5TOfzav7s=;
        b=l+qYp6fvGM8R66JYGOuYn7FlKparj3ZLSwN20SrOwwOfiEIzPPVQImP3sXK6cEeWJl
         Sh+wWbkLEoPdI2Psel0PBdxMUXQzrJBysAO0Wwlyu0FApr44f01Q0gQsOu8XF/F7fZLS
         tbtD/xOC+1MSBeHC2dregycRLumnWj7fFOD2rJsF1aAGilYnqVr78tRsvhjDPIhhsHqg
         eqccnBQJzkq6FS/D8N71xYwcAjpcUPwDSC47XcqzvLtfJuRYsIvbtgFds3zdtNX0RYWD
         uUAYN18MPK1jxH7hcwpLMNMhEBoRzk7UcGvJaBK9On64x4UDnF2Lq2ch49LWMuj85hQn
         yXbA==
X-Gm-Message-State: AOAM531Vn6pascvkyW7avlo7N/thGa8BHUO0W79H7g83xjD3FhPH+vMo
        pggZb9qQ7kmHW0M3M+kmf82hr80GDAcwig==
X-Google-Smtp-Source: ABdhPJzJ65gblNIDFUbiJW63dtKAk5r9xjH4j6dImNsNDmQG2MIhoK/hvx+e0l6i06MGcKKuqxO+1Q==
X-Received: by 2002:a19:f118:: with SMTP id p24mr1623511lfh.4.1613680206841;
        Thu, 18 Feb 2021 12:30:06 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id s9sm702289lfr.231.2021.02.18.12.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 12:30:06 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     gregkh@linuxfoundation.org, sergiu.cuciurean@analog.com
Cc:     Nikolay Kyx <knv418@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: code style: fix alignment issues
Date:   Thu, 18 Feb 2021 23:28:14 +0300
Message-Id: <20210218202814.14204-1-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kpc2000_i2c.c:
fix WARNING: line length of 124 exceeds 100 columns
fix CHECK: Alignment should match open parenthesis

kpc2000_spi.c:
fix CHECK: Alignment should match open parenthesis

Signed-off-by: Nikolay Kyx <knv418@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 6 ++++--
 drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 25bb5c97dd21..14f7940fa4fb 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -200,7 +200,9 @@ static int i801_check_post(struct kpc_i2c *priv, int status, int timeout)
 		outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
 		status = inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
 		if (status)
-			dev_warn(&priv->adapter.dev, "Failed clearing status flags at end of transaction (%02x)\n", status);
+			dev_warn(&priv->adapter.dev,
+				 "Failed clearing status flags at end of transaction (%02x)\n",
+				 status);
 	}
 
 	return result;
@@ -269,7 +271,7 @@ static int i801_block_transaction_by_block(struct kpc_i2c *priv,
 	}
 
 	status = i801_transaction(priv,
-			I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
+				  I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
 	if (status)
 		return status;
 
diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 44017d523da5..16ca18b8aa15 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -465,7 +465,7 @@ kp_spi_probe(struct platform_device *pldev)
 	}
 
 	kpspi->base = devm_ioremap(&pldev->dev, r->start,
-					   resource_size(r));
+				   resource_size(r));
 
 	status = spi_register_master(master);
 	if (status < 0) {
-- 
2.30.1

