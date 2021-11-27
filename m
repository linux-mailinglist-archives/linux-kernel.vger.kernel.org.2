Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5445FE55
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 12:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbhK0LuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 06:50:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:55085 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237849AbhK0LsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 06:48:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="321987933"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="321987933"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 03:44:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="457928962"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Nov 2021 03:44:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqw8N-0009RP-QT; Sat, 27 Nov 2021 11:44:47 +0000
Date:   Sat, 27 Nov 2021 19:44:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/rc_calc_fpu.c:81:40:
 sparse: sparse: Using plain integer as NULL pointer
Message-ID: <202111271941.jSP6Y7O7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
commit: d738db6883df3e3c513f9e777c842262693f951b drm/amd/display: move FPU associated DSC code to DML folder
date:   4 weeks ago
config: i386-randconfig-s002-20211122 (https://download.01.org/0day-ci/archive/20211127/202111271941.jSP6Y7O7-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d738db6883df3e3c513f9e777c842262693f951b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d738db6883df3e3c513f9e777c842262693f951b
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/rc_calc_fpu.c: note: in included file:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:28:18: sparse: sparse: symbol 'qp_table_422_10bpc_min' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:61:18: sparse: sparse: symbol 'qp_table_444_8bpc_max' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:102:18: sparse: sparse: symbol 'qp_table_420_12bpc_max' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:135:18: sparse: sparse: symbol 'qp_table_444_10bpc_min' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:188:18: sparse: sparse: symbol 'qp_table_420_8bpc_max' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:209:18: sparse: sparse: symbol 'qp_table_444_8bpc_min' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:250:18: sparse: sparse: symbol 'qp_table_444_12bpc_min' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:315:18: sparse: sparse: symbol 'qp_table_420_12bpc_min' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:348:18: sparse: sparse: symbol 'qp_table_422_12bpc_min' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:389:18: sparse: sparse: symbol 'qp_table_422_12bpc_max' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:430:18: sparse: sparse: symbol 'qp_table_444_12bpc_max' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:495:18: sparse: sparse: symbol 'qp_table_420_8bpc_min' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:516:18: sparse: sparse: symbol 'qp_table_422_8bpc_min' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:541:18: sparse: sparse: symbol 'qp_table_422_10bpc_max' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:574:16: sparse: sparse: symbol 'qp_table_420_10bpc_max' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:601:18: sparse: sparse: symbol 'qp_table_420_10bpc_min' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:628:18: sparse: sparse: symbol 'qp_table_444_10bpc_max' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/qp_tables.h:681:18: sparse: sparse: symbol 'qp_table_422_8bpc_max' was not declared. Should it be static?
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/rc_calc_fpu.c:81:40: sparse: sparse: Using plain integer as NULL pointer
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/rc_calc_fpu.c:106:22: sparse: sparse: Using plain integer as NULL pointer

vim +81 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/rc_calc_fpu.c

    73	
    74	static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
    75			       enum max_min max_min, float bpp)
    76	{
    77		int mode = MODE_SELECT(444, 422, 420);
    78		int sel = table_hash(mode, bpc, max_min);
    79		int table_size = 0;
    80		int index;
  > 81		const struct qp_entry *table = 0L;
    82	
    83		// alias enum
    84		enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
    85		switch (sel) {
    86			TABLE_CASE(444,  8, max);
    87			TABLE_CASE(444,  8, min);
    88			TABLE_CASE(444, 10, max);
    89			TABLE_CASE(444, 10, min);
    90			TABLE_CASE(444, 12, max);
    91			TABLE_CASE(444, 12, min);
    92			TABLE_CASE(422,  8, max);
    93			TABLE_CASE(422,  8, min);
    94			TABLE_CASE(422, 10, max);
    95			TABLE_CASE(422, 10, min);
    96			TABLE_CASE(422, 12, max);
    97			TABLE_CASE(422, 12, min);
    98			TABLE_CASE(420,  8, max);
    99			TABLE_CASE(420,  8, min);
   100			TABLE_CASE(420, 10, max);
   101			TABLE_CASE(420, 10, min);
   102			TABLE_CASE(420, 12, max);
   103			TABLE_CASE(420, 12, min);
   104		}
   105	
   106		if (table == 0)
   107			return;
   108	
   109		index = (bpp - table[0].bpp) * 2;
   110	
   111		/* requested size is bigger than the table */
   112		if (index >= table_size) {
   113			dm_error("ERROR: Requested rc_calc to find a bpp entry that exceeds the table size\n");
   114			return;
   115		}
   116	
   117		memcpy(qps, table[index].qps, sizeof(qp_set));
   118	}
   119	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
