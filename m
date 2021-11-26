Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34045E3A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356814AbhKZAWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:22:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:6781 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346150AbhKZAUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:20:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235823510"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235823510"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 16:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="741395724"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Nov 2021 16:16:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqOvA-000785-F0; Fri, 26 Nov 2021 00:16:56 +0000
Date:   Fri, 26 Nov 2021 08:16:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Henningsson <coding@diwic.se>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jaroslav Kysela <perex@perex.cz>
Subject: sound/core/rawmidi_compat.c:29:29: warning: taking address of packed
 member 'mode' of class or structure 'snd_rawmidi_params32' may result in an
 unaligned pointer value
Message-ID: <202111260812.IlTs6tBq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ced7ca3570333998ad2088d5a6275701970e28e
commit: 08fdced60ca08e34e316a3ab945636fcdfcbc973 ALSA: rawmidi: Add framing mode
date:   6 months ago
config: mips-randconfig-r002-20211031 (https://download.01.org/0day-ci/archive/20211126/202111260812.IlTs6tBq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d321548c3ce987f4f21350ba1c81fdb5d4354224)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08fdced60ca08e34e316a3ab945636fcdfcbc973
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 08fdced60ca08e34e316a3ab945636fcdfcbc973
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:26:31: warning: taking address of packed member 'stream' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
           if (get_user(params.stream, &src->stream) ||
                                        ^~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:21: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                              ^~~
   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:26:31: warning: taking address of packed member 'stream' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
           if (get_user(params.stream, &src->stream) ||
                                        ^~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:42: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                                                   ^~~
   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:27:36: warning: taking address of packed member 'buffer_size' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
               get_user(params.buffer_size, &src->buffer_size) ||
                                             ^~~~~~~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:21: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                              ^~~
   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:27:36: warning: taking address of packed member 'buffer_size' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
               get_user(params.buffer_size, &src->buffer_size) ||
                                             ^~~~~~~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:42: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                                                   ^~~
   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:28:34: warning: taking address of packed member 'avail_min' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
               get_user(params.avail_min, &src->avail_min) ||
                                           ^~~~~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:21: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                              ^~~
   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:28:34: warning: taking address of packed member 'avail_min' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
               get_user(params.avail_min, &src->avail_min) ||
                                           ^~~~~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:42: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                                                   ^~~
   In file included from sound/core/rawmidi.c:1608:
>> sound/core/rawmidi_compat.c:29:29: warning: taking address of packed member 'mode' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
               get_user(params.mode, &src->mode) ||
                                      ^~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:21: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                              ^~~
   In file included from sound/core/rawmidi.c:1608:
>> sound/core/rawmidi_compat.c:29:29: warning: taking address of packed member 'mode' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
               get_user(params.mode, &src->mode) ||
                                      ^~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:42: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                                                   ^~~
   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:30:21: warning: taking address of packed member 'no_active_sensing' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
               get_user(val, &src->no_active_sensing))
                              ^~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:21: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                              ^~~
   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:30:21: warning: taking address of packed member 'no_active_sensing' of class or structure 'snd_rawmidi_params32' may result in an unaligned pointer value [-Waddress-of-packed-member]
               get_user(val, &src->no_active_sensing))
                              ^~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:42: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                                                   ^~~
   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:63:31: warning: taking address of packed member 'stream' of class or structure 'compat_snd_rawmidi_status64' may result in an unaligned pointer value [-Waddress-of-packed-member]
           if (get_user(status.stream, &src->stream))
                                        ^~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:21: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                              ^~~
   In file included from sound/core/rawmidi.c:1608:
   sound/core/rawmidi_compat.c:63:31: warning: taking address of packed member 'stream' of class or structure 'compat_snd_rawmidi_status64' may result in an unaligned pointer value [-Waddress-of-packed-member]
           if (get_user(status.stream, &src->stream))
                                        ^~~~~~~~~~~
   arch/mips/include/asm/uaccess.h:135:42: note: expanded from macro 'get_user'
           const __typeof__(*(ptr)) __user *__p = (ptr);                   \
                                                   ^~~
   12 warnings generated.


vim +29 sound/core/rawmidi_compat.c

    19	
    20	static int snd_rawmidi_ioctl_params_compat(struct snd_rawmidi_file *rfile,
    21						   struct snd_rawmidi_params32 __user *src)
    22	{
    23		struct snd_rawmidi_params params;
    24		unsigned int val;
    25	
    26		if (get_user(params.stream, &src->stream) ||
    27		    get_user(params.buffer_size, &src->buffer_size) ||
    28		    get_user(params.avail_min, &src->avail_min) ||
  > 29		    get_user(params.mode, &src->mode) ||
    30		    get_user(val, &src->no_active_sensing))
    31			return -EFAULT;
    32		params.no_active_sensing = val;
    33		switch (params.stream) {
    34		case SNDRV_RAWMIDI_STREAM_OUTPUT:
    35			if (!rfile->output)
    36				return -EINVAL;
    37			return snd_rawmidi_output_params(rfile->output, &params);
    38		case SNDRV_RAWMIDI_STREAM_INPUT:
    39			if (!rfile->input)
    40				return -EINVAL;
    41			return snd_rawmidi_input_params(rfile->input, &params);
    42		}
    43		return -EINVAL;
    44	}
    45	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
