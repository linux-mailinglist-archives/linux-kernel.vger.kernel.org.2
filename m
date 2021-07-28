Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F19E3D8DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhG1M2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:28:38 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:46624
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234847AbhG1M2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:28:36 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id E09D23F327
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627475312;
        bh=pjz5ZlEXm5/saRfrb523NAHPbJDjlGI5vzYthqGvyTg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=CTaI9d3E0iQ3doVpK7fHBw+n5tkmrn1CFAqjpwA3Qq4f5AX3wUGGZENSsdPROlHFH
         bAllWgxda9FRvWNjFezFJTDGCzGjI5flW6+R2t5FdOXDJsnBSG8wOFNLwdGYE7IQvb
         3yI4V7ABiILtFhvMn08O9qG6SZdBwKY3EGOtpEyer9PEHAcDsjvoL4ZDI+ckVcs8BY
         92xe35nMx3IjzGC5IO/w7Na1DgXu4f9BGYE4tYwEk8AEDccYsAmpv0UAXaix0PfRtU
         c3FAdl3fTOe+PhPx8OWTrC0UGhKI09wkEUE4YBh/6MN4TuoEJ/6nIKzq+5wpnWBeib
         y178bAFlzi/lA==
Received: by mail-ed1-f70.google.com with SMTP id y39-20020a50bb2a0000b02903bc05daccbaso1176979ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 05:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pjz5ZlEXm5/saRfrb523NAHPbJDjlGI5vzYthqGvyTg=;
        b=SCkgeAuTdYCBEVfIH9LgEJF+z+88KpCalPB5yN8ckPDoLbauvujqSqPy/zGV9w3In3
         nVHCQ0hDzoMO0DNcyKUv26BHGbQJI295dLuXCH8StjTN9yrWox/9C9E62eztC/9NLKV0
         I7IBFdpgaZWjwVG0+lS3ZDeeMv55+4VSpwM+NvimmHD9IMPfRQGUQlgTpoiCSEKaZzvK
         /bEz9StC+twURgFO/sQ6L0WiWQ6q08Lor3ODDZwxy6GJj0pLn05nW5knlMife5Pe5kLb
         08YS8kMspy2AlMejuLxrhqMFVMe3yEChHxPM1ZvTh2Z6j2wc9Yr5KqZw/ebK+Ota6Gik
         f6OQ==
X-Gm-Message-State: AOAM530BWsXlpP4EiEV8ZbgGBpullOTQKd1g4TwNu7hIMWSp9SWn1oix
        acV+yQ+UVRnFwXZsmOpzonQf9n0/d6wR5lsbuDP2De1nE2LLYB6kgchc49fygJ6ybkhdGS+AELc
        KrFhVI6lZ/jNpxd+t7d6fty/XiNUTGz/OzYU64UI8LQ==
X-Received: by 2002:a17:907:1b29:: with SMTP id mp41mr27084490ejc.459.1627475309454;
        Wed, 28 Jul 2021 05:28:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrZkbFHjhxagytS+B+3gMkKG8bcSUnDFbt3UuykPPqHmgx4NiLQjohYIgeoXseoiWDUoXG5w==
X-Received: by 2002:a17:907:1b29:: with SMTP id mp41mr27084478ejc.459.1627475309295;
        Wed, 28 Jul 2021 05:28:29 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id mh10sm2006470ejb.32.2021.07.28.05.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:28:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        wengjianfeng <wengjianfeng@yulong.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] nfc: s3fwrn5: fix uninitialized ERRNO variable in probe error message
Date:   Wed, 28 Jul 2021 14:28:08 +0200
Message-Id: <20210728122808.156961-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0302ff5906a ("nfc: s3fwrn5: remove unnecessary label") removed
assignment to "ret" variable but it is used right after in dev_err() in
the error path.  This fixes clang warning:

    drivers/nfc/s3fwrn5/firmware.c:424:3: warning: 3rd function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]

Fixes: a0302ff5906a ("nfc: s3fwrn5: remove unnecessary label")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Commit hash a0302ff5906a from net-next (not Linus' tree).
---
 drivers/nfc/s3fwrn5/firmware.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
index 1421ffd46d9a..1e506f6be96e 100644
--- a/drivers/nfc/s3fwrn5/firmware.c
+++ b/drivers/nfc/s3fwrn5/firmware.c
@@ -421,9 +421,10 @@ int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info)
 
 	tfm = crypto_alloc_shash("sha1", 0, 0);
 	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
 		dev_err(&fw_info->ndev->nfc_dev->dev,
 			"Cannot allocate shash (code=%d)\n", ret);
-		return PTR_ERR(tfm);
+		return ret;
 	}
 
 	ret = crypto_shash_tfm_digest(tfm, fw->image, image_size, hash_data);
-- 
2.27.0

