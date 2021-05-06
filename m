Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753CE3751C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhEFJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:44:56 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:62016 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhEFJoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:44:55 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m176216.qiye.163.com (Hmail) with ESMTPA id 748B3C201AA;
        Thu,  6 May 2021 17:43:55 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] tools/x86: update include of alternative
Date:   Thu,  6 May 2021 17:43:28 +0800
Message-Id: <20210506094335.18281-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGktJSVZDHx1LT0MfTxkdS0hVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46OBw6MD8IT0JPUSwTPkgy
        IhwaChBVSlVKTUlLSUJPSUhNSk9PVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJSUpMNwY+
X-HM-Tid: 0a79410ff606d976kuws748b3c201aa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 5e21a3ecad15 ("x86/alternative: Merge include files"),
arch/x86/include/asm/alternative-asm.h was replaced by
arch/x86/include/asm/alternative.h. Fix them in tools directory.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/arch/x86/lib/memcpy_64.S | 2 +-
 tools/arch/x86/lib/memset_64.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 1e299ac73c86..1cc9da6e29c7 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -4,7 +4,7 @@
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 .pushsection .noinstr.text, "ax"
diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index 0bfd26e4ca9e..9827ae267f96 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -3,7 +3,7 @@
 
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
-#include <asm/alternative-asm.h>
+#include <asm/alternative.h>
 #include <asm/export.h>
 
 /*
-- 
2.25.1

