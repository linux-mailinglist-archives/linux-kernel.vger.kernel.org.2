Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C27034F739
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhCaDLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhCaDLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:11:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5363DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:11:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso487372pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vU9HbwbthLUaj/LqMMXz7Dv8hZu6/bR2kD4Hj5E8m94=;
        b=b6ROv1nVdxSjX9x91A8nrvM3NZaD5aEJKUAUFzAjUFU6x0dX0xV9MNfqpX9OyIQKuA
         XPgfnxSE/hQ7tx1kwX0f0mcMEo1BZIzUXoreKQlTVwJcJ+L/fGbrs0HjTY6TNC3cpI7h
         TDUICwoiBqV0SEQ3SpKNsgLF6WtVw5/2OJooJ2W6dMqzxdrh9iA88yY1siltCPovFhLw
         8tA1EGiBsa5bqEMHYwbmjAuKOctc484Orxg1aPydq1zbNQDWo+x/O+1yQuD5Bq/7o4GV
         9nDvWxhA4l9PNmrxMe1PXZ0gcxF32zY0e2FsfCTfBOhyOnSHIX+rih36Q2fV5BzsfNs8
         6/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vU9HbwbthLUaj/LqMMXz7Dv8hZu6/bR2kD4Hj5E8m94=;
        b=ulqp2ZusokoVPc73FQiSzIAHzACa3G2NZ/CGqjPMmw1Yvv/QTuxkRzTVMVjtvWa3DV
         7yI6aQ9hMehKvp2rXM4vv76fXZDual6ph0OXM4L8QiwD/rqXxohNfYovVswDr1RrsFEI
         32vFnPJ0aXeX7Ec786faEnjFm5TMMKGuWDUna4+QxUpYrTui/Lsf7/eUntzSVLqKBzqf
         alVIz1ej0fPIeV+gxhZTpyn2tzYAqYW86WlEbMHLgEdnp8ocaxOWNNR/WK8XiqXMqr/w
         WckA9ZNnxSe6Drb8LafS7PeIdIwhcUfqeNHfrWc5irI5fjAn9/X0ga4iQqTOZvrpC0Ir
         0imw==
X-Gm-Message-State: AOAM530i0VV/5sGlC079EgdquH5SwjCtDh1gtIbLYCClT5HTFueo4/wX
        PAd8awgtwLw3wDEVIA0LOZk=
X-Google-Smtp-Source: ABdhPJyqWfU6dlETJUhNEIvqgNXHw6SRIidnojwc02/kI9tyVrHUuGEGKwxN7WKN1FX7LhHtVF/ixA==
X-Received: by 2002:a17:90a:f286:: with SMTP id fs6mr1376656pjb.183.1617160282017;
        Tue, 30 Mar 2021 20:11:22 -0700 (PDT)
Received: from localhost.localdomain ([67.229.84.74])
        by smtp.gmail.com with ESMTPSA id y8sm418364pjb.11.2021.03.30.20.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:11:21 -0700 (PDT)
From:   gexueyuan <gexueyuan@gmail.com>
To:     krzk@kernel.org
Cc:     linux-kernel@vger.kernel.org, gexueyuan <gexueyuan@gmail.com>
Subject: [PATCH] memory: pl353: fix macro definition of ecc page_size  for arm pl353 static memory controller
Date:   Wed, 31 Mar 2021 11:10:56 +0800
Message-Id: <20210331031056.5326-1-gexueyuan@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    the macro "PL353_SMC_ECC_MEMCFG_PGSIZE_MASK" should be 0x3,
according to  the datasheet of pl353 smc

Signed-off-by: gexueyuan <gexueyuan@gmail.com>
---
 drivers/memory/pl353-smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index 3b5b1045edd9..9c0a28416777 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -63,7 +63,7 @@
 /* ECC memory config register specific constants */
 #define PL353_SMC_ECC_MEMCFG_MODE_MASK	0xC
 #define PL353_SMC_ECC_MEMCFG_MODE_SHIFT	2
-#define PL353_SMC_ECC_MEMCFG_PGSIZE_MASK	0xC
+#define PL353_SMC_ECC_MEMCFG_PGSIZE_MASK	0x3
 
 #define PL353_SMC_DC_UPT_NAND_REGS	((4 << 23) |	/* CS: NAND chip */ \
 				 (2 << 21))	/* UpdateRegs operation */
-- 
2.17.1

