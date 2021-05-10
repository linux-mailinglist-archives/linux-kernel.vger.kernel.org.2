Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93D3379150
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhEJOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:52:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:15122 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238319AbhEJOvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:51:11 -0400
IronPort-SDR: qdxnxHs7DCDg24tJk619JeGv77EdZAWMiHc6jZKMpdeWXHRsZtx1aGj9rYdwOSPQiOb9fxJblr
 vTJvPd9agw7g==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186346628"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="186346628"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 07:49:41 -0700
IronPort-SDR: IIq7QVtgyRvIoS8VM+whwRnHK75/L0kJeONX2upxP6Lk6Ttf2p3FqLU7TWvSUZclO1a2gzy42o
 NhtgALDaWdYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="470814346"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 May 2021 07:49:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D255912A; Mon, 10 May 2021 17:49:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] vt: Move custom isspace() to its own namespace
Date:   Mon, 10 May 2021 17:49:47 +0300
Message-Id: <20210510144947.58270-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If by some reason any of the headers will include ctype.h
we will have a name collision. Avoid this by moving isspace()
to the dedicate namespace.

First appearance of the code is in the commit 24a1c2a769cf
("Import 1.1.92").

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/vt/selection.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index f245a5acf7e9..bcb6bc5731cc 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -33,7 +33,7 @@
 #include <linux/sched/signal.h>
 
 /* Don't take this from <ctype.h>: 011-015 on the screen aren't spaces */
-#define isspace(c)	((c) == ' ')
+#define is_space_on_vt(c)	((c) == ' ')
 
 /* FIXME: all this needs locking */
 static struct vc_selection {
@@ -209,7 +209,7 @@ static int vc_selection_store_chars(struct vc_data *vc, bool unicode)
 			bp += store_utf8(c, bp);
 		else
 			*bp++ = c;
-		if (!isspace(c))
+		if (!is_space_on_vt(c))
 			obp = bp;
 		if (!((i + 2) % vc->vc_size_row)) {
 			/* strip trailing blanks from line and add newline,
@@ -238,9 +238,9 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
 		new_sel_end = pe;
 		break;
 	case TIOCL_SELWORD:	/* word-by-word selection */
-		spc = isspace(sel_pos(ps, unicode));
+		spc = is_space_on_vt(sel_pos(ps, unicode));
 		for (new_sel_start = ps; ; ps -= 2) {
-			if ((spc && !isspace(sel_pos(ps, unicode))) ||
+			if ((spc && !is_space_on_vt(sel_pos(ps, unicode))) ||
 			    (!spc && !inword(sel_pos(ps, unicode))))
 				break;
 			new_sel_start = ps;
@@ -248,9 +248,9 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
 				break;
 		}
 
-		spc = isspace(sel_pos(pe, unicode));
+		spc = is_space_on_vt(sel_pos(pe, unicode));
 		for (new_sel_end = pe; ; pe += 2) {
-			if ((spc && !isspace(sel_pos(pe, unicode))) ||
+			if ((spc && !is_space_on_vt(sel_pos(pe, unicode))) ||
 			    (!spc && !inword(sel_pos(pe, unicode))))
 				break;
 			new_sel_end = pe;
@@ -276,12 +276,12 @@ static int vc_do_selection(struct vc_data *vc, unsigned short mode, int ps,
 	/* select to end of line if on trailing space */
 	if (new_sel_end > new_sel_start &&
 		!atedge(new_sel_end, vc->vc_size_row) &&
-		isspace(sel_pos(new_sel_end, unicode))) {
+		is_space_on_vt(sel_pos(new_sel_end, unicode))) {
 		for (pe = new_sel_end + 2; ; pe += 2)
-			if (!isspace(sel_pos(pe, unicode)) ||
+			if (!is_space_on_vt(sel_pos(pe, unicode)) ||
 			    atedge(pe, vc->vc_size_row))
 				break;
-		if (isspace(sel_pos(pe, unicode)))
+		if (is_space_on_vt(sel_pos(pe, unicode)))
 			new_sel_end = pe;
 	}
 	if (vc_sel.start == -1)	/* no current selection */
-- 
2.30.2

