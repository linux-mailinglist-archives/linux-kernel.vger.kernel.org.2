Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57C40C62C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhIONVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhIONVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:21:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19FF961261;
        Wed, 15 Sep 2021 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631711987;
        bh=3BaNmCZTv0c11pAEto4TWOw5JJNkPY3QPpJT3D6yH7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaVKaeSUVggUaGZpLhN9NgxUAwuOe1r79ryv0Ruaz4RIqBWrUUL0PxhWjX5BIcEDD
         CbqHnMBXHdderNLR5reHA8lZXf4CK01I0bIojQNyIzoqRSqKNfDeWhU0gOp47RosEW
         0lf90OJfSeG8Rz5o83cWajuAmL6/jmkC2SRwS4X7gBpFMXgR/oljjlgN2ZpKSH2evb
         ImFFmrqSLYVFGV+0+/ssNA4nAv5+PpnGdcfqw7oMqlW0wcz2CcIXLEycdMrIZDvZba
         JFQxUAMAMzOvg29M1/EctL2H3N5hZeQ9PRUWKbXULh3yTS8UVKpzFpv5uBrxLwHB6i
         48fqObAGCzq1A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 2/3] bootconfig: init: Fix memblock leak in setup_boot_config()
Date:   Wed, 15 Sep 2021 22:19:44 +0900
Message-Id: <163171198422.590070.5414135296244084523.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163171196689.590070.15063104707696447188.stgit@devnote2>
References: <163171196689.590070.15063104707696447188.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free unused memblock in a error case to fix memblock leak
in setup_boot_config().

Fixes: 7684b8582c24 ("bootconfig: Load boot config from the tail of initrd")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 0b054fff8e92..4f059fde1df0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -459,6 +459,7 @@ static void __init setup_boot_config(void)
 		else
 			pr_err("Failed to parse bootconfig: %s at %d.\n",
 				msg, pos);
+		memblock_free_ptr(copy, size + 1);
 	} else {
 		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
 		/* keys starting with "kernel." are passed via cmdline */

