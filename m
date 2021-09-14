Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D5240B64E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhINR6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:58:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:8655 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhINR6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:58:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="220210776"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="220210776"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 10:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="472100805"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2021 10:56:47 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.c, ak@linux.intel.comom,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 0/3] Several fixes for event constraints on SKX and SNR platforms
Date:   Tue, 14 Sep 2021 20:56:43 +0300
Message-Id: <20210914175646.35437-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

This series contains the following fixes:
    - Fix filter_tid mask for CHA events on Skylake Server
    - Fix IIO event constraints for Skylake Server
    - Fix IIO event constraints for Snowridge

Alexander Antonov (3):
  Fix filter_tid mask for CHA events on Skylake Server
  Fix IIO event constraints for Skylake Server
  Fix IIO event constraints for Snowridge

 arch/x86/events/intel/uncore_snbep.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)


base-commit: 27151f177827d478508e756c7657273261aaf8a9
-- 
2.21.3

