Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC93AEC14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFUPOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:14:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:27047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUPOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:14:53 -0400
IronPort-SDR: VIIrE5PgWJGpGlWOnoOrm2jkIFeulU/G8jWGJSYVeLJ2D1GZzHv82e9OvGdE8e4a31+8IvbyS5
 x3ZSTDptLsGw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="268003775"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="268003775"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:12:38 -0700
IronPort-SDR: Z3YxKfnPtkBpI5xhzqQCONJhm0ZduPC2AN9AegJljxWJH1ZXPEe3K4GYH0+5ywvHCB1r9dWCvO
 aypDTLHr/6mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486522672"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:12:37 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/4] stm class/intel_th: Updates for v5.14
Date:   Mon, 21 Jun 2021 18:12:42 +0300
Message-Id: <20210621151246.31891-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are a few patches that I have for v5.14 merge window. Andy provided
his reviewed-bys. Please consider applying. Thanks!

Alexander Shishkin (2):
  intel_th: msu: Make contiguous buffers uncached
  intel_th: Wait until port is in reset before programming it

Randy Dunlap (1):
  stm class: Spelling fix

Uwe Kleine-König (1):
  intel_th: Remove an unused exit point from intel_th_remove()

 drivers/hwtracing/intel_th/core.c     | 29 +++++++++++++---
 drivers/hwtracing/intel_th/gth.c      | 16 +++++++++
 drivers/hwtracing/intel_th/intel_th.h |  3 ++
 drivers/hwtracing/intel_th/msu.c      | 48 ++++++++++++++++++---------
 include/linux/stm.h                   |  2 +-
 5 files changed, 76 insertions(+), 22 deletions(-)

-- 
2.30.2

