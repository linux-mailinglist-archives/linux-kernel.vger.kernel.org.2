Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF993EBFFA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 04:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbhHNC5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 22:57:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:12863 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236466AbhHNC5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 22:57:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="202851935"
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="gz'50?scan'50,208,50";a="202851935"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 19:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="gz'50?scan'50,208,50";a="508482224"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2021 19:56:44 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mEjqm-000OLc-AL; Sat, 14 Aug 2021 02:56:44 +0000
Date:   Sat, 14 Aug 2021 10:56:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20210813-sysfs-fixes-v8 4/10] fs/kernfs/file.c:262:69:
 error: macro "kernfs_debug_should_wait" passed 2 arguments, but takes just 1
Message-ID: <202108141020.SK0WVBMv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210813-sysfs-fixes-v8
head:   f5b8aadeca76656caad8bccc795bfe7b0730230a
commit: 039380571a670bd61d4192cbabbfcdff60c7f630 [4/10] kernfs: add initial failure injection support
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=039380571a670bd61d4192cbabbfcdff60c7f630
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20210813-sysfs-fixes-v8
        git checkout 039380571a670bd61d4192cbabbfcdff60c7f630
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/kernfs/file.c: In function 'kernfs_fop_write_iter':
>> fs/kernfs/file.c:262:69: error: macro "kernfs_debug_should_wait" passed 2 arguments, but takes just 1
     262 |         if (kernfs_debug_should_wait(kernfs_fop_write_iter, at_start))
         |                                                                     ^
   In file included from fs/kernfs/file.c:19:
   fs/kernfs/kernfs-internal.h:218: note: macro "kernfs_debug_should_wait" defined here
     218 | #define kernfs_debug_should_wait(when) (false)
         | 
>> fs/kernfs/file.c:262:13: error: 'kernfs_debug_should_wait' undeclared (first use in this function); did you mean 'kernfs_debug_wait'?
     262 |         if (kernfs_debug_should_wait(kernfs_fop_write_iter, at_start))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
         |             kernfs_debug_wait
   fs/kernfs/file.c:262:13: note: each undeclared identifier is reported only once for each function it appears in
   fs/kernfs/file.c:286:73: error: macro "kernfs_debug_should_wait" passed 2 arguments, but takes just 1
     286 |         if (kernfs_debug_should_wait(kernfs_fop_write_iter, before_mutex))
         |                                                                         ^
   In file included from fs/kernfs/file.c:19:
   fs/kernfs/kernfs-internal.h:218: note: macro "kernfs_debug_should_wait" defined here
     218 | #define kernfs_debug_should_wait(when) (false)
         | 
   fs/kernfs/file.c:295:72: error: macro "kernfs_debug_should_wait" passed 2 arguments, but takes just 1
     295 |         if (kernfs_debug_should_wait(kernfs_fop_write_iter, after_mutex))
         |                                                                        ^
   In file included from fs/kernfs/file.c:19:
   fs/kernfs/kernfs-internal.h:218: note: macro "kernfs_debug_should_wait" defined here
     218 | #define kernfs_debug_should_wait(when) (false)
         | 
   fs/kernfs/file.c:304:73: error: macro "kernfs_debug_should_wait" passed 2 arguments, but takes just 1
     304 |         if (kernfs_debug_should_wait(kernfs_fop_write_iter, after_active))
         |                                                                         ^
   In file included from fs/kernfs/file.c:19:
   fs/kernfs/kernfs-internal.h:218: note: macro "kernfs_debug_should_wait" defined here
     218 | #define kernfs_debug_should_wait(when) (false)
         | 


vim +/kernfs_debug_should_wait +262 fs/kernfs/file.c

   244	
   245	/*
   246	 * Copy data in from userland and pass it to the matching kernfs write
   247	 * operation.
   248	 *
   249	 * There is no easy way for us to know if userspace is only doing a partial
   250	 * write, so we don't support them. We expect the entire buffer to come on
   251	 * the first write.  Hint: if you're writing a value, first read the file,
   252	 * modify only the the value you're changing, then write entire buffer
   253	 * back.
   254	 */
   255	static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
   256	{
   257		struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
   258		ssize_t len = iov_iter_count(iter);
   259		const struct kernfs_ops *ops;
   260		char *buf;
   261	
 > 262		if (kernfs_debug_should_wait(kernfs_fop_write_iter, at_start))
   263			kernfs_debug_wait();
   264	
   265		if (of->atomic_write_len) {
   266			if (len > of->atomic_write_len)
   267				return -E2BIG;
   268		} else {
   269			len = min_t(size_t, len, PAGE_SIZE);
   270		}
   271	
   272		buf = of->prealloc_buf;
   273		if (buf)
   274			mutex_lock(&of->prealloc_mutex);
   275		else
   276			buf = kmalloc(len + 1, GFP_KERNEL);
   277		if (!buf)
   278			return -ENOMEM;
   279	
   280		if (copy_from_iter(buf, len, iter) != len) {
   281			len = -EFAULT;
   282			goto out_free;
   283		}
   284		buf[len] = '\0';	/* guarantee string termination */
   285	
   286		if (kernfs_debug_should_wait(kernfs_fop_write_iter, before_mutex))
   287			kernfs_debug_wait();
   288	
   289		/*
   290		 * @of->mutex nests outside active ref and is used both to ensure that
   291		 * the ops aren't called concurrently for the same open file.
   292		 */
   293		mutex_lock(&of->mutex);
   294	
   295		if (kernfs_debug_should_wait(kernfs_fop_write_iter, after_mutex))
   296			kernfs_debug_wait();
   297	
   298		if (!kernfs_get_active(of->kn)) {
   299			mutex_unlock(&of->mutex);
   300			len = -ENODEV;
   301			goto out_free;
   302		}
   303	
   304		if (kernfs_debug_should_wait(kernfs_fop_write_iter, after_active))
   305			kernfs_debug_wait();
   306	
   307		ops = kernfs_ops(of->kn);
   308		if (ops->write)
   309			len = ops->write(of, buf, len, iocb->ki_pos);
   310		else
   311			len = -EINVAL;
   312	
   313		kernfs_put_active(of->kn);
   314		mutex_unlock(&of->mutex);
   315	
   316		if (len > 0)
   317			iocb->ki_pos += len;
   318	
   319	out_free:
   320		if (buf == of->prealloc_buf)
   321			mutex_unlock(&of->prealloc_mutex);
   322		else
   323			kfree(buf);
   324		return len;
   325	}
   326	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--X1bOJ3K7DJ5YkBrT--
