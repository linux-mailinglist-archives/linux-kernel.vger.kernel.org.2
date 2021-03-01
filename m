Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623183280F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhCAOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:32:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:37764 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236377AbhCAOcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:32:10 -0500
IronPort-SDR: 6ntLO4OcDiPBJXYut69glLlXK+hUTVYSAEeQOeUKDPVj0CETQpYQp3VqzEwFB2N0nAwXE2i6rl
 /wIBKw7NKqag==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="186593223"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="186593223"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 06:30:18 -0800
IronPort-SDR: 3Y9J6kiQkddeclXcg1GeuJ2NzLVVMeBtxx1YB/HyK91a64LPt1LOL3Jd7gspnowUK2EBNiKV1C
 yx4iK5XDihCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="505086221"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2021 06:30:13 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] software node: Two fixes
Date:   Mon,  1 Mar 2021 17:30:10 +0300
Message-Id: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The second one only affects 5.12-rc1.


Heikki Krogerus (2):
  software node: Fix node registration
  software node: Fix device_add_software_node()

 drivers/base/swnode.c    | 29 ++++++++++++++++++++---------
 include/linux/property.h |  2 +-
 2 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.30.1

