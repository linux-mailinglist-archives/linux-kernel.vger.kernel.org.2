Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2CF407B54
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 04:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhILCsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 22:48:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:2051 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhILCsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 22:48:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10104"; a="221422775"
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="221422775"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 19:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="695982214"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2021 19:47:37 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mPFWq-00064f-O1; Sun, 12 Sep 2021 02:47:36 +0000
Date:   Sun, 12 Sep 2021 10:46:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH mcgrof] selftests: first_test_dev can be static
Message-ID: <20210912024657.GA9363@da1845d11521>
References: <202109121025.Nvy9Ygs2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109121025.Nvy9Ygs2-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/test_sysfs.c:148:26: warning: symbol 'first_test_dev' was not declared. Should it be static?

Fixes: ed2111f617d4 ("selftests: add tests_sysfs module")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 test_sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_sysfs.c b/lib/test_sysfs.c
index f8935bd678b12..273fc3f397401 100644
--- a/lib/test_sysfs.c
+++ b/lib/test_sysfs.c
@@ -145,7 +145,7 @@ struct sysfs_test_device {
 	int y;
 };
 
-struct sysfs_test_device *first_test_dev;
+static struct sysfs_test_device *first_test_dev;
 
 static struct miscdevice *dev_to_misc_dev(struct device *dev)
 {
