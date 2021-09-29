Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB641CA11
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbhI2Q1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:27:48 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59618
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345849AbhI2Q1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:27:47 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 363B33F4BC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632932765;
        bh=Rm+gsKMf3KO4CSrmWZZZ6Qt7mfefNMHgflz9fS2JkAo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=wP/hR1x32R8oYqCqcOyN2YA3L2+cUlhbUR0AY37FUfA7bZ+JO3rlZkllmJW9qDPaz
         Tw77qBd90v9GvthlrvF/WFOqIfPYZH0wYfLUriEMP7iDEJ2df6sPWiqsyFdac+jW6f
         DEh0qrciafG3sqS+krrlSFSbrMcZZfz7J7d7yt/w3n4Gl4wcUVQvKWvkhN2Gd3MAJO
         4PLM63dYExq765hdOvdl3nJ0+SmeRFHhwB9Ld4Og0S1zX2BIEqdDcMhEVahsgUefPv
         a6eW28x+ttmq1GnISB9y9N2QktzKH3kMDnyW6Nw5/rJf7wWfAZqMHy1dnC7vTh/05Y
         Ujc5a0jdeMr3g==
Received: by mail-pj1-f70.google.com with SMTP id mj18-20020a17090b369200b0019ee38c4c6aso2168051pjb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rm+gsKMf3KO4CSrmWZZZ6Qt7mfefNMHgflz9fS2JkAo=;
        b=AR0dH803Pc2eeKcA6v9XPxYOdoGYME5ETF1nBuuZxOx8clKrVX3RpkLe8EXwKZd1s5
         Bf/lM7wZbvrtb0mPvqeDMBd8qv6wKJRwVYozf2slxfa+Olww60nQYCiAxdM0WgYTQ+K6
         cUNEcuLs/i+h1d8rC7HxuCcKlNInHQli89UAy5fzu+RwH8zHVmImZzig974ougqwlJCo
         MBjnNNE0Th5UF17Ia7YyKPf08jPOU1yKCwETgqsRUDGqc+81N7RNcM5oXLTGJhi0w2W9
         YWCCSpJMktvd7e8BFgMJL6P0AIrdpADnV7poi3wsVKVt5PjKe8L4KY8cc450kFW7gtGG
         p1ag==
X-Gm-Message-State: AOAM533gn7gYZb3VNbBWcdP9u4i0y68QOAnfB7pghIylMJiq/B+yfkZw
        msCKhm7ko6z46E0enonbgBzqpKCKoVbUc7dzi73tyy+KoeTYDnsUHy/i5cgb8ylP2DDIXVjCiYA
        r6hzB5LpJKRRi2R+V3zt7Xv4GNguOxWURDgNr8M4mJA==
X-Received: by 2002:a17:90a:4290:: with SMTP id p16mr7357978pjg.112.1632932763762;
        Wed, 29 Sep 2021 09:26:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzC22Ts07QZM3TqmbHY6TDE7TF4sYwB/o3/NJgExi9doWhLlJTT95Q4jxI32IZQB87N6iLNQw==
X-Received: by 2002:a17:90a:4290:: with SMTP id p16mr7357953pjg.112.1632932763495;
        Wed, 29 Sep 2021 09:26:03 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id p16sm293615pfq.95.2021.09.29.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 09:26:03 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tim.gardner@canonical.com, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: prevent NULL dereference in msm_gpu_crashstate_capture()
Date:   Wed, 29 Sep 2021 10:25:54 -0600
Message-Id: <20210929162554.14295-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains of a possible NULL dereference:

CID 120718 (#1 of 1): Dereference null return value (NULL_RETURNS)
23. dereference: Dereferencing a pointer that might be NULL state->bos when
    calling msm_gpu_crashstate_get_bo. [show details]
301                        msm_gpu_crashstate_get_bo(state, submit->bos[i].obj,
302                                submit->bos[i].iova, submit->bos[i].flags);

Fix this by employing the same state->bos NULL check as is used in the next
for loop.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/gpu/drm/msm/msm_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 8a3a592da3a4..2c46cd968ac4 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -296,7 +296,7 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 		state->bos = kcalloc(nr,
 			sizeof(struct msm_gpu_state_bo), GFP_KERNEL);
 
-		for (i = 0; i < submit->nr_bos; i++) {
+		for (i = 0; state->bos && i < submit->nr_bos; i++) {
 			if (should_dump(submit, i)) {
 				msm_gpu_crashstate_get_bo(state, submit->bos[i].obj,
 					submit->bos[i].iova, submit->bos[i].flags);
-- 
2.33.0

