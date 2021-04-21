Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C763366C79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbhDUNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241396AbhDUNIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:08:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC2766144C;
        Wed, 21 Apr 2021 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010465;
        bh=0smudAQ2kY65xOvvC+YoieWAC/LJ1y76Yvn2nO1wstQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9t63TJjBUxhJ19d8XHbCAtuZU5OWj6NcPTFG+cfGwcBEiWIr/tLt0u8+ErfjD7zd
         ma+9dGuZmvHZrM4GYkDpLFVZfNivhNKxug8m3tWRXHgcH9AY5vDU+mEvX/uXq6ddIR
         9vlBVmtiJpsh/RocDuYrZfDs/pWUdaWpYGtYK0U0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Andrew Jeffery <andrew@aj.id.au>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 111/190] Revert "gpio: aspeed: fix a potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 14:59:46 +0200
Message-Id: <20210421130105.1226686-112-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6cf4511e9729c00a7306cf94085f9cc3c52ee723.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-aspeed.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index b966f5e28ebf..91d0fdf8469d 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1231,8 +1231,6 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 
 	gpio->offset_timer =
 		devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
-	if (!gpio->offset_timer)
-		return -ENOMEM;
 
 	rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
 	if (rc < 0)
-- 
2.31.1

