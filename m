Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0141DA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350985AbhI3Mvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245343AbhI3Mvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:51:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC291C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:50:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so3913924plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjWzY8VzHWdTbXC+cDxcBBzi3hKG0ksxrqqtEc9ibDg=;
        b=itNZYDLUEVAmagLyjLURs5erv6tCZif0vPj5WV0mREJYA5qAg/BcYBbVymj/G8NyWx
         a7k00f4dCNuWyoHJQUqcDWBYlFETelfEp2S0NGuKMX7W7BEFtynYpPxYks8/6wqsNEZX
         Xw8bcBehuXZx6pJWXb3Vr0G70uvSkmopRP2Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjWzY8VzHWdTbXC+cDxcBBzi3hKG0ksxrqqtEc9ibDg=;
        b=nFanWck+q7FbDAiFyM6mgIDS1J4LFNKXHx1T7Lc4IWCe9r+LvNuWEAOZoPbtrHDVo+
         BPa9zOjaRiTVZiExRst4DjTet9inpFseq/nEL7Fl0Ckg76cV2MV1DjQsmIo5pHQe0DdV
         bT7yg/MzcXTFgf7y3acdk+gVcWbQ0lIYXezcHBXm9Qp1KwvXi+6hPB/SRA56/cqMFtV4
         21rVzgvD+guIM2gmpsldLjmpOP+CL9lsKHxVUBqWnAUxW7LVxAMyM2FHPQUiPJQ71gUC
         L06WZ2NjIl1ikrYk9Q6raaEMrFUpKVAoyrpSMxlbMPKumDKbeOVVtn/E4po73qrNRZla
         /dXw==
X-Gm-Message-State: AOAM530MduhgC7NhdGFlO5nyPlB5a+H7SQgjnlqH33eALc8yHnVVxLwB
        xgOKX0ZCGOdcZqhfpmApSHnqbQ==
X-Google-Smtp-Source: ABdhPJzneNZwDOj6ZANVb6Tj/81+um+/s/maTYAU/KU680qsEvqVfalIXp4nx37sxgcE4jdcqRTYFg==
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr12870755pjb.33.1633006204114;
        Thu, 30 Sep 2021 05:50:04 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id b3sm2930417pfo.23.2021.09.30.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 05:50:03 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] serial: 8250_dw: Mark acpi match table as maybe unused
Date:   Thu, 30 Sep 2021 21:49:50 +0900
Message-Id: <20210930124950.3069638-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building kernels without ACPI support the table is declared
but is not used because ACPI_PTR() turns it into a NULL.

Add the __maybe_unused attribute to stop the compiler whining.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a3a0154da567..599d2bfff045 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -704,7 +704,7 @@ static const struct of_device_id dw8250_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
 
-static const struct acpi_device_id dw8250_acpi_match[] = {
+static const struct acpi_device_id __maybe_unused dw8250_acpi_match[] = {
 	{ "INT33C4", 0 },
 	{ "INT33C5", 0 },
 	{ "INT3434", 0 },
-- 
2.33.0

