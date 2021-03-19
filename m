Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A31341775
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhCSIZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhCSIYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A1EC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hq27so8275090ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yFPCpC+KcvysSHE/TzUxgB6C7mqpr36eNkZECpHJ1c=;
        b=OnWV+DYxB7TIf0RcdNt2mExHUJuVLp7UESXt8Qb+D65Bvf9Soff5k4j1Aw+lyaG+uK
         6pxegFZ5yiJ/sQ015s2er7qRKHqyFTxcQDdNd6KVVNiTWMaHgOqIASU7rsQw1w3Lsq5P
         uvuhgiTLupa06Vhn73WRiQetqx1HNcZBrV5fJg+aycceyxeb5AjvfTKyTsiT2izx5NRk
         sCDZZbUaXVIDlH2kp6prNzo3YGzhrOXl1IMx5ZR0N+9BdgW9fEsNMxUB2IAsU1HHaz1G
         MfrsxU0yzKgM772hKAc1WwgFMvta8vy4xrPRFoYTf9hJfm/Edz8GZeFvd7wH5hrNUb3W
         27ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yFPCpC+KcvysSHE/TzUxgB6C7mqpr36eNkZECpHJ1c=;
        b=b6D63f3FG0hexOYazRiN/RwmuIocyb2SgOyFjRnp1GukSCF70KfSNDDd81EssFlZf0
         semrOQqq409yvW6iGhxc15av6JbkoPOzy/4WN0OSWzG+G9u1cDW0NW4CnHjcLf2nXwbF
         /3rU4oWE3Y1RsPRq4UwBwsfJ7n5QS3DuueM3/5218ENWsZcny0sHIwj7EQSE625hguAw
         7ScobPfnGa2C2iRlC4LX/NLqmkbEH/kYIzquVBElIdckEguHWWH8i4opAjy1j4ewDR7G
         m3KXfgyfRMoJrxQP+MjiKwQ0JDfcDQ61HpR0jA3KQbnDhyfRfbXyNm1oPt7u4Q6IwHIA
         zTYg==
X-Gm-Message-State: AOAM5335PdehxrcFbVuFs2g14t4fSFBimr8Sm32zWoip7FljuLqV4hD1
        WeEfV/Nsr1okyIoyqP5G7QSiig==
X-Google-Smtp-Source: ABdhPJwnlGUjC/O4z4se0Ihju3NYtfJbBY/F+E6dbieSY7h3pOd75jAO65tz6uyrZ7HGsTDpXyp5nA==
X-Received: by 2002:a17:906:7c48:: with SMTP id g8mr3071902ejp.138.1616142285858;
        Fri, 19 Mar 2021 01:24:45 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 14/19] drm/nouveau/dispnv50/headc57d: Make local function 'headc57d_olut' static
Date:   Fri, 19 Mar 2021 08:24:23 +0000
Message-Id: <20210319082428.3294591-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
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

