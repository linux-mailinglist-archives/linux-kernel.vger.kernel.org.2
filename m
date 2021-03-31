Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38EF34F81F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 06:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhCaEvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 00:51:53 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:8516 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhCaEvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 00:51:44 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 7DF50980109;
        Wed, 31 Mar 2021 12:51:40 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Finn Behrens <me@kloenk.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Michal Marek <mmarek@suse.cz>,
        Mike Pagano <mpagano@gentoo.org>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] scripts: show_delta: Update the python interpreter
Date:   Wed, 31 Mar 2021 12:51:09 +0800
Message-Id: <20210331045112.2809594-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTh5NTUofQkMfTk9CVkpNSkxKTU1IS0tMSEpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0JITlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MxQ6Tgw6GD8LKDYUTUsoF0hR
        KgIKCxRVSlVKTUpMSk1NSEtLQkxNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTkNCNwY+
X-HM-Tid: 0a78869f75e6d992kuws7df50980109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f29b5f3e6fc0a, the script is update to support python3.
Fix the python interpreter update to python3.

Fixes: f29b5f3e6fc0a ("show_delta: Update script to support python3")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 scripts/show_delta | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/show_delta b/scripts/show_delta
index 28e67e178194..4660a988b2ad 100755
--- a/scripts/show_delta
+++ b/scripts/show_delta
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # show_deltas: Read list of printk messages instrumented with
-- 
2.25.1

