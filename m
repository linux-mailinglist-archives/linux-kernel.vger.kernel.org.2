Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECCC31F104
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhBRUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:30:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46572 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhBRU3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:29:37 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lCpuf-0001h7-QC; Thu, 18 Feb 2021 20:28:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] drivers/base/cpu: remove redundant assignment of variable retval
Date:   Thu, 18 Feb 2021 20:28:37 +0000
Message-Id: <20210218202837.516231-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable retval is being initialized with a value that is never read
and it is being updated later with a new value.  Clean this up by
initializing retval to -ENOMEM and remove the assignment to retval
on the !dev failure path.

Kudos to Rafael for the improved fix suggestion.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
V1: Remove initialization of retval
V2: Initialiation of retval with -ENOMEM and remove assignment in
    !dev failure path.
---
 drivers/base/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 8f1d6569564c..2b9e41377a07 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -409,13 +409,11 @@ __cpu_device_create(struct device *parent, void *drvdata,
 		    const char *fmt, va_list args)
 {
 	struct device *dev = NULL;
-	int retval = -ENODEV;
+	int retval = -ENOMEM;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		retval = -ENOMEM;
+	if (!dev)
 		goto error;
-	}
 
 	device_initialize(dev);
 	dev->parent = parent;
-- 
2.30.0

