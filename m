Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DCE3AEC16
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFUPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:15:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:18874 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUPP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:15:28 -0400
IronPort-SDR: GtObsAVmprd5EtgNa4BlfaxWWrxW+BdwlzOzKFaLR+qrOrAiUOccJAknTUvQ6a/U2jQH6/+n9P
 QYFFx1yDM1cg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="205039498"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="205039498"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:13:14 -0700
IronPort-SDR: EE0nnK9PP6lQ+/sALvd7dwJzZIL2eA6/f58VOd+T8DPLuVYwE58WYaCfUbBfh/fxTzCBG6oBcz
 oUqvdk2Orl4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486522871"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:13:12 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/4] stm class: Spelling fix
Date:   Mon, 21 Jun 2021 18:12:43 +0300
Message-Id: <20210621151246.31891-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621151246.31891-1-alexander.shishkin@linux.intel.com>
References: <20210621151246.31891-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[alexander.shishkin: fixed the commit message]
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/stm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/stm.h b/include/linux/stm.h
index c6f577ab6f21..3b22689512be 100644
--- a/include/linux/stm.h
+++ b/include/linux/stm.h
@@ -57,7 +57,7 @@ struct stm_device;
  *
  * Normally, an STM device will have a range of masters available to software
  * and the rest being statically assigned to various hardware trace sources.
- * The former is defined by the the range [@sw_start..@sw_end] of the device
+ * The former is defined by the range [@sw_start..@sw_end] of the device
  * description. That is, the lowest master that can be allocated to software
  * writers is @sw_start and data from this writer will appear is @sw_start
  * master in the STP stream.
-- 
2.30.2

