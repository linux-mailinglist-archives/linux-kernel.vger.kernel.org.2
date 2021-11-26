Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDFD45F4F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhKZSzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:55:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:55022 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233632AbhKZSxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:53:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="233198759"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="233198759"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 10:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="675632991"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2021 10:43:12 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqgBj-0008Re-I4; Fri, 26 Nov 2021 18:43:11 +0000
Date:   Sat, 27 Nov 2021 02:42:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tero Kristo <tero.kristo@linux.intel.com>
Subject: [t-kristo-pm:usi-5.16-rfc-v2-bpf 13/30]
 drivers/hid/hid-bpf.c:229:24: warning: no previous prototype for function
 'hid_bpf_add_report'
Message-ID: <202111270211.IeJK8UYl-lkp@intel.com>
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
config: hexagon-buildonly-randconfig-r002-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270211.IeJK8UYl-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/t-kristo/linux-pm/commit/db3fbbad76f810554bcb2c098f8c9beb02724702
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v2-bpf
        git checkout db3fbbad76f810554bcb2c098f8c9beb02724702
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hid/hid-bpf.c:141:5: warning: no previous prototype for function 'hid_bpf_prog_detach' [-Wmissing-prototypes]
   int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
       ^
   drivers/hid/hid-bpf.c:141:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int hid_bpf_prog_detach(struct hid_device *hdev, struct bpf_prog *prog)
   ^
   static 
>> drivers/hid/hid-bpf.c:229:24: warning: no previous prototype for function 'hid_bpf_add_report' [-Wmissing-prototypes]
   struct hid_bpf_report *hid_bpf_add_report(struct hid_bpf_parser_and_data *data,
                          ^
   drivers/hid/hid-bpf.c:229:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct hid_bpf_report *hid_bpf_add_report(struct hid_bpf_parser_and_data *data,
   ^
   static 
>> drivers/hid/hid-bpf.c:257:6: warning: no previous prototype for function 'hid_bpf_free_reports' [-Wmissing-prototypes]
   void hid_bpf_free_reports(struct hid_bpf_parser_and_data *data)
        ^
   drivers/hid/hid-bpf.c:257:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void hid_bpf_free_reports(struct hid_bpf_parser_and_data *data)
   ^
   static 
>> drivers/hid/hid-bpf.c:321:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case HID_MAIN_ITEM_TAG_END_COLLECTION:
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/hid.h:96:42: note: expanded from macro 'HID_MAIN_ITEM_TAG_END_COLLECTION'
   #define HID_MAIN_ITEM_TAG_END_COLLECTION        12
                                                   ^~
   drivers/hid/hid-bpf.c:338:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/hid/hid-bpf.c:318:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case HID_MAIN_ITEM_TAG_BEGIN_COLLECTION:
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/hid.h:95:44: note: expanded from macro 'HID_MAIN_ITEM_TAG_BEGIN_COLLECTION'
   #define HID_MAIN_ITEM_TAG_BEGIN_COLLECTION      10
                                                   ^~
   drivers/hid/hid-bpf.c:338:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/hid/hid-bpf.c:311:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   drivers/hid/hid-bpf.c:403:9: error: implicit declaration of function 'BPF_CAST_CALL' [-Werror,-Wimplicit-function-declaration]
                   ret = BPF_CAST_CALL(callback_fn)((u64)(long)ctx,
                         ^
   drivers/hid/hid-bpf.c:403:35: error: called object type 'int' is not a function or function pointer
                   ret = BPF_CAST_CALL(callback_fn)((u64)(long)ctx,
                         ~~~~~~~~~~~~~~~~~~~~~~~~~~^
   5 warnings and 2 errors generated.


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
   272	static int hid_bpf_add_field(struct hid_parser *parser, unsigned report_type, unsigned flags)
   273	{
   274		struct hid_bpf_parser_and_data *data = container_of(parser, struct hid_bpf_parser_and_data, parser);
   275		struct hid_bpf_report *report;
   276		unsigned int application = 0;
   277	
   278		report = hid_bpf_add_report(data, report_type, parser->global.report_id, application);
   279		if (!report) {
   280			hid_err(parser->device, "hid_bpf_add_report failed\n");
   281			return -1;
   282		}
   283	
   284		report->current_offset = report->size;
   285		report->size += parser->global.report_size * parser->global.report_count;
   286	
   287		/* Total size check: Allow for possible report index byte */
   288		if (report->size > (HID_MAX_BUFFER_SIZE - 1) << 3) {
   289			hid_err(parser->device, "report is too long\n");
   290			return -1;
   291		}
   292	
   293		data->callback_data.report = *report;
   294	
   295		return 0;
   296	}
   297	
   298	static u32 hid_bpf_item_udata(struct hid_item *item)
   299	{
   300		switch (item->size) {
   301		case 1: return item->data.u8;
   302		case 2: return item->data.u16;
   303		case 4: return item->data.u32;
   304		}
   305		return 0;
   306	}
   307	
   308	static int hid_bpf_parser_main(struct hid_parser *parser, struct hid_item *item)
   309	{
   310		__u32 data;
   311		int ret;
   312	
   313		hid_concatenate_last_usage_page(parser);
   314	
   315		data = hid_bpf_item_udata(item);
   316	
   317		switch (item->tag) {
   318		case HID_MAIN_ITEM_TAG_BEGIN_COLLECTION:
   319			/* FIXME: handle open collection */
   320			break;
 > 321		case HID_MAIN_ITEM_TAG_END_COLLECTION:
   322			/* FIXME: handle end collection */
   323			break;
   324		case HID_MAIN_ITEM_TAG_INPUT:
   325			ret = hid_bpf_add_field(parser, HID_INPUT_REPORT, data);
   326			break;
   327		case HID_MAIN_ITEM_TAG_OUTPUT:
   328			ret = hid_bpf_add_field(parser, HID_OUTPUT_REPORT, data);
   329			break;
   330		case HID_MAIN_ITEM_TAG_FEATURE:
   331			ret = hid_bpf_add_field(parser, HID_FEATURE_REPORT, data);
   332			break;
   333		default:
   334			hid_warn(parser->device, "unknown main item tag 0x%x\n", item->tag);
   335			ret = 0;
   336		}
   337	
   338		return ret;
   339	}
   340	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
