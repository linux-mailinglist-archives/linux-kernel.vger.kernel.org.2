Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32C5452B50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 08:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhKPHKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 02:10:50 -0500
Received: from mx.ucr.edu ([138.23.62.67]:34165 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhKPHKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1637046448; x=1668582448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VO2ps4lqNewVdq22Zvj/a2S0OmORg6rzuJt+A60klUs=;
  b=JQinrn4eRq4r6Sa3r3EbMpi0z6h8z4IV06vIF7erpN9m5R4jwju/9Mm9
   hVIabWkA8uLznmJEvtz3AgfoRxfENi2ze6CBoutCqNEIhMkxDMy48YHr5
   Okhi0JNIMOGAQoSkSvSf/3EvMZSObSg7ic1GOClQ7vs+BHYv6hG5EVoje
   E+fMCdkMP1FQZhsKvp/OP2fhlzWaMb7t5EzPdlc8RKV1g/TGI56oSJz/2
   K/iaFU1yJRm9GrulmXDfcxIQKcVz2R76sz4sFxa6bcZV2CqnXDpIiKCrt
   DoGrdpqp2gbpQp7romUP3T3B8ewg/ZwDoMLQjkJ4NPKKJM9fcPwu2jZPZ
   Q==;
IronPort-SDR: y4fuE5wzEEuY9D62hsmlvbsi0bE5sfhRyzI2rBq1deGFJA74eZKNe1anvuf42D4uM7KC8TQVG5
 kQnkWDJHMLB0xSsE7KmX5wWHuhIazHaK1A4QX3IvptME8JZOjTwsH1HaiScFnf+uY24YNFp64g
 3Uwo2Dp57ZySlwusTfFtVMB50DxpC/ojLsv+uGSNHRX18xqqzDgDlJWdJGw96dbKx2HpyknD0w
 UXQYiCs8eHME4L7GOcU3ZOlYl+x0zmUCrot3bgg4PD1sBO40VMxTg+B9PmOahgCYGLtObAD/3X
 /HAawmW4K8lz7FXTMm7JrYL0
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="255153699"
Received: from mail-qk1-f198.google.com ([209.85.222.198])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2021 23:07:22 -0800
Received: by mail-qk1-f198.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so13011655qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3HI54mJH/tMRV5CdW0GGK2Uj3sS8rXd01TKP0agSfQ=;
        b=f261Bw5lz3VrnlrV1z2mQHVATuwQH6Nv2Sn8mpGgv9cJwWqwounaC+e3aDrcj3xAUr
         HajLMQLzUyo4LmusHEW65YiMETuOWE6W64PHera/XO2cNYPf41Gb8NvTLyO35Vu902XT
         5oBdWzzt/izYc7pK1lt9bBhvSdVg+ygGGP82g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o3HI54mJH/tMRV5CdW0GGK2Uj3sS8rXd01TKP0agSfQ=;
        b=Euvj5xr0/skvIIDHF8FWNF269KQdl6A4vHB4P1UQc04q/9FP0mKMNz7pYiNF4znnVq
         K44G6kZopZ7i686qg7wL7fARBV5JFUZZJmOYiktW894Yu11+IymNkLwL89uM+D+1+Bfr
         fziL3gOlUECh7g//McSXiVT5jAToNoer6/o0u6ADfnqQCS0E0xt9cxh6a7as7oZDD080
         hQN75wwqSh9++DNXvl+aegvZdlBxcCI4nW9cwHa3QNZEs2ZilsSu0Mzzw0lUM+Nz2y4L
         mQwdL77i2i1kyD785ZGPH/zqo2CIfnLFFa7dYiMuhr6h/IPXwFK8ePuXOgApzdzT8OAa
         BLbw==
X-Gm-Message-State: AOAM533yfngDHYyX9+SouxDgPZr+0H2F2y+KeN/ibCaaPSOYXubGbgeO
        gnh91iaIkjibhrdW2y95e+9qzxfRX58kgo5kvb9inx9wBeWgZCV0XJcFyx7uElC84BtbML4YP8C
        zpdNGqekjAkpOOnlyi3gnEBFUBQ==
X-Received: by 2002:ac8:7dd5:: with SMTP id c21mr3298175qte.176.1637046440624;
        Mon, 15 Nov 2021 23:07:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhPC/C2kELtqxHwiDBXwIfNPToSUuU8wpj8qVqVxKjt5Ut7Tn0HkLJ7k8XQtQn5Vfh9zODaQ==
X-Received: by 2002:ac8:7dd5:: with SMTP id c21mr3298153qte.176.1637046440389;
        Mon, 15 Nov 2021 23:07:20 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id w10sm7205942qtj.37.2021.11.15.23.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 23:07:20 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] In function nvkm_ioctl_map(), the variable "type" could be uninitialized if "nvkm_object_map()" returns error code, however, it does not check the return value and directly use the "type" in the if statement, which is potentially unsafe.
Date:   Mon, 15 Nov 2021 23:07:04 -0800
Message-Id: <20211116070708.429432-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:01326050391ce("drm/nouveau/core/object: allow arguments to
be passed to map function")
Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
index 735cb6816f10..4264d9d79783 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
@@ -266,6 +266,8 @@ nvkm_ioctl_map(struct nvkm_client *client,
 		ret = nvkm_object_map(object, data, size, &type,
 				      &args->v0.handle,
 				      &args->v0.length);
+		if (ret)
+			return ret;
 		if (type == NVKM_OBJECT_MAP_IO)
 			args->v0.type = NVIF_IOCTL_MAP_V0_IO;
 		else
-- 
2.25.1

