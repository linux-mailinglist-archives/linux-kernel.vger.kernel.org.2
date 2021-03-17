Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B175033E716
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCQCp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:45:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:20620 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhCQCpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:45:25 -0400
IronPort-SDR: EDDmMSDU3WkOy7ez+Ni8Tv8WAfUnf91A79My/cafNG5GdflRgMgYKVYR8psrWY9PT3BjvqJBTK
 2hKfuCHYOTPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="188735433"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="188735433"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:45:24 -0700
IronPort-SDR: 4u2ph9zUDgiEGtaVTuju/to6DuQa0lqUdVMnpjwQHF1RyIFgT/HCvTtD7/BZF9tn3UPPIKVBnZ
 5HS6F4XhJHkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="372185257"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 16 Mar 2021 19:45:24 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 7F1E4580812;
        Tue, 16 Mar 2021 19:45:24 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, mgross@linux.intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: intel_pmt_class: Initial resource to 0
Date:   Tue, 16 Mar 2021 19:44:54 -0700
Message-Id: <20210317024455.3071477-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the struct resource in intel_pmt_dev_register to zero to avoid a
fault should the char *name field be non-zero.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

Base commit is v5.12-rc3.

 drivers/platform/x86/intel_pmt_class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmt_class.c b/drivers/platform/x86/intel_pmt_class.c
index c8939fba4509..ee2b3bbeb83d 100644
--- a/drivers/platform/x86/intel_pmt_class.c
+++ b/drivers/platform/x86/intel_pmt_class.c
@@ -173,7 +173,7 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
 				  struct intel_pmt_namespace *ns,
 				  struct device *parent)
 {
-	struct resource res;
+	struct resource res = {0};
 	struct device *dev;
 	int ret;
 

base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
-- 
2.25.1

