Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334D5444AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 23:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhKCWzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 18:55:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:18781 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhKCWzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:55:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231457579"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="gz'50?scan'50,208,50";a="231457579"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 15:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="gz'50?scan'50,208,50";a="489739590"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2021 15:52:29 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1miP7N-0005sz-5y; Wed, 03 Nov 2021 22:52:29 +0000
Date:   Thu, 4 Nov 2021 06:51:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tobetter:odroid-5.15.y 43/75] include/drm/drm_mipi_dbi.h:186:41:
 error: invalid use of undefined type 'struct spi_device'
Message-ID: <202111040636.2O6HNw5e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://github.com/tobetter/linux odroid-5.15.y
head:   49f1393b8740941fa5176620b302f25ab5f786dc
commit: f159783fdfea289ae7f9b6b62b71bb24e89631c9 [43/75] ODROID-COMMON: gpu/drm: Add new Tiny DRM driver with Ili9488
config: microblaze-randconfig-r035-20211103 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/f159783fdfea289ae7f9b6b62b71bb24e89631c9
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.15.y
        git checkout f159783fdfea289ae7f9b6b62b71bb24e89631c9
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/gpu/drm/tiny/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the tobetter/odroid-5.15.y HEAD 49f1393b8740941fa5176620b302f25ab5f786dc builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/tiny/ili9488_pio.c:30:
   drivers/gpu/drm/tiny/ili9488_pio.c: In function 'ili9488_pipe_enable':
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:132:9: note: in expansion of macro 'mipi_dbi_command'
     132 |         mipi_dbi_command(dbi, ILI9488_ITFCTR1, 0x00);
         |         ^~~~~~~~~~~~~~~~
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:133:9: note: in expansion of macro 'mipi_dbi_command'
     133 |         mipi_dbi_command(dbi, MIPI_DCS_EXIT_SLEEP_MODE);
         |         ^~~~~~~~~~~~~~~~
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:136:9: note: in expansion of macro 'mipi_dbi_command'
     136 |         mipi_dbi_command(dbi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
         |         ^~~~~~~~~~~~~~~~
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:137:9: note: in expansion of macro 'mipi_dbi_command'
     137 |         mipi_dbi_command(dbi, ILI9488_PWCTRL1, 0x33);
         |         ^~~~~~~~~~~~~~~~
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:138:9: note: in expansion of macro 'mipi_dbi_command'
     138 |         mipi_dbi_command(dbi, ILI9488_VMCTRL1, 0x00, 0x1e, 0x80, 0x00);
         |         ^~~~~~~~~~~~~~~~
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:139:9: note: in expansion of macro 'mipi_dbi_command'
     139 |         mipi_dbi_command(dbi, ILI9488_FRMCTR1, 0xb0, 0x11);
         |         ^~~~~~~~~~~~~~~~
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:140:9: note: in expansion of macro 'mipi_dbi_command'
     140 |         mipi_dbi_command(dbi, ILI9488_PGAMCTRL,
         |         ^~~~~~~~~~~~~~~~
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:143:9: note: in expansion of macro 'mipi_dbi_command'
     143 |         mipi_dbi_command(dbi, ILI9488_NGAMCTRL,
         |         ^~~~~~~~~~~~~~~~
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:146:9: note: in expansion of macro 'mipi_dbi_command'
     146 |         mipi_dbi_command(dbi, MIPI_DCS_SET_DISPLAY_ON);
         |         ^~~~~~~~~~~~~~~~
>> include/drm/drm_mipi_dbi.h:186:41: error: invalid use of undefined type 'struct spi_device'
     186 |         struct device *dev = &(dbi)->spi->dev;  \
         |                                         ^~
   drivers/gpu/drm/tiny/ili9488_pio.c:167:9: note: in expansion of macro 'mipi_dbi_command'
     167 |         mipi_dbi_command(dbi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
         |         ^~~~~~~~~~~~~~~~


vim +186 include/drm/drm_mipi_dbi.h

d23d4d4dac0119c include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2019-07-19  160  
13deee8111ed600 include/drm/tinydrm/mipi-dbi.h David Lechner       2017-11-19  161  u32 mipi_dbi_spi_cmd_max_speed(struct spi_device *spi, size_t len);
d23d4d4dac0119c include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2019-07-19  162  int mipi_dbi_spi_transfer(struct spi_device *spi, u32 speed_hz,
d23d4d4dac0119c include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2019-07-19  163  			  u8 bpw, const void *buf, size_t len);
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  164  
36b5057216236ae include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2019-07-22  165  int mipi_dbi_command_read(struct mipi_dbi *dbi, u8 cmd, u8 *val);
36b5057216236ae include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2019-07-22  166  int mipi_dbi_command_buf(struct mipi_dbi *dbi, u8 cmd, u8 *data, size_t len);
f019190b7d2708b include/drm/drm_mipi_dbi.h     Geert Uytterhoeven  2020-03-16  167  int mipi_dbi_command_stackbuf(struct mipi_dbi *dbi, u8 cmd, const u8 *data,
f019190b7d2708b include/drm/drm_mipi_dbi.h     Geert Uytterhoeven  2020-03-16  168  			      size_t len);
13deee8111ed600 include/drm/tinydrm/mipi-dbi.h David Lechner       2017-11-19  169  int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
b051b3459bbae90 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2019-01-15  170  		      struct drm_rect *clip, bool swap);
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  171  /**
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  172   * mipi_dbi_command - MIPI DCS command with optional parameter(s)
36b5057216236ae include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2019-07-22  173   * @dbi: MIPI DBI structure
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  174   * @cmd: Command
2b405ec0e1c4b4c include/drm/drm_mipi_dbi.h     Jonathan Neuschäfer 2021-01-01  175   * @seq: Optional parameter(s)
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  176   *
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  177   * Send MIPI DCS command to the controller. Use mipi_dbi_command_read() for
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  178   * get/read.
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  179   *
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  180   * Returns:
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  181   * Zero on success, negative error code on failure.
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  182   */
36b5057216236ae include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2019-07-22  183  #define mipi_dbi_command(dbi, cmd, seq...) \
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  184  ({ \
f019190b7d2708b include/drm/drm_mipi_dbi.h     Geert Uytterhoeven  2020-03-16  185  	const u8 d[] = { seq }; \
3f5aa5ac0b0f970 include/drm/drm_mipi_dbi.h     Linus Walleij       2021-07-02 @186  	struct device *dev = &(dbi)->spi->dev;	\
3f5aa5ac0b0f970 include/drm/drm_mipi_dbi.h     Linus Walleij       2021-07-02  187  	int ret; \
3f5aa5ac0b0f970 include/drm/drm_mipi_dbi.h     Linus Walleij       2021-07-02  188  	ret = mipi_dbi_command_stackbuf(dbi, cmd, d, ARRAY_SIZE(d)); \
3f5aa5ac0b0f970 include/drm/drm_mipi_dbi.h     Linus Walleij       2021-07-02  189  	if (ret) \
3f5aa5ac0b0f970 include/drm/drm_mipi_dbi.h     Linus Walleij       2021-07-02  190  		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret, cmd); \
3f5aa5ac0b0f970 include/drm/drm_mipi_dbi.h     Linus Walleij       2021-07-02  191  	ret; \
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  192  })
02dd95fe3169362 include/drm/tinydrm/mipi-dbi.h Noralf Trønnes      2017-01-22  193  

:::::: The code at line 186 was first introduced by commit
:::::: 3f5aa5ac0b0f9704f0c60f5fbbbcdc8c043d6eb6 drm/dbi: Print errors for mipi_dbi_command()

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Se1Hm5UmHMRqSi1r1HFx/xfIrUcpkQcCAA==

--82I3+IH0IqGh5yIs--
