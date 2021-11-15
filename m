Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0885444FD5C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhKODK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhKODIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:08:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBFBC0613B9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 19:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=g8w76dZkSr6jblzgg6NOnnN8X0qIj75nqx2bwi4VMDc=; b=o3X37Fa7z7Flbh5ly+7qtez00v
        XjuIqFvcWjGQ1hujwHhhjTx7/IV80aluYvl3YEPGROJpcWMJiGI30UQaalw1iOh9xGTpv7zuoe8OW
        07+pD3kAcfE1S9rt/glDxYsmRUgLyzgNkzUCCjwvtwcyfIrmS4dE9NwuW4V3qXZ9iF0hg1FKb519h
        QpKUBSQcPAS67+3lJmmhsspmdEuNsabssKatOjwbMs9eSXZDXo9nyxODJWTuaHOxMzYEqnUJr+Qct
        +l0FbmnXVWmyLjt/udQp4I0HK5ohJNqtUtWhZ7Lgso37xQ4iVM5iFQtfjLRaEVrcaCMNvqCA2jdnA
        QDdg9QiQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmSJN-00EI8O-KQ; Mon, 15 Nov 2021 03:05:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] extcon: usb-gpio: fix a non-kernel-doc comment
Date:   Sun, 14 Nov 2021 19:05:36 -0800
Message-Id: <20211115030536.2414-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use "/**" to begin a non-kernel-doc comment.
Fixes this build warning:

drivers/extcon/extcon-usb-gpio.c:23: warning: expecting prototype for drivers/extcon/extcon-usb-gpio.c(). Prototype was for USB_GPIO_DEBOUNCE_MS() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon-usb-gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211102.orig/drivers/extcon/extcon-usb-gpio.c
+++ linux-next-20211102/drivers/extcon/extcon-usb-gpio.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * drivers/extcon/extcon-usb-gpio.c - USB GPIO extcon driver
  *
  * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
