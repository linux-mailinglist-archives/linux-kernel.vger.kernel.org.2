Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44544FD5B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhKODKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhKODJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:09:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56728C061200
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 19:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7PlqnWl3dH/lPDaqEnf+Sj/vxI6xrMT0elhTwwjscH4=; b=rJvApR800OOF0hEt9iQXgFl+1C
        92PCjx1I8jJd+1I1TOIqp19xU/BPnngNzOyulyuh/1ASnDe8nup5my80lU/U3WNXDqfiIOFgBGSc+
        S3Dwtnwffi7JYgUlk0ouhy+JVEaIiz3xDaMJoPI+8LLFBV2ICW8YwS+BklsEr0JRV9CVUDlgFkJzQ
        zfwfTcOv9Q3BJTqt1IiGzhKCD7NN3c889xsvKAhbJEWF0cTldzg7zjdR2PzQ93CEK3AAImOvSlZQc
        OAYnZ5UDPcjTAfBhSY0bsWvW8HDnOtDs/lOvpEKXqStPbix7IQfypaLMfksBH89l0Zw8kyrF2SIOB
        tD5ie/pQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmSJj-00EI9A-Tf; Mon, 15 Nov 2021 03:06:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
Subject: [PATCH] phy: ti: report 2 non-kernel-doc comments
Date:   Sun, 14 Nov 2021 19:05:59 -0800
Message-Id: <20211115030559.13994-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use "/**" to begin a non-kernel-doc comment.
Fixes these build warnings:

drivers/phy/ti/phy-am654-serdes.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * PCIe SERDES driver for AM654x SoC

drivers/phy/ti/phy-j721e-wiz.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Wrapper driver for SERDES used in J721E

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-phy@lists.infradead.org
---
 drivers/phy/ti/phy-am654-serdes.c |    2 +-
 drivers/phy/ti/phy-j721e-wiz.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211102.orig/drivers/phy/ti/phy-am654-serdes.c
+++ linux-next-20211102/drivers/phy/ti/phy-am654-serdes.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * PCIe SERDES driver for AM654x SoC
  *
  * Copyright (C) 2018 - 2019 Texas Instruments Incorporated - http://www.ti.com/
--- linux-next-20211102.orig/drivers/phy/ti/phy-j721e-wiz.c
+++ linux-next-20211102/drivers/phy/ti/phy-j721e-wiz.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * Wrapper driver for SERDES used in J721E
  *
  * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
