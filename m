Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E3458457
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 16:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhKUPKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 10:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbhKUPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 10:10:07 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5701C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 07:07:02 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso10549322wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 07:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ireVUEQ1JdY574A92LABnjnF9+5/Z04T/SgwrrF3zJM=;
        b=HyXVrJCn4Dx4RSEXKzrHp0ZSEgp9dneVWylNXZ5R/7+m5eIZa5TM8Ad7DNipV4IFXz
         C0aRNyCYawLIASmVBN6sFd3y6udZO2UJ70yq+ogByM93ex1n1DaIjHZg0MWl81jWISBq
         CeNPi6XUSpszw7UYr3XQfKgntyVKnpvEtfjGhwhLcgEJ5TFdfvGbbuI1Z0qiNlQyzUye
         9dLLj9ca206gFbn7UUMqkJ/8p8TKoVrnH13/Y7g2xX5snctpbKpPfkV8a336n+Qrj9o+
         76P251IGR655ykP6V1UZz2p6iFRBIHRkeJy29z7eCvGcxC31TXYzmAzdJ/2Wxt5O72op
         D1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ireVUEQ1JdY574A92LABnjnF9+5/Z04T/SgwrrF3zJM=;
        b=J71jgxqHe8CQx2X2v5ndeZ9FaJnggB9bZL0sUe1IV3GcNpH07ZGGVUdrNWJune7Dzg
         ckVwLYyFjEKAeN5jmf1JWDG9o/wqXNpv8sIcI57bEiCkViiG4JQt0UwJa75CCAX0eJEz
         Oaee6uAFJH1okm/9X5vo6uWxRNuFq5uWGfZNtR+aAo/dEM0X1xDfAVo5RFkILTfhTryi
         QwpBYU44YZVFaEbBaNcb6dx1h4/Wj7ZY8fhnhllNMtuBP0jPvVBqD+7A4KRHV2k8E5vv
         Mf8M2wldk+zlp3MYOj7SaTdrfLEKLEp2qcIo+tUQksfcByqcA63wVD1IR5TVB+orBfkY
         GM2w==
X-Gm-Message-State: AOAM532coZytHGGt3cCiUdZpvkdimk2Z0B298pgucUcFr0ZaqYGya6T2
        Bl1BQ17pQcD0mvaFdUpFABLcQ+I2RZUWy/MD
X-Google-Smtp-Source: ABdhPJzTo0C6KTgAHEEIrV/TjDrr2RcxUfwPcPpOOfg5wT/hQMwYIHEhL4PAm45A8YTbuxG/js4VFA==
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr20101260wmj.179.1637507221371;
        Sun, 21 Nov 2021 07:07:01 -0800 (PST)
Received: from localhost.localdomain ([41.140.209.54])
        by smtp.gmail.com with ESMTPSA id n7sm5988588wro.68.2021.11.21.07.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 07:07:00 -0800 (PST)
From:   Nour-eddine Taleb <kernel.noureddine@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nour-eddine Taleb <kernel.noureddine@gmail.com>
Subject: [PATCH] scripts:extract-ikconfig: add support for zstd compression
Date:   Sun, 21 Nov 2021 16:06:58 +0100
Message-Id: <20211121150658.113192-1-kernel.noureddine@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update the to accept kernel images using zstd compression.

Signed-off-by: Nour-eddine Taleb <kernel.noureddine@gmail.com>
---
 scripts/extract-ikconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/extract-ikconfig b/scripts/extract-ikconfig
index 3b42f255e2ba..5cbf6f1d7f56 100755
--- a/scripts/extract-ikconfig
+++ b/scripts/extract-ikconfig
@@ -62,6 +62,8 @@ try_decompress 'BZh'          xy    bunzip2
 try_decompress '\135\0\0\0'   xxx   unlzma
 try_decompress '\211\114\132' xy    'lzop -d'
 try_decompress '\002\041\114\030' xyy 'lz4 -d -l'
+try_decompress '\002!L\030'   xxx   'lz4 -d'
+try_decompress '(\265/\375'   xxx   unzstd
 
 # Bail out:
 echo "$me: Cannot find kernel config." >&2
-- 
2.33.1

