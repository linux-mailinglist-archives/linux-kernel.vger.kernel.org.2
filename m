Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20A444D79B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhKKN4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:56:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:4598 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233529AbhKKN4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:56:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="233157369"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="gz'50?scan'50,208,50";a="233157369"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 05:53:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="gz'50?scan'50,208,50";a="492548940"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 05:53:36 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mlAWF-000GZZ-Ne; Thu, 11 Nov 2021 13:53:35 +0000
Date:   Thu, 11 Nov 2021 21:53:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:t6000/bringup-work 20/23]
 drivers/gpu/drm/drm_format_helper.c:408:6: warning: no previous prototype
 for 'drm_fb_xrgb8888_to_xrgb2101010_dstclip'
Message-ID: <202111112111.QrPfVyKQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/AsahiLinux/linux t6000/bringup-work
head:   62c107f5adde6d76632c6e2c1eff3efa25707099
commit: f32fd9413157a8c6e03acaca0504d4c3512d780e [20/23] drm/format-helper: Add drm_fb_xrgb8888_to_xrgb2101010_dstclip()
config: ia64-defconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/f32fd9413157a8c6e03acaca0504d4c3512d780e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux t6000/bringup-work
        git checkout f32fd9413157a8c6e03acaca0504d4c3512d780e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_format_helper.c:408:6: warning: no previous prototype for 'drm_fb_xrgb8888_to_xrgb2101010_dstclip' [-Wmissing-prototypes]
     408 | void drm_fb_xrgb8888_to_xrgb2101010_dstclip(void __iomem *dst,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:8,
                    from include/linux/numa.h:24,
                    from arch/ia64/include/asm/nodedata.h:14,
                    from arch/ia64/include/asm/processor.h:81,
                    from arch/ia64/include/asm/timex.h:15,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/gpu/drm/drm_format_helper.c:11:
   include/linux/export.h:67:43: error: redefinition of '__ksymtab_drm_fb_xrgb8888_to_rgb888_dstclip'
      67 |         static const struct kernel_symbol __ksymtab_##sym               \
         |                                           ^~~~~~~~~~
   include/linux/export.h:108:9: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |         __KSYMTAB_ENTRY(sym, sec)
         |         ^~~~~~~~~~~~~~~
   include/linux/export.h:152:41: note: in expansion of macro '___EXPORT_SYMBOL'
     152 | #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/export.h:160:41: note: in expansion of macro '__EXPORT_SYMBOL'
     160 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:163:41: note: in expansion of macro '_EXPORT_SYMBOL'
     163 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   drivers/gpu/drm/drm_format_helper.c:433:1: note: in expansion of macro 'EXPORT_SYMBOL'
     433 | EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_dstclip);
         | ^~~~~~~~~~~~~
   include/linux/export.h:67:43: note: previous definition of '__ksymtab_drm_fb_xrgb8888_to_rgb888_dstclip' with type 'const struct kernel_symbol'
      67 |         static const struct kernel_symbol __ksymtab_##sym               \
         |                                           ^~~~~~~~~~
   include/linux/export.h:108:9: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |         __KSYMTAB_ENTRY(sym, sec)
         |         ^~~~~~~~~~~~~~~
   include/linux/export.h:152:41: note: in expansion of macro '___EXPORT_SYMBOL'
     152 | #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/export.h:160:41: note: in expansion of macro '__EXPORT_SYMBOL'
     160 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:163:41: note: in expansion of macro '_EXPORT_SYMBOL'
     163 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   drivers/gpu/drm/drm_format_helper.c:379:1: note: in expansion of macro 'EXPORT_SYMBOL'
     379 | EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_dstclip);
         | ^~~~~~~~~~~~~


vim +/drm_fb_xrgb8888_to_xrgb2101010_dstclip +408 drivers/gpu/drm/drm_format_helper.c

   392	
   393	/**
   394	 * drm_fb_xrgb8888_to_xrgb2101010_dstclip - Convert XRGB8888 to XRGB2101010 clip
   395	 * buffer
   396	 * @dst: XRGB2101010 destination buffer (iomem)
   397	 * @dst_pitch: destination buffer pitch
   398	 * @vaddr: XRGB8888 source buffer
   399	 * @fb: DRM framebuffer
   400	 * @clip: Clip rectangle area to copy
   401	 *
   402	 * Drivers can use this function for XRGB2101010 devices that don't natively
   403	 * support XRGB8888.
   404	 *
   405	 * This function applies clipping on dst, i.e. the destination is a
   406	 * full (iomem) framebuffer but only the clip rect content is copied over.
   407	 */
 > 408	void drm_fb_xrgb8888_to_xrgb2101010_dstclip(void __iomem *dst,
   409						    unsigned int dst_pitch, void *vaddr,
   410						    struct drm_framebuffer *fb,
   411						    struct drm_rect *clip)
   412	{
   413		size_t linepixels = clip->x2 - clip->x1;
   414		size_t dst_len = linepixels * 4;
   415		unsigned y, lines = clip->y2 - clip->y1;
   416		void *dbuf;
   417	
   418		dbuf = kmalloc(dst_len, GFP_KERNEL);
   419		if (!dbuf)
   420			return;
   421	
   422		vaddr += clip_offset(clip, fb->pitches[0], sizeof(u32));
   423		dst += clip_offset(clip, dst_pitch, sizeof(u16));
   424		for (y = 0; y < lines; y++) {
   425			drm_fb_xrgb8888_to_xrgb2101010_line(dbuf, vaddr, linepixels);
   426			memcpy_toio(dst, dbuf, dst_len);
   427			vaddr += fb->pitches[0];
   428			dst += dst_len;
   429		}
   430	
   431		kfree(dbuf);
   432	}
   433	EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_dstclip);
   434	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
To2/SgEA

--J/dobhs11T7y2rNN--
