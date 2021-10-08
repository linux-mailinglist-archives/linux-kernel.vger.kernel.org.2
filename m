Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9D42689D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbhJHLWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240447AbhJHLWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:22:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670BAC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 04:20:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so7596691pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=9lO276wIMhh4FqI4kuDPYPf5UGxyINlwwJai4bRIJN4=;
        b=NDvLhFA7NEbl3MKRLemxLPPIkH19wT3blVgHRAB/Pz+O+Q4JzWKbT6ihElHxNYSgZr
         y3I7uRVU+fxmHUQDef6qMndsv7kh3KTF/MHyYGZ4UTgk9287SIQO9Pj7/oqXCJqZsi8l
         UTBgj4FAXfmHg605pWC+uMAXUyUhsuRlnDzLYDGTo/U8I4MX6V/AdkkmU5s2g4pMlxut
         WdUDIX/S5+hXZxg+t7yCdLnlFXQXGocyUYWGnCMRBkok1JawGjSvDE8QApVH1iVU5qxW
         qKS6DWGCGScjKzixhBFKwdvH1E3r8tmZnLZxs1eEZdrlOO0HMPgx+eOT1Y1ZnSGtYncC
         d6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9lO276wIMhh4FqI4kuDPYPf5UGxyINlwwJai4bRIJN4=;
        b=S2IuDOt5uXI53slWsmgcxBKHN+74tKx6MakVCHzmLbKMSZ4oJ0JrVQb/5Tb8L5/LST
         oGl4a86Gqf2MbkylSJeEEa7iJrqlYYq8Vajv0ZKsRRqN66GsUuuYl5nQ+GwqmFSd05sD
         7P8oizscb9+V89MrHNfmpWQOQX78JlL4xTS1wTjp+H9q36lPI0WtptnJ1L7TQgerPOzA
         EbqVn3IFjB1S/97loGT/E76LNZbEguUgO5aBd288wWsLC9hGQ7/2bz6rCCHiWz18r6rB
         yPv3cud0V575dAIDeQy2TQX+Ku6GE6qpvGglnuiEraJ63S9XRG9YcD/sYPpJlB/NTbQv
         bo2Q==
X-Gm-Message-State: AOAM530Pppxrhvlkithh7eTUz5lAAnkmKkOUjwIAstY20k/UFje5Vjjq
        oX7zCSLqU8/uKv5gxsPKhA+Pag==
X-Google-Smtp-Source: ABdhPJzJjPsiSxRaq/tNhUgnovpywMMR+S13s4qXRW1prEypz2cDRITZLFPyXUPbKfcExpbwpPOjfA==
X-Received: by 2002:a17:90a:4b47:: with SMTP id o7mr200773pjl.198.1633692016603;
        Fri, 08 Oct 2021 04:20:16 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id y18sm2490089pff.184.2021.10.08.04.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 04:20:16 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     mie@igel.co.jp,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf: Update obsoluted comments on dma_buf_vmap/vunmap()
Date:   Fri,  8 Oct 2021 20:20:09 +0900
Message-Id: <20211008112009.118996-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A comment for the dma_buf_vmap/vunmap() is not catching up a
corresponding implementation.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/dma-buf/dma-buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index beb504a92d60..7b619998f03a 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1052,8 +1052,8 @@ EXPORT_SYMBOL_GPL(dma_buf_move_notify);
  *
  *   Interfaces::
  *
- *      void \*dma_buf_vmap(struct dma_buf \*dmabuf)
- *      void dma_buf_vunmap(struct dma_buf \*dmabuf, void \*vaddr)
+ *      void \*dma_buf_vmap(struct dma_buf \*dmabuf, struct dma_buf_map \*map)
+ *      void dma_buf_vunmap(struct dma_buf \*dmabuf, struct dma_buf_map \*map)
  *
  *   The vmap call can fail if there is no vmap support in the exporter, or if
  *   it runs out of vmalloc space. Note that the dma-buf layer keeps a reference
-- 
2.17.1

