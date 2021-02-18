Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99D31EA4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhBRNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:09:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:55027 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231937AbhBRLjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:39:49 -0500
IronPort-SDR: rz4HUxro9R5E3yy3bSVMrBKa69KAfhN2F3u2pM3Pc8Y1CfH/8ddjco3icIx6GphA+oi532wtde
 ihND+25LbajQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="247552824"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="247552824"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 03:36:22 -0800
IronPort-SDR: hqFTJU+Y+7ssuR7UQVv22NRIYrTZpDuNELPaiFWYF/6MfaSnT/Xs61IHKjeQd/gw6aYeSHeQqQ
 S1Xm5lSOYigg==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="385861988"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 03:36:20 -0800
Date:   Thu, 18 Feb 2021 19:35:45 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: drivers/gpu/drm/drm_mipi_dbi.c:262:52: warning: Either the condition
 '!fb' is redundant or there is possible null pointer dereference: fb.
Message-ID: <20210218113545.GU219708@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f40ddce88593482919761f74910f42f4b84c004b
commit: 7e06886bbfca73717e45a0f20cdb4053793c191b drm/mipi-dbi: Remove ->enabled
date:   8 months ago
compiler: riscv64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/gpu/drm/drm_mipi_dbi.c:262:52: warning: Either the condition '!fb' is redundant or there is possible null pointer dereference: fb. [nullPointerRedundantCheck]
    struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(fb->dev);
                                                      ^
   drivers/gpu/drm/drm_mipi_dbi.c:271:14: note: Assuming that condition '!fb' is not redundant
    if (WARN_ON(!fb))
                ^
   drivers/gpu/drm/drm_mipi_dbi.c:262:52: note: Null pointer dereference
    struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(fb->dev);
                                                      ^

vim +262 drivers/gpu/drm/drm_mipi_dbi.c

f41a8a69890d08 drivers/gpu/drm/drm_mipi_dbi.c     Geert Uytterhoeven 2020-01-15  257  
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  258  static void mipi_dbi_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect)
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  259  {
7c9f1312cfca15 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-07-22  260  	struct drm_gem_object *gem = drm_gem_fb_get_obj(fb, 0);
7c9f1312cfca15 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-07-22  261  	struct drm_gem_cma_object *cma_obj = to_drm_gem_cma_obj(gem);
84137b866e834a drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-07-22 @262  	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(fb->dev);
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  263  	unsigned int height = rect->y2 - rect->y1;
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  264  	unsigned int width = rect->x2 - rect->x1;
84137b866e834a drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-07-22  265  	struct mipi_dbi *dbi = &dbidev->dbi;
36b5057216236a drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-07-22  266  	bool swap = dbi->swap_bytes;
9d5645ad1b979c drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-02-25  267  	int idx, ret = 0;
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  268  	bool full;
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  269  	void *tr;
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  270  
7e06886bbfca73 drivers/gpu/drm/drm_mipi_dbi.c     Daniel Vetter      2020-06-12  271  	if (WARN_ON(!fb))
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  272  		return;
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  273  
9d5645ad1b979c drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-02-25  274  	if (!drm_dev_enter(fb->dev, &idx))
9d5645ad1b979c drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-02-25  275  		return;
9d5645ad1b979c drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-02-25  276  
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  277  	full = width == fb->width && height == fb->height;
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  278  
b051b3459bbae9 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  279  	DRM_DEBUG_KMS("Flushing [FB:%d] " DRM_RECT_FMT "\n", fb->base.id, DRM_RECT_ARG(rect));
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  280  
36b5057216236a drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-07-22  281  	if (!dbi->dc || !full || swap ||
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  282  	    fb->format->format == DRM_FORMAT_XRGB8888) {
440961d20959e8 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-07-22  283  		tr = dbidev->tx_buf;
440961d20959e8 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-07-22  284  		ret = mipi_dbi_buf_copy(dbidev->tx_buf, fb, rect, swap);
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  285  		if (ret)
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  286  			goto err_msg;
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  287  	} else {
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  288  		tr = cma_obj->vaddr;
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  289  	}
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  290  
f41a8a69890d08 drivers/gpu/drm/drm_mipi_dbi.c     Geert Uytterhoeven 2020-01-15  291  	mipi_dbi_set_window_address(dbidev, rect->x1, rect->x2 - 1, rect->y1,
f41a8a69890d08 drivers/gpu/drm/drm_mipi_dbi.c     Geert Uytterhoeven 2020-01-15  292  				    rect->y2 - 1);
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  293  
36b5057216236a drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-07-22  294  	ret = mipi_dbi_command_buf(dbi, MIPI_DCS_WRITE_MEMORY_START, tr,
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  295  				   width * height * 2);
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  296  err_msg:
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  297  	if (ret)
af74138160e194 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-01-15  298  		dev_err_once(fb->dev->dev, "Failed to update display %d\n", ret);
9d5645ad1b979c drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-02-25  299  
9d5645ad1b979c drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2019-02-25  300  	drm_dev_exit(idx);
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  301  }
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes     2017-01-22  302  

:::::: The code at line 262 was first introduced by commit
:::::: 84137b866e834ac937582b04ae9bed0a72356a6a drm/tinydrm: Split struct mipi_dbi in two

:::::: TO: Noralf Trønnes <noralf@tronnes.org>
:::::: CC: Noralf Trønnes <noralf@tronnes.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
