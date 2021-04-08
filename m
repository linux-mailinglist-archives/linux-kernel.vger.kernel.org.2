Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9423D35835F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhDHMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:37:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:63950 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhDHMhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:37:21 -0400
IronPort-SDR: O5/Om29XpAhXUX6U6hke3X+kdpeQFiOiyIaRJY/n/BAaYwhf5RL1xCDOt5g7FfXJlz4y8gS3F5
 TZ0iD73xYqXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="181065526"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="gz'50?scan'50,208,50";a="181065526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 05:37:08 -0700
IronPort-SDR: ka3jNPDDd3SIdMZwnrHjphonUH7dsaxPJv4EZ5dvrXJftpeMfM4U8UeCZ+OjNagHTOfNGBLod3
 +kDJNHJ9InzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="gz'50?scan'50,208,50";a="458809495"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2021 05:37:04 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUTuB-000Eyn-M8; Thu, 08 Apr 2021 12:37:03 +0000
Date:   Thu, 8 Apr 2021 20:36:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ndesaulniers@google.com,
        dan.j.williams@intel.com, laniel_francis@privacyrequired.com,
        keescook@chromium.org, dja@axtens.net, akpm@linux-foundation.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: Re: [PATCH v3] lib/string: Introduce sysfs_streqcase
Message-ID: <202104082052.tVxrqv3U-lkp@intel.com>
References: <20210408093354.509810-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20210408093354.509810-1-gi-oh.kim@ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gioh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on kees/for-next/pstore linus/master v5.12-rc6 next-20210407]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Gioh-Kim/lib-string-Introduce-sysfs_streqcase/20210408-173449
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5e46d1b78a03d52306f21f77a4e4a144b6d31486
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7de114025f207fa41a9cffdf91c28e9b914e09f4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Gioh-Kim/lib-string-Introduce-sysfs_streqcase/20210408-173449
        git checkout 7de114025f207fa41a9cffdf91c28e9b914e09f4
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: drivers/base/core.o: in function `device_find_child_by_name':
   core.c:(.text+0x2e4c): undefined reference to `sysfs_streq'
>> nds32le-linux-ld: core.c:(.text+0x2e50): undefined reference to `sysfs_streq'
   nds32le-linux-ld: drivers/base/core.o: in function `device_match_name':
   core.c:(.text+0x35a0): undefined reference to `sysfs_streq'
   nds32le-linux-ld: core.c:(.text+0x35a4): undefined reference to `sysfs_streq'
   nds32le-linux-ld: lib/string.o: in function `__sysfs_match_string':
   string.c:(.text+0x668): undefined reference to `sysfs_streq'
   nds32le-linux-ld: lib/string.o:string.c:(.text+0x66c): more undefined references to `sysfs_streq' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Qxx1br4bt0+wmkIi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Qxx1br4bt0+wmkIi--
