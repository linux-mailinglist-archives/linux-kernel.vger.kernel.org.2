Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B829393FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbhE1JZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbhE1JZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:25:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:23:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x7so2544849wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TwMyPkR/HrGeug9rCbGLeSJ2vnl7bZJ0DCKVLG9Ypyc=;
        b=J8Lj7U8EZ5U8MKsYVH7RIa3SL46Pw/YP5YcKyxf+szx49EVWejoX3yo+C7WBesmM2p
         /7mn4Nv4R4tJ07vrWSXoIFQECVsMx43AeO7JeMGlz90YJ0sQXiNlyS3zacMCYdrR1LXt
         /xCSEJcgB2iPGRhxcLiPQzM28XrwZaJLeioPaTHPHb0xYAqmf+w03xq0xkxdhIEUbBuj
         9AC595zMs5V4SfIz9NfUvs8Vlzjsvw51zrCJSr2ggYI6Re+eQvUztYx+HlUO9yLunL6P
         MqqgZcMYSc3ugJGBHuo/EsZX5wpUEqE/FBQc6yad734gUlOj/8WOO6O/VuGr48DiWCXc
         YiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TwMyPkR/HrGeug9rCbGLeSJ2vnl7bZJ0DCKVLG9Ypyc=;
        b=MSmFrGFW8txDmC+XQrkMgdz+YM3YOy4xjkX5JxOYEY2OrrvBbqpNNee4RANYdvZDWR
         Rya4s3Ub9XzcVwj7pGjPPJvUyFPV5GeH9HAZOYmA3ZaV6iBIYgLbSldJzj8kIhJseRL8
         +8g/3MtBJF0aunhaydKTaN9fstSGc9803MSapzADCJKkk8/XwOLucSQcBxtJeRjTAfmi
         0mKf08JmpRvwB1Elb3PwA4ozGz/vVI5sxolPwoi71SmaG9/vv+FXwF61GSmweCI0WALe
         OduE1ZYx4pdUV9ANcDS8ShLgS9WngYxTrlBHUH+Y8AkkIP8g6GsRKyYgVN5nJpd31tkb
         T0bw==
X-Gm-Message-State: AOAM5302C3EcmSm7QUmaCnha5NwNhnhGmuHj7zbGNZW2F9o2FrmbVR3P
        MSllyWU74Gn/cB0TldH2Ck8=
X-Google-Smtp-Source: ABdhPJw04AupRaQwTEVUB3cvMG0U/ZEZdg3Sfk9joqp8WZJE+/zXJHtXJQvimAtE5iYrvLzATq5WJA==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr7873933wrq.108.1622193810113;
        Fri, 28 May 2021 02:23:30 -0700 (PDT)
Received: from ruhe.localdomain (89-139-227-208.bb.netvision.net.il. [89.139.227.208])
        by smtp.gmail.com with ESMTPSA id x13sm6301854wro.31.2021.05.28.02.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:29 -0700 (PDT)
From:   eli.billauer@gmail.com
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH 1/2] char: xillybus: Fix condition for invoking the xillybus/ subdirectory
Date:   Fri, 28 May 2021 12:22:41 +0300
Message-Id: <20210528092242.51104-1-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eli Billauer <eli.billauer@gmail.com>

As Xillybus' configuration symbol hierarchy has been reorganized recently,
the correct condition for compiling the xillybus/ subdirectory is now
CONFIG_XILLYBUS_CLASS, and not CONFIG_XILLYBUS.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---
 drivers/char/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index ffce287ef415..c7e4fc733a37 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -44,6 +44,6 @@ obj-$(CONFIG_TCG_TPM)		+= tpm/
 
 obj-$(CONFIG_PS3_FLASH)		+= ps3flash.o
 
-obj-$(CONFIG_XILLYBUS)		+= xillybus/
+obj-$(CONFIG_XILLYBUS_CLASS)	+= xillybus/
 obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
 obj-$(CONFIG_ADI)		+= adi.o
-- 
2.17.1

