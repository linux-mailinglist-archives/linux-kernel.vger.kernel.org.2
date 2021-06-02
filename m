Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78D39854C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhFBJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:32:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:32606 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhFBJcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:32:11 -0400
IronPort-SDR: NLeLwZbeGHg37h6Lgn68hreRy+ppconyDBT0ud709AXfwvxbp40D7aU0I+puLKPAX9ND1Gb5lX
 VbUWp8SnrpQw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="201886804"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="201886804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 02:30:25 -0700
IronPort-SDR: 8fSv3+xl+SCNikYfUNQPdCaaY4eus5NpbAix2OlGnojwyAkp0xNbo/RAFn52vCDPDjZ4KPmm32
 3S9n17432tTQ==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="445678923"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 02:30:22 -0700
Date:   Wed, 2 Jun 2021 17:30:07 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Ming Lin-SSI <mlin@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Ming Lin-SSI <mlin@kernel.org>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem
 read
Message-ID: <20210602093007.GG1271937@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622589753-9206-3-git-send-email-mlin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on arm64/for-next/core powerpc/next asm-generic/master linus/master v5.13-rc4]
[cannot apply to hnaz-linux-mm/master tip/x86/core next-20210601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ming-Lin/mm-adds-MAP_NOSIGBUS-extension-for-shmem-read/20210602-072403
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd860052c99b1e088352bdd4fb7aef46f8d2ef47
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
cd tools/perf && ./check-headers.sh

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


perfheadercheck warnings: (new ones prefixed by >>)
>> Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h':   32> #define MAP_NOSIGBUS		0x200000	/* do not SIGBUS on out-of-band shmem read */

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
