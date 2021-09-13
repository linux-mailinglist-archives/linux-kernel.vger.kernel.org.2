Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9464C40854C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbhIMH0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbhIMH0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:26:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:24:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h3so8619311pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rne45CFHVF3Ed+57mqPI4S8t0BZnsiIJa5Mce5cnMFs=;
        b=I0LVTvJN3u3LWC1FrrPIH1QhzeKn39Yh9Z96gRmixJ15fAXrUJMXNtI+W/YWdVtxeY
         9VDd2Kfd3QsQcwl1OAkNh+YARxq3iINnSVB3LK/DRiEnmMWgMPTGQMe1GM7wm2XPRqsE
         scpbov5JJEzBge1BaTGNUEkbhGxAo99oa5h0z8/drxKk7Le+uE09iL9JhzABQre+oMdF
         w/L4axgqjsQ7bqsgTuQQQpWDcjrwVkWQwSedgzDnJsuy97Dydbui5aM6zQuY/jG5TsSu
         0nnf2JmMW5NbXCzr603ZVH7j4uOg2N/XRIQyS1DUIBl8ze8V58s8EcBJLF3+g/Rwi41Z
         vstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rne45CFHVF3Ed+57mqPI4S8t0BZnsiIJa5Mce5cnMFs=;
        b=8HREVQKVoPJpdL7FH6XZjTVu7lI/9m57Kgz55MGdwIp7dPoyYITqP0PKmzea2lZ843
         erZ+qFUucUyiZRjgg6P0vL/bLzT8IKm8RPr1MIR2FWvjUlqybKipOlKVPkN0ieFP0Xzh
         T8F8G4n3W06Ii7SauwfmqMwshTHz0ajJG6RJhwd5yF+M7LJL/demJ7wh7exsDg/z8n1U
         dGp0ck47rqOQbblWC9DMJMYwkHhHF+jFjVkotBOPDuJUqM7eaHkout5NCyFT19Z/n2j7
         NY1c6G3oxmL1ZMJIUe3Epr792iHfVk5GGdBxKiuisf8mXkB30WRJu2SbOsMWjAOphzBa
         WYlQ==
X-Gm-Message-State: AOAM532vzHorq3FjMqv4WBHQYtY+iifcnJ4mLTmEjEXBLCmZ6OzisIU9
        NmxrgbzBFS1VSG5vlbMn4dk=
X-Google-Smtp-Source: ABdhPJz3kPSM1iVUOv123Y56zIId76DGu9yYy2/Q5GwwNmIPqpUoV376MCwV7pvmNJQoe5h9wCF0tw==
X-Received: by 2002:a62:e302:0:b0:3f2:628b:3103 with SMTP id g2-20020a62e302000000b003f2628b3103mr9843177pfh.39.1631517896240;
        Mon, 13 Sep 2021 00:24:56 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id u12sm5687365pjx.31.2021.09.13.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:24:55 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com, zbestahu@163.com
Subject: [PATCH] erofs: fix compacted_{4b_initial, 2b} when compacted_4b_initial > totalidx
Date:   Mon, 13 Sep 2021 15:24:05 +0800
Message-Id: <20210913072405.1128-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

mkfs.erofs will treat compacted_4b_initial & compacted_2b as 0 if
compacted_4b_initial > totalidx, kernel should be aligned with it
accordingly.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/zmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9fb98d8..4f941b6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -369,7 +369,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (compacted_4b_initial == 32 / 4)
 		compacted_4b_initial = 0;
 
-	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+	if (compacted_4b_initial > totalidx) {
+		compacted_4b_initial = 0;
+		compacted_2b = 0;
+	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
 		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
 	else
 		compacted_2b = 0;
-- 
1.9.1

