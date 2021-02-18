Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1390931E483
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhBRDXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBRDWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:22:49 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7181EC061797
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:58 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z190so873065qka.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSI1YK22wVuR2cagA4S8zvgCNzwItAWuuGlBLvaCabA=;
        b=Ee9uWcHbYZ/XoNjoLghk5DqzMTTsO5R0FEyXVspDfgWglsCCSU0wNy2jPM2MRZI5YN
         Z8h3Nw4cjXeuikgrXXwv21Lhhy7kkvW7GcdV1skq4J2Bc8JEAJkTlBtbO2cub/hLsne7
         A3dlQxGCDeyo/35848lBA+kmUkfVDU1+eCvs0yWx4PWS7k+qX16ywZzPv4Jqq9SQN3RA
         Ya40EAT+kq1c6Vxnawy6EbGCcUamjzxQSSZ5tfPXq0RuboF1gnwMAwm6eyBiyC79gY0w
         sRgqUuKN2pkbDhyFE+IMsYfVlzphLRd633mGj8btBgHyIaiGwR/mJFXjOOLZ8dTjmud9
         9tQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSI1YK22wVuR2cagA4S8zvgCNzwItAWuuGlBLvaCabA=;
        b=MS9vBBHrTRa/yAoi4IqgYXMnpXnTJ1OjXp0A3F1e2bjlBwQxkS0iMWkjg5D//yRT1C
         0AkcsPt1S3sqY9QyLnSqgc8fW7WfZhjcfdTSmkVsXm6SZ2+pK0ahcKKVJh/fcSJB4Rs8
         yMOQ9BXsH5K7Tor2ZxDyjURxLohRtizCmcq3io0vK6MpG9x4PrFsQp4mFnVLQsTtACzw
         a0h4ARbQ+JE/Zx4qL/0waDJW4FGoHY1QIWA5ESiFJTOv92nqDJFFRP405DFlqbZtvTsq
         mBKkcpDzukiR82pswrA27QTSLfggPs0nceAPnLvM886wPV/OaAYfk9Wb9fMqZdThmli1
         tdEA==
X-Gm-Message-State: AOAM531EAH34evdVgSGdLBS7ixI6DL3NDiILwZbL/CrG8PeIgkchUF6K
        jQA89IaI98/6avyhQ5zZrxMttQ==
X-Google-Smtp-Source: ABdhPJypn+BPGnzJlyewntbL8yFgi8ngaSIdwBUoRtPVyVgyvud/hvwvhvE7UQ6AltJeZtsspUXdHQ==
X-Received: by 2002:a37:63c7:: with SMTP id x190mr2439873qkb.189.1613618517770;
        Wed, 17 Feb 2021 19:21:57 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id b24sm2578996qtt.44.2021.02.17.19.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:21:57 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     srinivas.kandagatla@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] fastrpc: remove redundant fastrpc_map_create() call
Date:   Wed, 17 Feb 2021 22:20:55 -0500
Message-Id: <20210218032055.28247-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210218032055.28247-1-jonathan@marek.ca>
References: <20210218032055.28247-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fastrpc_internal_invoke() will call fastrpc_map_create, so there is no
point in having it called here. This does change the behavior somewhat as
fastrpc_internal_invoke() will release the map afterwards, but that's what
we want to happen in this case.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/misc/fastrpc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 170352b43ab6..ccad9f5f5e2f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1013,7 +1013,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	struct fastrpc_init_create init;
 	struct fastrpc_invoke_args *args;
 	struct fastrpc_phy_page pages[1];
-	struct fastrpc_map *map = NULL;
 	struct fastrpc_buf *imem = NULL;
 	int memlen;
 	int err;
@@ -1049,18 +1048,12 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	inbuf.siglen = init.siglen;
 	fl->pd = USER_PD;
 
-	if (init.filelen && init.filefd) {
-		err = fastrpc_map_create(fl, init.filefd, init.filelen, &map);
-		if (err)
-			goto err;
-	}
-
 	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
 		       1024 * 1024);
 	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
 				&imem);
 	if (err)
-		goto err_alloc;
+		goto err;
 
 	fl->init_mem = imem;
 	args[0].ptr = (u64)(uintptr_t)&inbuf;
@@ -1106,9 +1099,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 err_invoke:
 	fl->init_mem = NULL;
 	fastrpc_buf_free(imem);
-err_alloc:
-	if (map)
-		fastrpc_map_put(map);
 err:
 	kfree(args);
 
-- 
2.26.1

