Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2172540B6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhINSZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:25:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:52821 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhINSZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:25:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="283094752"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="283094752"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 11:23:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="470309630"
Received: from nntpdsd52-165.inn.intel.com ([10.125.52.165])
  by fmsmga007.fm.intel.com with ESMTP; 14 Sep 2021 11:23:50 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, ak@linux.intel.com,
        alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 0/3] Several fixes for event constraints on SKX and SNR platforms
Date:   Tue, 14 Sep 2021 21:23:46 +0300
Message-Id: <20210914182349.36186-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Sent this patch set again. There were typos in CC.
Sorry for the spam.

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

