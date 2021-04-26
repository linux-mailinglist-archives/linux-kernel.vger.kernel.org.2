Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1D36B35D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhDZMq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231903AbhDZMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:46:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C07B761263;
        Mon, 26 Apr 2021 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619441174;
        bh=c498Rj4MfzrSWXfXITVT/8lblIv4MDJFrBJ5q3ZMG0k=;
        h=Date:From:To:Cc:Subject:From;
        b=dtV2S8vohPTHN4ut8j5iMPcnM7RiFWD9hAgkrSYxsS5r9oNFakkLi7iJXeZFCYy1o
         cGKpJZ7+gwpGz2BDSFnA8GQFXWvAo2J8sjobN/LsI7jmrMoOqDs3paQgPYTqZowigX
         KvWZrfPLIXVhOw0Rq63Upt5n2JtUcZ8kDOiCb5DM=
Date:   Mon, 26 Apr 2021 14:46:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging/IIO driver updates for 5.13-rc1
Message-ID: <YIa2ErYuJyCfSkS+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.13-rc1

for you to fetch changes up to c295d3007ff63064181befa734d9705dfc10b396:

  staging: octeon: Use 'for_each_child_of_node' (2021-04-22 10:43:25 +0200)

----------------------------------------------------------------
Staging/IIO driver updates for 5.13-rc1

Here is the big set of staging and IIO driver updates for 5.13-rc1.

Lots of little churn in here, and some larger churn as well.  Major
things are:
	- removal of wimax drivers, no one has this hardware anymore for
	  this failed "experiment".
	- removal of the Google gasket driver, turns out no one wanted
	  to maintain it or cares about it anymore, so they asked for it
	  to be removed.
	- comedi finally moves out of the staging directory into
	  drivers/comedi/  This is one of the oldest kernel subsystems
	  around, being created in the 2.0 kernel days, and was one of
	  the first things added to drivers/staging/ when that was
	  created over 15 years ago.  It should have been moved out of
	  staging a long time ago, it's well maintained and used by
	  loads of different devices in the real world every day.  Nice
	  to see this finally happen.
	- so many tiny coding style cleanups it's not funny.  Perfect
	  storm of at least 2 different intern project application
	  deadlines combined to provide a huge number of new
	  contributions in this area from people learning how to do
	  kernel development.  Great job to everyone involved here.

There's also the normal updates for IIO drivers with new IIO drivers and
updates all over that subsystem.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahmad Fatoum (2):
      iio: st_sensors: fix typo in comment
      iio: adc: stm32-adc: enable timestamping for non-DMA usage

Alaa Emad (1):
      staging: hikey9xx: fix warning styling issues

Alexandru Ardelean (33):
      iio: kfifo: add devm_iio_kfifo_buffer_setup() helper
      iio: make use of devm_iio_kfifo_buffer_setup() helper
      iio: accel: sca3000: use devm_iio_kfifo_buffer_setup() helper
      iio: kfifo: un-export devm_iio_kfifo_allocate() function
      iio: buffer-dma,adi-axi-adc: introduce devm_iio_dmaengine_buffer_setup()
      docs: ioctl-number.rst: reserve IIO subsystem ioctl() space
      iio: core: register chardev only if needed
      iio: core-trigger: make iio_device_register_trigger_consumer() an int return
      iio: core: rework iio device group creation
      iio: buffer: group attr count and attr alloc
      iio: core: merge buffer/ & scan_elements/ attributes
      iio: add reference to iio buffer on iio_dev_attr
      iio: buffer: wrap all buffer attributes into iio_dev_attr
      iio: buffer: dmaengine: obtain buffer object from attribute
      iio: core: wrap iio device & buffer into struct for character devices
      iio: buffer: move __iio_buffer_free_sysfs_and_mask() before alloc
      iio: dummy: iio_simple_dummy_buffer: use triggered buffer core calls
      iio: buffer: introduce support for attaching more IIO buffers
      iio: buffer: add ioctl() to support opening extra buffers for IIO device
      iio: core: rename 'dev' -> 'indio_dev' in iio_device_alloc()
      tools: iio: make iioutils_get_type() private in iio_utils
      tools: iio: privatize globals and functions in iio_generic_buffer.c file
      tools: iio: convert iio_generic_buffer to use new IIO buffer API
      iio: Documentation: update definitions for bufferY and scan_elements
      iio: adc: adi-axi-adc: fix typo in doc-string
      iio: kfifo: mask flags without zero-check in devm_iio_kfifo_buffer_setup()
      iio: buffer: fix use-after-free for attached_buffers array
      iio: temperature: tmp007: use device-managed functions in probe
      staging: iio: ad9834: convert to device-managed functions in probe
      iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant
      iio: buffer: return 0 for buffer getfd ioctl handler
      iio: buffer: use sysfs_attr_init() on allocated attrs
      iio: adc: Kconfig: make AD9467 depend on ADI_AXI_ADC symbol

Alexandru Tachici (1):
      iio: adc: ad7124: allow more than 8 channels

Amos Gross (1):
      Staging: rtl8723bs: rtw_xmit: fixed tabbing issue

Amrit Khera (2):
      staging: greybus: Fix blank line style issue in sdio.c
      staging: wimax: Fix block comment style issue in stack.c

Andy Shevchenko (6):
      iio: chemical: bmp680: Drop unneeded explicit castings
      iio: imu: fxos8700: Drop unneeded explicit castings
      iio: imu: st_lsm6dsx: Drop unneeded explicit castings
      iio: light: gp2ap002: Drop unneeded explicit casting
      iio: trigger: Replace explicit casting and wrong specifier with proper one
      iio: trigger: Fix strange (ladder-type) indentation

Arnd Bergmann (2):
      staging/rtl8192u: avoid Wempty-body warning
      staging/nvec:: avoid Wempty-body warning

Ashish Vara (1):
      staging: gasket: removed unnecessary debug message to fix coding style warning

Atul Gopinathan (1):
      staging: rtl8192u: ieee80211: Remove braces for single line blocks

Barry Song (1):
      genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()

Baruch Siach (1):
      staging: iio: remove mention of defunct list

Bastien Maureille (1):
      staging: vc04_services: fix indent in vchiq_debugfs_node

Beatriz Martins de Carvalho (9):
      staging: greybus: arche-platform: Ending line with argument
      staging: rtl8723bs: core: Removed extra blank line
      staging: rtl8723bs: core: Ending line with argument
      staging: rtl8723bs: core: align arguments with open parenthesis
      drivers: staging: rtl8712: align arguments with open parenthesis
      staging: rtl8723bs: core: reorganize characters so the lines are under 100 ch
      staging: rtl8723bs: hal: remove space before tabs
      staging: rtl8723bs: hal: Remove extra blank line
      staging: rtl8723bs: hal: Correct indentation

Bhaskar Chowdhury (8):
      iio: proximity: sx9500: Fix a spelling postive to positive
      staging: wimax: i2400m: Mundane typos fix in the file tx.c
      staging: wimax: i2400m: Mundane typo fix in the file driver.c
      staging: rtl8188eu: Fix couple of typos
      staging: vchiq: Typo fixes
      staging: rtl8723bs: Mundane typo fixes
      staging: rtl8723bs: Trivial typo fix
      iio: dac: Rudimentary typo fix

Bixuan Cui (1):
      staging: ralink-gdma: Add missing MODULE_DEVICE_TABLE

Bruno Raoult (5):
      r8192U_wx.c: style: alignment with open parenthesis
      r8192U_wx.c: style: spaces preferred around operators
      r8192U_wx.c: style: braces all arms of statement
      r8192U_wx.c: style: Unnecessary parentheses
      r8192U_wx.c: style: avoid multiple blank lines

Bryan Brattlof (5):
      staging: rtl8723bs: remove extra indent
      staging: rtl8723bs: remove redundant initialization
      staging: rtl8723bs: remove unnecessary goto jumps
      staging: rtl8723bs: remove unnecessary adapter
      staging: rtl8723bs: remove sdio_drv_priv structure

Candy Febriyanto (3):
      staging: rtl8723bs: core: Replace sprintf with scnprintf
      staging: rtl8723bs: hal: Replace sprintf with scnprintf
      staging: rtl8723bs: os_dep: Replace sprintf with scnprintf

Chen Lin (2):
      staging: wlan-ng: Remove unused function pointer typedef freebuf_method_t
      staging: rtl8723bs: Remove unused function pointer typedef wi_act_func

Christian Gromm (1):
      drivers: most: add ALSA sound driver

Christophe JAILLET (5):
      staging: rtl8712: Use constants from <linux/ieee80211.h>
      staging: rtl8712: remove struct rtl_ieee80211_ht_cap and ieee80211_ht_addt_info
      staging: rtl8712: remove enum WIFI_FRAME_SUBTYPE
      staging: rtl8712: remove (most of) enum WIFI_FRAME_TYPE
      staging: octeon: Use 'for_each_child_of_node'

Coiby Xu (1):
      staging: qlge: deal with the case that devlink_health_reporter_create fails

Colin Ian King (4):
      staging: rtl8723bs: Fix spelling mistake "disabed" -> "disabled"
      staging: rtl8188eu: Fix null pointer dereference on free_netdev call
      staging: comedi: drivers: Fix spelling mistake "nubmer" -> "number"
      staging: rtl8192u: Fix potential infinite loop

Dan Carpenter (1):
      staging: qlge: fix an error code in probe()

Darryl T. Agostinelli (1):
      staging: wimax: i2400m: fix some incorrect type warnings

David Villasana Jiménez (2):
      staging: iio: cdc: remove repeated word
      staging: kpc2000: pcie.h: Remove extra blank line

Davidson Francis (1):
      staging: rtl8192e: Fix comparisons to NULL

Deborah Brouwer (10):
      staging: rtl8723bs: core: add comma within a comment
      staging: rtl8723bs: core: add * to block comments
      staging: rtl8723bs: core: remove empty comment
      staging: rtl8188eu: core: add comma within a comment
      staging: rtl8188eu: core: replace spaces with a tab
      staging: rtl8192e: move const after static
      staging: rtl8712: add period within a comment
      staging: rtl8712: remove a blank line
      staging: rtl8712: remove space after cast
      staging: rtl8712: add space before binary operator

Denis Efremov (1):
      staging: rtl8723bs: remove duplicate pstat->hwaddr check

Dmitrii Wolf (1):
      Staging: rtl8192u: ieee80211: remove odd backslash.

Dom Cobley (1):
      staging: bcm2835-pcm: Allow up to 8 channels and 192kHz data rate

Du Cheng (3):
      staging: qlge: fix comment style in qlge_main.c
      staging: rtl8192u: fix RT_TRACE() in r8190_rtl8256.c
      staging: rtl8192u: remove unnecessary return in r8190_rtl8256.c

Edmundo Carmona Antoranz (4):
      staging: vt6655: correct documentation warnings
      staging: vt6655: remove duplicate code
      staging: rtl8723bs: sdio_ops: removing unused variable
      staging: rtl8723bs: hal: remove unused variable in HalBtc8723b1Ant.c

Fabio Aiuto (196):
      staging: rtl8723bs: removed unused code block
      staging: rtl8723bs: remove unused code block
      staging: rtl8723bs: align and beautify comments
      staging: rtl8723bs: put quoted string in a single line
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_PNO_SET_DEBUG
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_TCP_CSUM_OFFLOAD_RX
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_PNO_SUPPORT
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_WOWLAN
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_AUTO_AP_MODE
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_HW_PWRP_DETECTION
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_QOS_OPTIMIZATION
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_SIGNAL_DISPLAY_DBM
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_BACKGROUND_NOISE_MONITOR
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_SKIP_SIGNAL_SCALE_MAPPING
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_EXT_CLK
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_CHECK_BT_HANG
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_SDIO_TX_TASKLET
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_SW_CHANNEL_PLAN
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_C2H_PACKET_EN
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_ODM_ADAPTIVITY
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_AP_WOWLAN
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_GPIO_API
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_CMCC_TEST
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_INTERRUPT_BASED_TXBCN*
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_DISABLE_MCS13TO15
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_UPDATE_INDICATE_SEQ_WHILE_PROCESS_ADDBA_REQ
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_VALIDATE_SSID
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_LAYER2_ROAMING_ACTIVE
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_USB_VENDOR*
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_SINGLE_RECV_BUF
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_RX_INDICATE_QUEUE
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_BSD_RX_USE_MBUF
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_R871X_TEST
      staging: rtl8723bs: remove unused code blocks conditioned by never set CONFIG_MULTI_VIR_IFACES
      staging: rtl8723bs: remove unused code blocks completed
      staging: rtl8723bs: remove unnecessary logging in os_dep/ioctl_cfg80211.c
      staging: rtl8723bs: remove unnecessary logging in core/rtw_ap.c
      staging: rtl8723bs: remove unnecessary logging in core/rtw_mlme.c
      staging: rtl8723bs: remove unnecessary logging in core/rtw_mlme_ext.c
      staging: rtl8723bs: remove unnecessary logging in core/rtw_pwrctrl.c
      staging: rtl8723bs: remove unnecessary logging in core/rtw_wlan_util.c
      staging: rtl8723bs: remove unnecessary logging in hal/HalBtcOutSrc.h
      staging: rtl8723bs: remove unnecessary logging in hal/hal_com_phycfg.c
      staging: rtl8723bs: remove unnecessary logging in hal/odm.c
      staging: rtl8723bs: remove unnecessary logging in hal/odm_debug.h
      staging: rtl8723bs: remove unnecessary logging in hal/rtl8723b_hal_init.c
      staging: rtl8723bs: remove unnecessary logging in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove unnecessary logging in os_dep/os_intfs.c
      staging: rtl8723bs: remove unnecessary logging in os_dep/wifi_regd.c
      staging: rtl8723bs: delete extern declarations in core/rtw_ap.c
      staging: rtl8723bs: removed function prototypes in core/rtw_efuse.c
      staging: rtl8723bs: moved function prototype out of core/rtw_ioctl_set.c and core/rtw_mlme.c
      staging: rtl8723bs: removed function prototypes and made statics in core/rtw_recv.c
      staging: rtl8723bs: delete extern declarations in core/rtw_wlan_util.c
      staging: rtl8723bs: remove function prototypes in hal/odm.c
      staging: rtl8723bs: move function prototypes out of os_dep/int_fs.c
      staging: rtl8723bs: remove undefined function prototype in of os_dep/sdio_intf.c
      staging: rtl8723bs: remove unnecessary extern in os_dep/sdio_intf.c
      staging: rtl8723bs: remove blank line os_dep/os_intfs.c
      staging: rtl8723bs: remove assignment in condition in core/rtw_ieee80211.c
      staging: rtl8723bs: remove assignment in condition in os_dep/ioctl_cfg80211.c
      staging: rtl8723bs: remove assignment in condition in os_dep/ioctl_linux.c
      staging: rtl8723bs: fix broken indentation
      staging: rtl8723bs: remove unused macros in include/hal_com.h
      staging: rtl8723bs: put parentheses on macro with complex values in include/hal_com.h
      staging: rtl8723bs: added spaces around operators in a macro in include/hal_com.h
      staging: rtl8723bs: remove unused macros in include/hal_com_reg.h
      staging: rtl8723bs: remove unused macros in include/hal_data.h
      staging: rtl8723bs: put parentheses on macros with complex values in include/hal_data.h
      staging: rtl8723bs: add spaces around operators in include/hal_data.h
      staging: rtl8723bs: remove unused macros in include/hal_phy.h
      staging: rtl8723bs: remove unused macro in include/rtw_pwrctrl.h
      staging: rtl8723bs: remove unused field in rereg_nd_name_data struct
      staging: rtl8723bs: remove commented code line in os_dep/ioctl_linux.c
      staging: rtl8723bs: put parentheses on macros with complex values in include/rtw_pwrctrl.h
      staging: rtl8723bs: add spaces around operator in include/rtw_pwrctrl.h
      staging: rtl8723bs: remove unused macros in include/wifi.h
      staging: rtl8723bs: put parentheses on macros with complex values in include/wifi.h
      staging: rtl8723bs: remove macros updating unused fields in struct security_priv
      staging: rtl8723bs: remove unused fields in struct security_priv
      staging: rtl8723bs: include macro in a do - while loop in core/rtw_security.c
      staging: rtl8723bs: remove unused macros in include/drv_types.c
      staging: rtl8723bs: use print_hex_dump_debug instead of private RT_PRINT_DATA
      staging: rtl8723bs: remove unused macro RT_PRINT_DATA
      staging: rtl8723bs: remove RT_TRACE logs in core/rtw_xmit.c
      staging: rtl8723bs: fix condition in if statement in core/rtw_xmit.c
      staging: rtl8723bs: remove RT_TRACE logs in core/rtw_security.c
      staging: rtl8723bs: fix line exceed warning in core/rtw_security.c
      staging: rtl8723bs: fix spaces around operator issues in core/rtw_security.c
      staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_eeprom.c
      staging: rtl8723bs: fix error prone if conditions in core/rtw_eeprom.c
      staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_pwrctrl.c
      staging: rtl8723bs: fix logical continuation issue in core/rtw_pwrctrl.c
      staging: rtl8723bs: remove unnecessary parentheses in if-condition in core/rtw_pwrctrl.c
      staging: rtl8723bs: remove RT_TRACE logs in core/rtw_cmd.c
      staging: rtl8723bs: fix null check conditions in core/rtw_cmd.c
      staging: rtl8723bs: remove unnecessary parentheses in if condition in core/rtw_cmd.c
      staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_mlme.c
      staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme.c
      staging: rtl8723bs: tidy up some error handling in core/rtw_mlme.c
      staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme_ext.c
      staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_recv.c
      staging: rtl8723bs: remove RT_TRACE logs in core/rtw_recv.c
      staging: rtl8723bs: added spaces around operator in core/rtw_recv.c
      staging: rtl8723bs: split long line in core/rtw_recv.c
      staging: rtl8723bs: remove unnecessary parentheses in core/rtw_recv.c
      staging: rtl8723bs: fix comparison in if condition in core/rtw_recv.c
      staging: rtl8723bs: remove commented RT_TRACE call in core/rtw_ioctl_set.c
      staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ioctl_set.c
      staging: rtl8723bs: place constant on the right side of the test in core/rtw_ioctl_set.c
      staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_wlan_util.c
      staging: rtl8723bs: remove RT_TRACE logs in core/rtw_sta_mgt.c
      staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ieee80211.c
      staging: rtl8723bs: add spaces around operators in core/rtw_ieee80211.c
      staging: rtl8723bs: remove all RT_TRACE logs in hal/ and os_dep/
      staging: rtl8723bs: remove commented out RT_TRACE logs in hal/ and os_dep/
      staging: rtl8723bs: remove RT_TRACE log definitions
      staging: rtl8723bs: remove empty if, else blocks after RT_TRACE deletion
      staging: rtl8723bs: remove empty #ifdef blocks after RT_TRACE deletion
      staging: rtl8723bs: remove unnecessary bracks after RT_TRACE deletion
      staging: rtl8723bs: place constant on the right side of the test
      staging: rtl8723bs: rewrite comparisons to null
      staging: rtl8723bs: remove empty for cycles
      staging: rtl8723bs: remove commented code block
      staging: rtl8723bs: remove DBG_871X log argument
      staging: rtl8723bs: remove all DBG_871X logs
      staging: rtl8723bs: remove DBG_871CX log unmatched by cocci
      staging: rtl8723bs: remove commented out DBG_871X logs
      staging: rtl8723bs: remove DBG_871X macro definitions
      staging: rtl8723bs: remove all if-else empty blocks left by DBG_871X removal
      drivers: rtl8723bs: rewrite comparison to null
      staging: rtl8723bs: put constant on the right side in if condition
      staging: rtl8723bs: remove empty for cycles left by DBG_871X removal
      staging: rtl8723bs: remove empty tracing function dump_rx_packet
      staging: rtl8723bs: remove empty #ifdef blocks after DBG_871X removal
      staging: rtl8723bs: remove unnecessary bracks on DBG_871X removal sites
      staging: rtl8723bs: remove unnecessary parentheses in if condition
      staging: rtl8723bs: add spaces around operators
      staging: rtl8723bs: rewrite comparison to null
      staging: rtl8723bs: remove unnecessary parentheses
      staging: rtl8723bs: fix comparison in if condition
      staging: rtl8723bs: split long lines
      staging: rtl8723bs: remove unnecessary parentheses
      staging: rtl8723bs: remove unused variable in core/rtw_cmd.c
      staging: rtl8723bs: remove unused variable and empty for cycles left unused in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove unused code block in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove unused variables and code block left unused in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove set but unused psta variable in rtw_dbg_port() in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove unused variable pstapriv in rtw_dbg_port() in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove unused cur_network variable in rtw_dbg_port() in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove unused pmlmepriv variable in rtw_dbg_port() in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove unused variable declaration in include/rtw_security.h
      staging: rtl8723bs: remove unused variable in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove decl of unused static const variable in os_dep/ioctl_linux.c
      staging: rtl8723bs: remove all MSG_8192C logs
      staging: rtl8723bs: remove commented out MSG_8192C log
      staging: rtl8723bs: remove MSG_8192C macro definitions
      staging: rtl8723bs: remove all DBG_8192C logs
      staging: rtl8723bs: remove all commented out DBG_8192C logs
      staging: rtl8723bs: remove DBG_8192C macro definitions
      staging: rtl8723bs: remove all if-blocks left empty by DBG_8192C-remove coccinelle script
      staging: rtl8723bs: put spaces around operators
      staging: rtl8723bs: remove unused code blocks guarded by DEBUG_RTL871X
      staging: rtl8723bs: remove commented out DEBUG_RTL871X definition
      staging: rtl8723bs: remove code blocks guarded by DEBUG symbol
      staging: rtl8723bs: remove empty code block guarded by DBG_CCX
      staging: rtl8723bs: remove code block guarded by undefined SDIO_DEBUG_IO
      staging: rtl8723bs: remove commented out SDIO_DEBUG_IO symbol definition
      staging: rtl8723bs: remove empty ifdef blocks conditioned to DEBUG_CFG80211 definition
      staging: rtl8723bs: remove commented out DEBUG_CFG80211 symbol definition
      staging: rtl8723bs: remove unnecessary bracks
      staging: rtl8723bs: fix comparison to null
      staging: rtl8723bs: put spaces around operators
      staging: rtl8723bs: split long line
      staging: rtl8723bs: put constant on the right side of the test
      staging: rtl8723bs: remove empty if and else blocks
      staging: rtl8723bs: put constant on the right side of a test in os_dep/ioctl_cfg80211.c
      staging: rtl8723bs: remove unnecessary parentheses in os_dep/ioctl_cfg80211.c
      staging: rtl8723bs: remove empty else block in os_dep/ioctl_cfg80211.c
      staging: rtl8723bs: fix comparison to true issue
      staging: rtl8723bs: remove more unnecessary parentheses
      staging: rtl8723bs: remove more empty if blocks after DBG_8192C deletion
      staging: rtl8723bs: remove unused variable 'start' in hal/sdio_halinit.c
      staging: rtl8723bs: replace dump_drv_version() usage with netdev_dbg()
      staging: rtl8723bs: remove unnecessary dump_drv_version() usage
      staging: rtl8723bs: remove two unused functions
      staging: rtl8723bs: fix indentation issue introduced by long line split
      staging: rtl8723bs: replace DBG_871X_SEL_NL with netdev_dbg()
      staging: rtl8723bs: remove DBG_871X_SEL_NL macro declaration
      staging: rtl8723bs: remove unused argument in function
      staging: rtl8723bs: replace DBG_871X_LEVEL logs with netdev_*()
      staging: rtl8723bs: fix code indent issue
      staging: rtl8723bs: fix indentation in if block
      staging: rtl8723bs: split too long line
      staging: rtl8723bs: remove unused DBG_871X_LEVEL macro declarations
      staging: rtl8723bs: remove empty #ifdef block

Fabio M. De Francesco (15):
      staging: rtl8723bs: hal: Add spaces around operators
      staging: rtl8723bs: hal: Add spaces around operators in hal_btcoex.c
      staging: rtl8723bs: hal: Add spaces around operators in HalBtc8723b2Ant.c
      staging: rtl8723bs: hal: Add spaces around operator in HalBtc8723b1Ant.h
      staging: rtl8723bs: hal: Remove camelcase
      staging: rtl8723bs: hal: Remove camelcase in sdio_ops.c
      staging: rtl8723bs: core: Remove an unused variable
      staging: rtl8723bs: Remove camelcase in several files
      staging: rtl8723bs: include: Fix misspelled words in comments
      staging: rtl8723bs: include: Change the type of a variable
      staging: rtl8723bs: Change controlling expressions
      staging: rtl8188eu: Move channel_table away from rtw_mlme_ext.h
      staging: rtl8723bs: core: Remove unused but set variable
      staging: rtl8723bs: hal: Remove four set but not used variables
      staging: rtl8723bs: Remove led_blink_hdl() and everything related

Fabrice Gasnier (1):
      counter: stm32-lptimer-cnt: remove iio counter abi

Fatih Yildirim (1):
      staging: comedi dt2814: Removed unused variables

Florian Ziegler (1):
      staging: vt6656: Fix alignment of function args

Gabriele Modena (3):
      staging: wimax: fix block comment style check in op-rfkill.c
      staging: wimax: add a blank line after declaration in op-rfkill.c
      staging: wimax: fix quoted string split across lines in op-rfkill.c

George Xanthakis (1):
      staging: android: Remove filename reference from file

Giovanni Gherdovich (1):
      staging: ralink-gdma: Check return code of device_reset

Greg Kroah-Hartman (8):
      Merge 5.12-rc3 into staging-next
      staging: gasket: remove it from the kernel
      staging: wimax: delete from the tree.
      Merge v5.12-rc4 into staging-next
      Merge tag 'iio-for-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
      Merge 5.12-rc6 into staging-next
      Merge tag 'iio-for-5.13b-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
      staging: comedi: move out of staging directory

Guoqing Chi (2):
      iio: adc: ad7292: Modify the bool initialization assignment
      iio:imu:mpu6050: Modify matricies to matrices

Gustavo A. R. Silva (2):
      staging: rtl8188eu: Replace one-element array with flexible-array in struct ndis_802_11_var_ie
      iio: hrtimer-trigger: Fix potential integer overflow in iio_hrtimer_store_sampling_frequency

Gwendal Grignou (16):
      iio: hrtimer: Allow sub Hz granularity
      iio: Remove kernel-doc keyword in file header comment
      iio: set default trig->dev.parent
      iio: fix devm_iio_trigger_alloc with parent.cocci
      iio: adis_trigger: Remove code to set trigger parent
      iio: gp2ap020a00f: Remove code to set trigger parent
      iio: lmp91000: Remove code to set trigger parent
      iio: chemical: atlas: Remove code to set trigger parent
      iio: as3935: Remove code to set trigger parent
      iio: xilinx-xadc: Remove code to set trigger parent
      iio: cros: unify hw fifo attributes without API changes
      iio: acpi_als: Add timestamp channel
      iio: acpi_als: Add local variable dev in probe
      iio: acpi_als: Add trigger support
      iio: sx9310: Fix access to variable DT array
      iio: sx9310: Fix write_.._debounce()

Hans de Goede (5):
      iio: core: Allow drivers to specify a label without it coming from of
      iio: accel: bmc150: Set label based on accel-location on 2-accel yoga-style 2-in-1s
      iio: accel: kxcjk-1013: Set label based on accel-location on 2-accel yoga-style 2-in-1s
      iio: documentation: Document proximity sensor label use
      iio: documentation: Document accelerometer label use

Hao Peng (2):
      staging: rtl8723bs: remove extra space
      staging: rtl8723bs: remove extra lines

Hassan Shahbazi (1):
      staging: wimax: fix code style issues

HyeonggonYoo (1):
      Staging: rtl8723bs: fixed a brace coding style

Ian Abbott (18):
      staging: comedi: dt2814: Clear stale AI data before operation
      staging: comedi: dt2814: Don't wait for conversion in interrupt handler
      staging: comedi: dt2814: Call dt2814_ai_clear() during initialization
      staging: comedi: dt2814: Fix asynchronous command interrupt handling
      staging: comedi: dt2814: Remove struct dt2814_private
      staging: comedi: dt2814: Clear stale AI data on detach
      staging: comedi: tests: ni_routes_test: Fix compilation error
      staging: comedi: tests: ni_routes_test: Put complex values in parentheses
      staging: comedi: tests: ni_routes_test: Avoid CamelCase: <RVi>
      staging: comedi: tests: ni_routes_test: Lines should not end with a '('
      staging: comedi: tests: Correct unittest_fptr
      staging: comedi: tests: ni_routes_test: Reduce stack usage
      staging: comedi: tests: ni_route_tests: Declare functions static
      staging: comedi: tests: example_test: Reduce stack usage
      staging: comedi: tests: example_test: Declare functions static
      staging: comedi: tests: example_test: Rename to 'comedi_example_test'
      staging: comedi: Add Kconfig options to build unit test modules
      staging: comedi: Kconfig: Fix COMEDI_TESTS_NI_ROUTES selections

Ian Kewish (1):
      staging: rtl8192e: indent statement properly

Ilya Lipnitskiy (1):
      staging: mt7621-pci: stop using of_pci_range_to_resource

Ivan Mikhaylov (1):
      iio: proximity: vcnl3020: add proximity rate

Ivan Safonov (8):
      staging:rtl8712: replace get_(d|s)a with ieee80211_get_(D|S)A
      staging:rtl8712: remove unused definitions from wifi.h
      staging:rtl8712: use IEEE80211_FCTL_* kernel definitions
      staging:rtl8712: replace cap_* definitions with native kernel WLAN_CAPABILITY_*
      staging:r8188eu: replace get_(d|s)a with ieee80211_get_(D|S)A
      staging:r8188eu: remove unused definitions from wifi.h
      staging:r8188eu: replace cap_* definitions with native kernel WLAN_CAPABILITY_*
      staging:r8188eu: use ieee80211_is_ctl instead IsFrameTypeCtrl

Jia-Ju Bai (1):
      staging: vc04_services: vchiq_arm: fix error return code of vchiq_release_internal() and vchiq_use_internal()

Jiapeng Chong (3):
      staging: rtl8192e: rtl8192E_dev: remove unused variable
      staging: rtl8192u: remove unused variable
      staging: comedi: cb_pcidas64: remove useless function

Jonathan Cameron (50):
      iio:adc:stm32-adc: Add HAS_IOMEM dependency
      iio:ABI docs: Combine sysfs-bus-iio-humidity-hdc2010/hdc100x into one file
      iio:ABI docs: Combine the two instances of docs for sensor_sensitivity
      iio: pressure: zpa2326: kernel-doc fixes
      iio: adc: ti-adc084s021: kernel-doc fixes, missing function names
      iio: dac: ad5770r: kernel-doc fix case of letter R wrong in structure name
      iio: dac: ad5504: fix wrong part number in kernel-doc structure name.
      iio: adc: cpcap-adc: kernel-doc fix - that should be _ in structure name
      iio: adc: adi-axi-adc: Drop false marking for kernel-doc
      iio: accel: sca3000: kernel-doc fixes. Missing - and wrong function names.
      iio: buffer: kfifo_buf: kernel-doc, typo in function name.
      iio:cros_ec_sensors: Fix a wrong function name in kernel doc.
      Merge remote-tracking branch 'local/ib-iio-scmi-5.12-rc2-take3' into togreg
      iio:accel:adis16201: Fix wrong axis assignment that prevents loading
      staging:iio:cdc:ad7150: use swapped reads/writes for i2c rather than open coding
      staging:iio:cdc:ad7150: Remove magnitude adaptive events
      staging:iio:cdc:ad7150: Refactor event parameter update
      staging:iio:cdc:ad7150: Timeout register covers both directions so both need updating
      staging:iio:cdc:ad7150: Drop platform data support
      staging:iio:cdc:ad7150: Handle variation in chan_spec across device and irq present or not
      staging:iio:cdc:ad7150: Simplify event handling by only using rising direction.
      staging:iio:cdc:ad7150: Drop noisy print in probe
      staging:iio:cdc:ad7150: Add sampling_frequency support
      iio:event: Add timeout event info type
      staging:iio:cdc:ad7150: Change timeout units to seconds and use core support
      staging:iio:cdc:ad7150: Rework interrupt handling.
      staging:iio:cdc:ad7150: More consistent register and field naming
      staging:iio:cdc:ad7150: Reorganize headers.
      staging:iio:cdc:ad7150: Tidy up local variable positioning.
      staging:iio:cdc:ad7150: Drop unnecessary block comments.
      staging:iio:cdc:ad7150: Shift the _raw readings by 4 bits.
      staging:iio:cdc:ad7150: Add scale and offset to info_mask_shared_by_type
      staging:iio:cdc:ad7150: Really basic regulator support.
      staging:iio:cdc:ad7150: Add of_match_table
      iio:Documentation:ABI Add missing elements as used by the adi,ad7150
      staging:iio:cdc:ad7150: Add copyright notice given substantial changes.
      dt-bindings:iio:cdc:adi,ad7150 binding doc
      iio:cdc:ad7150: Move driver out of staging.
      iio:adc: Drop false comment about lack of timestamp control
      Merge tag 'irq-no-autoen-2021-03-25' into togreg
      iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce boilerplate
      iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag rather than separate irq_disable()
      iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of request then disable
      iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag instead of request then disable
      iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq request then disable
      iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq request then disable
      iio:adc:ad_sigma_delta: Use IRQF_NO_AUTOEN rather than request and disable
      iio:adc:ad7476: Fix remove handling
      iio:adc: Fix trivial typo
      iio:cdc:ad7150: Fix use of uninitialized ret

Julia Lawall (1):
      iio: use getter/setter functions

Julian Braha (1):
      drivers: staging: netlogic: fix unmet dependency for PHYLIB

Jyoti Bhayana (1):
      iio/scmi: Adding support for IIO SCMI Based Sensors

Klemen Košir (1):
      staging: unisys: visornic: Fix repeated words in comments

Kumar Kartikeya Dwivedi (1):
      staging/greybus: eliminate use of NAME_SIZE for strings

Kurt Manucredo (1):
      staging: rtl8723bs: fix code style comparison warning

LI Qingwu (2):
      dt-bindings: iio: st,st-sensors add IIS2MDC.
      iio:magnetometer: Add Support for ST IIS2MDC

Lars-Peter Clausen (10):
      iio: iio_format_value(): Use signed temporary for IIO_VAL_FRACTIONAL_LOG2
      iio: iio_format_value(): Fix IIO_VAL_FRACTIONAL_LOG2 values between -1.0 and 0.0
      iio: Add basic unit test for iio_format_value()
      iio: core: Use sysfs_emit() (trivial bits)
      iio: iio_enum_available_read(): Convert to sysfs_emit_at()
      iio: __iio_format_value(): Convert to sysfs_emit_at()
      iio: dac: Convert powerdown read callbacks to sysfs_emit()
      iio: inv_mpu6050: Remove superfluous indio_dev->modes assignment
      iio: inv_mpu6050: Make interrupt optional
      iio: inv_mpu6050: Fully validate gyro and accel scale writes

Lee Gibson (2):
      staging: fwserial: minor coding style fix
      staging: rtl8712: Fix a possible NULL pointer dereference in function r8712_joinbss_event_callback

Linus Walleij (8):
      iio: adc: mt6360: Include right header
      iio: Provide iio_read_channel_processed_scale() API
      hwmon: (ntc_thermistor): try reading processed
      iio: event_monitor: Enable events before monitoring
      iio: imu: inv_mpu6050: Use as standalone trigger
      iio: Fix iio_read_channel_processed_scale()
      iio: magnetometer: yas530: Fix return value on error path
      iio: magnetometer: yas530: Include right header

Luca Ceresoli (5):
      docs: iio: fix example formatting
      docs: iio: fix directory naming
      docs: iio: document the 'index' attribute too
      docs: iio: fix bullet list formatting
      docs: iio: mark "repeat" sysfs attribute as optional

Lucas Stankus (3):
      iio: adc: ad7923: use devm_add_action_or_reset for regulator disable
      iio: adc: ad7923: use device-managed function for triggered buffer
      iio: adc: ad7923: register device with devm_iio_device_register

Madhumitha Prabakaran (1):
      staging: vt6655: Rename two dimensional array declaration

Mahak Gupta (1):
      staging: octeon-usb: Match alignment with open parenthesis

Marco Cesati (190):
      staging: rtl8723bs: remove useless typedef's in HalPhyRf.h
      staging: HalBtc8723b2Ant: remove useless typedef's
      staging: HalBtc8723b1Ant: remove useless typedef's
      staging: rtl8723bs: remove typedefs in HalBtcOutSrc.h
      staging: rtl8723bs: remove typedefs in rtw_mlme.h
      staging: rtl8723bs: remove typedefs in odm.h
      staging: rtl8723bs: remove typedefs in odm_CfoTracking.h
      staging: rtl8723bs: remove typedefs in odm_NoiseMonitor.h
      staging: rtl8723bs: remove typedefs in odm_interface.h
      staging: rtl8723bs: remove typedefs in odm_EdcaTurboCheck.h
      staging: rtl8723bs: remove typedefs in odm_HWConfig.h
      staging: rtl8723bs: remove typedefs in odm_types.h
      staging: rtl8723bs: remove typedefs in rtw_eeprom.h
      staging: rtl8723bs: remove typedefs in hal_com.h
      staging: rtl8723bs: remove typedefs in drv_types.h
      staging: rtl8723bs: remove typedefs in rtw_ht.h
      staging: rtl8723bs: remove typedefs in rtw_ioctl_set.h
      staging: rtl8723bs: remove typedefs in wlan_bssdef.h
      staging: rtl8723bs: remove typedefs in rtw_mp.h
      staging: rtl8723bs: remove typedefs in osdep_service.h
      staging: rtl8723bs: remove typedefs in rtw_security.h
      staging: rtl8723bs: remove typedefs in hal_com_h2c.h
      staging: rtl8723bs: remove typedefs in rtl8723b_xmit.h
      staging: rtl8723bs: remove typedefs in HalVerDef.h
      staging: rtl8723bs: remove typedefs in rtl8723b_hal.h
      staging: rtl8723bs: remove typedefs in rtw_mlme_ext.h
      staging: rtl8723bs: remove typedefs in HalPwrSeqCmd.h
      staging: rtl8723bs: remove typedefs in sta_info.h
      staging: rtl8723bs: remove typedefs in ieee80211.h
      staging: rtl8723bs: remove typedefs in basic_types.h
      staging: rtl8723bs: remove typedefs in osdep_service_linux.h
      staging: rtl8723bs: remove typedefs in rtw_efuse.h
      staging: rtl8723bs: remove typedefs in hal_btcoex.h
      staging: rtl8723bs: remove typedefs in odm_DIG.h
      staging: rtl8723bs: remove typedefs in hal_btcoex.c
      staging: rtl8723bs: remove typedefs in odm_DynamicBBPowerSaving.h
      Staging: rtl8723bs: fix spaces in rtw_cmd.c
      Staging: rtl8723bs: fix spaces in HalBtc8723b1Ant.c
      Staging: rtl8723bs: fix spaces in HalBtc8723b1Ant.h
      Staging: rtl8723bs: fix spaces in HalBtc8723b2Ant.c
      Staging: rtl8723bs: fix spaces in HalBtc8723b2Ant.h
      Staging: rtl8723bs: fix spaces in HalBtcOutSrc.h
      Staging: rtl8723bs: fix spaces in HalHWImg8723B_BB.c
      Staging: rtl8723bs: fix spaces in HalHWImg8723B_BB.h
      Staging: rtl8723bs: fix spaces in HalHWImg8723B_MAC.c
      Staging: rtl8723bs: fix spaces in HalHWImg8723B_MAC.h
      Staging: rtl8723bs: fix spaces in HalHWImg8723B_RF.c
      Staging: rtl8723bs: fix spaces in HalHWImg8723B_RF.h
      Staging: rtl8723bs: fix spaces in HalPhyRf.c
      Staging: rtl8723bs: fix spaces in HalPhyRf.h
      Staging: rtl8723bs: fix spaces in HalPhyRf_8723B.c
      Staging: rtl8723bs: fix spaces in HalPhyRf_8723B.h
      Staging: rtl8723bs: fix spaces in hal_btcoex.c
      Staging: rtl8723bs: fix spaces in hal_com.c
      Staging: rtl8723bs: fix spaces in hal_com_phycfg.c
      Staging: rtl8723bs: fix spaces in odm.c
      Staging: rtl8723bs: fix spaces in odm.h
      Staging: rtl8723bs: fix spaces in odm_CfoTracking.c
      Staging: rtl8723bs: fix spaces in odm_DIG.c
      Staging: rtl8723bs: fix in odm_DynamicBBPowerSaving.c
      Staging: rtl8723bs: fix spaces in odm_DynamicTxPower.c
      Staging: rtl8723bs: fix spaces in odm_EdcaTurboCheck.c
      Staging: rtl8723bs: fix spaces in odm_HWConfig.c
      Staging: rtl8723bs: fix spaces in odm_HWConfig.h
      Staging: rtl8723bs: fix spaces in odm_NoiseMonitor.c
      Staging: rtl8723bs: fix spaces in odm_PathDiv.c
      Staging: rtl8723bs: fix spaces in odm_RegConfig8723B.c
      Staging: rtl8723bs: fix spaces in odm_RegConfig8723B.h
      Staging: rtl8723bs: fix spaces in odm_debug.c
      Staging: rtl8723bs: fix spaces in odm_debug.h
      Staging: rtl8723bs: fix spaces in rtl8723b_dm.c
      Staging: rtl8723bs: fix spaces in rtl8723b_hal_init.c
      Staging: rtl8723bs: fix spaces in rtl8723b_phycfg.c
      Staging: rtl8723bs: fix spaces in HalPwrSeqCmd.h
      Staging: rtl8723bs: fix spaces in basic_types.h
      Staging: rtl8723bs: fix spaces in drv_types.h
      Staging: rtl8723bs: fix spaces in hal_com.h
      Staging: rtl8723bs: fix spaces in hal_com_h2c.h
      Staging: rtl8723bs: fix spaces in hal_com_phycfg.h
      Staging: rtl8723bs: fix spaces in ieee80211.h
      Staging: rtl8723bs: fix spaces in ioctl_cfg80211.h
      Staging: rtl8723bs: fix spaces in osdep_intf.h
      Staging: rtl8723bs: fix spaces in osdep_service.h
      Staging: rtl8723bs: fix spaces in osdep_service_linux.h
      Staging: rtl8723bs: fix spaces in recv_osdep.h
      Staging: rtl8723bs: fix spaces in rtl8723b_xmit.h
      Staging: rtl8723bs: fix spaces in rtw_cmd.h
      Staging: rtl8723bs: fix spaces in rtw_ioctl_set.h
      Staging: rtl8723bs: fix spaces in rtw_mlme_ext.h
      Staging: rtl8723bs: fix spaces in xmit_osdep.h
      Staging: rtl8723bs: fix spaces in os_intfs.c
      Staging: rtl8723bs: fix spaces in osdep_service.c
      Staging: rtl8723bs: fix spaces in xmit_linux.c
      Staging: rtl8723bs: fix names in rtw_mlme.h
      Staging: rtl8723bs: fix names in wlan_bssdef.h
      Staging: rtl8723bs: fix names in rtw_pwrctrl.h
      Staging: rtl8723bs: fix names in hal_com.h
      Staging: rtl8723bs: fix names in rtw_eeprom.h
      Staging: rtl8723bs: fix names in rtw_recv.h
      Staging: rtl8723bs: fix names in drv_types.h
      Staging: rtl8723bs: fix names in rtw_ht.h
      Staging: rtl8723bs: fix names in rtw_mp.h
      Staging: rtl8723bs: fix names in rtw_cmd.h
      Staging: rtl8723bs: fix names in hal_intf.h
      Staging: rtl8723bs: fix names in osdep_service.h
      Staging: rtl8723bs: fix names in rtw_security.h
      Staging: rtl8723bs: fix names in hal_com_h2c.h
      Staging: rtl8723bs: fix names in rtl8723b_xmit.h
      Staging: rtl8723bs: fix names in HalVerDef.h
      Staging: rtl8723bs: fix names in wifi.h
      Staging: rtl8723bs: fix names in rtl8723b_hal.h
      Staging: rtl8723bs: fix names in hal_phy.h
      Staging: rtl8723bs: fix names in rtw_mlme_ext.h
      Staging: rtl8723bs: fix names in rtw_xmit.h
      Staging: rtl8723bs: fix names in rtw_rf.h
      Staging: rtl8723bs: fix names in HalPwrSeqCmd.h
      Staging: rtl8723bs: fix names in hal_com_phycfg.h
      Staging: rtl8723bs: fix names in sta_info.h
      Staging: rtl8723bs: fix names in hal_data.h
      Staging: rtl8723bs: fix names in ieee80211.h
      Staging: rtl8723bs: fix names in rtw_efuse.h
      Staging: rtl8723bs: fix names in hal_btcoex.h
      Staging: rtl8723bs: fix names in odm_interface.h
      Staging: rtl8723bs: fix names in HalBtcOutSrc.h
      Staging: rtl8723bs: fix names in odm_EdcaTurboCheck.h
      Staging: rtl8723bs: fix names in odm_HWConfig.h
      Staging: rtl8723bs: fix names in HalBtc8723b1Ant.h
      Staging: rtl8723bs: fix names in odm_types.h
      Staging: rtl8723bs: fix names in odm_DIG.h
      Staging: rtl8723bs: fix names in hal_btcoex.c
      Staging: rtl8723bs: fix names in odm_CfoTracking.h
      Staging: rtl8723bs: fix names in HalPhyRf.h
      Staging: rtl8723bs: fix names in odm.h
      Staging: rtl8723bs: fix in odm_DynamicBBPowerSaving.h
      Staging: rtl8723bs: fix names in odm_NoiseMonitor.h
      Staging: rtl8723bs: fix names in HalBtc8723b2Ant.h
      Staging: rtl8723bs: remove useless structs in rtw_mlme.h
      Staging: rtl8723bs: remove useless structs in rtw_cmd.h
      Staging: rtl8723bs: remove useless structs in rtw_recv.h
      Staging: rtl8723bs: remove useless structs in drv_types.h
      Staging: rtl8723bs: remove useless structs in rtw_ioctl_set.h
      Staging: rtl8723bs: remove useless structs in wlan_bssdef.h
      Staging: rtl8723bs: remove useless structs in rtw_mp.h
      Staging: rtl8723bs: remove useless structs in hal_intf.h
      Staging: rtl8723bs: remove useless structs in rtw_event.h
      Staging: rtl8723bs: remove useless structs in rtl8723b_recv.h
      Staging: rtl8723bs: remove useless structs in rtw_security.h
      Staging: rtl8723bs: remove useless structs in rtw_wifi_regd.h
      Staging: rtl8723bs: remove useless structs in rtw_io.h
      Staging: rtl8723bs: remove useless structs in wifi.h
      Staging: rtl8723bs: remove useless structs in hal_phy.h
      Staging: rtl8723bs: remove useless structs in rtw_xmit.h
      Staging: rtl8723bs: remove useless structs in ieee80211.h
      Staging: rtl8723bs: remove useless structs in odm_HWConfig.h
      Staging: rtl8723bs: remove useless structs in odm.h
      Staging: rtl8723bs: remove named enums in rtw_mlme.h
      Staging: rtl8723bs: remove named enums in rtw_cmd.h
      Staging: rtl8723bs: remove named enums in rtw_eeprom.h
      Staging: rtl8723bs: remove named enums in hal_com.h
      Staging: rtl8723bs: remove named enums in rtw_recv.h
      Staging: rtl8723bs: remove named enums in drv_types.h
      Staging: rtl8723bs: remove named enums in rtw_ht.h
      Staging: rtl8723bs: remove named enums in wlan_bssdef.h
      Staging: rtl8723bs: remove named enums in rtw_mp.h
      Staging: rtl8723bs: remove named enums in osdep_service.h
      Staging: rtl8723bs: remove named enums in hal_intf.h
      Staging: rtl8723bs: remove named enums in rtw_pwrctrl.h
      Staging: rtl8723bs: remove named enums in rtl8723b_cmd.h
      Staging: rtl8723bs: remove named enums in hal_com_h2c.h
      Staging: rtl8723bs: remove named enums in rtw_wifi_regd.h
      Staging: rtl8723bs: remove named enums in wifi.h
      Staging: rtl8723bs: remove named enums in rtl8723b_hal.h
      Staging: rtl8723bs: remove named enums in hal_phy.h
      Staging: rtl8723bs: remove named enums in rtw_mlme_ext.h
      Staging: rtl8723bs: remove named enums in rtw_xmit.h
      Staging: rtl8723bs: remove named enums in rtw_rf.h
      Staging: rtl8723bs: remove named enums in HalPwrSeqCmd.h
      Staging: rtl8723bs: remove named enums in hal_com_phycfg.h
      Staging: rtl8723bs: remove named enums in ieee80211.h
      Staging: rtl8723bs: remove named enums in rtw_efuse.h
      Staging: rtl8723bs: remove named enums in odm_interface.h
      Staging: rtl8723bs: remove named enums in HalBtcOutSrc.h
      Staging: rtl8723bs: remove named enums in HalBtc8723b1Ant.h
      Staging: rtl8723bs: remove named enums in odm_types.h
      Staging: rtl8723bs: remove named enums in odm_DIG.h
      Staging: rtl8723bs: remove named enums in HalPhyRf.h
      Staging: rtl8723bs: remove named enums in odm.h
      Staging: rtl8723bs: remove named enums in HalBtc8723b2Ant.h
      Staging: rtl8723bs: remove obsolete comments
      Staging: rtl8723bs: remove useless macros

Martin Kaiser (41):
      staging: rtl8188eu: use netdev routines for private data
      staging: rtl8188eu: remove unused function parameter
      staging: rtl8188eu: (trivial) remove a duplicate debug print
      staging: rtl8723bs: remove unused dvobj_priv members
      staging: rtl8188eu: remove unused efuse hal components
      staging: rtl8188eu: ctrl vendor req value is always 0x05
      staging: rtl8188eu: ctrl vendor req index is not used
      staging: rtl8188eu: use actual request type as parameter
      staging: rtl8188eu: clean up usb_read8
      staging: rtl8188eu: clean up usb_read16
      staging: rtl8188eu: clean up usb_read32
      staging: rtl8188eu: clean up usb_write8
      staging: rtl8188eu: clean up usb_write16
      staging: rtl8188eu: clean up usb_write32
      staging: rtl8188eu: remove an obsolete comment
      staging: rtl8188eu: remove unused macros
      staging: rtl8188eu: remove unnecessary brackets
      staging: rtl8188eu: remove unused defines
      staging: rtl8188eu: move defines into the .c file
      staging: rtl8188eu: set pipe only once
      staging: rtl8188eu: clean up rtw_recv_entry
      staging: rtl8188eu: remove unnecessary variable
      staging: rtl8188eu: rtw_usb_if1_init needs no dvobj parameter
      staging: rtl8188eu: make usb_dvobj_init return a status
      staging: rtl8188eu: make rtw_usb_if1_init return a status
      staging: rtl8188eu: remove the last urb callback macros
      staging: rtl8188eu: remove prototype for non-existing function
      staging: rtl8188eu: make ffaddr2pipehdl static
      staging: rtl8188eu: replace switch-case with if
      staging: rtl8188eu: remove unused function parameter
      staging: rtl8188eu: remove a constant variable
      staging: rtl8188eu: move static array from .h to .c
      staging: rtl8188eu: move another static array from .h to .c
      staging: rtl8188eu: always free cmd_obj in the cmd thread
      staging: rtl8188eu: remove duplicate if statement
      staging: rtl8188eu: remove a dead assignment
      staging: rtl8188eu: simplify rtw_cmd_thread's main loop
      staging: rtl8188eu: change bLeisurePs' type to bool
      staging: rtl8188eu: remove constant variable and dead code
      staging: rtl8188eu: cmdThread is a task_struct
      staging: rtl8188eu: remove unused function parameters

Mauro Carvalho Chehab (16):
      staging: hisilicon,hisi-spmi-controller.yaml cleanup schema
      regulator: hi6421v600-regulator: move it from staging
      MAINTAINERS: update adi,ad5758.yaml reference
      MAINTAINERS: update st,hts221.yaml reference
      MAINTAINERS: update dpot-dac.yaml reference
      MAINTAINERS: update envelope-detector.yaml reference
      MAINTAINERS: update current-sense-amplifier.yaml reference
      MAINTAINERS: update current-sense-shunt.yaml reference
      MAINTAINERS: update voltage-divider.yaml reference
      MAINTAINERS: update atmel,sama5d2-adc.yaml reference
      MAINTAINERS: update pni,rm3100.yaml reference
      MAINTAINERS: update renesas,rcar-gyroadc.yaml reference
      MAINTAINERS: update st,lsm6dsx.yaml reference
      MAINTAINERS: update st,vl53l0x.yaml reference
      MAINTAINERS: update ti,dac7612.yaml reference
      dt-bindings:iio:dac: update microchip,mcp4725.yaml reference

Mayank Suman (1):
      staging: gasket Fix comparison with Null

Michael Straube (2):
      staging: rtl8188eu: rename ODM_PhyStatusQuery()
      staging: rtl8188eu: rename parameters of odm_phy_status_query()

Mike Looijmans (2):
      dt-bindings: iio: accel: Add bmi088 accelerometer bindings
      iio: accel: Add support for the Bosch-Sensortec BMI088

Mikko Talikka (1):
      staging: comedi: adv_pci_dio: remove whitespace

Mircea Caprioru (1):
      iio: dac: ad5686: Add support for AD5673R/AD5677R

Mitali Borkar (14):
      staging: rtl8712: matched alignment with open parenthesis
      staging: rtl8712: removed extra blank line
      staging: rtl8712: add spaces around '+'
      staging: rtl8192e: replace comparison to NULL by bool
      staging: rtl8192e: remove unnecesasry f-trace like logging
      staging: rtl8192e: Fix incorrect pointer check
      staging: rts5208: remove unnecessary ftrace-like logging
      staging: vc04_services: TODO: remove trailing whitespace
      staging: vc04_services: TODO: rectify spelling mistake
      staging: rtl8192e: remove unnecessary ftrace-like logging
      staging: rtl8192e: add spaces around binary operators
      staging: rtl8192e: remove unnecessary blank line before brace
      staging: rtl8192e: remove unnecessary blank line after close brace
      staging: rtl8192e: removed multiple blank lines

Mugilraj Dhavachelvan (3):
      iio:dac:max517.c: Use devm_iio_device_register()
      staging: iio: ad9832: kernel-doc fixes
      iio: adc: stm32-dfsdm: drop __func__ while using Dynamic debug

Muhammad Usama Anjum (3):
      staging: wimax/i2400m: don't change the endianness of one byte variable
      staging: axis-fifo: remove redundant dev_err call
      staging: rtl8723bs: Remove unnecessary code

Nikolay Kyx (4):
      staging: fwserial: match alignment with open parenthesis
      staging: kpc2000: code style: match alignment with open parenthesis
      staging: kpc2000: code style: fix line length issue
      staging: rtl8192e: remove redundant variable shadowing

Nuno Sa (3):
      iio: adis16480: fix pps mode sampling frequency math
      iio: adis16475: improve sync scale mode handling
      iio: adis: add helpers for locking

Nuno Sá (1):
      dt-bindings: adis16475: remove property

Oleksij Rempel (2):
      dt-bindings: counter: add interrupt-counter binding
      counter: add IRQ or GPIO based counter

Paul McQuade (1):
      staging: rtl8188eu: Removed Unnecessary logging

Peter Meerwald-Stadler (1):
      MAINTAINERS: iio: move Peter Meerwald-Stadler to CREDITS

Phillip Potter (7):
      staging: rtl8723bs: remove DBG_COUNTER calls from os_dep/recv_linux.c
      staging: rtl8723bs: remove DBG_COUNTER calls from os_dep/xmit_linux.c
      staging: rtl8723bs: remove DBG_COUNTER calls from core/rtw_xmit.c
      staging: rtl8723bs: remove DBG_COUNTER calls from core/rtw_recv.c
      staging: rtl8723bs: remove DBG_COUNTER definition from rtw_debug.h
      staging: rtl8723bs: remove rx_logs/tx_logs/int_logs from drv_types.h
      staging: rtl8723bs: remove unused variable from rtw_os_recv_indicate_pkt

Pritthijit Nath (1):
      staging: wlan-ng: Fixed incorrect type warning in p80211netdev.c

Pu Lehui (1):
      staging: rtl8723bs: remove unused variable pwrctl

Qiang Ma (3):
      Staging: rtl8723bs/core: fix space coding style issue
      staging: rtl8723bs: add spaces between operators
      staging: rtl8723bs/core: add spaces between operators

Qiheng Lin (1):
      staging: comedi: tests: ni_routes_test: Remove unused variable 'olddevroutes'

Rajat Asthana (1):
      staging: wfx: Fix alignment style issue in sta.c

Rajesh Kumbhakar (1):
      staging: wimax: i2400m: add space before open parenthesis

Sean Behan (1):
      staging: emxx_udc: remove unused variable driver_desc

Sean Nyekjaer (1):
      iio: accel: mma8452: fix indentation

Seiya Wang (1):
      dt-bindings: iio: adc: Add compatible for Mediatek MT8195

Selvakumar Elangovan (3):
      Staging: mt7621-pci: fixed a blank line coding style issue
      staging: rtl8712: fixed no space coding style issue
      staging: rtl8712: fixed whitespace coding style issue

Sergei Krainov (1):
      staging: rtl8712: fix wrong function output

Sergiu Cuciurean (3):
      iio: adc: spear_adc: Replace indio_dev->mlock with own device lock
      iio: adc: palmas_gpadc: Replace indio_dev->mlock with own device lock
      iio: adc: npcm_adc: Replace indio_dev->mlock with own device lock

Shreesh Adiga (1):
      staging: octeon: cleanup unnecessary parentheses in ethernet-spmi.c

Shreya Ajith (1):
      staging:rtl8723bs:core:rtw_wlan_util:fixed indentation coding style issue

Shubhrajyoti Datta (7):
      staging: clocking-wizard: Fix kernel-doc warning
      staging: clocking-wizard: Rename speed-grade to xlnx,speed-grade
      staging: clocking-wizard: Update the fixed factor divisors
      staging: clocking-wizard: Allow changing of parent rate for single output
      staging: clocking-wizard: Add support for dynamic reconfiguration
      staging: clocking-wizard: Add support for fractional support
      staging: clocking-wizard: Remove the hardcoding of the clock outputs

Simone Serra (1):
      staging: rt8192u: Move constant in comparison to the RHS

Song Chen (1):
      staging: unisys: visornic: enhance visornic to use channel_interrupt

Stefan Wahren (10):
      staging: vchiq_core: Simplify vchiq_send_remote_use*
      staging: vchiq_core: Shorten var name for service quota
      staging: vchiq_core: Get the rid off curly braces around cases
      staging: vchiq_core: Exit early in 2 functions
      staging: vchiq_core: introduce service skip
      staging: vchiq_core: improve readability of request_poll
      staging: vchiq_core: use BITSET_WORD macro
      staging: vchiq_core: introduce SLOT_QUEUE_INDEX_FROM_POS_MASKED
      staging: vchiq_core: fix if alignments
      staging: vchiq_core: split exit conditions

Stephen Boyd (3):
      platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
      dt-bindings: iio: Add cros ec proximity yaml doc
      iio: proximity: Add a ChromeOS EC MKBP proximity driver

Suryashankar Das (1):
      staging: rtl8188eu: Format comments

Swen Kalski (1):
      Staging: comedi: remove unnecessary else statement

Tian Tao (2):
      staging: rtl8723bs: remove unused including <linux/version.h>
      staging: fieldbus: simplify devm_anybuss_host_common_probe

Tomislav Denis (2):
      iio: adc: Add driver for Texas Instruments ADS131E0x ADC family
      bindings: iio: adc: Add documentation for ADS131E0x ADC driver

Tong Zhang (1):
      staging: comedi: das800: fix request_irq() warn

Vardhan H G (1):
      staging: rt8192u: change constants to be on right

Wan Jiabing (1):
      drivers: staging: rtl8712: _adapter is declared twice

William Breathitt Gray (1):
      counter: 104-quad-8: Remove IIO counter ABI

William Durand (46):
      staging: rtl8192e: fix typo in a comment
      staging: rtl8192e: fix typo in a function name
      staging: rtl8192e: rename ShortData to short_data in sequence_control union
      staging: rtl8192e: rename FragNum to frag_num in sequence_control union
      staging: rtl8192e: rename SeqNum to seq_num in sequence_control union
      staging: rtl8192e: rename charData to char_data in ba_param_set union
      staging: rtl8192e: rename shortData to short_data in ba_param_set union
      staging: rtl8192e: rename BAPolicy to ba_policy in ba_param_set union
      staging: rtl8192e: rename BufferSize to buffer_size in ba_param_set union
      staging: rtl8192e: rename AMSDU_Support to amsdu_support in ba_param_set union
      staging: rtl8192e: rename TID to tid in ba_param_set union
      staging: rtl8192e: rename charData to char_data in delba_param_set union
      staging: rtl8192e: rename shortData to short_data in delba_param_set union
      staging: rtl8192e: rename Reserved to reserved in delba_param_set union
      staging: rtl8192e: rename Initiator to initiator in delba_param_set union
      staging: rtl8192e: rename TID to tid in delba_param_set union
      staging: rtl8192e: rename Timer to timer in ba_record struct
      staging: rtl8192e: rename bValid to b_valid in ba_record struct
      staging: rtl8192e: rename DialogToken to dialog_token in ba_record struct
      staging: rtl8192e: rename BaParamSet to ba_param_set in ba_record struct
      staging: rtl8192e: rename BaTimeoutValue to ba_timeout_value in ba_record struct
      staging: rtl8192e: rename BaStartSeqCtrl to ba_start_seq_ctrl in ba_record struct
      staging: rtl8192e: reformat ba_record struct
      staging: rtl8192e: fix alignment issues in rtllib_wx.c
      staging: rtl8192e: remove blank line in bss_ht struct
      staging: rtl8192e: rename bdSupportHT to bd_support_ht in bss_ht struct
      staging: rtl8192e: rename bdHTCapBuf to bd_ht_cap_buf in bss_ht struct
      staging: rtl8192e: rename bdHTCapLen to bd_ht_cap_len in bss_ht struct
      staging: rtl8192e: rename bdHTInfoBuf to bd_ht_info_buf in bss_ht struct
      staging: rtl8192e: rename bdHTInfoLen to bd_ht_info_len in bss_ht struct
      staging: rtl8192e: rename bdHTSpecVer to bd_ht_spec_ver in bss_ht struct
      staging: rtl8192e: rename bdBandWidth to bd_bandwidth in bss_ht struct
      staging: rtl8192e: rename bdRT2RTAggregation to bd_rt2rt_aggregation in bss_ht struct
      staging: rtl8192e: rename bdRT2RTLongSlotTime to bd_rt2rt_long_slot_time in bss_ht struct
      staging: rtl8192e: rename RT2RT_HT_Mode to rt2rt_ht_mode in bss_ht struct
      staging: rtl8192e: rename bdHT1R to bd_ht_1r in bss_ht struct
      staging: rtl8192e: reformat bss_ht struct
      staging: rtl8192e: rename TsCommonInfo to ts_common_info in rx_ts_record struct
      staging: rtl8192e: rename RxIndicateSeq to rx_indicate_seq in rx_ts_record struct
      staging: rtl8192e: rename RxTimeoutIndicateSeq to rx_timeout_indicate_seq in rx_ts_record struct
      staging: rtl8192e: rename RxPendingPktList to rx_pending_pkt_list in rx_ts_record struct
      staging: rtl8192e: rename RxPktPendingTimer to rx_pkt_pending_timer in rx_ts_record struct
      staging: rtl8192e: rename RxAdmittedBARecord to rx_admitted_ba_record in rx_ts_record struct
      staging: rtl8192e: rename RxLastSeqNum to rx_last_seq_num in rx_ts_record struct
      staging: rtl8192e: rename RxLastFragNum to rx_last_frag_num in rx_ts_record struct
      staging: rtl8192e: reformat rx_ts_record struct

Xuezhi Zhang (1):
      staging: fbtft: convert sysfs snprintf to sysfs_emit

Yang Yingliang (1):
      staging: greybus: camera: Switch to memdup_user_nul()

Ye Xiang (6):
      iio: hid-sensor-rotation: Fix quaternion data not correct
      iio: hid-sensors: Move get sensitivity attribute to hid-sensor-common
      hid-sensors: Add more data fields for sensitivity checking
      iio: Add relative sensitivity support
      iio: hid-sensor-als: Add relative hysteresis support
      iio: Add relative hysteresis in ABI documentation

Zhansaya Bagdauletkyzy (10):
      staging: sm750fb: Remove unnecessary blank line
      staging: rtl8712: add blank lines after declarations
      staging: rtl8712: remove extra blank lines
      staging: rtl8712: add spaces around operators
      staging: rtl8712: match parentheses alignment
      staging: rtl8712: remove extra blank lines
      staging: rtl8712: Remove spaces after a cast
      staging: rtl8712: Rewrite NULL comparisons
      staging: rtl8712: Remove extra blank lines
      staging: rtl8723bs: core: Move constants to the right of comparison

karthik alapati (2):
      staging: wimax/i2400m: fix byte-order issue
      staging: wimax/i2400m: convert __le32 type to host byte-order

shivang upadhyay (1):
      staging: sm750fb: added identifier names for function declarations

zhaoxiao (2):
      staging: rtl8192u: fixed no space coding style issue.
      Staging: rtl8192u: fixed a whitespace coding style issue

zhuo1angt@outlook.com (1):
      staging: wfx: logical continuations should be on the previous line

zuoqilin (1):
      iio:adc:dac:ad5791 typo fix of regster

 CREDITS                                            |    8 +
 Documentation/ABI/testing/sysfs-bus-iio            |  173 ++
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   |  133 --
 .../ABI/testing/sysfs-bus-iio-distance-srf08       |    8 -
 ...iio-humidity-hdc2010 => sysfs-bus-iio-humidity} |    3 +-
 .../ABI/testing/sysfs-bus-iio-humidity-hdc100x     |    9 -
 .../ABI/testing/sysfs-bus-iio-lptimer-stm32        |   62 -
 Documentation/ABI/testing/sysfs-bus-iio-proximity  |   14 +
 .../ABI/testing/sysfs-bus-iio-proximity-as3935     |    9 -
 .../bindings/counter/interrupt-counter.yaml        |   62 +
 .../bindings/iio/accel/bosch,bmi088.yaml           |   68 +
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |    1 +
 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  |  181 ++
 .../devicetree/bindings/iio/cdc/adi,ad7150.yaml    |   69 +
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |    9 -
 .../proximity/google,cros-ec-mkbp-proximity.yaml   |   37 +
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    1 +
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |    7 +
 Documentation/driver-api/driver-model/devres.rst   |    3 +-
 Documentation/driver-api/iio/buffers.rst           |   15 +-
 Documentation/iio/iio_configfs.rst                 |    3 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 MAINTAINERS                                        |   68 +-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/{staging => }/comedi/Kconfig               |   33 +
 drivers/{staging => }/comedi/Makefile              |    0
 drivers/{staging => }/comedi/TODO                  |    0
 drivers/{staging => }/comedi/comedi.h              |    0
 drivers/{staging => }/comedi/comedi_buf.c          |   52 +-
 drivers/{staging => }/comedi/comedi_fops.c         |    0
 drivers/{staging => }/comedi/comedi_internal.h     |    0
 drivers/{staging => }/comedi/comedi_pci.c          |    0
 drivers/{staging => }/comedi/comedi_pci.h          |    0
 drivers/{staging => }/comedi/comedi_pcmcia.c       |    0
 drivers/{staging => }/comedi/comedi_pcmcia.h       |    0
 drivers/{staging => }/comedi/comedi_usb.c          |    0
 drivers/{staging => }/comedi/comedi_usb.h          |    0
 drivers/{staging => }/comedi/comedidev.h           |    0
 drivers/{staging => }/comedi/comedilib.h           |    0
 drivers/{staging => }/comedi/drivers.c             |    0
 drivers/{staging => }/comedi/drivers/8255.c        |    0
 drivers/{staging => }/comedi/drivers/8255.h        |    0
 drivers/{staging => }/comedi/drivers/8255_pci.c    |    0
 drivers/{staging => }/comedi/drivers/Makefile      |    0
 .../{staging => }/comedi/drivers/addi_apci_1032.c  |    0
 .../{staging => }/comedi/drivers/addi_apci_1500.c  |    0
 .../{staging => }/comedi/drivers/addi_apci_1516.c  |    0
 .../{staging => }/comedi/drivers/addi_apci_1564.c  |    0
 .../{staging => }/comedi/drivers/addi_apci_16xx.c  |    2 +-
 .../{staging => }/comedi/drivers/addi_apci_2032.c  |    0
 .../{staging => }/comedi/drivers/addi_apci_2200.c  |    0
 .../{staging => }/comedi/drivers/addi_apci_3120.c  |    0
 .../{staging => }/comedi/drivers/addi_apci_3501.c  |    0
 .../{staging => }/comedi/drivers/addi_apci_3xxx.c  |    0
 drivers/{staging => }/comedi/drivers/addi_tcw.h    |    0
 .../{staging => }/comedi/drivers/addi_watchdog.c   |    0
 .../{staging => }/comedi/drivers/addi_watchdog.h   |    0
 drivers/{staging => }/comedi/drivers/adl_pci6208.c |    0
 drivers/{staging => }/comedi/drivers/adl_pci7x3x.c |    0
 drivers/{staging => }/comedi/drivers/adl_pci8164.c |    0
 drivers/{staging => }/comedi/drivers/adl_pci9111.c |    0
 drivers/{staging => }/comedi/drivers/adl_pci9118.c |    0
 drivers/{staging => }/comedi/drivers/adq12b.c      |    0
 drivers/{staging => }/comedi/drivers/adv_pci1710.c |    0
 drivers/{staging => }/comedi/drivers/adv_pci1720.c |    0
 drivers/{staging => }/comedi/drivers/adv_pci1723.c |    0
 drivers/{staging => }/comedi/drivers/adv_pci1724.c |    0
 drivers/{staging => }/comedi/drivers/adv_pci1760.c |    0
 drivers/{staging => }/comedi/drivers/adv_pci_dio.c |    1 -
 drivers/{staging => }/comedi/drivers/aio_aio12_8.c |    0
 drivers/{staging => }/comedi/drivers/aio_iiro_16.c |    0
 drivers/{staging => }/comedi/drivers/amcc_s5933.h  |    0
 .../{staging => }/comedi/drivers/amplc_dio200.c    |    0
 .../{staging => }/comedi/drivers/amplc_dio200.h    |    0
 .../comedi/drivers/amplc_dio200_common.c           |    0
 .../comedi/drivers/amplc_dio200_pci.c              |    0
 drivers/{staging => }/comedi/drivers/amplc_pc236.c |    0
 drivers/{staging => }/comedi/drivers/amplc_pc236.h |    0
 .../comedi/drivers/amplc_pc236_common.c            |    0
 drivers/{staging => }/comedi/drivers/amplc_pc263.c |    0
 .../{staging => }/comedi/drivers/amplc_pci224.c    |    0
 .../{staging => }/comedi/drivers/amplc_pci230.c    |    0
 .../{staging => }/comedi/drivers/amplc_pci236.c    |    0
 .../{staging => }/comedi/drivers/amplc_pci263.c    |    0
 drivers/{staging => }/comedi/drivers/c6xdigio.c    |    0
 drivers/{staging => }/comedi/drivers/cb_das16_cs.c |    0
 drivers/{staging => }/comedi/drivers/cb_pcidas.c   |    0
 drivers/{staging => }/comedi/drivers/cb_pcidas64.c |    5 -
 drivers/{staging => }/comedi/drivers/cb_pcidda.c   |    0
 drivers/{staging => }/comedi/drivers/cb_pcimdas.c  |    0
 drivers/{staging => }/comedi/drivers/cb_pcimdda.c  |    0
 drivers/{staging => }/comedi/drivers/comedi_8254.c |    0
 drivers/{staging => }/comedi/drivers/comedi_8254.h |    0
 drivers/{staging => }/comedi/drivers/comedi_8255.c |    0
 drivers/{staging => }/comedi/drivers/comedi_bond.c |    0
 .../{staging => }/comedi/drivers/comedi_isadma.c   |    0
 .../{staging => }/comedi/drivers/comedi_isadma.h   |    0
 .../{staging => }/comedi/drivers/comedi_parport.c  |    0
 drivers/{staging => }/comedi/drivers/comedi_test.c |    0
 .../{staging => }/comedi/drivers/contec_pci_dio.c  |    0
 drivers/{staging => }/comedi/drivers/dac02.c       |    0
 .../{staging => }/comedi/drivers/daqboard2000.c    |    0
 drivers/{staging => }/comedi/drivers/das08.c       |    0
 drivers/{staging => }/comedi/drivers/das08.h       |    0
 drivers/{staging => }/comedi/drivers/das08_cs.c    |    0
 drivers/{staging => }/comedi/drivers/das08_isa.c   |    0
 drivers/{staging => }/comedi/drivers/das08_pci.c   |    0
 drivers/{staging => }/comedi/drivers/das16.c       |    0
 drivers/{staging => }/comedi/drivers/das16m1.c     |    0
 drivers/{staging => }/comedi/drivers/das1800.c     |    0
 drivers/{staging => }/comedi/drivers/das6402.c     |    0
 drivers/{staging => }/comedi/drivers/das800.c      |    2 +-
 drivers/{staging => }/comedi/drivers/dmm32at.c     |    0
 drivers/{staging => }/comedi/drivers/dt2801.c      |    0
 drivers/{staging => }/comedi/drivers/dt2811.c      |    0
 drivers/{staging => }/comedi/drivers/dt2814.c      |  152 +-
 drivers/{staging => }/comedi/drivers/dt2815.c      |    0
 drivers/{staging => }/comedi/drivers/dt2817.c      |    0
 drivers/{staging => }/comedi/drivers/dt282x.c      |    0
 drivers/{staging => }/comedi/drivers/dt3000.c      |    0
 drivers/{staging => }/comedi/drivers/dt9812.c      |    0
 .../{staging => }/comedi/drivers/dyna_pci10xx.c    |    0
 drivers/{staging => }/comedi/drivers/fl512.c       |    0
 drivers/{staging => }/comedi/drivers/gsc_hpdi.c    |    0
 drivers/{staging => }/comedi/drivers/icp_multi.c   |    0
 drivers/{staging => }/comedi/drivers/ii_pci20kc.c  |    0
 drivers/{staging => }/comedi/drivers/jr3_pci.c     |    0
 drivers/{staging => }/comedi/drivers/jr3_pci.h     |    0
 drivers/{staging => }/comedi/drivers/ke_counter.c  |    0
 drivers/{staging => }/comedi/drivers/me4000.c      |    0
 drivers/{staging => }/comedi/drivers/me_daq.c      |    0
 drivers/{staging => }/comedi/drivers/mf6x4.c       |    0
 drivers/{staging => }/comedi/drivers/mite.c        |    0
 drivers/{staging => }/comedi/drivers/mite.h        |    0
 drivers/{staging => }/comedi/drivers/mpc624.c      |    0
 drivers/{staging => }/comedi/drivers/multiq3.c     |    0
 drivers/{staging => }/comedi/drivers/ni_6527.c     |    0
 drivers/{staging => }/comedi/drivers/ni_65xx.c     |    0
 drivers/{staging => }/comedi/drivers/ni_660x.c     |    0
 drivers/{staging => }/comedi/drivers/ni_670x.c     |    0
 drivers/{staging => }/comedi/drivers/ni_at_a2150.c |    0
 drivers/{staging => }/comedi/drivers/ni_at_ao.c    |    0
 drivers/{staging => }/comedi/drivers/ni_atmio.c    |    0
 drivers/{staging => }/comedi/drivers/ni_atmio16d.c |    0
 drivers/{staging => }/comedi/drivers/ni_daq_700.c  |    0
 .../{staging => }/comedi/drivers/ni_daq_dio24.c    |    0
 drivers/{staging => }/comedi/drivers/ni_labpc.c    |    0
 drivers/{staging => }/comedi/drivers/ni_labpc.h    |    0
 .../{staging => }/comedi/drivers/ni_labpc_common.c |    0
 drivers/{staging => }/comedi/drivers/ni_labpc_cs.c |    0
 .../{staging => }/comedi/drivers/ni_labpc_isadma.c |    0
 .../{staging => }/comedi/drivers/ni_labpc_isadma.h |    0
 .../{staging => }/comedi/drivers/ni_labpc_pci.c    |    0
 .../{staging => }/comedi/drivers/ni_labpc_regs.h   |    0
 .../{staging => }/comedi/drivers/ni_mio_common.c   |    0
 drivers/{staging => }/comedi/drivers/ni_mio_cs.c   |    0
 drivers/{staging => }/comedi/drivers/ni_pcidio.c   |    0
 drivers/{staging => }/comedi/drivers/ni_pcimio.c   |    0
 drivers/{staging => }/comedi/drivers/ni_routes.c   |    0
 drivers/{staging => }/comedi/drivers/ni_routes.h   |    0
 .../{staging => }/comedi/drivers/ni_routing/README |    0
 .../comedi/drivers/ni_routing/ni_device_routes.c   |    0
 .../comedi/drivers/ni_routing/ni_device_routes.h   |    0
 .../drivers/ni_routing/ni_device_routes/all.h      |    0
 .../ni_routing/ni_device_routes/pci-6070e.c        |    0
 .../drivers/ni_routing/ni_device_routes/pci-6220.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6221.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6229.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6251.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6254.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6259.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6534.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6602.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6713.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6723.c |    0
 .../drivers/ni_routing/ni_device_routes/pci-6733.c |    0
 .../ni_routing/ni_device_routes/pxi-6030e.c        |    0
 .../drivers/ni_routing/ni_device_routes/pxi-6224.c |    0
 .../drivers/ni_routing/ni_device_routes/pxi-6225.c |    0
 .../drivers/ni_routing/ni_device_routes/pxi-6251.c |    0
 .../drivers/ni_routing/ni_device_routes/pxi-6733.c |    0
 .../ni_routing/ni_device_routes/pxie-6251.c        |    0
 .../ni_routing/ni_device_routes/pxie-6535.c        |    0
 .../ni_routing/ni_device_routes/pxie-6738.c        |    0
 .../comedi/drivers/ni_routing/ni_route_values.c    |    0
 .../comedi/drivers/ni_routing/ni_route_values.h    |    0
 .../drivers/ni_routing/ni_route_values/all.h       |    0
 .../drivers/ni_routing/ni_route_values/ni_660x.c   |    0
 .../ni_routing/ni_route_values/ni_eseries.c        |    0
 .../ni_routing/ni_route_values/ni_mseries.c        |    0
 .../comedi/drivers/ni_routing/tools/.gitignore     |    0
 .../comedi/drivers/ni_routing/tools/Makefile       |    0
 .../drivers/ni_routing/tools/convert_c_to_py.c     |    0
 .../drivers/ni_routing/tools/convert_csv_to_c.py   |    0
 .../drivers/ni_routing/tools/convert_py_to_csv.py  |    0
 .../drivers/ni_routing/tools/csv_collection.py     |    0
 .../drivers/ni_routing/tools/make_blank_csv.py     |    0
 .../comedi/drivers/ni_routing/tools/ni_names.py    |    0
 drivers/{staging => }/comedi/drivers/ni_stc.h      |    0
 drivers/{staging => }/comedi/drivers/ni_tio.c      |    0
 drivers/{staging => }/comedi/drivers/ni_tio.h      |    0
 .../{staging => }/comedi/drivers/ni_tio_internal.h |    0
 drivers/{staging => }/comedi/drivers/ni_tiocmd.c   |    0
 drivers/{staging => }/comedi/drivers/ni_usb6501.c  |    0
 drivers/{staging => }/comedi/drivers/pcl711.c      |    0
 drivers/{staging => }/comedi/drivers/pcl724.c      |    0
 drivers/{staging => }/comedi/drivers/pcl726.c      |    0
 drivers/{staging => }/comedi/drivers/pcl730.c      |    0
 drivers/{staging => }/comedi/drivers/pcl812.c      |    0
 drivers/{staging => }/comedi/drivers/pcl816.c      |    0
 drivers/{staging => }/comedi/drivers/pcl818.c      |    0
 drivers/{staging => }/comedi/drivers/pcm3724.c     |    0
 drivers/{staging => }/comedi/drivers/pcmad.c       |    0
 drivers/{staging => }/comedi/drivers/pcmda12.c     |    0
 drivers/{staging => }/comedi/drivers/pcmmio.c      |    0
 drivers/{staging => }/comedi/drivers/pcmuio.c      |    0
 drivers/{staging => }/comedi/drivers/plx9052.h     |    0
 drivers/{staging => }/comedi/drivers/plx9080.h     |    0
 .../{staging => }/comedi/drivers/quatech_daqp_cs.c |    0
 drivers/{staging => }/comedi/drivers/rtd520.c      |    0
 drivers/{staging => }/comedi/drivers/rti800.c      |    0
 drivers/{staging => }/comedi/drivers/rti802.c      |    0
 drivers/{staging => }/comedi/drivers/s526.c        |    0
 drivers/{staging => }/comedi/drivers/s626.c        |    0
 drivers/{staging => }/comedi/drivers/s626.h        |    0
 drivers/{staging => }/comedi/drivers/ssv_dnp.c     |    0
 .../{staging => }/comedi/drivers/tests/Makefile    |    3 +-
 .../drivers/tests/comedi_example_test.c}           |   10 +-
 .../comedi/drivers/tests/ni_routes_test.c          |  120 +-
 .../{staging => }/comedi/drivers/tests/unittest.h  |    2 +-
 drivers/{staging => }/comedi/drivers/usbdux.c      |    0
 drivers/{staging => }/comedi/drivers/usbduxfast.c  |    0
 drivers/{staging => }/comedi/drivers/usbduxsigma.c |    0
 drivers/{staging => }/comedi/drivers/vmk80xx.c     |    0
 drivers/{staging => }/comedi/drivers/z8536.h       |    0
 drivers/{staging => }/comedi/kcomedilib/Makefile   |    0
 .../comedi/kcomedilib/kcomedilib_main.c            |    0
 drivers/{staging => }/comedi/proc.c                |    0
 drivers/{staging => }/comedi/range.c               |    0
 drivers/counter/104-quad-8.c                       |  653 +------
 drivers/counter/Kconfig                            |   14 +-
 drivers/counter/Makefile                           |    1 +
 drivers/counter/interrupt-cnt.c                    |  244 +++
 drivers/counter/stm32-lptimer-cnt.c                |  297 +---
 drivers/firmware/arm_scmi/driver.c                 |    2 +-
 drivers/hwmon/ntc_thermistor.c                     |   27 +-
 drivers/iio/Kconfig                                |    2 +
 drivers/iio/Makefile                               |    2 +
 drivers/iio/accel/Kconfig                          |   18 +
 drivers/iio/accel/Makefile                         |    2 +
 drivers/iio/accel/adis16201.c                      |    2 +-
 drivers/iio/accel/adxl372.c                        |    2 -
 drivers/iio/accel/bma180.c                         |    3 +-
 drivers/iio/accel/bma220_spi.c                     |    2 +-
 drivers/iio/accel/bmc150-accel-core.c              |   19 +-
 drivers/iio/accel/bmi088-accel-core.c              |  567 ++++++
 drivers/iio/accel/bmi088-accel-spi.c               |   83 +
 drivers/iio/accel/bmi088-accel.h                   |   18 +
 drivers/iio/accel/cros_ec_accel_legacy.c           |    2 +-
 drivers/iio/accel/da280.c                          |    2 +-
 drivers/iio/accel/da311.c                          |    2 +-
 drivers/iio/accel/dmard10.c                        |    2 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   23 +-
 drivers/iio/accel/kxcjk-1013.c                     |   16 +-
 drivers/iio/accel/mc3230.c                         |    2 +-
 drivers/iio/accel/mma7660.c                        |    2 +-
 drivers/iio/accel/mma8452.c                        |   47 +-
 drivers/iio/accel/mxc4005.c                        |    1 -
 drivers/iio/accel/sca3000.c                        |   27 +-
 drivers/iio/accel/ssp_accel_sensor.c               |   14 +-
 drivers/iio/accel/stk8312.c                        |    3 +-
 drivers/iio/accel/stk8ba50.c                       |    3 +-
 drivers/iio/adc/Kconfig                            |   16 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7124.c                           |  459 +++--
 drivers/iio/adc/ad7292.c                           |    2 +-
 drivers/iio/adc/ad7298.c                           |    6 -
 drivers/iio/adc/ad7476.c                           |   18 +-
 drivers/iio/adc/ad7606.c                           |    1 -
 drivers/iio/adc/ad7766.c                           |   16 +-
 drivers/iio/adc/ad7768-1.c                         |    1 -
 drivers/iio/adc/ad7887.c                           |    6 -
 drivers/iio/adc/ad7923.c                           |   47 +-
 drivers/iio/adc/ad799x.c                           |    6 -
 drivers/iio/adc/ad_sigma_delta.c                   |   13 +-
 drivers/iio/adc/adi-axi-adc.c                      |   14 +-
 drivers/iio/adc/at91_adc.c                         |    3 +-
 drivers/iio/adc/cpcap-adc.c                        |    2 +-
 drivers/iio/adc/exynos_adc.c                       |    4 +-
 drivers/iio/adc/ina2xx-adc.c                       |   14 +-
 drivers/iio/adc/max1027.c                          |    1 -
 drivers/iio/adc/mt6360-adc.c                       |    3 +-
 drivers/iio/adc/nau7802.c                          |    6 +-
 drivers/iio/adc/npcm_adc.c                         |   15 +-
 drivers/iio/adc/palmas_gpadc.c                     |   18 +-
 drivers/iio/adc/spear_adc.c                        |   20 +-
 drivers/iio/adc/stm32-adc.c                        |   39 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   10 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    4 +-
 drivers/iio/adc/ti-adc084s021.c                    |    6 +-
 drivers/iio/adc/ti-ads131e08.c                     |  948 ++++++++++
 drivers/iio/adc/ti_am335x_adc.c                    |   18 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    1 -
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   35 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |   10 +-
 drivers/iio/buffer/kfifo_buf.c                     |   45 +-
 drivers/iio/cdc/Kconfig                            |   17 +
 drivers/iio/cdc/Makefile                           |    6 +
 drivers/iio/cdc/ad7150.c                           |  673 ++++++++
 drivers/iio/chemical/atlas-sensor.c                |    1 -
 drivers/iio/chemical/bme680_i2c.c                  |    3 +-
 drivers/iio/chemical/bme680_spi.c                  |    3 +-
 drivers/iio/chemical/ccs811.c                      |    1 -
 drivers/iio/chemical/scd30_core.c                  |   17 +-
 drivers/iio/chemical/scd30_serial.c                |    2 +-
 drivers/iio/common/Kconfig                         |    1 +
 drivers/iio/common/Makefile                        |    1 +
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |    3 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |    3 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   33 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c |   83 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |    4 +-
 drivers/iio/common/scmi_sensors/Kconfig            |   18 +
 drivers/iio/common/scmi_sensors/Makefile           |    5 +
 drivers/iio/common/scmi_sensors/scmi_iio.c         |  672 ++++++++
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |    2 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |    4 +-
 drivers/iio/dac/Kconfig                            |    5 +-
 drivers/iio/dac/ad5064.c                           |    2 +-
 drivers/iio/dac/ad5360.c                           |    2 +-
 drivers/iio/dac/ad5380.c                           |    2 +-
 drivers/iio/dac/ad5446.c                           |    2 +-
 drivers/iio/dac/ad5504.c                           |    6 +-
 drivers/iio/dac/ad5624r_spi.c                      |    4 +-
 drivers/iio/dac/ad5686.c                           |   14 +-
 drivers/iio/dac/ad5686.h                           |    2 +
 drivers/iio/dac/ad5696-i2c.c                       |    6 +-
 drivers/iio/dac/ad5755.c                           |    4 +-
 drivers/iio/dac/ad5758.c                           |    2 +-
 drivers/iio/dac/ad5766.c                           |    2 +-
 drivers/iio/dac/ad5770r.c                          |    4 +-
 drivers/iio/dac/ad5791.c                           |    4 +-
 drivers/iio/dac/ad7303.c                           |    2 +-
 drivers/iio/dac/ltc2632.c                          |    4 +-
 drivers/iio/dac/max517.c                           |   10 +-
 drivers/iio/dac/max5821.c                          |    2 +-
 drivers/iio/dac/mcp4725.c                          |    2 +-
 drivers/iio/dac/stm32-dac.c                        |    2 +-
 drivers/iio/dac/ti-dac082s085.c                    |    2 +-
 drivers/iio/dac/ti-dac5571.c                       |    2 +-
 drivers/iio/dac/ti-dac7311.c                       |    2 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |   68 +-
 drivers/iio/gyro/adxrs290.c                        |    1 -
 drivers/iio/gyro/bmg160_core.c                     |    2 -
 drivers/iio/gyro/fxas21002c_core.c                 |    1 -
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   19 +-
 drivers/iio/gyro/itg3200_buffer.c                  |    3 +-
 drivers/iio/gyro/ssp_gyro_sensor.c                 |   14 +-
 drivers/iio/health/afe4403.c                       |    1 -
 drivers/iio/health/afe4404.c                       |    1 -
 drivers/iio/health/max30100.c                      |   16 +-
 drivers/iio/health/max30102.c                      |   16 +-
 drivers/iio/humidity/am2315.c                      |    2 +-
 drivers/iio/humidity/hid-sensor-humidity.c         |   16 +-
 drivers/iio/humidity/hts221_buffer.c               |    1 -
 drivers/iio/iio_core.h                             |   32 +-
 drivers/iio/iio_core_trigger.h                     |    4 +-
 drivers/iio/imu/adis16400.c                        |   22 +-
 drivers/iio/imu/adis16460.c                        |    4 +-
 drivers/iio/imu/adis16475.c                        |  123 +-
 drivers/iio/imu/adis16480.c                        |  133 +-
 drivers/iio/imu/adis_trigger.c                     |   21 +-
 drivers/iio/imu/fxos8700_i2c.c                     |    3 +-
 drivers/iio/imu/fxos8700_spi.c                     |    3 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   14 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   13 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   72 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   10 +
 drivers/iio/imu/kmx61.c                            |    1 -
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   15 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c        |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    3 +-
 drivers/iio/industrialio-buffer.c                  |  517 ++++--
 drivers/iio/industrialio-core.c                    |  198 ++-
 drivers/iio/industrialio-event.c                   |    9 +-
 drivers/iio/industrialio-trigger.c                 |   72 +-
 drivers/iio/inkern.c                               |   16 +-
 drivers/iio/light/acpi-als.c                       |  117 +-
 drivers/iio/light/apds9960.c                       |   16 +-
 drivers/iio/light/cros_ec_light_prox.c             |    3 +-
 drivers/iio/light/gp2ap002.c                       |    3 +-
 drivers/iio/light/gp2ap020a00f.c                   |    1 -
 drivers/iio/light/hid-sensor-als.c                 |   34 +-
 drivers/iio/light/hid-sensor-prox.c                |   32 +-
 drivers/iio/light/opt3001.c                        |    2 +-
 drivers/iio/light/rpr0521.c                        |    1 -
 drivers/iio/light/si1145.c                         |    1 -
 drivers/iio/light/st_uvis25_core.c                 |    1 -
 drivers/iio/light/stk3310.c                        |    2 +-
 drivers/iio/light/vcnl4000.c                       |    1 -
 drivers/iio/light/vcnl4035.c                       |    1 -
 drivers/iio/magnetometer/bmc150_magn.c             |    1 -
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   32 +-
 drivers/iio/magnetometer/rm3100-core.c             |    1 -
 drivers/iio/magnetometer/st_magn.h                 |    1 +
 drivers/iio/magnetometer/st_magn_core.c            |    1 +
 drivers/iio/magnetometer/st_magn_i2c.c             |    5 +
 drivers/iio/magnetometer/st_magn_spi.c             |    5 +
 drivers/iio/magnetometer/yamaha-yas530.c           |    4 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |   20 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |   37 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |   20 +-
 drivers/iio/potentiometer/max5481.c                |    4 +-
 drivers/iio/potentiometer/max5487.c                |    4 +-
 drivers/iio/potentiostat/lmp91000.c                |    3 +-
 drivers/iio/pressure/cros_ec_baro.c                |    3 +-
 drivers/iio/pressure/hid-sensor-press.c            |   20 +-
 drivers/iio/pressure/zpa2326.c                     |    5 +-
 drivers/iio/proximity/Kconfig                      |   11 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/as3935.c                     |    1 -
 drivers/iio/proximity/cros_ec_mkbp_proximity.c     |  271 +++
 drivers/iio/proximity/sx9310.c                     |   53 +-
 drivers/iio/proximity/sx9500.c                     |    3 +-
 drivers/iio/proximity/vcnl3020.c                   |   97 +-
 drivers/iio/temperature/hid-sensor-temperature.c   |   16 +-
 drivers/iio/temperature/tmp007.c                   |   36 +-
 drivers/iio/test/Kconfig                           |    9 +
 drivers/iio/test/Makefile                          |    7 +
 drivers/iio/test/iio-test-format.c                 |  198 +++
 drivers/iio/trigger/iio-trig-hrtimer.c             |   37 +-
 drivers/iio/trigger/iio-trig-interrupt.c           |    2 +-
 drivers/iio/trigger/iio-trig-loop.c                |    2 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |    3 +-
 drivers/most/Kconfig                               |   10 +
 drivers/most/Makefile                              |    1 +
 .../most/sound/sound.c => most/most_snd.c}         |    0
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 .../hikey9xx => regulator}/hi6421v600-regulator.c  |    0
 drivers/rtc/rtc-hid-sensor-time.c                  |    4 +-
 drivers/staging/Kconfig                            |    6 -
 drivers/staging/Makefile                           |    3 -
 drivers/staging/android/uapi/ashmem.h              |    2 -
 drivers/staging/axis-fifo/axis-fifo.c              |    1 -
 .../clocking-wizard/clk-xlnx-clock-wizard.c        |  369 +++-
 drivers/staging/emxx_udc/emxx_udc.c                |    1 -
 drivers/staging/fbtft/fbtft-sysfs.c                |    2 +-
 drivers/staging/fieldbus/anybuss/host.c            |   24 +-
 drivers/staging/fwserial/fwserial.c                |    6 +-
 drivers/staging/gasket/Kconfig                     |   25 -
 drivers/staging/gasket/Makefile                    |   10 -
 drivers/staging/gasket/TODO                        |   22 -
 drivers/staging/gasket/apex.h                      |   30 -
 drivers/staging/gasket/apex_driver.c               |  726 --------
 drivers/staging/gasket/gasket.h                    |  122 --
 drivers/staging/gasket/gasket_constants.h          |   44 -
 drivers/staging/gasket/gasket_core.c               | 1815 --------------------
 drivers/staging/gasket/gasket_core.h               |  638 -------
 drivers/staging/gasket/gasket_interrupt.c          |  515 ------
 drivers/staging/gasket/gasket_interrupt.h          |   95 -
 drivers/staging/gasket/gasket_ioctl.c              |  388 -----
 drivers/staging/gasket/gasket_ioctl.h              |   28 -
 drivers/staging/gasket/gasket_page_table.c         | 1359 ---------------
 drivers/staging/gasket/gasket_page_table.h         |  249 ---
 drivers/staging/gasket/gasket_sysfs.c              |  398 -----
 drivers/staging/gasket/gasket_sysfs.h              |  175 --
 drivers/staging/greybus/arche-platform.c           |   10 +-
 drivers/staging/greybus/audio_module.c             |    4 +-
 drivers/staging/greybus/audio_topology.c           |   12 +-
 drivers/staging/greybus/camera.c                   |   13 +-
 drivers/staging/greybus/sdio.c                     |    1 -
 drivers/staging/hikey9xx/Kconfig                   |   11 -
 drivers/staging/hikey9xx/Makefile                  |    1 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c        |    8 +-
 .../hikey9xx/hisilicon,hisi-spmi-controller.yaml   |   18 +-
 drivers/staging/iio/TODO                           |    4 -
 drivers/staging/iio/cdc/Kconfig                    |   10 -
 drivers/staging/iio/cdc/Makefile                   |    3 +-
 drivers/staging/iio/cdc/ad7150.c                   |  655 -------
 drivers/staging/iio/frequency/ad9832.c             |    4 +-
 drivers/staging/iio/frequency/ad9834.c             |   67 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   23 +-
 drivers/staging/kpc2000/kpc2000/pcie.h             |    1 -
 drivers/staging/kpc2000/kpc2000_i2c.c              |    6 +-
 drivers/staging/kpc2000/kpc2000_spi.c              |    2 +-
 drivers/staging/most/Kconfig                       |    2 -
 drivers/staging/most/Makefile                      |    1 -
 drivers/staging/most/sound/Kconfig                 |   14 -
 drivers/staging/most/sound/Makefile                |    4 -
 drivers/staging/mt7621-pci/pci-mt7621.c            |   12 +-
 drivers/staging/netlogic/Kconfig                   |    1 +
 drivers/staging/nvec/nvec_ps2.c                    |    2 +-
 drivers/staging/octeon-usb/octeon-hcd.c            |   32 +-
 drivers/staging/octeon/ethernet-spi.c              |    2 +-
 drivers/staging/octeon/ethernet.c                  |    9 +-
 drivers/staging/qlge/qlge_devlink.c                |   10 +-
 drivers/staging/qlge/qlge_devlink.h                |    2 +-
 drivers/staging/qlge/qlge_main.c                   |   17 +-
 drivers/staging/ralink-gdma/ralink-gdma.c          |    5 +-
 drivers/staging/rtl8188eu/core/rtw_ap.c            |    6 -
 drivers/staging/rtl8188eu/core/rtw_cmd.c           |   83 +-
 drivers/staging/rtl8188eu/core/rtw_debug.c         |    8 +-
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |    6 +-
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c     |    8 +
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |    2 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |   12 +-
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c       |    5 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c          |   27 +-
 drivers/staging/rtl8188eu/core/rtw_security.c      |   78 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |    7 +-
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c       |   11 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c    |   12 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c     |    2 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c        |    5 +-
 drivers/staging/rtl8188eu/include/drv_types.h      |    2 +-
 drivers/staging/rtl8188eu/include/odm_hwconfig.h   |    8 +-
 drivers/staging/rtl8188eu/include/osdep_intf.h     |    2 +-
 drivers/staging/rtl8188eu/include/osdep_service.h  |   13 -
 drivers/staging/rtl8188eu/include/recv_osdep.h     |    2 +-
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h   |    4 -
 drivers/staging/rtl8188eu/include/rtw_cmd.h        |   20 -
 drivers/staging/rtl8188eu/include/rtw_efuse.h      |   20 -
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h   |   30 -
 drivers/staging/rtl8188eu/include/rtw_pwrctrl.h    |    2 +-
 drivers/staging/rtl8188eu/include/usb_ops_linux.h  |   32 -
 drivers/staging/rtl8188eu/include/wifi.h           |  156 --
 drivers/staging/rtl8188eu/include/wlan_bssdef.h    |    2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |   88 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c        |   22 +-
 drivers/staging/rtl8188eu/os_dep/osdep_service.c   |   31 -
 drivers/staging/rtl8188eu/os_dep/recv_linux.c      |    3 +-
 drivers/staging/rtl8188eu/os_dep/rtw_android.c     |   23 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |   84 +-
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c   |  171 +-
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c      |    2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |   14 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |    5 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |    4 +-
 drivers/staging/rtl8192e/rtl819x_BA.h              |   40 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |  127 +-
 drivers/staging/rtl8192e/rtl819x_HT.h              |   23 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |   81 +-
 drivers/staging/rtl8192e/rtl819x_TS.h              |   18 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |   79 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |    2 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |  170 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |   14 +-
 drivers/staging/rtl8192e/rtllib_tx.c               |    8 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |   76 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  |   42 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |    2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c  |    4 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c  |    6 +-
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    |    4 +-
 drivers/staging/rtl8192u/r8190_rtl8256.c           |    7 +-
 drivers/staging/rtl8192u/r8192U.h                  |    6 +-
 drivers/staging/rtl8192u/r8192U_core.c             |    5 +-
 drivers/staging/rtl8192u/r8192U_wx.c               |  159 +-
 drivers/staging/rtl8712/drv_types.h                |    2 -
 drivers/staging/rtl8712/ieee80211.c                |   18 +-
 drivers/staging/rtl8712/mlme_osdep.h               |    4 +-
 drivers/staging/rtl8712/rtl8712_recv.h             |    2 +-
 drivers/staging/rtl8712/rtl8712_wmac_regdef.h      |    1 -
 drivers/staging/rtl8712/rtl8712_xmit.c             |   13 +-
 drivers/staging/rtl8712/rtl8712_xmit.h             |    5 +-
 drivers/staging/rtl8712/rtl871x_cmd.h              |   10 +
 drivers/staging/rtl8712/rtl871x_event.h            |    1 +
 drivers/staging/rtl8712/rtl871x_ht.h               |    2 +-
 drivers/staging/rtl8712/rtl871x_io.h               |    1 -
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c      |   20 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |   28 +-
 drivers/staging/rtl8712/rtl871x_mlme.h             |    1 -
 drivers/staging/rtl8712/rtl871x_mp.c               |    1 +
 drivers/staging/rtl8712/rtl871x_mp.h               |    1 +
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c         |    3 +
 drivers/staging/rtl8712/rtl871x_pwrctrl.h          |    3 -
 drivers/staging/rtl8712/rtl871x_recv.c             |   36 +-
 drivers/staging/rtl8712/rtl871x_recv.h             |   12 +-
 drivers/staging/rtl8712/rtl871x_security.c         |   24 +-
 drivers/staging/rtl8712/rtl871x_security.h         |    4 +-
 drivers/staging/rtl8712/rtl871x_xmit.c             |    8 +-
 drivers/staging/rtl8712/rtl871x_xmit.h             |   12 +-
 drivers/staging/rtl8712/sta_info.h                 |    1 -
 drivers/staging/rtl8712/usb_ops.h                  |    6 +-
 drivers/staging/rtl8712/wifi.h                     |  265 +--
 drivers/staging/rtl8712/wlan_bssdef.h              |    2 +-
 drivers/staging/rtl8712/xmit_osdep.h               |    8 +-
 drivers/staging/rtl8723bs/TODO                     |    1 -
 drivers/staging/rtl8723bs/core/rtw_ap.c            |  336 +---
 drivers/staging/rtl8723bs/core/rtw_btcoex.c        |   12 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |  184 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c         |   61 +-
 drivers/staging/rtl8723bs/core/rtw_eeprom.c        |   56 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   25 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |  156 +-
 drivers/staging/rtl8723bs/core/rtw_io.c            |   11 +-
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |  120 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |  350 +---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |  832 ++-------
 drivers/staging/rtl8723bs/core/rtw_odm.c           |   60 +-
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |  316 +---
 drivers/staging/rtl8723bs/core/rtw_recv.c          |  939 +++-------
 drivers/staging/rtl8723bs/core/rtw_security.c      |  283 +--
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |   35 -
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  407 +----
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |  399 +----
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h        |  435 +++--
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c    |  258 ++-
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h    |   54 +-
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c    |  224 +--
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.h    |   48 +-
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h       |  188 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c   |   10 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.h   |    6 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c  |    6 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.h  |    2 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c   |   12 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.h   |    6 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf.c           |    8 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf.h           |   25 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |   70 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.h     |   12 +-
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c       |   59 +-
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         |  171 +-
 drivers/staging/rtl8723bs/hal/hal_com.c            |  233 +--
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |  250 +--
 drivers/staging/rtl8723bs/hal/hal_intf.c           |   39 +-
 drivers/staging/rtl8723bs/hal/hal_pwr_seq.c        |   22 +-
 drivers/staging/rtl8723bs/hal/odm.c                | 1728 +++++++++----------
 drivers/staging/rtl8723bs/hal/odm.h                |  412 ++---
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c    |   28 +-
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.h    |    4 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |   66 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.h            |   32 +-
 .../rtl8723bs/hal/odm_DynamicBBPowerSaving.c       |    8 +-
 .../rtl8723bs/hal/odm_DynamicBBPowerSaving.h       |    4 +-
 drivers/staging/rtl8723bs/hal/odm_DynamicTxPower.c |    2 +-
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c |    6 +-
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.h |    4 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c       |   35 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h       |   79 +-
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c   |    2 +-
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h   |    4 +-
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c        |    4 +-
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c |   16 +-
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h |   16 +-
 drivers/staging/rtl8723bs/hal/odm_debug.c          |    2 +-
 drivers/staging/rtl8723bs/hal/odm_debug.h          |    4 +-
 drivers/staging/rtl8723bs/hal/odm_interface.h      |   11 -
 drivers/staging/rtl8723bs/hal/odm_types.h          |   47 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c       | 1392 +--------------
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c        |   26 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  713 +-------
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |   74 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c    |    4 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c    |    3 -
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |   35 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |  100 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       |  561 +-----
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |  201 +--
 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h |    8 +-
 drivers/staging/rtl8723bs/include/HalPwrSeqCmd.h   |   12 +-
 drivers/staging/rtl8723bs/include/HalVerDef.h      |   62 +-
 drivers/staging/rtl8723bs/include/autoconf.h       |   10 -
 drivers/staging/rtl8723bs/include/basic_types.h    |    6 +-
 drivers/staging/rtl8723bs/include/drv_conf.h       |   10 -
 drivers/staging/rtl8723bs/include/drv_types.h      |  215 +--
 drivers/staging/rtl8723bs/include/drv_types_sdio.h |    5 -
 drivers/staging/rtl8723bs/include/hal_btcoex.h     |    4 +-
 drivers/staging/rtl8723bs/include/hal_com.h        |   52 +-
 drivers/staging/rtl8723bs/include/hal_com_h2c.h    |  185 +-
 drivers/staging/rtl8723bs/include/hal_com_phycfg.h |   40 +-
 drivers/staging/rtl8723bs/include/hal_com_reg.h    |   48 +-
 drivers/staging/rtl8723bs/include/hal_data.h       |   50 +-
 drivers/staging/rtl8723bs/include/hal_intf.h       |   72 +-
 drivers/staging/rtl8723bs/include/hal_phy.h        |   85 +-
 drivers/staging/rtl8723bs/include/hal_phy_cfg.h    |    6 +-
 drivers/staging/rtl8723bs/include/hal_pwr_seq.h    |   24 +-
 drivers/staging/rtl8723bs/include/ieee80211.h      |  202 +--
 drivers/staging/rtl8723bs/include/ioctl_cfg80211.h |    6 +-
 drivers/staging/rtl8723bs/include/osdep_intf.h     |   12 +-
 drivers/staging/rtl8723bs/include/osdep_service.h  |   39 +-
 .../rtl8723bs/include/osdep_service_linux.h        |   29 +-
 drivers/staging/rtl8723bs/include/recv_osdep.h     |    8 +-
 drivers/staging/rtl8723bs/include/rtl8723b_cmd.h   |    8 +-
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h   |   48 +-
 drivers/staging/rtl8723bs/include/rtl8723b_recv.h  |   44 -
 drivers/staging/rtl8723bs/include/rtl8723b_rf.h    |    2 +-
 drivers/staging/rtl8723bs/include/rtl8723b_spec.h  |   10 -
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h  |    8 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h        |  271 +--
 drivers/staging/rtl8723bs/include/rtw_debug.h      |   92 -
 drivers/staging/rtl8723bs/include/rtw_eeprom.h     |    4 +-
 drivers/staging/rtl8723bs/include/rtw_efuse.h      |   10 +-
 drivers/staging/rtl8723bs/include/rtw_event.h      |   11 -
 drivers/staging/rtl8723bs/include/rtw_ht.h         |   12 +-
 drivers/staging/rtl8723bs/include/rtw_io.h         |  113 +-
 drivers/staging/rtl8723bs/include/rtw_ioctl_set.h  |   16 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |  142 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |   90 +-
 drivers/staging/rtl8723bs/include/rtw_mp.h         |  137 +-
 drivers/staging/rtl8723bs/include/rtw_odm.h        |    2 +-
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h    |   95 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h       |   66 +-
 drivers/staging/rtl8723bs/include/rtw_rf.h         |   36 +-
 drivers/staging/rtl8723bs/include/rtw_security.h   |   58 +-
 drivers/staging/rtl8723bs/include/rtw_wifi_regd.h  |   12 -
 drivers/staging/rtl8723bs/include/rtw_xmit.h       |   62 +-
 drivers/staging/rtl8723bs/include/sdio_ops.h       |    7 -
 drivers/staging/rtl8723bs/include/sta_info.h       |   28 +-
 drivers/staging/rtl8723bs/include/wifi.h           |  101 +-
 drivers/staging/rtl8723bs/include/wlan_bssdef.h    |   51 +-
 drivers/staging/rtl8723bs/include/xmit_osdep.h     |   14 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  534 +-----
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |  731 +-------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c      |   24 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |  568 +-----
 drivers/staging/rtl8723bs/os_dep/osdep_service.c   |    8 +-
 drivers/staging/rtl8723bs/os_dep/recv_linux.c      |   96 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |  217 +--
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c  |   97 +-
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c       |    4 +-
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |   62 +-
 drivers/staging/rts5208/xd.c                       |    2 -
 drivers/staging/sm750fb/sm750.h                    |   32 +-
 drivers/staging/unisys/visornic/visornic_main.c    |   34 +-
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |   10 +-
 drivers/staging/vc04_services/interface/TODO       |    6 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |    8 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  360 ++--
 .../interface/vchiq_arm/vchiq_debugfs.h            |    2 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |    4 +-
 drivers/staging/vt6655/baseband.c                  |    6 +-
 drivers/staging/vt6655/channel.c                   |   42 +-
 drivers/staging/vt6656/card.c                      |    3 +-
 drivers/staging/wfx/hif_rx.c                       |    6 +-
 drivers/staging/wfx/sta.c                          |    2 +-
 drivers/staging/wimax/Documentation/i2400m.rst     |  283 ---
 drivers/staging/wimax/Documentation/index.rst      |   19 -
 drivers/staging/wimax/Documentation/wimax.rst      |   89 -
 drivers/staging/wimax/Kconfig                      |   47 -
 drivers/staging/wimax/Makefile                     |   15 -
 drivers/staging/wimax/TODO                         |   18 -
 drivers/staging/wimax/debug-levels.h               |   29 -
 drivers/staging/wimax/debugfs.c                    |   38 -
 drivers/staging/wimax/i2400m/Kconfig               |   37 -
 drivers/staging/wimax/i2400m/Makefile              |   23 -
 drivers/staging/wimax/i2400m/control.c             | 1434 ----------------
 drivers/staging/wimax/i2400m/debug-levels.h        |   32 -
 drivers/staging/wimax/i2400m/debugfs.c             |  253 ---
 drivers/staging/wimax/i2400m/driver.c              | 1003 -----------
 drivers/staging/wimax/i2400m/fw.c                  | 1666 ------------------
 drivers/staging/wimax/i2400m/i2400m-usb.h          |  275 ---
 drivers/staging/wimax/i2400m/i2400m.h              |  970 -----------
 drivers/staging/wimax/i2400m/linux-wimax-i2400m.h  |  572 ------
 drivers/staging/wimax/i2400m/netdev.c              |  603 -------
 drivers/staging/wimax/i2400m/op-rfkill.c           |  196 ---
 drivers/staging/wimax/i2400m/rx.c                  | 1394 ---------------
 drivers/staging/wimax/i2400m/sysfs.c               |   65 -
 drivers/staging/wimax/i2400m/tx.c                  | 1015 -----------
 drivers/staging/wimax/i2400m/usb-debug-levels.h    |   28 -
 drivers/staging/wimax/i2400m/usb-fw.c              |  365 ----
 drivers/staging/wimax/i2400m/usb-notif.c           |  258 ---
 drivers/staging/wimax/i2400m/usb-rx.c              |  462 -----
 drivers/staging/wimax/i2400m/usb-tx.c              |  273 ---
 drivers/staging/wimax/i2400m/usb.c                 |  765 ---------
 drivers/staging/wimax/id-table.c                   |  130 --
 drivers/staging/wimax/linux-wimax-debug.h          |  491 ------
 drivers/staging/wimax/linux-wimax.h                |  239 ---
 drivers/staging/wimax/net-wimax.h                  |  503 ------
 drivers/staging/wimax/op-msg.c                     |  391 -----
 drivers/staging/wimax/op-reset.c                   |  108 --
 drivers/staging/wimax/op-rfkill.c                  |  431 -----
 drivers/staging/wimax/op-state-get.c               |   52 -
 drivers/staging/wimax/stack.c                      |  616 -------
 drivers/staging/wimax/wimax-internal.h             |   85 -
 drivers/staging/wlan-ng/p80211conv.h               |    3 -
 drivers/staging/wlan-ng/p80211netdev.c             |    2 +-
 include/linux/hid-sensor-hub.h                     |    9 +-
 include/linux/hid-sensor-ids.h                     |    1 +
 include/linux/iio/adc/adi-axi-adc.h                |    2 +-
 include/linux/iio/buffer-dmaengine.h               |    7 +-
 include/linux/iio/buffer.h                         |    4 +-
 include/linux/iio/buffer_impl.h                    |   21 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |    3 +-
 include/linux/iio/consumer.h                       |   15 +
 include/linux/iio/dac/mcp4725.h                    |    2 +-
 include/linux/iio/iio-opaque.h                     |   14 +
 include/linux/iio/iio.h                            |    7 +-
 include/linux/iio/imu/adis.h                       |   10 +
 include/linux/iio/kfifo_buf.h                      |   11 +-
 include/linux/iio/sysfs.h                          |    3 +
 include/linux/iio/trigger.h                        |    3 +-
 include/linux/iio/types.h                          |    2 +
 include/linux/interrupt.h                          |    4 +
 include/linux/platform_data/cros_ec_commands.h     |    1 +
 include/linux/platform_data/invensense_mpu6050.h   |    2 +-
 include/uapi/linux/iio/buffer.h                    |   10 +
 kernel/irq/manage.c                                |   11 +-
 tools/iio/Makefile                                 |    1 +
 tools/iio/iio_event_monitor.c                      |   69 +-
 tools/iio/iio_generic_buffer.c                     |  153 +-
 tools/iio/iio_utils.c                              |   18 +-
 tools/iio/iio_utils.h                              |    9 +-
 807 files changed, 12561 insertions(+), 40936 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 rename Documentation/ABI/testing/{sysfs-bus-iio-humidity-hdc2010 => sysfs-bus-iio-humidity} (79%)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
 create mode 100644 Documentation/devicetree/bindings/counter/interrupt-counter.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
 rename drivers/{staging => }/comedi/Kconfig (97%)
 rename drivers/{staging => }/comedi/Makefile (100%)
 rename drivers/{staging => }/comedi/TODO (100%)
 rename drivers/{staging => }/comedi/comedi.h (100%)
 rename drivers/{staging => }/comedi/comedi_buf.c (95%)
 rename drivers/{staging => }/comedi/comedi_fops.c (100%)
 rename drivers/{staging => }/comedi/comedi_internal.h (100%)
 rename drivers/{staging => }/comedi/comedi_pci.c (100%)
 rename drivers/{staging => }/comedi/comedi_pci.h (100%)
 rename drivers/{staging => }/comedi/comedi_pcmcia.c (100%)
 rename drivers/{staging => }/comedi/comedi_pcmcia.h (100%)
 rename drivers/{staging => }/comedi/comedi_usb.c (100%)
 rename drivers/{staging => }/comedi/comedi_usb.h (100%)
 rename drivers/{staging => }/comedi/comedidev.h (100%)
 rename drivers/{staging => }/comedi/comedilib.h (100%)
 rename drivers/{staging => }/comedi/drivers.c (100%)
 rename drivers/{staging => }/comedi/drivers/8255.c (100%)
 rename drivers/{staging => }/comedi/drivers/8255.h (100%)
 rename drivers/{staging => }/comedi/drivers/8255_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/Makefile (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_1032.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_1500.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_1516.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_1564.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_16xx.c (98%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_2032.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_2200.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_3120.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_3501.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_apci_3xxx.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_tcw.h (100%)
 rename drivers/{staging => }/comedi/drivers/addi_watchdog.c (100%)
 rename drivers/{staging => }/comedi/drivers/addi_watchdog.h (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci6208.c (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci7x3x.c (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci8164.c (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci9111.c (100%)
 rename drivers/{staging => }/comedi/drivers/adl_pci9118.c (100%)
 rename drivers/{staging => }/comedi/drivers/adq12b.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1710.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1720.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1723.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1724.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci1760.c (100%)
 rename drivers/{staging => }/comedi/drivers/adv_pci_dio.c (99%)
 rename drivers/{staging => }/comedi/drivers/aio_aio12_8.c (100%)
 rename drivers/{staging => }/comedi/drivers/aio_iiro_16.c (100%)
 rename drivers/{staging => }/comedi/drivers/amcc_s5933.h (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_dio200.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_dio200.h (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_dio200_common.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_dio200_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pc236.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pc236.h (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pc236_common.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pc263.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pci224.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pci230.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pci236.c (100%)
 rename drivers/{staging => }/comedi/drivers/amplc_pci263.c (100%)
 rename drivers/{staging => }/comedi/drivers/c6xdigio.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_das16_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_pcidas.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_pcidas64.c (99%)
 rename drivers/{staging => }/comedi/drivers/cb_pcidda.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_pcimdas.c (100%)
 rename drivers/{staging => }/comedi/drivers/cb_pcimdda.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_8254.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_8254.h (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_8255.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_bond.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_isadma.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_isadma.h (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_parport.c (100%)
 rename drivers/{staging => }/comedi/drivers/comedi_test.c (100%)
 rename drivers/{staging => }/comedi/drivers/contec_pci_dio.c (100%)
 rename drivers/{staging => }/comedi/drivers/dac02.c (100%)
 rename drivers/{staging => }/comedi/drivers/daqboard2000.c (100%)
 rename drivers/{staging => }/comedi/drivers/das08.c (100%)
 rename drivers/{staging => }/comedi/drivers/das08.h (100%)
 rename drivers/{staging => }/comedi/drivers/das08_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/das08_isa.c (100%)
 rename drivers/{staging => }/comedi/drivers/das08_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/das16.c (100%)
 rename drivers/{staging => }/comedi/drivers/das16m1.c (100%)
 rename drivers/{staging => }/comedi/drivers/das1800.c (100%)
 rename drivers/{staging => }/comedi/drivers/das6402.c (100%)
 rename drivers/{staging => }/comedi/drivers/das800.c (99%)
 rename drivers/{staging => }/comedi/drivers/dmm32at.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt2801.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt2811.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt2814.c (66%)
 rename drivers/{staging => }/comedi/drivers/dt2815.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt2817.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt282x.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt3000.c (100%)
 rename drivers/{staging => }/comedi/drivers/dt9812.c (100%)
 rename drivers/{staging => }/comedi/drivers/dyna_pci10xx.c (100%)
 rename drivers/{staging => }/comedi/drivers/fl512.c (100%)
 rename drivers/{staging => }/comedi/drivers/gsc_hpdi.c (100%)
 rename drivers/{staging => }/comedi/drivers/icp_multi.c (100%)
 rename drivers/{staging => }/comedi/drivers/ii_pci20kc.c (100%)
 rename drivers/{staging => }/comedi/drivers/jr3_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/jr3_pci.h (100%)
 rename drivers/{staging => }/comedi/drivers/ke_counter.c (100%)
 rename drivers/{staging => }/comedi/drivers/me4000.c (100%)
 rename drivers/{staging => }/comedi/drivers/me_daq.c (100%)
 rename drivers/{staging => }/comedi/drivers/mf6x4.c (100%)
 rename drivers/{staging => }/comedi/drivers/mite.c (100%)
 rename drivers/{staging => }/comedi/drivers/mite.h (100%)
 rename drivers/{staging => }/comedi/drivers/mpc624.c (100%)
 rename drivers/{staging => }/comedi/drivers/multiq3.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_6527.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_65xx.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_660x.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_670x.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_at_a2150.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_at_ao.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_atmio.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_atmio16d.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_daq_700.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_daq_dio24.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_common.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_isadma.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_isadma.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_pci.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_labpc_regs.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_mio_common.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_mio_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_pcidio.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_pcimio.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routes.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routes.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/README (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/all.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values/all.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values/ni_660x.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/.gitignore (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/Makefile (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/convert_c_to_py.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/convert_csv_to_c.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/convert_py_to_csv.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/csv_collection.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/make_blank_csv.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_routing/tools/ni_names.py (100%)
 rename drivers/{staging => }/comedi/drivers/ni_stc.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_tio.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_tio.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_tio_internal.h (100%)
 rename drivers/{staging => }/comedi/drivers/ni_tiocmd.c (100%)
 rename drivers/{staging => }/comedi/drivers/ni_usb6501.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl711.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl724.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl726.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl730.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl812.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl816.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcl818.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcm3724.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcmad.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcmda12.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcmmio.c (100%)
 rename drivers/{staging => }/comedi/drivers/pcmuio.c (100%)
 rename drivers/{staging => }/comedi/drivers/plx9052.h (100%)
 rename drivers/{staging => }/comedi/drivers/plx9080.h (100%)
 rename drivers/{staging => }/comedi/drivers/quatech_daqp_cs.c (100%)
 rename drivers/{staging => }/comedi/drivers/rtd520.c (100%)
 rename drivers/{staging => }/comedi/drivers/rti800.c (100%)
 rename drivers/{staging => }/comedi/drivers/rti802.c (100%)
 rename drivers/{staging => }/comedi/drivers/s526.c (100%)
 rename drivers/{staging => }/comedi/drivers/s626.c (100%)
 rename drivers/{staging => }/comedi/drivers/s626.h (100%)
 rename drivers/{staging => }/comedi/drivers/ssv_dnp.c (100%)
 rename drivers/{staging => }/comedi/drivers/tests/Makefile (57%)
 rename drivers/{staging/comedi/drivers/tests/example_test.c => comedi/drivers/tests/comedi_example_test.c} (91%)
 rename drivers/{staging => }/comedi/drivers/tests/ni_routes_test.c (88%)
 rename drivers/{staging => }/comedi/drivers/tests/unittest.h (98%)
 rename drivers/{staging => }/comedi/drivers/usbdux.c (100%)
 rename drivers/{staging => }/comedi/drivers/usbduxfast.c (100%)
 rename drivers/{staging => }/comedi/drivers/usbduxsigma.c (100%)
 rename drivers/{staging => }/comedi/drivers/vmk80xx.c (100%)
 rename drivers/{staging => }/comedi/drivers/z8536.h (100%)
 rename drivers/{staging => }/comedi/kcomedilib/Makefile (100%)
 rename drivers/{staging => }/comedi/kcomedilib/kcomedilib_main.c (100%)
 rename drivers/{staging => }/comedi/proc.c (100%)
 rename drivers/{staging => }/comedi/range.c (100%)
 create mode 100644 drivers/counter/interrupt-cnt.c
 create mode 100644 drivers/iio/accel/bmi088-accel-core.c
 create mode 100644 drivers/iio/accel/bmi088-accel-spi.c
 create mode 100644 drivers/iio/accel/bmi088-accel.h
 create mode 100644 drivers/iio/adc/ti-ads131e08.c
 create mode 100644 drivers/iio/cdc/Kconfig
 create mode 100644 drivers/iio/cdc/Makefile
 create mode 100644 drivers/iio/cdc/ad7150.c
 create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
 create mode 100644 drivers/iio/common/scmi_sensors/Makefile
 create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c
 create mode 100644 drivers/iio/proximity/cros_ec_mkbp_proximity.c
 create mode 100644 drivers/iio/test/Kconfig
 create mode 100644 drivers/iio/test/Makefile
 create mode 100644 drivers/iio/test/iio-test-format.c
 rename drivers/{staging/most/sound/sound.c => most/most_snd.c} (100%)
 rename drivers/{staging/hikey9xx => regulator}/hi6421v600-regulator.c (100%)
 delete mode 100644 drivers/staging/gasket/Kconfig
 delete mode 100644 drivers/staging/gasket/Makefile
 delete mode 100644 drivers/staging/gasket/TODO
 delete mode 100644 drivers/staging/gasket/apex.h
 delete mode 100644 drivers/staging/gasket/apex_driver.c
 delete mode 100644 drivers/staging/gasket/gasket.h
 delete mode 100644 drivers/staging/gasket/gasket_constants.h
 delete mode 100644 drivers/staging/gasket/gasket_core.c
 delete mode 100644 drivers/staging/gasket/gasket_core.h
 delete mode 100644 drivers/staging/gasket/gasket_interrupt.c
 delete mode 100644 drivers/staging/gasket/gasket_interrupt.h
 delete mode 100644 drivers/staging/gasket/gasket_ioctl.c
 delete mode 100644 drivers/staging/gasket/gasket_ioctl.h
 delete mode 100644 drivers/staging/gasket/gasket_page_table.c
 delete mode 100644 drivers/staging/gasket/gasket_page_table.h
 delete mode 100644 drivers/staging/gasket/gasket_sysfs.c
 delete mode 100644 drivers/staging/gasket/gasket_sysfs.h
 delete mode 100644 drivers/staging/iio/cdc/ad7150.c
 delete mode 100644 drivers/staging/most/sound/Kconfig
 delete mode 100644 drivers/staging/most/sound/Makefile
 delete mode 100644 drivers/staging/wimax/Documentation/i2400m.rst
 delete mode 100644 drivers/staging/wimax/Documentation/index.rst
 delete mode 100644 drivers/staging/wimax/Documentation/wimax.rst
 delete mode 100644 drivers/staging/wimax/Kconfig
 delete mode 100644 drivers/staging/wimax/Makefile
 delete mode 100644 drivers/staging/wimax/TODO
 delete mode 100644 drivers/staging/wimax/debug-levels.h
 delete mode 100644 drivers/staging/wimax/debugfs.c
 delete mode 100644 drivers/staging/wimax/i2400m/Kconfig
 delete mode 100644 drivers/staging/wimax/i2400m/Makefile
 delete mode 100644 drivers/staging/wimax/i2400m/control.c
 delete mode 100644 drivers/staging/wimax/i2400m/debug-levels.h
 delete mode 100644 drivers/staging/wimax/i2400m/debugfs.c
 delete mode 100644 drivers/staging/wimax/i2400m/driver.c
 delete mode 100644 drivers/staging/wimax/i2400m/fw.c
 delete mode 100644 drivers/staging/wimax/i2400m/i2400m-usb.h
 delete mode 100644 drivers/staging/wimax/i2400m/i2400m.h
 delete mode 100644 drivers/staging/wimax/i2400m/linux-wimax-i2400m.h
 delete mode 100644 drivers/staging/wimax/i2400m/netdev.c
 delete mode 100644 drivers/staging/wimax/i2400m/op-rfkill.c
 delete mode 100644 drivers/staging/wimax/i2400m/rx.c
 delete mode 100644 drivers/staging/wimax/i2400m/sysfs.c
 delete mode 100644 drivers/staging/wimax/i2400m/tx.c
 delete mode 100644 drivers/staging/wimax/i2400m/usb-debug-levels.h
 delete mode 100644 drivers/staging/wimax/i2400m/usb-fw.c
 delete mode 100644 drivers/staging/wimax/i2400m/usb-notif.c
 delete mode 100644 drivers/staging/wimax/i2400m/usb-rx.c
 delete mode 100644 drivers/staging/wimax/i2400m/usb-tx.c
 delete mode 100644 drivers/staging/wimax/i2400m/usb.c
 delete mode 100644 drivers/staging/wimax/id-table.c
 delete mode 100644 drivers/staging/wimax/linux-wimax-debug.h
 delete mode 100644 drivers/staging/wimax/linux-wimax.h
 delete mode 100644 drivers/staging/wimax/net-wimax.h
 delete mode 100644 drivers/staging/wimax/op-msg.c
 delete mode 100644 drivers/staging/wimax/op-reset.c
 delete mode 100644 drivers/staging/wimax/op-rfkill.c
 delete mode 100644 drivers/staging/wimax/op-state-get.c
 delete mode 100644 drivers/staging/wimax/stack.c
 delete mode 100644 drivers/staging/wimax/wimax-internal.h
 create mode 100644 include/uapi/linux/iio/buffer.h
