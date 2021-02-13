Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC1531AD36
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBMQrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBMQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:47:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E44C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:46:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z9so1378145pjl.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtZlRFFC+ex+pjaOYETsGKR4hoKgtSzTKa5mItC0Pbg=;
        b=niMEAwq0GDi1ROtssntqWIWRDqPbEvtvFm0UVuSRORREP2jwOqes+zPUgpd1IqEXWx
         6AzXtq5rSmb4gAhcoW2yLeFZYq/9l8QMYkCa0JU3pMw8Xs23S/rc9kHX7uYAO4nqsT4K
         TuUn4dTl7pHF8uHfZSNktA++RDL3OdyfX9Vb1mxvgFtCxN8p0rTcue52QgfOfiFr8hiB
         0NkaFIzh5cFzSdzoXBvdMQLRAD5K7mcCOVSyWgZ1cxRQHRLSK1gXNslMKXyLchUlfVce
         Km6cg+gidZ9BGGHhcpWKeGdTL/3p71QBvsgO+BiEsy3DPA2sq66OHrphS8XQOAv/3FJX
         +VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtZlRFFC+ex+pjaOYETsGKR4hoKgtSzTKa5mItC0Pbg=;
        b=DrdqDcPpo2wp5MDuKk1MpJNK7n5WQqnbGxj56vG/IdQL2LaFgCPed4xGFSQMtZrgk/
         mKASFEgh6Hw+O25r9ghBQ+2pxXK7duFcyj6bTh34qp6+S5qIbGyrEoFlKiDCXinEhvXG
         QP1Uh6TsFKa+5w+ixASxu+zWMN/Pvb/YfUAq9DgoX7u8KceTsUU4MjKsxQmU2GQ7zjHE
         7qI8z3W9CU2SjuMFAHG7E0PTocILH2SUqN6HW9J3vNxxlU+NuoLJFDzQoGrSyM3DZrcp
         FRxbi7i0sfJSF258k5BeEb979fhtINIJL5rS3qp+YIjqfPgUL0JCzukNhlpTGkA8zvd5
         p4Iw==
X-Gm-Message-State: AOAM533d7zhTFX4+5eaoFTPw36W/2BR5whEyVXuYLXqSmBvAv2QLhW1m
        qbWRzx2QzcGEzI0IQm6Z6bs=
X-Google-Smtp-Source: ABdhPJwLkckV2e9Edp7CCQuA7r0uMG7v8N5/r2i+0uU/4CqtHNY/YnS11YEnHd6n5NgUpzAVLPMq7Q==
X-Received: by 2002:a17:903:228a:b029:da:d645:ab58 with SMTP id b10-20020a170903228ab02900dad645ab58mr7711471plh.25.1613234793925;
        Sat, 13 Feb 2021 08:46:33 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id h70sm12598145pfe.70.2021.02.13.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 08:46:33 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH mtd/next 0/8] Introduces the module_mtd_blktrans macro
Date:   Sun, 14 Feb 2021 00:45:52 +0800
Message-Id: <20210213164600.409061-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces the module_mtd_blktrans macro which is a
convenience macro for mtd blktrans modules similar to
module_platform_driver. It is intended to be used by drivers which
init/exit section does nothing but register/unregister the mtd
blktrans driver. By using this macro it is possible to eliminate a
few lines of boilerplate code per mtd blktrans driver.

Dejin Zheng (8):
  mtd: Add helper macro for register_mtd_blktrans boilerplate
  mtd: ftl: Use module_mtd_blktrans to register driver
  mtd: inftlcore: Use module_mtd_blktrans to register driver
  mtd: mtdblock: Use module_mtd_blktrans to register driver
  mtd: mtdblock_ro: Use module_mtd_blktrans to register driver
  mtd: mtdswap: Use module_mtd_blktrans to register driver
  mtd: nftlcore: Use module_mtd_blktrans to register driver
  mtd: rfd_ftl: Use module_mtd_blktrans to register driver

 drivers/mtd/ftl.c            | 14 +-------------
 drivers/mtd/inftlcore.c      | 13 +------------
 drivers/mtd/mtdblock.c       | 14 +-------------
 drivers/mtd/mtdblock_ro.c    | 13 +------------
 drivers/mtd/mtdswap.c        | 14 +-------------
 drivers/mtd/nftlcore.c       | 13 +------------
 drivers/mtd/rfd_ftl.c        | 13 +------------
 include/linux/mtd/blktrans.h | 11 +++++++++++
 8 files changed, 18 insertions(+), 87 deletions(-)

-- 
2.25.0

