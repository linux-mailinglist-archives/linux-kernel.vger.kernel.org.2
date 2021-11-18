Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0094554BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243345AbhKRGYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:24:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:64399 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243339AbhKRGYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:24:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="221003131"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="221003131"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 22:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="455190137"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2021 22:21:37 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnang-0002la-AV; Thu, 18 Nov 2021 06:21:36 +0000
Date:   Thu, 18 Nov 2021 14:20:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH mcgrof-next] hung_task:
 sysctl_hung_task_all_cpu_backtrace can be static
Message-ID: <20211118062040.GA67066@d1b1ea5158cd>
References: <202111181439.tykxEC3r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111181439.tykxEC3r-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/hung_task.c:66:28: warning: symbol 'sysctl_hung_task_all_cpu_backtrace' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 hung_task.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index edccc9a09a62f..cf16ddc02f503 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -63,7 +63,7 @@ static struct task_struct *watchdog_task;
  * Should we dump all CPUs backtraces in a hung task event?
  * Defaults to 0, can be changed via sysctl.
  */
-unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
+static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
 #else
 /* Avoid need for ifdefs elsewhere in the code */
 enum { sysctl_hung_task_timeout_secs = 0 };
