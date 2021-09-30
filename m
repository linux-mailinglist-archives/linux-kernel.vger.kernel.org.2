Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4990341D8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350520AbhI3LhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350459AbhI3LhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:37:16 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A74C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:35:34 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t189so6834922oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=B3Fs1aBIXktvYLGb2TVUnCvr2QaRY0CbNTHUGXHt+HU=;
        b=iQEIwj08+MJhPX4gMi8OYV39VoxE8yvKN7UeZCGVdoIOyTFhg7v1jKLTWhpxS/LGEa
         7u8RbcSg8ITkenlIUFsQV9jR77J+T1yO0PD//7sixR9W5XttQlGf+eEjUpdVHnTeUT1X
         VW/JwX1qhJ8jLIdxu5P666VS8Jv0HmckvGOlyyve+dAlF0rL529sXKvj3FTkfwYI9klU
         9KGNLPLSOA68dAFZI76dTdob39g9ZzyKxvJdUR62l7wAg85ZE0zZMggcpfTC9Z9bqV0B
         ysPpmLloPlLNzSVmKH/P2BZYrlA2Ez1NboIiGlITipDhm//ckb6JM/cK/o2Zi5ele1Yg
         AkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B3Fs1aBIXktvYLGb2TVUnCvr2QaRY0CbNTHUGXHt+HU=;
        b=P4WtJZoA4cprrShpZLgGIQqhpgQwu1qvergIowWJTP4QVk9CdgU8iCuCDxplzyIqtA
         6dcqsi/oyPfs6WQlpx7egLG5qaw3QiYXY85bhXOc2hBK1QoeU4dRzg66+BkM9GCAiCve
         oYawgQGbRVhNuXhY59JhMoln54mJVDEIRsG9o7sdzDYiK6VJJs6VyPE4/+32oihWUZ/I
         qHIoxkEnqZrLsXkzZ3eRgSKIsH1UF2eMO1xzRrgNsq0uwbMQrIOQKLJKs9+igMHychXm
         i6yPQ0ziPgLNRK73UyktEvo7pUJOHXxo2Gdalpa7WhDYGmY+p5ypy4zVBrX15mNCT61D
         lNLQ==
X-Gm-Message-State: AOAM530wd9oWkK8It6x4NoBcZfv1cLCKGRdVdx11XAgL1PzbaGZhearA
        Kmod7DxUCQz9GhHeUn80+2jjNg==
X-Google-Smtp-Source: ABdhPJy5INDSJMlJcQdd5j2HBzFLTf88QFIAKmhJeAltP1c0EkyTOgER3wGh4aS89zWNpeSV1HyCQw==
X-Received: by 2002:aca:32c2:: with SMTP id y185mr2335719oiy.47.1633001733390;
        Thu, 30 Sep 2021 04:35:33 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id k4sm500053oic.48.2021.09.30.04.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:35:32 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp
Subject: [PATCH] Provider/rxe: Allocate rxe/ib objs by calloc
Date:   Thu, 30 Sep 2021 20:35:27 +0900
Message-Id: <20210930113527.49659-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some rxe/ib objects are allocated by malloc() and initialize manually
respectively. To prevent a bug caused by memory uninitialization, this
patch change to use calloc().

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 providers/rxe/rxe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3533a325..788a1bbd 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -104,7 +104,7 @@ static struct ibv_pd *rxe_alloc_pd(struct ibv_context *context)
 	struct ib_uverbs_alloc_pd_resp resp;
 	struct ibv_pd *pd;
 
-	pd = malloc(sizeof(*pd));
+	pd = calloc(1, sizeof(*pd));
 	if (!pd)
 		return NULL;
 
@@ -225,7 +225,7 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	struct ib_uverbs_reg_mr_resp resp;
 	int ret;
 
-	vmr = malloc(sizeof(*vmr));
+	vmr = calloc(1, sizeof(*vmr));
 	if (!vmr)
 		return NULL;
 
@@ -382,7 +382,7 @@ static struct ibv_cq *rxe_create_cq(struct ibv_context *context, int cqe,
 	struct urxe_create_cq_resp resp = {};
 	int ret;
 
-	cq = malloc(sizeof(*cq));
+	cq = calloc(1, sizeof(*cq));
 	if (!cq)
 		return NULL;
 
@@ -594,7 +594,7 @@ static struct ibv_srq *rxe_create_srq(struct ibv_pd *pd,
 	struct urxe_create_srq_resp resp;
 	int ret;
 
-	srq = malloc(sizeof(*srq));
+	srq = calloc(1, sizeof(*srq));
 	if (srq == NULL)
 		return NULL;
 
@@ -1167,7 +1167,7 @@ static struct ibv_qp *rxe_create_qp(struct ibv_pd *ibpd,
 	struct rxe_qp *qp;
 	int ret;
 
-	qp = malloc(sizeof(*qp));
+	qp = calloc(1, sizeof(*qp));
 	if (!qp)
 		goto err;
 
@@ -1659,7 +1659,7 @@ static struct ibv_ah *rxe_create_ah(struct ibv_pd *pd, struct ibv_ah_attr *attr)
 		return NULL;
 	}
 
-	ah = malloc(sizeof(*ah));
+	ah = calloc(1, sizeof(*ah));
 	if (ah == NULL)
 		return NULL;
 
-- 
2.17.1

