Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306D03AD691
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 04:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhFSCFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 22:05:21 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:10076 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFSCFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 22:05:20 -0400
DKIM-Signature: a=rsa-sha256;
        b=dLpdFc9Q7rPSgM68Awvtd0xeLc5bI8T3xuKCV134KeWUMdsQA1JylXOK+IztBEu3RUVH7WWPLadtRdf0rZmuYeKYhqHo5pe5KzdDcylvvXLuSUixNWqWbTevTW9zSyu2dxujNTWv+k71+iCfDtPLMb9ze/gXYewP16vsLW7fprs=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=/ebFraQVopw3z7zea9Lub4DRXBudgNMt+6DiRZl95uo=;
        h=date:mime-version:subject:message-id:from;
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 1A389AC0113;
        Sat, 19 Jun 2021 10:03:08 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: remove unneeded semicolon in um_arch.c
Date:   Sat, 19 Jun 2021 10:02:59 +0800
Message-Id: <20210619020301.77672-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQxhJGFYfTRkZS0wfSksYTE1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6Ngw5ET8XAUJRCD8XNTEq
        SS4KFC1VSlVKTUlPS01DSkNDTU5KVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJSUpNNwY+
X-HM-Tid: 0a7a2201e8bdb039kuuu1a389ac0113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./arch/um/kernel/um_arch.c:284:34-35: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/um/kernel/um_arch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index f9f1463f0521..a149a5e9a16a 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -281,7 +281,7 @@ static void parse_host_cpu_flags(char *line)
 	int i;
 	for (i = 0; i < 32*NCAPINTS; i++) {
 		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
-			set_cpu_cap(&boot_cpu_data, i);;
+			set_cpu_cap(&boot_cpu_data, i);
 	}
 }
 static void parse_cache_line(char *line)
-- 
2.20.1

