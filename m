Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D0638CA49
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhEUPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhEUPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:39:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DAFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:38:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q15so14496459pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OpRoddiq2Ou7xlZRWSspgbeiw/t3elijZ5c7rapvKRU=;
        b=Qa5WVH0zL+ve5TqZ4Y6oVxPuFtPdq/zT39Q+LcfyQ5e5Yt39lBXvJKTblC8YAJ+M4O
         vT3oAJjzbv3vIAa4Zk1QwI0Pl9mMo4scdWrgxpFy/sSqTEc+mPkReFTqE47AxHkMa0WO
         V/pSib6Fmv7iQkAtdViQxdIIgm1zp4vaQagcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OpRoddiq2Ou7xlZRWSspgbeiw/t3elijZ5c7rapvKRU=;
        b=rNcXWHUq/dJtyH1ntEvA9OhW/OYd6hU7F/FRc5Lh4svmp9GFCIyDBJcrmEHMb9dTs9
         Apx1c7SrXnGlM12czRtFA1i2vxUyxxrskjlo8Fbf/udNAAimt69eEvdE/jlI7Y/gPJ14
         caqO94iWybEcXeTHFRZKGqTdIgzRLMXpex9TYzB69b3KMxtzxSJt4kYG2r8M4I0CRCiu
         NNXph/I0dTFQZJoC0hApPQMJelCLAJyOh/nAq9fYGQSdK8kOZ3tDHuNXu2QXV3EnaIc/
         D+jfNRyk/sozZSV5ZjRx0IH5tzMVAdOcIlFx04vexvA2TwLjIuhqGj/QXBQ/6wqC2ekl
         CeLA==
X-Gm-Message-State: AOAM5337cK+Pdoqxu/W6/f5XqcxgV1zU4ca1E3GzIz5umL1qzsKxPVa1
        euIWzrSuatxmb3KgOa8JL/nhEBMToAt5/9Ff
X-Google-Smtp-Source: ABdhPJyJqj3YsDpvTzExkd2w22iinpvpv8HDShHz9ij3F7yvU9QloonBmphkbwd7HkQg7JlVgMnplQ==
X-Received: by 2002:a62:7f51:0:b029:2dc:e1c9:ef71 with SMTP id a78-20020a627f510000b02902dce1c9ef71mr10685861pfd.33.1621611485525;
        Fri, 21 May 2021 08:38:05 -0700 (PDT)
Received: from shou-ws (ip98-185-228-170.sb.sd.cox.net. [98.185.228.170])
        by smtp.gmail.com with ESMTPSA id m1sm4174942pjo.10.2021.05.21.08.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:38:05 -0700 (PDT)
Date:   Fri, 21 May 2021 08:38:03 -0700
From:   shouc <scf@ieee.org>
To:     linux-kernel@vger.kernel.org
Cc:     ch0.han@lge.com, akpm@linux-foundation.org
Subject: [PATCH] page_owner_sort.c: Fix potential nullptr dereferencing
Message-ID: <20210521153803.GA537901@shou-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"malloc" may return a null pointer when OOM. This is a patch for catching all the OOM cases that may lead to nullptr dereferencing.
---
 tools/vm/page_owner_sort.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 85eb65ea16d3..894a929d2053 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -11,10 +11,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
-#include <unistd.h>
 #include <string.h>
 
 struct block_list {
@@ -72,6 +69,10 @@ static void add_list(char *buf, int len)
 		exit(1);
 	}
 	list[list_size].txt = malloc(len+1);
+	if (list[list_size].txt == NULL) {
+		printf("Out of memory\n");
+		exit(1);
+	}
 	list[list_size].len = len;
 	list[list_size].num = 1;
 	memcpy(list[list_size].txt, buf, len);
@@ -133,6 +134,11 @@ int main(int argc, char **argv)
 
 	list2 = malloc(sizeof(*list) * list_size);
 
+	if (list2 == NULL) {
+		printf("Out of memory\n");
+		exit(1);
+	}
+
 	printf("culling\n");
 
 	for (i = count = 0; i < list_size; i++) {
@@ -149,5 +155,7 @@ int main(int argc, char **argv)
 	for (i = 0; i < count; i++)
 		fprintf(fout, "%d times:\n%s\n", list2[i].num, list2[i].txt);
 
+	fclose(fin);
+	fclose(fout);
 	return 0;
 }
-- 
2.27.0

