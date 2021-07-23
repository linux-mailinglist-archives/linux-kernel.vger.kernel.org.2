Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE513D3197
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhGWBpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 21:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhGWBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:45:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F4C061575;
        Thu, 22 Jul 2021 19:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lxVhInIwiABEsGcqvpyjzJj0fv/fi/yK+7IU5FB7els=; b=sp9PsPiO8KVhBUOGnam8QOSEB9
        AZpz73IYkN0YiIh6lXG/P8Uyzg00/gtuG2xEBDlCESO/RrOTfG6/wqU4jaIGbYwRsAJeMXWqxU12A
        QGnWayRQIwW09Y5E8XXG48zPs2dd100bhKTxB1hgHplXgMyGVdMVi2LMBmPju0ccsCR/HxyeGvgT3
        zRBFGsXO3Uk7hvb15gTDQ5ZxOgptpBoXnWYCgtzxke0d/q0TXVB6pK/EOofwNIfSVIRT62dZ8sJqk
        P+2ZCuIl3y9bkixRUKoTLRfTMxYRMNiz/1zki+R3lGXLU0quZF8ljMrpTQSO+ycMsQ3mWlVDSF3yK
        a76WZFZg==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6ksn-0035n7-6M; Fri, 23 Jul 2021 02:25:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
Subject: [PATCH] phy: qualcomm: phy-qcom-usb-hs: repair non-kernel-doc comment
Date:   Thu, 22 Jul 2021 19:25:48 -0700
Message-Id: <20210723022548.25695-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix errant use of "/**" to begin a comment although the comment
is not kernel-doc notation. Just use "/*" instead.

Fixes this kernel-doc warning:

drivers/phy/qualcomm/phy-qcom-usb-hs.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Copyright (C) 2016 Linaro Ltd

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-phy@lists.infradead.org
---
 drivers/phy/qualcomm/phy-qcom-usb-hs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210722.orig/drivers/phy/qualcomm/phy-qcom-usb-hs.c
+++ linux-next-20210722/drivers/phy/qualcomm/phy-qcom-usb-hs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2016 Linaro Ltd
  */
 #include <linux/module.h>
