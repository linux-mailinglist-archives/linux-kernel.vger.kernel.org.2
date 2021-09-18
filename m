Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B827410447
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhIRGRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIRGR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:17:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7132C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 23:16:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o8so7619725pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRf/VeJ9RoO6ChGZw9NzGTDZprf/hMmndoggZ/+vGHs=;
        b=hNbrGMYw8ZeFvZHOXw6MZpoboMIgYu0T21d9KhC128mArJNH4Izj26EzkYPukZNI1r
         4j7gTTWJY4RtoAaatzd0gHxtW8k+MM/P6CUt9g1FG9mdGdlm0SRSH97qHQklKc9nTPL0
         etOq2XkjhWVFdXhOd4YPMxbPOP7ZhdwZA7BJVOu3bGGqKmKSCD5U7DBUFIM9YCOXec0X
         gpt77YIJg21k2htY9e9UnSEWZ7f9PurxZV4Ms9cCdKGXRzhgv1pL3Xdvc74Jl/adnBEP
         Itq4JRRBP395kS16Q4ulTXxaIrwqEaQZjYOE/av76pttp3QeGXgLjCLtktxi7DNGkoLs
         bdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRf/VeJ9RoO6ChGZw9NzGTDZprf/hMmndoggZ/+vGHs=;
        b=YUjllu3BmzJWfHPzFrl1bV9rDbWL0ChhP+yiIJdIRxLYyFVi5psWVD3Nhe+3uhbLeQ
         4YRO/dfG7t8IaeKbSMd43sxxCz5zO/qL8rY0/3WhPhw2gIUrSG3rC7qRqxXt+DuiBuDn
         pBHqWBo61OLyH2+s/Ef0tvS9iRPxXTWB6kg18W2hx3cyxXF30dgfpfXNMQPM6VHG+KJn
         t8AX2YHR1DOkktns3frx14trexGGS7aP2+arBfu+IXV5uQC+gQhioLtce6G/3wOV8Re9
         +VGINX2ZGJEiV8jTn+jcPF3cnSe/ucgrdrpnMy9RbbBSbqLgBlVy2k2DWA70u8mHSRT3
         +vzw==
X-Gm-Message-State: AOAM532RUBG6FMkxAVi7DqxSTgJ8jsaQec4AolAiG+cx2zfV8rmiXfMK
        1g6kkJ9nhkA/aMYyy5f9RFsC4opZF2Q=
X-Google-Smtp-Source: ABdhPJzbPMwU70SdDe+mNJ8BKUWiZbCnhmz9/Bd98qnmxY8TXigvZqjz8+jktcQr+3gY5lP3OPNsvw==
X-Received: by 2002:a17:90a:44:: with SMTP id 4mr17015206pjb.130.1631945763370;
        Fri, 17 Sep 2021 23:16:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m125sm8298056pfd.174.2021.09.17.23.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 23:16:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>
Subject: [PATCH] Modify the check condition
Date:   Sat, 18 Sep 2021 06:15:57 +0000
Message-Id: <20210918061557.238461-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The numa_distance is NULL or numa_alloc_distance() return error
state, It should return. So the "&&" should been changed to "||".

Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/x86/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1e9b93b088db..fa73648aeeb0 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -419,7 +419,7 @@ static int __init numa_alloc_distance(void)
  */
 void __init numa_set_distance(int from, int to, int distance)
 {
-	if (!numa_distance && numa_alloc_distance() < 0)
+	if (!numa_distance || numa_alloc_distance() < 0)
 		return;
 
 	if (from >= numa_distance_cnt || to >= numa_distance_cnt ||
-- 
2.25.1

