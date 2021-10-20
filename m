Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12564347A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJTJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:09:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89967C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:07:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so1996819pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cC5Q7CknUGVE4TEDHT6ozzG2sw4T010Smk7bX1IlW0Q=;
        b=gZXCTWBkJpEfbsVyy1dJtM9zlPGXveNf1CNpNi7dwn66M37n4PsSTu3KCJz9k9yrFv
         5HahZlxX7rXiQAAAOoEYzYVA8ELSwJUc3rGFaWKJn2SVV/x0Li0xlnLYAeiP16dsLb0J
         HEK9PvhyI41znuWwd8TqAr8/2wgcmCyWH6FzYxx/8zzM5VZ2mBRtWvEzj7SwjGswXM2Q
         epF0L6Og8XuVyAn5/Ujvsk8I6DlLVMb9eepqb3CIfXBmW61trCmPSwLL32BGry1D9Kxm
         d6G7a9FwjzTGtq0VkCZ4CDvfWnFx0znkaAa2Vem7l+TIU5EJOnVR5ji59vmAWhqQ1Uh2
         nAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cC5Q7CknUGVE4TEDHT6ozzG2sw4T010Smk7bX1IlW0Q=;
        b=v9t2freYsvFtt6QLXUVkd3nrAVKe7hDamjLXkCWqpT0q2GCl2eYcw5AIkGcYQbczV2
         OCn/9HUrO8GJ9Mfb8Ouh32yAeJF3RCG122qxOncYAP0omFyJgqWppb7aK7wGOKDU2t3x
         cBjGRSGH0Ih8kXzQYPagi6hVBRoLM3TJb/ZMFF/QOd+bsKTySUZb80TZ25Kw/iRTutRG
         ZeCIe9QCotbvO8Gd6EqhXhDxjgjcSbUGyBi0IuarOqF9BSXwYWRTdj/ulDOBLMmEXZZJ
         Glb/O1QqZ5k5nrPY3WBZe+VpIu1xsqQf5ZA+U2CnrW/RR89FrrBrC1W5DWYyQR2x+7pP
         +j7Q==
X-Gm-Message-State: AOAM530G0aN3GrzJfKh/DdmJog9xbQNL0JcDCxa8tdaQh4fnTpnaSCGe
        Hi3is/8GYpWawFRfx2W/GyY=
X-Google-Smtp-Source: ABdhPJykT4gM8kuTeE3hWNZW6zkfPy8inA5edHWRgQe48DADrn98tyuU1TkchbNCw2yZk88mlu5IBg==
X-Received: by 2002:a17:90a:3b4d:: with SMTP id t13mr6113687pjf.115.1634720834117;
        Wed, 20 Oct 2021 02:07:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 17sm1713976pgr.10.2021.10.20.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 02:07:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     bhe@redhat.com
Cc:     cgel.zte@gmail.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        vgoyal@redhat.com, ye.guojin@zte.com.cn, zealci@zte.com.cn
Subject: [PATCH v2] crash_dump: remove duplicate include in crash_dump.h
Date:   Wed, 20 Oct 2021 09:06:59 +0000
Message-Id: <20211020090659.1038877-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020015357.GD27625@MiWiFi-R3L-srv>
References: <20211020015357.GD27625@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

In crash_dump.h, header file <linux/pgtable.h> is included twice. This
duplication was introduced in commit 65fddcfca8ad("mm: reorder includes
after introduction of linux/pgtable.h") where the order of the header
files is adjusted, while the old one was not removed.

Clean it up here.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
v2:
- update the commit log
---
 include/linux/crash_dump.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0c547d866f1e..b7b255b23b99 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -8,8 +8,6 @@
 #include <linux/pgtable.h>
 #include <uapi/linux/vmcore.h>

-#include <linux/pgtable.h> /* for pgprot_t */
-
 /* For IS_ENABLED(CONFIG_CRASH_DUMP) */
 #define ELFCORE_ADDR_MAX       (-1ULL)
 #define ELFCORE_ADDR_ERR       (-2ULL)
-- 
2.25.1

