Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED33E39CAFA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFEUlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 16:41:19 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:39820 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEUlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 16:41:17 -0400
Received: by mail-lf1-f41.google.com with SMTP id p17so18642373lfc.6;
        Sat, 05 Jun 2021 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaLVsgy9EG9wzIwQnKI+lzZzmSS/nBZJSY+bai8m++4=;
        b=JJxzS8QqJWVvMq2oNdLa0TCOzUwt8ttbq5JIxQ9sibPdy47e9nC2sDUMPfOs49LWYw
         /AVyKzofQ9ED0D8zvmFfBTXYwTTYeDESNILRiPbMVgY0ewsvqVZ7CgMEmQN6HMcZ8Yfp
         HU/AiyO5RpzyN59CrxwNjn1iIpGDq85CKUAMhS7KjXO6c/Xdlpg2c+KSYICgWAXTZFwR
         iy0l5RuY8oEmpdLMzrA1F606ZWcoOo1y2ieRTDHTP7oYEIyyQUVAscWNz+J23pdQvZZA
         DLa+yLHiaDU0SccZCUEKUaGhrECPUsi/6MWUQCnqgCQxCsu6rvHEnD5Pj9GzC3QXXYqU
         QRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaLVsgy9EG9wzIwQnKI+lzZzmSS/nBZJSY+bai8m++4=;
        b=bOm0hATwqQ4K0c6J4yvX5zHdnZswDgvpEMef9Nj2cc5vwK5ZlyVZBlxO+ORDiwz9zn
         G579AxCmDsrrlCZ9Bxb7U2HikNm6ITU5QkyWRTo/zuicH4g4tRRt1lonRk4V3zty6x8D
         WQ/S66XSyqz7WHR4IMkG56kpl+Q1D7w4brryK9I1HXlIzmaCLJ7wtmSaSJLHYgbsnFtG
         VkE/TEOQa0Ij9hlrh/PRsyh15AWUEl4QXT4gjb9FqoJOWePo5B5upoPg/2t/GvepPn+G
         5wzx4pQ448yZ/CMVJG7qzDxznvJZUX5A0bmF4fCPnTYSufwHDkxYKLs5+OeA0VpBcSSt
         h1sA==
X-Gm-Message-State: AOAM53023l3mccgNTrh+ggQB37CA0dmsjT2ONZVcdKZnuYSxL8TJEf5H
        +zaLz2HrtPvUx64IcT8bA2prCAZzPI03QA==
X-Google-Smtp-Source: ABdhPJyJ7hidi+3DNbiWdcifgU4QiJFIA/I2o4cn2i3E6QGoiEugS/2lv273qCnGOaFw9p99POnf5w==
X-Received: by 2002:a19:691e:: with SMTP id e30mr6798624lfc.302.1622925496175;
        Sat, 05 Jun 2021 13:38:16 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id k24sm1170063ljg.43.2021.06.05.13.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 13:38:15 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Frank Seidel <frank@f-seidel.de>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Justin Ernst <justin.ernst@hpe.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/4] platform/x86: hdaps: Constify static attribute_group struct
Date:   Sat,  5 Jun 2021 22:38:04 +0200
Message-Id: <20210605203807.60547-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
References: <20210605203807.60547-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only use of hdaps_attribute_group is to pass its address to
sysfs_create_group() and sysfs_remove_group(), both which takes pointers
to const attribute_group structs. Make it const to allow the compiler to
put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/platform/x86/hdaps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hdaps.c b/drivers/platform/x86/hdaps.c
index a72270932ec3..9996485f5295 100644
--- a/drivers/platform/x86/hdaps.c
+++ b/drivers/platform/x86/hdaps.c
@@ -462,7 +462,7 @@ static struct attribute *hdaps_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group hdaps_attribute_group = {
+static const struct attribute_group hdaps_attribute_group = {
 	.attrs = hdaps_attributes,
 };
 
-- 
2.31.1

