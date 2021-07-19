Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE72A3CD021
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhGSI2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:28:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3430 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhGSI2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:28:40 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GSwFc0mcQz6D8sQ;
        Mon, 19 Jul 2021 16:37:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 10:52:04 +0200
Received: from localhost (10.47.80.117) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 09:52:02 +0100
Date:   Mon, 19 Jul 2021 09:51:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [iio:testing 20/38] drivers/iio/dac/ad5624r_spi.c:296:1:
 warning: ISO C90 forbids mixed declarations and code
Message-ID: <20210719095141.00007c2c@Huawei.com>
In-Reply-To: <202107190634.g0BVPvia-lkp@intel.com>
References: <202107190634.g0BVPvia-lkp@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.117]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 06:50:43 +0800
kernel test robot <lkp@intel.com> wrote:

Gah. Failed to commit the local fix I had for this.  Now rectified.

Jonathan


> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> head:   49be30ad801804ba0ba0051eefd61f2ce74060d7
> commit: 78379c9664cf4c92b7789d04d4dcc8714edb8385 [20/38] iio: dac: ad5624r: Fix incorrect handling of an optional regulator.
> config: i386-randconfig-a014-20210718 (attached as .config)
> compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=78379c9664cf4c92b7789d04d4dcc8714edb8385
>         git remote add iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>         git fetch --no-tags iio testing
>         git checkout 78379c9664cf4c92b7789d04d4dcc8714edb8385
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/iio/dac/ad5624r_spi.c: In function 'ad5624r_probe':
>    drivers/iio/dac/ad5624r_spi.c:296:12: error: invalid storage class for function 'ad5624r_remove'
>      296 | static int ad5624r_remove(struct spi_device *spi)
>          |            ^~~~~~~~~~~~~~
> >> drivers/iio/dac/ad5624r_spi.c:296:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]  
>      296 | static int ad5624r_remove(struct spi_device *spi)
>          | ^~~~~~
>    drivers/iio/dac/ad5624r_spi.c:324:12: error: initializer element is not constant
>      324 |  .remove = ad5624r_remove,
>          |            ^~~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:324:12: note: (near initialization for 'ad5624r_driver.remove')
>    drivers/iio/dac/ad5624r_spi.c:319:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>      319 | static struct spi_driver ad5624r_driver = {
>          | ^~~~~~
>    In file included from include/linux/device.h:32,
>                     from drivers/iio/dac/ad5624r_spi.c:10:
>    drivers/iio/dac/ad5624r_spi.c:327:19: error: invalid storage class for function 'ad5624r_driver_init'
>      327 | module_spi_driver(ad5624r_driver);
>          |                   ^~~~~~~~~~~~~~
>    include/linux/device/driver.h:259:19: note: in definition of macro 'module_driver'
>      259 | static int __init __driver##_init(void) \
>          |                   ^~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
>    In file included from include/linux/export.h:43,
>                     from include/linux/linkage.h:7,
>                     from include/linux/kernel.h:8,
>                     from include/linux/interrupt.h:6,
>                     from drivers/iio/dac/ad5624r_spi.c:8:
>    include/linux/compiler.h:242:46: error: initializer element is not constant
>      242 |   __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
>          |                                              ^
>    include/linux/init.h:236:2: note: in expansion of macro '__ADDRESSABLE'
>      236 |  __ADDRESSABLE(fn)
>          |  ^~~~~~~~~~~~~
>    include/linux/init.h:241:2: note: in expansion of macro '__define_initcall_stub'
>      241 |  __define_initcall_stub(__stub, fn)   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~
>    include/linux/init.h:254:2: note: in expansion of macro '____define_initcall'
>      254 |  ____define_initcall(fn,     \
>          |  ^~~~~~~~~~~~~~~~~~~
>    include/linux/init.h:260:2: note: in expansion of macro '__unique_initcall'
>      260 |  __unique_initcall(fn, id, __sec, __initcall_id(fn))
>          |  ^~~~~~~~~~~~~~~~~
>    include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
>      262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
>          |                                   ^~~~~~~~~~~~~~~~~~
>    include/linux/init.h:291:30: note: in expansion of macro '__define_initcall'
>      291 | #define device_initcall(fn)  __define_initcall(fn, 6)
>          |                              ^~~~~~~~~~~~~~~~~
>    include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
>      296 | #define __initcall(fn) device_initcall(fn)
>          |                        ^~~~~~~~~~~~~~~
>    include/linux/module.h:88:24: note: in expansion of macro '__initcall'
>       88 | #define module_init(x) __initcall(x);
>          |                        ^~~~~~~~~~
>    include/linux/device/driver.h:263:1: note: in expansion of macro 'module_init'
>      263 | module_init(__driver##_init); \
>          | ^~~~~~~~~~~
>    include/linux/spi/spi.h:317:2: note: in expansion of macro 'module_driver'
>      317 |  module_driver(__spi_driver, spi_register_driver, \
>          |  ^~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
>    In file included from include/linux/bits.h:22,
>                     from include/linux/bitops.h:6,
>                     from include/linux/kernel.h:12,
>                     from include/linux/interrupt.h:6,
>                     from drivers/iio/dac/ad5624r_spi.c:8:
> >> include/linux/build_bug.h:78:41: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]  
>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>          |                                         ^~~~~~~~~~~~~~
>    include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>       77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>          |                                  ^~~~~~~~~~~~~~~
>    include/linux/init.h:246:2: note: in expansion of macro 'static_assert'
>      246 |  static_assert(__same_type(initcall_t, &fn));
>          |  ^~~~~~~~~~~~~
>    include/linux/init.h:254:2: note: in expansion of macro '____define_initcall'
>      254 |  ____define_initcall(fn,     \
>          |  ^~~~~~~~~~~~~~~~~~~
>    include/linux/init.h:260:2: note: in expansion of macro '__unique_initcall'
>      260 |  __unique_initcall(fn, id, __sec, __initcall_id(fn))
>          |  ^~~~~~~~~~~~~~~~~
>    include/linux/init.h:262:35: note: in expansion of macro '___define_initcall'
>      262 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
>          |                                   ^~~~~~~~~~~~~~~~~~
>    include/linux/init.h:291:30: note: in expansion of macro '__define_initcall'
>      291 | #define device_initcall(fn)  __define_initcall(fn, 6)
>          |                              ^~~~~~~~~~~~~~~~~
>    include/linux/init.h:296:24: note: in expansion of macro 'device_initcall'
>      296 | #define __initcall(fn) device_initcall(fn)
>          |                        ^~~~~~~~~~~~~~~
>    include/linux/module.h:88:24: note: in expansion of macro '__initcall'
>       88 | #define module_init(x) __initcall(x);
>          |                        ^~~~~~~~~~
>    include/linux/device/driver.h:263:1: note: in expansion of macro 'module_init'
>      263 | module_init(__driver##_init); \
>          | ^~~~~~~~~~~
>    include/linux/spi/spi.h:317:2: note: in expansion of macro 'module_driver'
>      317 |  module_driver(__spi_driver, spi_register_driver, \
>          |  ^~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
>    In file included from include/linux/device.h:32,
>                     from drivers/iio/dac/ad5624r_spi.c:10:
>    drivers/iio/dac/ad5624r_spi.c:327:19: error: invalid storage class for function 'ad5624r_driver_exit'
>      327 | module_spi_driver(ad5624r_driver);
>          |                   ^~~~~~~~~~~~~~
>    include/linux/device/driver.h:264:20: note: in definition of macro 'module_driver'
>      264 | static void __exit __driver##_exit(void) \
>          |                    ^~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
> >> include/linux/device/driver.h:264:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]  
>      264 | static void __exit __driver##_exit(void) \
>          | ^~~~~~
>    include/linux/spi/spi.h:317:2: note: in expansion of macro 'module_driver'
>      317 |  module_driver(__spi_driver, spi_register_driver, \
>          |  ^~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
>    In file included from include/linux/printk.h:6,
>                     from include/linux/kernel.h:19,
>                     from include/linux/interrupt.h:6,
>                     from drivers/iio/dac/ad5624r_spi.c:8:
>    drivers/iio/dac/ad5624r_spi.c:327:19: error: initializer element is not constant
>      327 | module_spi_driver(ad5624r_driver);
>          |                   ^~~~~~~~~~~~~~
>    include/linux/init.h:299:50: note: in definition of macro '__exitcall'
>      299 |  static exitcall_t __exitcall_##fn __exit_call = fn
>          |                                                  ^~
>    include/linux/device/driver.h:268:1: note: in expansion of macro 'module_exit'
>      268 | module_exit(__driver##_exit);
>          | ^~~~~~~~~~~
>    include/linux/spi/spi.h:317:2: note: in expansion of macro 'module_driver'
>      317 |  module_driver(__spi_driver, spi_register_driver, \
>          |  ^~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:327:1: note: in expansion of macro 'module_spi_driver'
>      327 | module_spi_driver(ad5624r_driver);
>          | ^~~~~~~~~~~~~~~~~
>    In file included from include/linux/module.h:22,
>                     from include/linux/bpf.h:19,
>                     from include/linux/bpf-cgroup.h:5,
>                     from include/linux/cgroup-defs.h:22,
>                     from include/linux/cgroup.h:28,
>                     from include/linux/memcontrol.h:13,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from include/linux/regulator/consumer.h:35,
>                     from drivers/iio/dac/ad5624r_spi.c:15:
> >> include/linux/moduleparam.h:24:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]  
>       24 |  static const char __UNIQUE_ID(name)[]      \
>          |  ^~~~~~
>    include/linux/module.h:166:32: note: in expansion of macro '__MODULE_INFO'
>      166 | #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
>          |                                ^~~~~~~~~~~~~
>    include/linux/module.h:236:32: note: in expansion of macro 'MODULE_INFO'
>      236 | #define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
>          |                                ^~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:329:1: note: in expansion of macro 'MODULE_AUTHOR'
>      329 | MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
>          | ^~~~~~~~~~~~~
>    drivers/iio/dac/ad5624r_spi.c:331:1: error: expected declaration or statement at end of input
>      331 | MODULE_LICENSE("GPL v2");
>          | ^~~~~~~~~~~~~~
>    At top level:
>    drivers/iio/dac/ad5624r_spi.c:222:12: warning: 'ad5624r_probe' defined but not used [-Wunused-function]
>      222 | static int ad5624r_probe(struct spi_device *spi)
>          |            ^~~~~~~~~~~~~
> 
> 
> vim +296 drivers/iio/dac/ad5624r_spi.c
> 
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  295  
> fc52692c49969e drivers/iio/dac/ad5624r_spi.c         Greg Kroah-Hartman 2012-12-21 @296  static int ad5624r_remove(struct spi_device *spi)
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  297  {
> 3ff242055b7b46 drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-06-27  298  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> 3ff242055b7b46 drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-06-27  299  	struct ad5624r_state *st = iio_priv(indio_dev);
> 3ff242055b7b46 drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-06-27  300  
> d2fffd6c2fd60f drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-10-14  301  	iio_device_unregister(indio_dev);
> 75238230cce22b drivers/iio/dac/ad5624r_spi.c         Sachin Kamat       2013-08-19  302  	if (!IS_ERR(st->reg))
> 26a54797c1b094 drivers/staging/iio/dac/ad5624r_spi.c Jonathan Cameron   2011-08-30  303  		regulator_disable(st->reg);
> 14f88f1b07e03b drivers/staging/iio/dac/ad5624r_spi.c Michael Hennerich  2011-03-09  304  
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  305  	return 0;
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  306  }
> 6790e29fef61b2 drivers/staging/iio/dac/ad5624r_spi.c Barry Song         2010-10-27  307  
> 
> :::::: The code at line 296 was first introduced by commit
> :::::: fc52692c49969ec72595766929b9f54ac402da34 Drivers: iio: remove __dev* attributes.
> 
> :::::: TO: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

