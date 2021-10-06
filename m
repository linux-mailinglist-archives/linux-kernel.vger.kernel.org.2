Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBBB423D6D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbhJFMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhJFMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:05:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D51C061749;
        Wed,  6 Oct 2021 05:03:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so8132966wrg.5;
        Wed, 06 Oct 2021 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/aej7GbV3RNso2QLtyef0SKYF6ZtFllJDqUDN4OhOw=;
        b=pjApfVmGa2U6cE/pKb0yScYS7aJhpSbaYToMzszxXiVVy2EDizgOZUD3J8Q5YsL+F5
         9HUvXaMOkG5oPHBD1j/LYmlKuvwuayhCudKU8f9Q1Z2uxSNmnqhMNCI4Js7fELco8vCt
         MLhss5+DO8Gqapjz5T1jPN3+VM8UjOLqlrqtZoW6fP/pDVFZDOPD8V8AStpscxfb3HFe
         qGQur6Zv6FXEUF9UvuSDo0/fXeL0wUQP8Ngak97RI9QxOD6+MMISkC9EksmPDCCvVVAr
         2kucbFm0pzLWHHrIRZCzPuUuL+h0eqlQJyU6LZgNWRJBJzVljGUITi1mbSgpv4OVtBup
         HJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/aej7GbV3RNso2QLtyef0SKYF6ZtFllJDqUDN4OhOw=;
        b=Gtr1QYNVVpfi+8bBLn5c1fj8VT76rMlhOPqoJwN0T1UM6UDUboLChBJL1h1ZK3LSS7
         JLB/dI/VFyjmRZSiAG7P4RGFm5+sJf61DbRHnBw/6td/H97It/agc+zxq7amNXzelreS
         44w/fZE9mTJPcK7yWORPMKr74wFLXK0vk7fhlAxxZU95Vc+f3uJr/KuOBL6i5qGeMDRz
         gu5sAY/HsFGOGptdDhN05iFdXvwwXSxDLG5K5gpT9uWNAFuZEn5ct0fIzuSbgOfbI3mG
         uqTskChvfl/pEB+v9cMIwS9iSec+GR5S/i+ptAXD9bQLtw8feXizKdke5f5FTJyUIe+i
         PX/Q==
X-Gm-Message-State: AOAM5318rS0+zgxstoy55rJRaKaXfI8m/taNk/sFr4i1x4T92ZEcsb9h
        OitbZVFNnQ3QhYzcfm809tVXHY6KRy8=
X-Google-Smtp-Source: ABdhPJx25D0gRSn90gByos6lL+f5LoTcfRdO2Q2woo7Eg/ad9i7u9KhZ3isEjsydfgyH0nxeaU9m6Q==
X-Received: by 2002:adf:a550:: with SMTP id j16mr20811802wrb.384.1633521838318;
        Wed, 06 Oct 2021 05:03:58 -0700 (PDT)
Received: from localhost.localdomain (i577BCBA0.versanet.de. [87.123.203.160])
        by smtp.gmail.com with ESMTPSA id a2sm7178336wru.82.2021.10.06.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 05:03:57 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] memory: remove unused CONFIG_MEM_BLOCK_SIZE
Date:   Wed,  6 Oct 2021 14:03:54 +0200
Message-Id: <20211006120354.7468-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3947be1969a9 ("[PATCH] memory hotplug: sysfs and add/remove
functions") defines CONFIG_MEM_BLOCK_SIZE, but this has never been
utilized anywhere.

It is a good practice to keep the CONFIG_* defines exclusively for the
Kbuild system. So, drop this unused definition.

This issue was noticed due to running ./scripts/checkkconfigsymbols.py.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 include/linux/memory.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index c46ff374d48d..a216829df280 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -143,7 +143,6 @@ typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t func);
 extern int for_each_memory_block(void *arg, walk_memory_blocks_func_t func);
-#define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 
 extern int memory_group_register_static(int nid, unsigned long max_pages);
 extern int memory_group_register_dynamic(int nid, unsigned long unit_pages);
-- 
2.26.2

