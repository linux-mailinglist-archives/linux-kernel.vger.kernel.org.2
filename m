Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E451845F2D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhKZR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:26:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:56683 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237460AbhKZRYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:24:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235515261"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="235515261"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 09:21:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="458251698"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2021 09:21:08 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqeuJ-0008Mk-Sa; Fri, 26 Nov 2021 17:21:07 +0000
Date:   Sat, 27 Nov 2021 01:20:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [t-kristo-pm:usi-5.16-rfc-v2-bpf 13/30]
 drivers/hid/hid-bpf.c:229:24: warning: no previous prototype for
 'hid_bpf_add_report'
Message-ID: <202111270132.Dq7VKYca-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-rfc-v2-bpf
head:   241207b4769fca049dfcc4dbde0bda92e4f67027
commit: db3fbbad76f810554bcb2c098f8c9beb02724702 [13/30] HID: bpf: add a helper to parse a given report descriptor
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211127/202111270132.Dq7VKYca-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/t-kristo/linux-pm/commit/db3fbbad76f810554bcb2c098f8c9beb02724702
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v2-bpf
        git checkout db3fbbad76f810554bcb2c098f8c9beb02724702
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hid/hid-bpf.c:141:5: warning: no previous prototype for 'hid_bpf_prog_detach' [-Wmissing-prototypes]
     141 | int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
         |     ^~~~~~~~~~~~~~~~~~~
>> drivers/hid/hid-bpf.c:229:24: warning: no previous prototype for 'hid_bpf_add_report' [-Wmissing-prototypes]
     229 | struct hid_bpf_report *hid_bpf_add_report(struct hid_bpf_parser_and_data *data,
         |                        ^~~~~~~~~~~~~~~~~~
>> drivers/hid/hid-bpf.c:257:6: warning: no previous prototype for 'hid_bpf_free_reports' [-Wmissing-prototypes]
     257 | void hid_bpf_free_reports(struct hid_bpf_parser_and_data *data)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-bpf.c: In function '____bpf_hid_foreach_rdesc_item':
   drivers/hid/hid-bpf.c:403:9: error: implicit declaration of function 'BPF_CAST_CALL'; did you mean 'BPF_EMIT_CALL'? [-Werror=implicit-function-declaration]
     403 |   ret = BPF_CAST_CALL(callback_fn)((u64)(long)ctx,
         |         ^~~~~~~~~~~~~
         |         BPF_EMIT_CALL
   drivers/hid/hid-bpf.c:403:9: error: called object is not a function or function pointer
   cc1: some warnings being treated as errors


vim +/hid_bpf_add_report +229 drivers/hid/hid-bpf.c

   228	
 > 229	struct hid_bpf_report *hid_bpf_add_report(struct hid_bpf_parser_and_data *data,
   230						  unsigned int type, unsigned int id,
   231						  unsigned int application)
   232	{
   233		struct hid_bpf_report_enum *report_enum = data->report_enum + type;
   234		struct hid_bpf_report *report;
   235	
   236		if (id >= HID_MAX_IDS)
   237			return NULL;
   238		if (report_enum->report_id_hash[id])
   239			return report_enum->report_id_hash[id];
   240	
   241		report = kzalloc(sizeof(struct hid_bpf_report), GFP_KERNEL);
   242		if (!report)
   243			return NULL;
   244	
   245		if (id != 0)
   246			report_enum->numbered = 1;
   247	
   248		report->id = id;
   249		report->type = type;
   250		report->size = 0;
   251		report->application = application;
   252		report_enum->report_id_hash[id] = report;
   253	
   254		return report;
   255	}
   256	
 > 257	void hid_bpf_free_reports(struct hid_bpf_parser_and_data *data)
   258	{
   259		unsigned i, j;
   260	
   261		for (i = 0; i < HID_REPORT_TYPES; i++) {
   262			struct hid_bpf_report_enum *report_enum = data->report_enum + i;
   263	
   264			for (j = 0; j < HID_MAX_IDS; j++) {
   265				struct hid_bpf_report *report = report_enum->report_id_hash[j];
   266				kfree(report);
   267			}
   268			memset(report_enum, 0, sizeof(*report_enum));
   269		}
   270	}
   271	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
