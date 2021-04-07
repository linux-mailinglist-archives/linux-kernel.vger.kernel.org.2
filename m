Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B7E356C03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352110AbhDGMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:23:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:21613 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235058AbhDGMXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:23:36 -0400
IronPort-SDR: W1qDZ9/REPVuA9+LdBdUiZUDEYXWF3V951tTdqOO/J6o0K/v/PndZpmnkbnSvlVv/v5wmVUtjK
 NHM3ukP1jHRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180425300"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="180425300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 05:23:26 -0700
IronPort-SDR: EVUBtt3Tizwi9cAo/RgfWkVXBkrRABuRN464VG8eU4NE9HDJf7fisIKPbeSihWYbmF0FVbtL3/
 TyvrfRQcBjeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="449099301"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 07 Apr 2021 05:23:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5435412A; Wed,  7 Apr 2021 15:23:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v1 1/1] drm/i915: Include only needed headers in ascii85.h
Date:   Wed,  7 Apr 2021 15:23:37 +0300
Message-Id: <20210407122337.77493-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ascii85.h is user of exactly two headers, i.e. math.h and types.h.
There is no need to carry on entire kernel.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ascii85.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ascii85.h b/include/linux/ascii85.h
index 4cc40201273e..83ad775ad0aa 100644
--- a/include/linux/ascii85.h
+++ b/include/linux/ascii85.h
@@ -8,7 +8,8 @@
 #ifndef _ASCII85_H_
 #define _ASCII85_H_
 
-#include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/types.h>
 
 #define ASCII85_BUFSZ 6
 
-- 
2.30.2

