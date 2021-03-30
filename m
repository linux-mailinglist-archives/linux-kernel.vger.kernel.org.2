Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE85134EA10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhC3OOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:14:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:9145 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231710AbhC3ONs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:13:48 -0400
IronPort-SDR: JwK2gP/bvYa3XbyOTeosXRA6/puQSCsFDHcgAeHlo8rrdMAIUCdXMjW9mxu5SmwlL4VRBczrbZ
 pKVZZ1XF9YOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191248699"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191248699"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 07:13:47 -0700
IronPort-SDR: P11bKoII7gJiSLAf5c6OyVtpyoNfVH1qA2DGZVw6yeBrfjsRqzH1jfs/9QIIt+CVXIc4Ed7cQm
 cxYch6PlYwxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="595479859"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2021 07:13:46 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     mdf@kernel.org, linux-kernel@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH] A patch for Intel service layer driver
Date:   Tue, 30 Mar 2021 09:33:04 -0500
Message-Id: <1617114785-22211-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Hi Greg,

Please take this stratix10-svc patch, which has been reviewed on the
mailing list and applied cleanly on current linux-next and
char-misc-testing.

Thanks,
Richard 

Richard Gong (1):
  firmware: stratix10-svc: extend SVC driver to get the firmware version

 drivers/firmware/stratix10-svc.c                    | 12 ++++++++++--
 include/linux/firmware/intel/stratix10-smc.h        | 21 +++++++++++++++++++--
 include/linux/firmware/intel/stratix10-svc-client.h |  4 ++++
 3 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.7.4

