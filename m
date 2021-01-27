Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D83066B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhA0Vs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:48:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:2646 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234602AbhA0V1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:27:05 -0500
IronPort-SDR: zUKbvwegylcoByO4ayJudHalrR0BFutx4lsTexgJdZcgKTkIOZeXcHTH1ZYu37Sp1pZQu2hUNF
 ZR7+wICLSDxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="241664872"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="241664872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:23:44 -0800
IronPort-SDR: T6kjbkrh8eAI7vWhXlFsQ4TFMPEzXCEY7LVpUM4BBljg+NjC2ki5GW3sjKzfxFi41B3eWIPOKH
 RmYvFxrWub7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="388470767"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2021 13:23:43 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     mdf@kernel.org, trix@redhat.com, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
Date:   Wed, 27 Jan 2021 15:43:20 -0600
Message-Id: <1611783801-30766-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

This is a bug fix and needs to be backported to stable kernel releases.

Richard Gong (1):
  firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0

 include/linux/firmware/intel/stratix10-svc-client.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4

