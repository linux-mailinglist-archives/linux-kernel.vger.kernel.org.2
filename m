Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A0A3C6C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhGMIf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:35:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:36040 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234648AbhGMIf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:35:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="295770789"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="295770789"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 01:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="492670678"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2021 01:32:30 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3DqA-000He3-1m; Tue, 13 Jul 2021 08:32:30 +0000
Date:   Tue, 13 Jul 2021 16:32:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH dhowells-fs] cachefiles: fscache_lru_cookie_timeout can
 be static
Message-ID: <20210713083203.GA18070@f95dff6026d9>
References: <202107131619.bni4kdJM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107131619.bni4kdJM-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/fscache/cookie.c:34:14: warning: symbol 'fscache_lru_cookie_timeout' was not declared. Should it be static?

Fixes: 4bd5274decc6 ("cachefiles: Automatically close a file that's not in use after a while")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 cookie.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index c6c3ce8be80d7..618b040e156b2 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -31,7 +31,7 @@ static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 static DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
 static const char fscache_cookie_stages[FSCACHE_COOKIE_STAGE__NR] = "-LCAIFMWRD";
-unsigned int fscache_lru_cookie_timeout = 10 * HZ;
+static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
