Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B028F345164
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhCVVGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCVVG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:06:29 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAAAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:06:27 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id q9so9396989qvm.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPLRPNjgY0ax0oZwT9jDC8RniRcWGGGKB5AERe/75K0=;
        b=a3YhtOJ2fmCXh2tOAF1skh2r0jCbsm44WhTNjT4Uzk9fA1yzjOXrfCWoXkuaqq8jcA
         QCOph2dqCZxJMIKIMRLonxYUcwfTGVqQARFcgo2HKhEPfC0u2N4mV1URlg/yYYNInLp3
         mldVKM80JhNfwgUzS1n/K8n0Y+JrLhgpFVnnYF8fTpllU4QUEoStl4qZ0B7m9oEFoPOT
         sgLqZqACFVUYKTqv00z6KifvCehE7m3Xc0w+G+X24BDNbQemsOhXQ0giovuzxQlIWIPv
         +eJwFUbw6l6MfF854YwZnPrlN4TYcDSK9mzED8vkcMJKU4hyGfyVa0melMP2+6urFeJz
         mjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPLRPNjgY0ax0oZwT9jDC8RniRcWGGGKB5AERe/75K0=;
        b=nNOBLW0Sdp4Kzrfu6ouyDbA7HkJtWUIWGcv5fPlbR3AhCL6ldNJ5td93a57dqYtLEx
         0q+qOddTzAKf9tPO+BPjvtSJ5C3n2dmBIOTfXoOJ/kiTFeJtSuEQrTqHgFwYMba/yqAX
         l4hD2CAJ1Hrz0YrfxzHD3IHoFl5rrqvCB9D5DyuEF1JWKnqDJ+jzA5Zb+Dyvd2o6vtY8
         xKF3UwebKNrAfMaXd2TGTy7f25cfnUOw3LCZtqkeES0P9gyAxVrn5E02s7YlHMHYM6Hz
         Hu0ivRMsbxZmYgoJRHLmawkjdNYJJ9D9hyZMD2Ku1ljOYttCkSJuGjsfZkCQ9ZiP+pdr
         iH5A==
X-Gm-Message-State: AOAM5338OtN4D1rwd4QhfqCPB+G821q7mbgxdDPck8G+IKX/S3CHx7bb
        b/BMNn3NYLPzewuAL44BSng=
X-Google-Smtp-Source: ABdhPJyL8RzT2268AePI7aoKOYXKUVZdw+v/SpLsXEcuN/hf+pUU7PWPOcyO3v+unk8GIxbJTVbOgA==
X-Received: by 2002:a05:6214:10c7:: with SMTP id r7mr2044447qvs.3.1616447186832;
        Mon, 22 Mar 2021 14:06:26 -0700 (PDT)
Received: from localhost.localdomain ([138.199.10.68])
        by smtp.gmail.com with ESMTPSA id z14sm9639290qti.87.2021.03.22.14.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 14:06:26 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        unixbhaskar@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] drm/amd: Fix a typo in two different sentences
Date:   Tue, 23 Mar 2021 02:36:12 +0530
Message-Id: <20210322210612.1786322-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/defintion/definition/ .....two different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/amd/include/atombios.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index c1d7b1d0b952..47eb84598b96 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -1987,9 +1987,9 @@ typedef struct _PIXEL_CLOCK_PARAMETERS_V6
 #define PIXEL_CLOCK_V6_MISC_HDMI_BPP_MASK           0x0c
 #define PIXEL_CLOCK_V6_MISC_HDMI_24BPP              0x00
 #define PIXEL_CLOCK_V6_MISC_HDMI_36BPP              0x04
-#define PIXEL_CLOCK_V6_MISC_HDMI_36BPP_V6           0x08    //for V6, the correct defintion for 36bpp should be 2 for 36bpp(2:1)
+#define PIXEL_CLOCK_V6_MISC_HDMI_36BPP_V6           0x08    //for V6, the correct definition for 36bpp should be 2 for 36bpp(2:1)
 #define PIXEL_CLOCK_V6_MISC_HDMI_30BPP              0x08
-#define PIXEL_CLOCK_V6_MISC_HDMI_30BPP_V6           0x04    //for V6, the correct defintion for 30bpp should be 1 for 36bpp(5:4)
+#define PIXEL_CLOCK_V6_MISC_HDMI_30BPP_V6           0x04    //for V6, the correct definition for 30bpp should be 1 for 36bpp(5:4)
 #define PIXEL_CLOCK_V6_MISC_HDMI_48BPP              0x0c
 #define PIXEL_CLOCK_V6_MISC_REF_DIV_SRC             0x10
 #define PIXEL_CLOCK_V6_MISC_GEN_DPREFCLK            0x40
--
2.31.0

