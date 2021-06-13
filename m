Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809373A5A54
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhFMUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:23:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60056 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhFMUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:23:05 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lsWbM-000444-7D; Sun, 13 Jun 2021 20:21:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools: Fix "the the" in a message in kernel-chktaint
Date:   Sun, 13 Jun 2021 21:20:59 +0100
Message-Id: <20210613202059.80403-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a double "the" in a message in kernel-chktaint, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/debugging/kernel-chktaint | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 719f18b1edf0..f1af27ce9f20 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -196,7 +196,7 @@ else
 fi
 
 echo "For a more detailed explanation of the various taint flags see"
-echo " Documentation/admin-guide/tainted-kernels.rst in the the Linux kernel sources"
+echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
 echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
 echo "Raw taint value as int/string: $taint/'$out'"
 #EOF#
-- 
2.31.1

