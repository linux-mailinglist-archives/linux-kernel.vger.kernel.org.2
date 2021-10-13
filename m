Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D64B42C7CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbhJMRma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:42:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3978 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhJMRm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:42:28 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HV08N4j7Fz67XhV;
        Thu, 14 Oct 2021 01:36:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 13 Oct 2021 19:40:23 +0200
Received: from localhost (10.52.125.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 18:40:22 +0100
Date:   Wed, 13 Oct 2021 18:40:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: Re: [jic23-iio:testing 149/151]
 drivers/iio/buffer/kfifo_buf.c:165:9: sparse: sparse: cast to restricted
 __poll_t
Message-ID: <20211013184001.00005b76@Huawei.com>
In-Reply-To: <202110110440.lDjKV8lX-lkp@intel.com>
References: <202110110440.lDjKV8lX-lkp@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.73]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 04:39:48 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> head:   687109cbbfd744cba8aea3580770dcf6e13ce12a
> commit: dc02c5452d3a3c2792efae0b6b436634915384ac [149/151] iio: kfifo-buffer: Add output buffer support
> config: xtensa-randconfig-s031-20211010 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=dc02c5452d3a3c2792efae0b6b436634915384ac
>         git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>         git fetch --no-tags jic23-iio testing
>         git checkout dc02c5452d3a3c2792efae0b6b436634915384ac
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/iio/buffer/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/iio/buffer/kfifo_buf.c:165:9: sparse: sparse: cast to restricted __poll_t  
> 
> vim +165 drivers/iio/buffer/kfifo_buf.c
> 
>    152	
>    153	static int iio_kfifo_remove_from(struct iio_buffer *r, void *data)
>    154	{
>    155		int ret;
>    156		struct iio_kfifo *kf = iio_to_kfifo(r);
>    157	
>    158		if (kfifo_size(&kf->kf) < 1)
>    159			return -EBUSY;
>    160	
>    161		ret = kfifo_out(&kf->kf, data, 1);
>    162		if (ret != 1)
>    163			return -EBUSY;
>    164	
>  > 165		wake_up_interruptible_poll(&r->pollq, POLLOUT | POLLWRNORM);  

These should be EPOLLOUT and EPOLLWRNORM I believe. I'll apply a fixup.

>    166	
>    167		return 0;
>    168	}
>    169	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

