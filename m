Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1701035F990
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhDNRNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:13:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:3013 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhDNRM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:12:59 -0400
IronPort-SDR: VCODcDubTIOokLce2H3/fy9BZsFfGwsO8BmTzzQpbPBJi8lUCLT8M18Nk2q0UMsr8zJx8g43Xo
 blKKozqsOqzw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="181811888"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="181811888"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:12:38 -0700
IronPort-SDR: vN4HFGKtWkNxoMrdW/sr2LJxu5wTLjWDVcHK6tW1TJIulRdgV6R4pkho382YMOGzsjJgd/iHXe
 abALwIVFve5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="382427911"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2021 10:12:36 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/7] stm class/intel_th: Updates for v5.13
Date:   Wed, 14 Apr 2021 20:12:44 +0300
Message-Id: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are the stm class and intel_th updates that I have for v5.13. These
are all trivial, including 2 new PCI IDs. Andy provided his reviewed-bys.
Please consider applying. Thank you!

Alexander Shishkin (3):
  intel_th: Constify all drvdata references
  intel_th: pci: Add Rocket Lake CPU support
  intel_th: pci: Add Alder Lake-M support

Andy Shevchenko (1):
  stm class: Replace uuid_t with plain u8 uuid[16]

Jiapeng Chong (1):
  stm class: Remove an unused function

Pavel Machek (1):
  intel_th: Consistency and off-by-one fix

Rikard Falkeborn (1):
  intel_th: Constify attribute_group structs

 drivers/hwtracing/intel_th/core.c     |  2 +-
 drivers/hwtracing/intel_th/gth.c      |  4 ++--
 drivers/hwtracing/intel_th/intel_th.h |  8 ++++----
 drivers/hwtracing/intel_th/msu.c      |  2 +-
 drivers/hwtracing/intel_th/pci.c      | 12 +++++++++++-
 drivers/hwtracing/intel_th/pti.c      |  4 ++--
 drivers/hwtracing/stm/p_sys-t.c       | 16 ++++++++++------
 drivers/hwtracing/stm/policy.c        |  5 -----
 8 files changed, 31 insertions(+), 22 deletions(-)

-- 
2.30.2

