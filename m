Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B23346F98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhCXCeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhCXCeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:34:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EE2C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:34:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ha17so10964634pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FtR2XAnVeb7sTn7ci9VSG13zU1YG59bwE8DNyaYnBJ0=;
        b=UxXQcGQqHSuQKzUD87+w3X4+DZF6fS7NFSJ1tmq6qVI5SOCd3TLqjsjyc/UBGua/PI
         GqEHMxd9Mvieb0CWtFuzc8RIz+VFhnG2BHTGsF2gM/sQvCJso4uG25Em+XTuHapbAJEe
         bfsdmoqZnBDjzyA2RLLWsE+0L3mtbypUGbdy5B1kiIRyWRfcOCGfB6PMlU0SzZK8krcb
         a7ZbPcRvKs8/vp748bwsLfTA8WdBK02nTOLYw2eTdBx0JMbKx6tHPNXvo1mAQyxYlg8h
         fkk9tOtP8SvOZmgEHFINNYstHIazChIkvN+Pj6lc10a9o3z0eou5/4BxzcHtOWQFrkOI
         baVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FtR2XAnVeb7sTn7ci9VSG13zU1YG59bwE8DNyaYnBJ0=;
        b=HBcqsDrzFS1NspX+/eAATO3O3jahDRnH2WgIrhLt8k79Goc4FQopyiDXJ0QCTfjELh
         w92jpkOe5cy1UZL0ctwOwAzA30zsgKJwgigvgKD948RB+M8Ow+GQmg9SunMtFsf1OEQW
         xWlv13f2BHjurssRaYGwLh7WTmUIzma8G8qjQUlL7sbT0Q/6EzwdbtnlrM3Is2Yr4NqY
         pKtnImxRXLtFx6D47Kc7yaUUKz+KmZJ5TIlifxILahlegO+yW6qWqZHGYpqPW7UY+3TU
         PA39DJRBFsxCAKYM8AxRiYvPq29Xyj6oGQ9/iIlx9J5pFRwdsg64euhL55qNCcaqTbCG
         GtTg==
X-Gm-Message-State: AOAM532JCKn078P/X08QSMUILpdf6sszujXjX2le24VjByZ6zzI1pKRK
        AbbbMpNGEDq+PDLvpujf9OA=
X-Google-Smtp-Source: ABdhPJx7B800Mzl/C+A13vTz7K1QCiK0gZOlLxshk1up6+rI7jsgkUVAyN3h2W0wR7nIDP8+zqwlLQ==
X-Received: by 2002:a17:902:7682:b029:e6:2bc5:f005 with SMTP id m2-20020a1709027682b02900e62bc5f005mr1518296pll.32.1616553252518;
        Tue, 23 Mar 2021 19:34:12 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.62])
        by smtp.gmail.com with ESMTPSA id il6sm398222pjb.56.2021.03.23.19.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:34:12 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] base: dd: fix error return code of driver_sysfs_add()
Date:   Tue, 23 Mar 2021 19:34:05 -0700
Message-Id: <20210324023405.12465-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When device_create_file() fails and returns a non-zero value,
no error return code of driver_sysfs_add() is assigned.
To fix this bug, ret is assigned with the return value of
device_create_file(), and then ret is checked.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Fix a redundant whitespace.
  Thank Greg for good advice.

---
 drivers/base/dd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9179825ff646..704ae8a90a00 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -413,8 +413,11 @@ static int driver_sysfs_add(struct device *dev)
 	if (ret)
 		goto rm_dev;
 
-	if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump ||
-	    !device_create_file(dev, &dev_attr_coredump))
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump)
+		return 0;
+
+	ret = device_create_file(dev, &dev_attr_coredump);
+	if (!ret)
 		return 0;
 
 	sysfs_remove_link(&dev->kobj, "driver");
-- 
2.17.1

