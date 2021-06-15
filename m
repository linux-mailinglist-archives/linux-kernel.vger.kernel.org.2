Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21F3A74CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFODPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:15:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:63362 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhFODPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:15:24 -0400
IronPort-SDR: 4GM09+ZIt0OlZY+VQgYCZm0FEW5fTLY/1sY44njkZL5cWYtSwX3B3PL+R9HPAyEmYDsgTY25lM
 ukaaRMYSNZUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205724461"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="205724461"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:30:13 -0700
IronPort-SDR: KxB7ziHQCmRbLm/hWG1xbTTTvK1ZnFKf/FCVDrJhA/grBuHz/2IMBLS/cKr3P3oqWu3gGRFrxH
 eFoWoFp1MJwA==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="450069047"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:30:11 -0700
Date:   Tue, 15 Jun 2021 09:30:09 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [cryptodev:master 110/119] drivers/crypto/gemini/sl3516-ce-cipher.c:
 linux/io.h is included more than once.
Message-ID: <20210615013009.GV237458@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
head:   0dc64297c8ac98503a7c7621b3c78e151deb75b6
commit: 46c5338db7bd45b2cf99570560f00389d60fd6b4 [110/119] crypto: sl3516 - Add sl3516 crypto engine
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> drivers/crypto/gemini/sl3516-ce-cipher.c: linux/io.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
