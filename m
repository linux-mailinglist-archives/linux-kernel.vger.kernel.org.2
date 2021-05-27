Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E44A392B81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhE0KMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:12:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:27217 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235950AbhE0KMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:12:44 -0400
IronPort-SDR: TqPNZ5Q+A9UomTIcAkhmlllQlj4WwlHS5eCvyfIuy5ihNaekbj5d9tDCKFNmP1Ekircy+y9FrI
 Zor4O4+9hqYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="266587820"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="gz'50?scan'50,208,50";a="266587820"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 03:11:11 -0700
IronPort-SDR: dlJGSDEjKk+qmLTmibgN8gQczj6cwCe/gVQtarFKwmuRL5twBVjbeWYtabkJgRrQQPphqRdgac
 CcyhQiFrOqyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="gz'50?scan'50,208,50";a="633940537"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2021 03:11:08 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lmCyq-0002hO-88; Thu, 27 May 2021 10:11:08 +0000
Date:   Thu, 27 May 2021 18:11:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baokun Li <libaokun1@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, weiyongjun1@huawei.com,
        yuehaibing@huawei.com, yangjihong1@huawei.com, yukuai3@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH -next] driver core: Remove set but not used variable
 'no_warn'
Message-ID: <202105271808.EfMVdIzx-lkp@intel.com>
References: <20210527091453.3880695-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20210527091453.3880695-1-libaokun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baokun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20210526]

url:    https://github.com/0day-ci/linux/commits/Baokun-Li/driver-core-Remove-set-but-not-used-variable-no_warn/20210527-170758
base:    f6b46ef27317b3441138b902689bd89e4f82c6f4
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/c41d30a4b7791bb76211dd1ddb7b467d555ad596
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Baokun-Li/driver-core-Remove-set-but-not-used-variable-no_warn/20210527-170758
        git checkout c41d30a4b7791bb76211dd1ddb7b467d555ad596
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/base/module.c: In function 'module_add_driver':
>> drivers/base/module.c:61:2: warning: ignoring return value of 'sysfs_create_link', declared with attribute warn_unused_result [-Wunused-result]
      61 |  sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/module.c:65:3: warning: ignoring return value of 'sysfs_create_link', declared with attribute warn_unused_result [-Wunused-result]
      65 |   sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      66 |       driver_name);
         |       ~~~~~~~~~~~~


vim +/sysfs_create_link +61 drivers/base/module.c

    32	
    33	void module_add_driver(struct module *mod, struct device_driver *drv)
    34	{
    35		char *driver_name;
    36		struct module_kobject *mk = NULL;
    37	
    38		if (!drv)
    39			return;
    40	
    41		if (mod)
    42			mk = &mod->mkobj;
    43		else if (drv->mod_name) {
    44			struct kobject *mkobj;
    45	
    46			/* Lookup built-in module entry in /sys/modules */
    47			mkobj = kset_find_obj(module_kset, drv->mod_name);
    48			if (mkobj) {
    49				mk = container_of(mkobj, struct module_kobject, kobj);
    50				/* remember our module structure */
    51				drv->p->mkobj = mk;
    52				/* kset_find_obj took a reference */
    53				kobject_put(mkobj);
    54			}
    55		}
    56	
    57		if (!mk)
    58			return;
    59	
    60		/* Don't check return codes; these calls are idempotent */
  > 61		sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
    62		driver_name = make_driver_name(drv);
    63		if (driver_name) {
    64			module_create_drivers_dir(mk);
    65			sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
    66					  driver_name);
    67			kfree(driver_name);
    68		}
    69	}
    70	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2fHTh5uZTiUOsy+g
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2fHTh5uZTiUOsy+g--
