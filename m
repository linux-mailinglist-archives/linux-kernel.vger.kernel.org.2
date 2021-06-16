Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41D3A8D88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFPAi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:38:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:22893 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhFPAiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:38:55 -0400
IronPort-SDR: tyIwjpMfYdw8fli73qKOYRqWPzWgr3hPeA+KWE0GVU1kIBGaKM4VDw7kEb5QbUeF3Pntz0LtPw
 1B4DYobh7hHw==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="227578459"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="227578459"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 17:36:50 -0700
IronPort-SDR: IUW+IbsdJrn5LO+okM2ePmFUC8DyNuW2n//StC1Zwjxyk42X2Bkrgx2Zuy829uF4II9aJ4WLTC
 6l0LFW3sV1/g==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="639825057"
Received: from shyvonen-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.5.121])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 17:36:47 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, seanjc@google.com,
        jarkko@kernel.org, dave.hansen@intel.com, tglx@linutronix.de,
        mingo@redhat.com, Yang Zhong <yang.zhong@intel.com>,
        Kai Huang <kai.huang@intel.com>
Subject: [PATCH v2] x86/sgx: Add missing xa_destroy() when virtual EPC is destroyed
Date:   Wed, 16 Jun 2021 12:36:34 +1200
Message-Id: <20210616003634.320206-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xa_destroy() needs to be called to destroy virtual EPC's page array
before calling kfree() to free the virtual EPC.  Currently it is not
called.  Add the missing xa_destroy() to fix.

Fixes: 540745ddbc70 ("x86/sgx: Introduce virtual EPC for use by KVM guests")
Tested-by: Yang Zhong <yang.zhong@intel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---
v1->v2:

 - Fixed typo in commit msg
 - Added Dave's Acked-by
---
 arch/x86/kernel/cpu/sgx/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 6ad165a5c0cc..64511c4a5200 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -212,6 +212,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 		list_splice_tail(&secs_pages, &zombie_secs_pages);
 	mutex_unlock(&zombie_secs_pages_lock);
 
+	xa_destroy(&vepc->page_array);
 	kfree(vepc);
 
 	return 0;
-- 
2.31.1

