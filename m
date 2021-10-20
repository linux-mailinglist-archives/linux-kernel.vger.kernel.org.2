Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7828A434CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhJTN7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:59:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:44987 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230180AbhJTN7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:59:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="292245580"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="292245580"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 06:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="662253207"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga005.jf.intel.com with ESMTP; 20 Oct 2021 06:57:25 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, ak@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH v2 0/3] Several fixes for event constraints on SKX and SNR platforms
Date:   Wed, 20 Oct 2021 16:57:22 +0300
Message-Id: <20211020135725.46597-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Changes in this revision are:
v1 -> v2:
- Addressed comment from Peter Zijlstra:
    - Fix coding style issue in skx_cha_hw_config()

This series contains the following fixes:
    - Fix filter_tid mask for CHA events on Skylake Server
    - Fix IIO event constraints for Skylake Server
    - Fix IIO event constraints for Snowridge

Alexander Antonov (3):
  Fix filter_tid mask for CHA events on Skylake Server
  Fix IIO event constraints for Skylake Server
  Fix IIO event constraints for Snowridge

 arch/x86/events/intel/uncore_snbep.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: d9abdee5fd5abffd0e763e52fbfa3116de167822
-- 
2.21.3

