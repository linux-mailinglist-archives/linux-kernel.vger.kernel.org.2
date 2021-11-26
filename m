Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3E45F702
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 23:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhKZXCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 18:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241928AbhKZXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 18:00:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B77C06175E;
        Fri, 26 Nov 2021 14:53:31 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so7695712wms.3;
        Fri, 26 Nov 2021 14:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T3FV8iy9Zjp3vvRz4CguAsn6fxTAtVVJ0X26/BtHGfk=;
        b=OyQa6U0qJnr5lI8DPNyFKOv3jacVjuQIl5erQC9UjkdHUeI2YV5ACTY8CWmxD2ssY0
         440vm8aR7nGOktbR/6nq93aZBGvDhsrO2cY97mdCxAlI5B+9bSSHoRRyYpgl2L2aTVOC
         +aKEHxjrKZaKQG53FQfVEuP6mjQaAQBmW8EL85itXLS1ErEpu+XtTYaa5PVtSfRu3YeU
         sjnhCeq06BfRytxxPefOLAGt69Q4fy6JB0Crvd+tmMycleBEP8srrhbGaygLPpP/BeI6
         8jv64n5pzqeH6FXFz1CMAiMUip/bdKNaSTB1oHpiqU59gavCSJLhIdNDLLgaGv9kF+r9
         wHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T3FV8iy9Zjp3vvRz4CguAsn6fxTAtVVJ0X26/BtHGfk=;
        b=DxVlYvsvnMsAvjXm4tMC+n5LD6yEGjf8UWpQGfPQWwA2A4hrMbrGbUewStbIKUIlR6
         xHSZYF4k1TPRaxbPqZvK40NSQ1NxZfcyA9ST/Cd6VwgmEmJ4h9iR5Iq7hturq73o/eJm
         C+GXE3AcyoJ9lRPEshanNlEmxpGsZoWZoFhcdpS/C72HlXHn+m0S6XJR0dvtqi4ju2Va
         SJaIs8rRH+csDvXuiAySxVm6w7N718RIVg+rMDKq/GXnZXLnZGXylOkbf7y8YcR5tttD
         /JprZt/ggSB+5++AKj+HwhGXq8nGDgLQQNb6txQHyXp9lhc/jjS77CWB8VudzzwnBBxQ
         HF0w==
X-Gm-Message-State: AOAM5309WX30InlueotIV3oUZtLPWbLsv1baba/XtgNaxH9lEgqQf26V
        BHBc3fAYhukVsqx/VDfj2Q==
X-Google-Smtp-Source: ABdhPJwS5uBB6FHcbY4s9TdyBfLmGioIhq0k48qrFDgvhUsC2Ve6qcYxi94GhQnFDrqvKIwwx/rz6w==
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr18771519wmi.145.1637967210365;
        Fri, 26 Nov 2021 14:53:30 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id s8sm6858874wro.19.2021.11.26.14.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:53:30 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Michal Simek <monstr@monstr.eu>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze/mm/highmem: Remove redundant initialization of variable maxmem
Date:   Fri, 26 Nov 2021 22:53:29 +0000
Message-Id: <20211126225329.1150651-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable maxmem is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/microblaze/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 952f35b335b2..f328d4549fad 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -144,7 +144,7 @@ int page_is_ram(unsigned long pfn)
  */
 static void mm_cmdline_setup(void)
 {
-	unsigned long maxmem = 0;
+	unsigned long maxmem;
 	char *p = cmd_line;
 
 	/* Look for mem= option on command line */
-- 
2.33.1

