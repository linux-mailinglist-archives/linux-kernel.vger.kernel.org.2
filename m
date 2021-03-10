Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8103341B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhCJPiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:38:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:29764 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233188AbhCJPhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:37:42 -0500
IronPort-SDR: li0WUBl4KwTANVqPVwSFkGGN+ah2N8Bx7rqw3RMw2zqQxAJGAqbxZyTK/FGWUdvdIIDgo4vwzD
 86cam2kOG6eA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167764354"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="167764354"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:37:42 -0800
IronPort-SDR: /jwZ3eJvchUszeFKv9oHIpkXEgsTd9ZKE83agHGU5k83nVGrjd2Fxg4ayYinIBWdRM66CRp0Jo
 k8CsMMIkDO4g==
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="447938072"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 07:37:40 -0800
From:   shuo.a.liu@intel.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com,
        Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH] virt: acrn: Correct type casting of argument of copy_from_user()
Date:   Wed, 10 Mar 2021 23:37:08 +0800
Message-Id: <20210310153708.17451-1-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

hsm.c:336:50: warning: incorrect type in argument 2 (different address spaces)
hsm.c:336:50:    expected void const [noderef] __user *from
hsm.c:336:50:    got void *

This patch fixes above sparse warning.

Fixes: 3d679d5aec64 ("virt: acrn: Introduce interfaces to query C-states and P-states allowed by hypervisor")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
---
 drivers/virt/acrn/hsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 1f6b7c54a1a4..37cc7acd7df8 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -333,7 +333,7 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
 		acrn_ioreq_request_clear(vm);
 		break;
 	case ACRN_IOCTL_PM_GET_CPU_STATE:
-		if (copy_from_user(&cstate_cmd, (void *)ioctl_param,
+		if (copy_from_user(&cstate_cmd, (void __user *)ioctl_param,
 				   sizeof(cstate_cmd)))
 			return -EFAULT;
 
-- 
2.28.0

