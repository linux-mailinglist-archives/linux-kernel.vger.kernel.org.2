Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E520942EFC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhJOLgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:36:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:12609 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhJOLgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:36:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="227790826"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="gz'50?scan'50,208,50";a="227790826"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 04:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="gz'50?scan'50,208,50";a="660488636"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2021 04:34:31 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbLTr-0007ox-5Q; Fri, 15 Oct 2021 11:34:31 +0000
Date:   Fri, 15 Oct 2021 19:33:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [tglx-devel:x86/fpu 81/82] core.c:undefined reference to
 `__fpu_state_size_dynamic'
Message-ID: <202110151943.TO9fT9O1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu
head:   fbeb78415a1b32f890fa49e4355faa02bb0c0602
commit: 57e37526099d33c397f7a6bb1a0198ba1e148478 [81/82] x86/fpu: Add XFD handling for dynamic states
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=57e37526099d33c397f7a6bb1a0198ba1e148478
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel x86/fpu
        git checkout 57e37526099d33c397f7a6bb1a0198ba1e148478
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/fpu/core.o: in function `fpu_clone':
>> core.c:(.text+0x3ed): undefined reference to `__fpu_state_size_dynamic'
   ld: arch/x86/kernel/fpu/xstate.o: in function `fpu__resume_cpu':
>> xstate.c:(.text+0x4af): undefined reference to `__fpu_state_size_dynamic'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICGpiaWEAAy5jb25maWcAnFxbc9u2s3/vp+C0M2fah6S+xP47c8YPEAhKqHgLQeriF44i
04mmtuQjyW3y7c8uQIoguVByTmfa2tgFiMtefrtY+LdffvPY23H3sjpu1qvn5+/el2pb7VfH
6tF72jxX/+35iRcnuSd8mb8H5nCzffv25+b67ta7eX958/7i3X597U2r/bZ69vhu+7T58gbd
N7vtL7/9wpM4kOOS83ImMiWTuMzFIr//9ct6/e6j97tffd6stt7H99cwzNXVH+anX61uUpVj
zu+/N03jdqj7jxfXFxcn3pDF4xPp1MyUHiIu2iGgqWG7ur65uGraQx9ZR4HfskITzWoRLqzZ
chaXoYyn7QhWY6lylkveoU1gMkxF5TjJE5IgY+gqBqQ4KdMsCWQoyiAuWZ5nLYvMPpXzJLMm
MSpk6OcyEmXORtBFJVneUvNJJhisPQ4S+A+wKOwKh/ebN9ai8OwdquPba3ucoyyZiriE01RR
an04lnkp4lnJMtgiGcn8/voKRmmmnkQpTjgXKvc2B2+7O+LALcNcZFmS2aRmuxPOwma/f/21
7WETSlbkCdFZL75ULMyxa904YTNRTkUWi7AcP0hrETZlBJQrmhQ+RIymLB5cPRIX4QNNeFA5
yuJptdZ8yf2zZ32OAedObJQ9/2GX5PyIH86RcSHEB30RsCLMtdxYZ9M0TxKVxywS97/+vt1t
qz+sc1dLNZMpp6WI5XxSfipEIUg6zxKlykhESbZEzWF8QvIVSoRyRExbHxHL4COsAJsIcwEh
DBuVAe3zDm+fD98Px+qlVZmxiEUmuVZO0NyRpdI2SU2SuS0MmQ+tqlTzMhNKxD7dC2nZDIwL
aEGU+KJrC4Ik48Kv1VzG45aqUpYpgUz6yKvto7d76q2gta8Jn6qkgLHMFvuJNZLeDptFn+l3
qvOMhdJnuShDpvKSL3lI7IU2VrN2a3tkPZ6YiThXZ4llBAaN+X8VKif4okSVRYpz6elfmii5
KHla6HlkStvExqbqU843L9X+QB305KFMYfjE15b+JE1gsIEi/ZAWSk0mKRM5nuAB11Pp8tQn
NphNZzVilAblX/o49Nzh187ET59CvnrLyc90OzbfSDMhojSHJWg/dRqtaZ8lYRHnLFuSy6u5
bJqZUlr8ma8Of3tHWJu3ggkcjqvjwVut17u37XGz/dJuOTjVqT4txnkC3zIyfvoE6oCWp5ZM
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

--RnlQjJ0d97Da+TV1--
