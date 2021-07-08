Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641DF3BF855
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhGHKY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhGHKYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:24:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB164C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 03:21:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o22so3770034wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 03:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zsTyfulO0N33vAWpB/Tf9AM50ddHjz+fMYwTZ8ZdAwk=;
        b=qbxGC4XBwQVbT/M9kkpQzQP+yT30ivlTjEfT/UIJtZaS9/YsvwbLLaWx/zei1qqzZD
         cD/P4R/y7mpcrK82FV47Nlhbz7dDtvLfEYQnQuo8px1WKtgzPj1g6tgdGdzcqbxN+MLt
         +eS1Lv6CvitNGhI+3CF6IuloVPDLe7Ttq0LXG7I514VDLX0GXkUZjv6J4hMLM58rUTuA
         V+QWjgaNjkt6nFMpp8Gsx8KTkEMTuDhehvc9jIviinAcHT73zSXZiJaHKStukWvHUoyc
         fQvNlqrrkHO/PRW8vWipEnELDjIlE1i0Zyd6/lekcOcjLM/lcuqh7BWxOZ1XnOLbXNFB
         zliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zsTyfulO0N33vAWpB/Tf9AM50ddHjz+fMYwTZ8ZdAwk=;
        b=PoTDA3+tjTGRWgkoqbN6IYSWijX3ixwQE5O3YdfPKnR9TruVDzIY7MeFANhM0WsV9+
         z5SJ1+eCu25OZsLxzt+/CG43Qk9MDEoSABqgn9FHZLNZc/mOCCAXNBforzDBSbFmBM9m
         heQVv5FiKH3KYz1n3vT1sdzO9wVk1lJtFudNEJhxhmt7XJxZ6cIEbJHFKHU/4Y6Sdove
         2SbKbfIhCKNoqBBPCdLgtRWr8Xy6IgVs9IDcMUn7sfJZSd6hqvGsJ0e3wrzzA3F2Ad4O
         ZhazMAu720L08teIKnHprLSzKINUZKOFCnMIX6sidKakc1FIuTsqZdja8Fw6LrEOT0ba
         3xIg==
X-Gm-Message-State: AOAM532Rul2jcGykLO6dTityvx4XjfnPd10a3woFRVQzL1u635KQrfui
        bUS6objJG2K9P0P3YGci9JsK9vvw/FfT4TSz
X-Google-Smtp-Source: ABdhPJy9ai0PSwzqjslrnDf+4nRxGB8/uDPhov5IdjmV6z3pH9xafOX/dkTYDlL0T7TSjXdUuS4SXg==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr4435760wml.107.1625739702255;
        Thu, 08 Jul 2021 03:21:42 -0700 (PDT)
Received: from linux-dev (host81-151-110-100.range81-151.btcentralplus.com. [81.151.110.100])
        by smtp.gmail.com with ESMTPSA id v1sm1921607wre.20.2021.07.08.03.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 03:21:41 -0700 (PDT)
Date:   Thu, 8 Jul 2021 11:21:39 +0100
From:   Kev Jackson <foamdino@gmail.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alasdair.mcwilliam@thehutgroup.com,
        kevin.jackson@thehutgroup.com
Subject: [PATCH] mlx5e: Correct order of closing qs on error
Message-ID: <YObRs9tjVfGb9/Jn@linux-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to open queues for a channel, on error the goto for
mlx5e_open_rq and mlx5e_open_xdpsq are inverted. This could lead to a q
not being correctly closed.

Signed-off-by: Kev Jackson <foamdino@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a836a02a2116..bf12a7790fac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1858,21 +1858,21 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 
 	err = mlx5e_open_rq(c, params, &cparam->rq, NULL, NULL, &c->rq);
 	if (err)
-		goto err_close_xdp_sq;
+		goto err_close_rq;
 
 	err = mlx5e_open_xdpsq(c, params, &cparam->xdp_sq, NULL, &c->xdpsq, true);
 	if (err)
-		goto err_close_rq;
+		goto err_close_xdp_sq;
 
 	return 0;
 
-err_close_rq:
-	mlx5e_close_rq(&c->rq);
-
 err_close_xdp_sq:
 	if (c->xdp)
 		mlx5e_close_xdpsq(&c->rq_xdpsq);
 
+err_close_rq:
+	mlx5e_close_rq(&c->rq);
+
 err_close_sqs:
 	mlx5e_close_sqs(c);
 
-- 
2.30.2

