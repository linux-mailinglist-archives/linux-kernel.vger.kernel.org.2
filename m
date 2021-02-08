Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79330314150
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhBHVIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbhBHUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:07:53 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5753AC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:07:13 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id j4so7580489qvk.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eP5/j98wp1t6sAqe5tfFmscgonRv+nQeEYYt6nNWAig=;
        b=zeKbPy4n3j+GckYgfzXgy3Jrr2u0TvsWN7EM6jmh9pZO27kf1AMRJ8hE5LWnec/b26
         6xzSTJlnmAjgEYi+f7SgeEyVERKXSduSd7w0B/MkglpXE5/c3OrcUCOVF1BRPqXuG846
         ehnDG5c/7/FIz1cZbEeChApXOFgrNz0BQXel62qTvjkWT9XscOcDWDwMTv2YgVBFDcef
         25NSdQq7PJ+SdvWqPKYDzdh+PV4Jycu90J3dy2xcQ9p9BB1nUMlxGvNsl8SgypctOgDg
         FC+3QcqlsKSBKjYr3z8oe5BJEOeUW7YIccMubT/oq5RvyWkL/EX34aENm8kaqT4plxMx
         WRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eP5/j98wp1t6sAqe5tfFmscgonRv+nQeEYYt6nNWAig=;
        b=lW9yyORBD75dCqWPxE4gC/UWza8M32bjxn1UrCEv+Xm4M9yDqioJLcdRAmyngbQhig
         +n8fisVDBdi4uLjjK3fgVAe6h5IEuBcnL3b1bi4nNS9wtMktdybZxplmKAqvGjp8b03C
         jLipyJHL4EZ26qOOvVIFFEMiOF8mOwrGaqqRc58dV3Bgobvmp6c2J7021yH53B+sTS4Y
         ryaIpZRTVOksOweQYQ7oVem27PB/s5bsidPh4wLDZn/zGbbLwWsUZ3OlgcCENQUbhwR8
         kmKg2T9bldY/U8jcBbqkCqoexl5/WbXeiuuOoronRMMvjlJyqL8ULEifEwxokHuhFCUJ
         8CzA==
X-Gm-Message-State: AOAM5306fEZZz4DDN14o869XiOS+SOXWb7B4Nr5bUmxY0lDAWjN2qhXl
        RMliN44QBtW0WH3xFiXZ8nH0Ag==
X-Google-Smtp-Source: ABdhPJyFOwdUIUyn/vUcIKbnbe01w02jVSNywGAvgPLr+K2tbQLcPm3G+qBjJsRptWcL06Al3DzeNg==
X-Received: by 2002:a0c:f114:: with SMTP id i20mr2404071qvl.20.1612814832641;
        Mon, 08 Feb 2021 12:07:12 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id x63sm1847433qkb.22.2021.02.08.12.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 12:07:11 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] misc: fastrpc: fix incorrect usage of dma_map_sgtable
Date:   Mon,  8 Feb 2021 15:04:01 -0500
Message-Id: <20210208200401.31100-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sgtable() returns 0 on success, which is the opposite of what this
code was doing.

Fixes: 7cd7edb89437 ("misc: fastrpc: fix common struct sg_table related issues")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/misc/fastrpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 70eb5ed942d0..f12e909034ac 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -520,12 +520,13 @@ fastrpc_map_dma_buf(struct dma_buf_attachment *attachment,
 {
 	struct fastrpc_dma_buf_attachment *a = attachment->priv;
 	struct sg_table *table;
+	int ret;
 
 	table = &a->sgt;
 
-	if (!dma_map_sgtable(attachment->dev, table, dir, 0))
-		return ERR_PTR(-ENOMEM);
-
+	ret = dma_map_sgtable(attachment->dev, table, dir, 0);
+	if (ret)
+		table = ERR_PTR(ret);
 	return table;
 }
 
-- 
2.26.1

