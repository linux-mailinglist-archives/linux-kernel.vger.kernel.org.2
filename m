Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFEE350AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhCaX0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:26:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:4846 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232655AbhCaX0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:26:39 -0400
IronPort-SDR: MNhDKmpl7Q+GNfB6eXVNIIs+OlckdXLrGZd/hiQ6g70+HWOMCethFA1vQYQUylteLBa73+Hv7S
 NFriQiSeseaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171528069"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="171528069"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:39 -0700
IronPort-SDR: lA3ZSjELFa0NIDo8bePPi1qY9wOPlIzkzGr7G0jYNESBC/NgEm6HokONY706097FC17yerrMDu
 PlEeLO5VeDug==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="610685724"
Received: from dfrayn-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.146.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 16:26:38 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/7] drivers/base: remove kernel-doc warnings
Date:   Wed, 31 Mar 2021 18:26:07 -0500
Message-Id: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fixes to reduce the number of warnings with make W=1

After this patchset, there are still a number of false positives
reported, I left them as is.

drivers/base/power/runtime.c:347: warning: Excess function parameter
'dev' description in '__rpm_callback'


drivers/base/platform.c:1545:20: warning: no previous prototype for
‘early_platform_cleanup’ [-Wmissing-prototypes]
 1545 | void __weak __init early_platform_cleanup(void) { }
      |                    ^~~~~~~~~~~~~~~~~~~~~~

drivers/base/attribute_container.c:304: warning: Function parameter or
member 'fn' not described in 'attribute_container_device_trigger_safe'

drivers/base/attribute_container.c:304: warning: Function parameter or
member 'undo' not described in
'attribute_container_device_trigger_safe'

drivers/base/attribute_container.c:357: warning: Function parameter or
member 'fn' not described in 'attribute_container_device_trigger'

drivers/base/module.c: In function ‘module_add_driver’:
drivers/base/module.c:36:6: warning: variable ‘no_warn’ set but not
used [-Wunused-but-set-variable]
   36 |  int no_warn;
      |      ^~~~~~~


Pierre-Louis Bossart (7):
  driver core: remove kernel-doc warnings
  driver core: attribute_container: remove kernel-doc warnings
  PM: runtime: remove kernel-doc warnings
  PM: wakeup: fix kernel-doc warnings and fix typos
  PM: clk: remove kernel-doc warning
  platform-msi: fix kernel-doc warnings
  devcoredump: fix kernel-doc warning

 drivers/base/attribute_container.c |  4 ++++
 drivers/base/core.c                | 11 ++++++-----
 drivers/base/devcoredump.c         |  4 ++--
 drivers/base/platform-msi.c        |  3 ++-
 drivers/base/power/clock_ops.c     |  2 +-
 drivers/base/power/runtime.c       |  2 +-
 drivers/base/power/wakeup.c        | 17 +++++++++--------
 7 files changed, 25 insertions(+), 18 deletions(-)


base-commit: 7a43c78d0573e0bbbb0456b033e2b9a895b89464
-- 
2.25.1

