Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3F34EE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhC3Qpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhC3QpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3981CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo8756805wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7E9ANSWVnOkd6S+LvdaLCdOS3FRa7Vd+au3GaJnYrI=;
        b=KUmqqYoZ5gJ7kZnZP61Q4rLhcLD4XGQAQtocSS4U2wTeM0o1sqDMnsQn1u8viICHVi
         AbEB0TCw6Ga3i/st09W3J5H9TcoAm8KoEJnOYir2C0Lwoil2mSZ4PM7DgpCmiHabwi6t
         QM0c47f0exTKNqWQ0pf3XuaWuVGpbrqdgHgkCDYMuyehl8HhoJZ1pIN2WtIcK+GHsOm7
         UWC8qyO1TrpF6Fq54FkAyBAtm7CQE2gOq+QjwVFRtkM0hVKjt2FDYd4gu6menE4lnamW
         hU12Xd79J2PadCmD0eaTw+gRT+rL8lAXjk91+HV799CNwQPza9deNbN8okc4D7qfI4Iv
         yeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7E9ANSWVnOkd6S+LvdaLCdOS3FRa7Vd+au3GaJnYrI=;
        b=ZRtzcm+WEBbOWD+5eUkaPm99n6c2K4p01G96pJuBgBG+U4QOqKgh028YMT7MTnTObO
         BlV1mNZZPckW5bVA+/YHnoPT5+7+SpcjSDpneYH0wrUvB0x6yKKX3NqGJX9uMod6ZEKG
         DaQcksOAjuBYOZKFugYkqCguYTFqTun3684i+DRMoYTTjzMvmy5hXSYYGRyHN8YMTIzl
         65ngMP/7xr1/HqssDkyvTjv1dVxXj5vg9M6DGKEq4Hwjt1YIFN28yv31iWzxcnZofrig
         CKGUdTaZqsaX8o7zfvh7ONZyUbnYDaJmFbCyHC0ka0zjTIm49T5t5Ma/St2eAc8zqQfj
         DYQw==
X-Gm-Message-State: AOAM533/IuRQqMdoXhxdhc8qzIHnhp4qHiCSpMjCAzX4bj+qziLXGHug
        djb7WEdPXiUb72anz5ZNo4/W7A==
X-Google-Smtp-Source: ABdhPJwCk3P+TYA5zfxerNkG0iKDd/6+8j3OZvSjQUsjScjybqSh/0o+6k43Ke3/mcrUCaPxfNcz6A==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr4898917wmc.75.1617122709878;
        Tue, 30 Mar 2021 09:45:09 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 09/31] fs: gfs2: meta_io: Add missing description for 'rahead' param
Date:   Tue, 30 Mar 2021 17:44:36 +0100
Message-Id: <20210330164458.1625478-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/meta_io.c:249: warning: Function parameter or member 'rahead' not described in 'gfs2_meta_read'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/meta_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index c38e3805f4689..9f01df6a84911 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -243,6 +243,7 @@ static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
  * @gl: The glock covering the block
  * @blkno: The block number
  * @flags: flags
+ * @rahead: Do read-ahead
  * @bhp: the place where the buffer is returned (NULL on failure)
  *
  * Returns: errno
-- 
2.27.0

