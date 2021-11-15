Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA114500D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhKOJHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:07:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:34445 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhKOJG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:06:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="232128025"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="232128025"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 01:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="471838173"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2021 01:03:36 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, ak@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [RESEND PATCH v2 0/3] Several fixes for event constraints on SKX and SNR platforms
Date:   Mon, 15 Nov 2021 12:03:31 +0300
Message-Id: <20211115090334.3789-1-alexander.antonov@linux.intel.com>
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


base-commit: 8ab774587903771821b59471cc723bba6d893942
-- 
2.21.3

