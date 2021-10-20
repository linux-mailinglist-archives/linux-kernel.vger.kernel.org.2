Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58AE434992
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJTLCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:02:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:39328 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhJTLCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:02:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="215917459"
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="215917459"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 04:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="444322931"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2021 04:00:29 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, ak@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [RESEND PATCH 0/3] Several fixes for event constraints on SKX and SNR platforms
Date:   Wed, 20 Oct 2021 14:00:25 +0300
Message-Id: <20211020110028.38781-1-alexander.antonov@linux.intel.com>
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


base-commit: d9abdee5fd5abffd0e763e52fbfa3116de167822
-- 
2.21.3

