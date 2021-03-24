Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC04347297
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhCXH2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCXH1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:27:51 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C2CC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:27:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f12so16908747qtq.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doLGIOHegWUY4bKonv54TOpnfPrc1iFCg0IxD5DTTns=;
        b=VWGSCtK51iElpZIKBr335nV+z+CFNYgTZ3GnZ6Zkv4Qg3t8swSvBXmKYe+2Jyv7pD3
         yLHz0JD6mOPKi6NYkGO9nSdRXIOGW2SBmGlAbXHLKFHUfB1vRAFJiIFO9QKknKJmS71u
         MeA0A7uF3wv0hwnTPD9hoWvxUm9GsNqDZ5msQxkUwO9Q98gnNEwq3Vxpj1rj2votQ1xV
         FU4fDam775f/AmnaHIYr5j9GfaVIEAgvpMDptwUhW2VLJXL/pzfG7sv4Ocmk025sm4Qp
         ez2r5q33eARVQHIzIpQ9tAgku5lvjAnvTzAnssRYVlKdSdkgrkA8FKiOQyq9VvOCaLOj
         XuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doLGIOHegWUY4bKonv54TOpnfPrc1iFCg0IxD5DTTns=;
        b=iwICWzNJ4E+2YWoDJootBN7ScMufFvT4yBdps5LOQnT5PX5I5OEr+ypDdwNrPpIWJY
         BBl+PL/GIsx6rfnfXq6HRFpe0xfiuW8Tz4PYx2yjI1v8Xtjh0edU/m/NiZf2f/0HiYAz
         TQ6hAOXHhu4N1lXZzn4uPyFTVEdchTOfwyY1CpQkaQ9ueuw/cPuFoviwPm1gafIfLrTl
         Fsnedtwl8FRseqeVELfydW6RVTNnvDnet69cnuEj/6ZmYZTC3YqMmLMWF+qnNhoJDx+X
         rilemkv1UT7oVB/lgggAs1qulMsskGhrvqAIcp4OACMSkWJjzXsXygeJPpCenilSK2Tx
         rgXg==
X-Gm-Message-State: AOAM531Qk7N1pi/9eODc7B/235OIhqsgWp2V5tAmGX8QmtpDvawRJ2f8
        XtjULrb8D0GEaA6IJ88iqsE=
X-Google-Smtp-Source: ABdhPJx0BPMPcUz/Zkohzh+90B54PD0hev/LS+My+FphCBunKypqs5LDtZkPucDKxGBXnfpjixvY8g==
X-Received: by 2002:a05:622a:1654:: with SMTP id y20mr1736965qtj.364.1616570870175;
        Wed, 24 Mar 2021 00:27:50 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.37.194])
        by smtp.gmail.com with ESMTPSA id o7sm1093640qki.63.2021.03.24.00.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:27:49 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH ] ocfs2: Fix a typo
Date:   Wed, 24 Mar 2021 12:59:31 +0530
Message-Id: <20210324072931.5056-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/cluter/cluster/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/ocfs2/stackglue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index a191094694c6..8d33ebc6b6fc 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -731,7 +731,7 @@ static void __exit ocfs2_stack_glue_exit(void)
 }

 MODULE_AUTHOR("Oracle");
-MODULE_DESCRIPTION("ocfs2 cluter stack glue layer");
+MODULE_DESCRIPTION("ocfs2 cluster stack glue layer");
 MODULE_LICENSE("GPL");
 module_init(ocfs2_stack_glue_init);
 module_exit(ocfs2_stack_glue_exit);
--
2.30.1

