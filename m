Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE034FDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhCaKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbhCaJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:59:51 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FADC061761
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:59:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:ada2:b4da:6568:5ad5])
        by andre.telenet-ops.be with bizsmtp
        id mxzd2400B5W9KJv01xzdoa; Wed, 31 Mar 2021 11:59:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRXdQ-00BseR-HG; Wed, 31 Mar 2021 11:59:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lRXBt-001bpc-Ar; Wed, 31 Mar 2021 11:31:09 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>,
        Gary R Hook <gary.hook@amd.com>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-embedded@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] Use pr_crit() instead of long fancy messages
Date:   Wed, 31 Mar 2021 11:31:01 +0200
Message-Id: <20210331093104.383705-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

While long fancy messages have a higher probability of being seen than
small messages, they may scroll of the screen fast, if visible at all,
and may still be missed.  In addition, they increase boot time and
kernel size.

The correct mechanism to increase importance of a kernel message is not
to draw fancy boxes with more text, but to shout louder, i.e. increase
the message's reporting level.  Making sure the administrator of the
system is aware of such a message is a system policy, and is the
responsability of a user-space log daemon.

This series increases the reporting level of such messages from
KERN_WARNING to KERN_CRIT, and removes irrelevant text and graphics.
It was made against linux-next, but applies to v5.12-rc5 with an offset
for the last patch.

Each of these patches reduces kernel size by ca. 0.5 KiB.

Thanks for your comments!

Geert Uytterhoeven (3):
  iommu: Use pr_crit() instead of long fancy messages
  tracing: Use pr_crit() instead of long fancy messages
  lib/vsprintf: Use pr_crit() instead of long fancy messages

 drivers/iommu/iommu-debugfs.c | 19 ++++---------------
 kernel/trace/trace.c          | 17 +++--------------
 lib/vsprintf.c                | 17 +++--------------
 3 files changed, 10 insertions(+), 43 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
