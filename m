Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F168132BE73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574221AbhCCRWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442503AbhCCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95AC0611BC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b18so17252481wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yFPCpC+KcvysSHE/TzUxgB6C7mqpr36eNkZECpHJ1c=;
        b=b8s1GADMy3KCr1xBwRkJxqrHKcPwaqZuz/sooEbpFBd2wLj+LQxrMwWz3TBw/Vlja7
         9WlmxMg3FND6FswMAyNnsSIunYjTbwzz3+KFzk9Rd8fwcKLsPbG3JWLJ57I6S+zBV8uw
         N5LxB9/i1sAnWt65VqWTe3+gddF+brZb0ZhOl7kzIzYGu6ErsNhO02pFM6qk0r/JPqGx
         PQ59WcXnAdN6Al+FNN0k/T6klL5epStV/txWxabOxawEY5hEM3Ir+uhkuDsngHx2eeod
         4vdzgdGYV6/hW/g0s46y8B9nkF0v3AdxgmJWsMn/VnDTuOXSn+yweuNGiBmmEFVB5HoX
         eMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yFPCpC+KcvysSHE/TzUxgB6C7mqpr36eNkZECpHJ1c=;
        b=QOcuwUsurw4A6n+CjmWudF3Ok3xRLOJEQnCUSd9YQEdHOhwrZ6GsRsEvj633u4g6Xz
         1niknv6pWrw56Glz05SIwrd0oc5sJWMS1z2rlUe4pjZPpsBhniH+qrEp/Y8ajXOBPPo2
         8D0/QBG71D9wIbQ1ADm0eYaWEAKxwuTc2zZM/zPcRqHNuScf3ePVKUhqXcVqgYH7ys5m
         IYkwg+Dq9SvkVKXQ8b2vnSCTzn9Hc+Z2knFQiZ+0u5srv3+aCva6e8JvGEi93njMajLr
         189b22yAuCxk1TOwIz+P7OTzE2t+bmbDqEZxv+wJuVM83QnuaNseyXf1rvFn/21cZyki
         VfEA==
X-Gm-Message-State: AOAM531fhZJhjH6NEmdPyNaQdR6xsmLHfWNppKA3dGje8CoQTepypZHj
        vlrdghfjG6yDjU8p1c4AHZnyhA==
X-Google-Smtp-Source: ABdhPJw8poGH42pSfanQCsguNS4B/QAleU7GHwRIqu0RlxmsWTz/8hZAQXuIPpPcZu9zagNyWVO7aw==
X-Received: by 2002:adf:fec5:: with SMTP id q5mr16913767wrs.43.1614779028142;
        Wed, 03 Mar 2021 05:43:48 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 17/53] drm/nouveau/dispnv50/headc57d: Make local function 'headc57d_olut' static
Date:   Wed,  3 Mar 2021 13:42:43 +0000
Message-Id: <20210303134319.3160762-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv50/headc57d.c:173:1: warning: no previous prototype for ‘headc57d_olut’ [-Wmissing-prototypes]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
index fd51527b56b83..bdcfd240d61c8 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -169,7 +169,7 @@ headc57d_olut_load(struct drm_color_lut *in, int size, void __iomem *mem)
 	writew(readw(mem - 4), mem + 4);
 }
 
-bool
+static bool
 headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh, int size)
 {
 	if (size != 0 && size != 256 && size != 1024)
-- 
2.27.0

