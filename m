Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BBC3571F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244147AbhDGQMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhDGQMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:12:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DEEC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:12:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f6so12495494wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aXJMkbHYuGwBccedw3JgWsefWKqhfd6TEzDaHSegUOk=;
        b=R1KnRH95esdS9oJngTJiNZ2CatqOweuDjwG7YueIAq4yybD/VqsfZ7XUCxLdZdV6E4
         EgCwKrBgJakPq7fABuDUdxThqaCjFwI+J0xkoC3TYzYF0De073O6zoat8QwcVZzCMG6l
         Qw8yzziCKkwuhe3bq1f6I2Cs3c0VMl26WY5EnMT9BstwjrQsRMCGIYBPBUBljreJ9upE
         +U8Fx16+sZxpq/7UNpd012yPcJ6kSHJAmeAnD+2CbXpGp1W8AqEsO8+HLlTNqXlp7Sk+
         yHNusFxLGV27vhSQcfcjfAlr4WwAry0e/9qLEkAAk4i/6McwwdFrKKVjsuT0gGdZfdn/
         laQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aXJMkbHYuGwBccedw3JgWsefWKqhfd6TEzDaHSegUOk=;
        b=bCSHgqw3aSytidkejTtsbUMhmddqgR0l0G7frGEx3FGC+8ny4e1DadssZ64L4PVjOQ
         Z6koXghtWswq+7y2gmSc7LGDSF8LEkvBgqt93+8l4Wq7WRC9IQEkHq12jZF8IbgysoPl
         e7e+urxXbxfR5LIaoKIJYNEktzUUAxHCr5BuKHwTY/4co603jWWHH5bdcqg07IFA+JFw
         Kv7gbxr5GD/gJifu9QBEh7oV29W96Xrwcii6h65PUgaNZ9+InxRlmrZqhgEKrHK1LKiO
         tEzc5tpkCJpLm2VVjastAFI7u1EsvRALfgMwvjnSuKotnJ1qny5FtxrpxI67PgFwpZej
         UJ2g==
X-Gm-Message-State: AOAM533w42zZKDYfKfmV56JeEV2dTn0dTi24Hau9T8+Wvf91jQDpU2TH
        2JvCM089GvvU43TqkLyGedU=
X-Google-Smtp-Source: ABdhPJyGIvPG0ARpLbeJXdpIZSUFIA2iFlDIsg3HEkuSdEsupu8NtfeJLY9X5lt1/1vMEkYcg+Eedw==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr5311147wrk.49.1617811927452;
        Wed, 07 Apr 2021 09:12:07 -0700 (PDT)
Received: from LEGION ([39.46.7.73])
        by smtp.gmail.com with ESMTPSA id w7sm6211481wro.43.2021.04.07.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:12:07 -0700 (PDT)
Date:   Wed, 7 Apr 2021 21:12:02 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>, hverkuil@xs4all.nl
Cc:     musamaanjum@gmail.com
Subject: [PATCH] staging: axis-fifo: remove redundant dev_err call
Message-ID: <20210407161202.GA1505056@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource() prints error message in itself. Remove the
dev_err call to avoid redundant error message.

Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 2bb1c2e9cb57..ed9281089738 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -853,7 +853,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	fifo->base_addr = devm_ioremap_resource(fifo->dt_device, r_mem);
 	if (IS_ERR(fifo->base_addr)) {
 		rc = PTR_ERR(fifo->base_addr);
-		dev_err(fifo->dt_device, "can't remap IO resource (%d)\n", rc);
 		goto err_initial;
 	}
 
-- 
2.25.1

