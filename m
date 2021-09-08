Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A12403428
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347714AbhIHGSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347701AbhIHGR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:17:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05156C0613D9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 23:16:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i24so1027003pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t326ukayDkNK+rInLGvygXBSQMBOdWFnPHaxte87M+E=;
        b=aZnUi3gU92sRkqR7q5q3DONWNupExinn4y/WaYDXhpLYKWKr5OdlN/fkMAWFkrflhP
         UnC7QgTkEco8s+WWq9E6EjZlE3NoBgcawU+Ax1ZEaEDxAItomc2K4TuY8xgsYN1jCI52
         OqCt3S45tushW8jQfA9EweFPPfMW1yKEwsY1qef92fPuXcrYSr/wD+G2kcRF879d9ihF
         ZhX04yzR79MOJE5UelBfyLX45caSitc1K4J3k6O31JRktnvi/ZWk4JmkPRduVwzOlFHx
         2sdSsiPaM8+GIQlLMFqgFhHvTVkJeUkDuD6k1ZoaaP18gO82NwUW+jSn5gIZVatgsV59
         GOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t326ukayDkNK+rInLGvygXBSQMBOdWFnPHaxte87M+E=;
        b=QArYKZAVgxcKGca4m0VNsSAQY8L/PDLqs3yL8uhMqfRcRYKTAXEtEHTnekFFV+qws9
         Nld5qVvsLa9JMIYiG6/zMexEEJxUDw70hYG7KFq7hH6SSRoBUAk8qfoc6srJ3Gd7FCCQ
         xexoXn/Rvdm2U7cnMySHn6L//kzXhWSLijPhzKunxyLY99MS0jxu04eTjdbUThDP3RCp
         GJIJ0QwYK121L3S+9ER+Aogka9xjtJPovAN3lD1+RINBFhdTKAP6wlRStr6P5zZFELQj
         Bv1gDji+7L079SvrfDyi+BOY+xTalCgDD/uc+u94JGLwzMET+hMxYmL26SsnSyxnHinm
         g13g==
X-Gm-Message-State: AOAM531/k1fweszdRz0GoOF65dfmUKDN5aOCX0ffkjgDyaOHXjMWkQtu
        pEeV/nqygxTgdv3f+FgV7yAQ2Q==
X-Google-Smtp-Source: ABdhPJx6JwVjc91ZM1FGjBMsTgl5ytdnlFm870wu6IIJD9+4A+LbZB2ac6mZqeo76XmRtRaMVFTdMw==
X-Received: by 2002:a63:4f17:: with SMTP id d23mr2110849pgb.253.1631081803639;
        Tue, 07 Sep 2021 23:16:43 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id n1sm971730pfv.209.2021.09.07.23.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 23:16:43 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        dhobsong@igel.co.jp, taki@igel.co.jp, etom@igel.co.jp
Subject: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma device
Date:   Wed,  8 Sep 2021 15:16:09 +0900
Message-Id: <20210908061611.69823-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908061611.69823-1-mie@igel.co.jp>
References: <20210908061611.69823-1-mie@igel.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To share memory space using dma-buf, a API of the dma-buf requires dma
device, but devices such as rxe do not have a dma device. For those case,
change to specify a device of struct ib instead of the dma device.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/infiniband/core/umem_dmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index c6e875619fac..58d6ac9cb51a 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -146,7 +146,7 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 
 	umem_dmabuf->attach = dma_buf_dynamic_attach(
 					dmabuf,
-					device->dma_device,
+					device->dma_device ? device->dma_device : &device->dev,
 					ops,
 					umem_dmabuf);
 	if (IS_ERR(umem_dmabuf->attach)) {
-- 
2.17.1

