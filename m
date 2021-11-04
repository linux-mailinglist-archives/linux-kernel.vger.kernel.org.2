Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198EA445C16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhKDWYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 18:24:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:47229 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhKDWYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:24:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="212550660"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="gz'50?scan'50,208,50";a="212550660"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 15:22:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="gz'50?scan'50,208,50";a="490128144"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2021 15:22:11 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mil7a-0006qb-PV; Thu, 04 Nov 2021 22:22:10 +0000
Date:   Fri, 5 Nov 2021 06:21:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking address
 of packed member 'pixelformat' of class or structure
 'v4l2_pix_format_mplane' may result in an unaligned pointer value
Message-ID: <202111050644.9HQjbpIQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1e2e0350ce37f633b5ce3ce1cdf4428513fc2a2
commit: e927e1e0f0dd3e353d5556503a71484008692c82 v4l: ioctl: Use %p4cc printk modifier to print FourCC codes
date:   9 months ago
config: mips-randconfig-r011-20211101 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 82ed106567063ea269c6d5669278b733e173a42f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e927e1e0f0dd3e353d5556503a71484008692c82
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e927e1e0f0dd3e353d5556503a71484008692c82
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_pix_format_mplane' may result in an unaligned pointer value [-Waddress-of-packed-member]
                           mp->width, mp->height, &mp->pixelformat,
                                                   ^~~~~~~~~~~~~~~
   include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
                                   ^~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-ioctl.c:347:37: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_sdr_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
                   pr_cont(", pixelformat=%p4cc\n", &sdr->pixelformat);
                                                     ^~~~~~~~~~~~~~~~
   include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
                                   ^~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-ioctl.c:353:5: warning: taking address of packed member 'dataformat' of class or structure 'v4l2_meta_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
                           &meta->dataformat, meta->buffersize);
                            ^~~~~~~~~~~~~~~~
   include/linux/printk.h:385:26: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
                                   ^~~~~~~~~~~
   3 warnings generated.


vim +303 drivers/media/v4l2-core/v4l2-ioctl.c

   273	
   274	static void v4l_print_format(const void *arg, bool write_only)
   275	{
   276		const struct v4l2_format *p = arg;
   277		const struct v4l2_pix_format *pix;
   278		const struct v4l2_pix_format_mplane *mp;
   279		const struct v4l2_vbi_format *vbi;
   280		const struct v4l2_sliced_vbi_format *sliced;
   281		const struct v4l2_window *win;
   282		const struct v4l2_sdr_format *sdr;
   283		const struct v4l2_meta_format *meta;
   284		u32 planes;
   285		unsigned i;
   286	
   287		pr_cont("type=%s", prt_names(p->type, v4l2_type_names));
   288		switch (p->type) {
   289		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
   290		case V4L2_BUF_TYPE_VIDEO_OUTPUT:
   291			pix = &p->fmt.pix;
   292			pr_cont(", width=%u, height=%u, pixelformat=%p4cc, field=%s, bytesperline=%u, sizeimage=%u, colorspace=%d, flags=0x%x, ycbcr_enc=%u, quantization=%u, xfer_func=%u\n",
   293				pix->width, pix->height, &pix->pixelformat,
   294				prt_names(pix->field, v4l2_field_names),
   295				pix->bytesperline, pix->sizeimage,
   296				pix->colorspace, pix->flags, pix->ycbcr_enc,
   297				pix->quantization, pix->xfer_func);
   298			break;
   299		case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
   300		case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
   301			mp = &p->fmt.pix_mp;
   302			pr_cont(", width=%u, height=%u, format=%p4cc, field=%s, colorspace=%d, num_planes=%u, flags=0x%x, ycbcr_enc=%u, quantization=%u, xfer_func=%u\n",
 > 303				mp->width, mp->height, &mp->pixelformat,
   304				prt_names(mp->field, v4l2_field_names),
   305				mp->colorspace, mp->num_planes, mp->flags,
   306				mp->ycbcr_enc, mp->quantization, mp->xfer_func);
   307			planes = min_t(u32, mp->num_planes, VIDEO_MAX_PLANES);
   308			for (i = 0; i < planes; i++)
   309				printk(KERN_DEBUG "plane %u: bytesperline=%u sizeimage=%u\n", i,
   310						mp->plane_fmt[i].bytesperline,
   311						mp->plane_fmt[i].sizeimage);
   312			break;
   313		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
   314		case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
   315			win = &p->fmt.win;
   316			/* Note: we can't print the clip list here since the clips
   317			 * pointer is a userspace pointer, not a kernelspace
   318			 * pointer. */
   319			pr_cont(", wxh=%dx%d, x,y=%d,%d, field=%s, chromakey=0x%08x, clipcount=%u, clips=%p, bitmap=%p, global_alpha=0x%02x\n",
   320				win->w.width, win->w.height, win->w.left, win->w.top,
   321				prt_names(win->field, v4l2_field_names),
   322				win->chromakey, win->clipcount, win->clips,
   323				win->bitmap, win->global_alpha);
   324			break;
   325		case V4L2_BUF_TYPE_VBI_CAPTURE:
   326		case V4L2_BUF_TYPE_VBI_OUTPUT:
   327			vbi = &p->fmt.vbi;
   328			pr_cont(", sampling_rate=%u, offset=%u, samples_per_line=%u, sample_format=%p4cc, start=%u,%u, count=%u,%u\n",
   329				vbi->sampling_rate, vbi->offset,
   330				vbi->samples_per_line, &vbi->sample_format,
   331				vbi->start[0], vbi->start[1],
   332				vbi->count[0], vbi->count[1]);
   333			break;
   334		case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
   335		case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
   336			sliced = &p->fmt.sliced;
   337			pr_cont(", service_set=0x%08x, io_size=%d\n",
   338					sliced->service_set, sliced->io_size);
   339			for (i = 0; i < 24; i++)
   340				printk(KERN_DEBUG "line[%02u]=0x%04x, 0x%04x\n", i,
   341					sliced->service_lines[0][i],
   342					sliced->service_lines[1][i]);
   343			break;
   344		case V4L2_BUF_TYPE_SDR_CAPTURE:
   345		case V4L2_BUF_TYPE_SDR_OUTPUT:
   346			sdr = &p->fmt.sdr;
 > 347			pr_cont(", pixelformat=%p4cc\n", &sdr->pixelformat);
   348			break;
   349		case V4L2_BUF_TYPE_META_CAPTURE:
   350		case V4L2_BUF_TYPE_META_OUTPUT:
   351			meta = &p->fmt.meta;
   352			pr_cont(", dataformat=%p4cc, buffersize=%u\n",
 > 353				&meta->dataformat, meta->buffersize);
   354			break;
   355		}
   356	}
   357	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--3MwIy2ne0vdjdPXF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--3MwIy2ne0vdjdPXF--
