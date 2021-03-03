Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A932BD42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384370AbhCCPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:40:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:50703 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357299AbhCCKtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:49:20 -0500
IronPort-SDR: IPxL63WntVsqux/rrNdHodLYaF8ZwULpKsZZCPcIlIHkpXPCv5C/cuKsvY96CKk1tv143tRoaB
 g4D1SjqDpcYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="167037834"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="167037834"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:32:36 -0800
IronPort-SDR: gsw+uUzHeCVlJYu9SjV0EzjX2PdXUTAUl2aK2r7sTsDfSH5NX1FwfN2Ph8NhwLm6U6knAF+CFu
 IycjEXa5ev7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="367523932"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2021 00:32:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 509CBF4; Wed,  3 Mar 2021 10:32:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] vt: keyboard, Fix typo in the doc for vt_get_shift_state()
Date:   Wed,  3 Mar 2021 10:32:29 +0200
Message-Id: <20210303083229.75784-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel documentation validator is not happy:

.../keyboard.c:2195: warning: expecting prototype for vt_get_shiftstate(). Prototype was for vt_get_shift_state() instead

This is due to typo, fix it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 77638629c562..5d2309742718 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2186,7 +2186,7 @@ void vt_reset_unicode(int console)
 }
 
 /**
- *	vt_get_shiftstate	-	shift bit state
+ *	vt_get_shift_state	-	shift bit state
  *
  *	Report the shift bits from the keyboard state. We have to export
  *	this to support some oddities in the vt layer.
-- 
2.30.1

