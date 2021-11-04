Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6715F444EB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhKDGUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhKDGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:19:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97B0C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:17:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v20so5552174plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwY/0Yret/ZeU+RSixeWoCXh4kAArCYXsS+DBE2iOpM=;
        b=b7L7/Tpz1l/HxDPeN39J9BMcBjMJwNyQ/xfaESAkuJ4b9f8p2/XbcsNDU5693ndSId
         WEYzqyFy8I6fSDQcl1pD8kFsvySUaedoqOEjWXx0FVRUkdwwi95TmLyBOdB0KgQeKilq
         e10V6iLB67OtwudJy5YWsAdvLmn4pt2i0ee/Xj/3lwdpgDH10tdSMRkgfslGMvURgLNy
         cQnp5we2TjPYoKHjr/ClxG+RESgKks0lBKJcUVt0wf3ZrvOqiz/Ln7utxCtBKMzXJ1EC
         iewav8hFSyuofy1lTTYo9qqF0EPGS8xo9DBpxrIHutJmYLkmX2OeSZxxWBVsgJjbP5i8
         lLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwY/0Yret/ZeU+RSixeWoCXh4kAArCYXsS+DBE2iOpM=;
        b=AnstfPYWvLmPeJ4EQC7XMnkw1o0LSPcmIk3umqg0OGhsSW5gIqO21tGhJaAo+UOllQ
         ZvdKN92SDTlwykDUFu8sKQjXLjpnsUTtMXMWJxUG1zG/dVDy5tKxpoTdoDN9YyZxOIzI
         LWqo/SaDbod+JrU7ohQscAlgzQhkjbfkL9vPToKU1OKGHcliLqGmIaMaGva7s96bN2dj
         ajV4ftm/OwI/ldOV108/D8pD4Vt0cC3xCencAXpMyeO3tUQLuTDIycgPfvM8NiF4hVHJ
         CCUEZ9fUB/Bau67hzpDc2JgckI9K8NiRks1IGQ85ecx6rnZHs4Z6nIeVUjFScCcjQKVR
         /m3w==
X-Gm-Message-State: AOAM533XcTxiGIIkeUD5/pBUpfZnxT69roQVuX5MkjfjEpxJH69oSJvw
        E3Wd9SRVq5DqbckNpa5sl59xVTOBtvo=
X-Google-Smtp-Source: ABdhPJyJuRHN9mD8kGYSac3FNpwwDOidKHwy/xInjRGJxG7R0xX2xZ2j2x96d36H2Lo6RqJecqNk8w==
X-Received: by 2002:a17:90a:f182:: with SMTP id bv2mr19780432pjb.139.1636006641455;
        Wed, 03 Nov 2021 23:17:21 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id a10sm3193010pgw.25.2021.11.03.23.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:17:21 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     davidcomponentone@gmail.com, benh@kernel.crashing.org,
        paulus@samba.org, nathan@kernel.org, sfr@canb.auug.org.au,
        sxwjean@gmail.com, aneesh.kumar@linux.ibm.com,
        yang.guang5@zte.com.cn, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] powerpc: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 14:17:09 +0800
Message-Id: <20211104061709.1505592-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/powerpc/kernel/fadump.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index b7ceb041743c..5b40e2d46090 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1265,7 +1265,6 @@ static void fadump_release_reserved_area(u64 start, u64 end)
 static void sort_and_merge_mem_ranges(struct fadump_mrange_info *mrange_info)
 {
 	struct fadump_memory_range *mem_ranges;
-	struct fadump_memory_range tmp_range;
 	u64 base, size;
 	int i, j, idx;
 
@@ -1281,9 +1280,7 @@ static void sort_and_merge_mem_ranges(struct fadump_mrange_info *mrange_info)
 				idx = j;
 		}
 		if (idx != i) {
-			tmp_range = mem_ranges[idx];
-			mem_ranges[idx] = mem_ranges[i];
-			mem_ranges[i] = tmp_range;
+			swap(mem_ranges[idx], mem_ranges[i]);
 		}
 	}
 
-- 
2.30.2

