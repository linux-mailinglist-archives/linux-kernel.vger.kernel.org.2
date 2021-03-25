Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D05234939B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhCYOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:04:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57754 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhCYOE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:04:27 -0400
Received: from 111-240-153-89.dynamic-ip.hinet.net ([111.240.153.89] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lPQb4-00085S-9U; Thu, 25 Mar 2021 14:04:26 +0000
From:   chris.chiu@canonical.com
To:     akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: update the email address for Chris Chiu
Date:   Thu, 25 Mar 2021 22:04:19 +0800
Message-Id: <20210325140419.27978-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

Redirect my older email addresses in the git logs.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 85b93cdefc87..1f8579db5a3f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -65,6 +65,8 @@ Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
 Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
 Chao Yu <chao@kernel.org> <yuchao0@huawei.com>
+Chris Chiu <chris.chiu@canonical.com> <chiu@endlessm.com>
+Chris Chiu <chris.chiu@canonical.com> <chiu@endlessos.org>
 Christophe Ricard <christophe.ricard@gmail.com>
 Christoph Hellwig <hch@lst.de>
 Corey Minyard <minyard@acm.org>
-- 
2.20.1

