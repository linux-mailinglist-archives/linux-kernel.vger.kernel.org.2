Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68293BC220
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGERPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhGERPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:15:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC16361935;
        Mon,  5 Jul 2021 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625505156;
        bh=QUHddoUcd4GqaeJQPuR/BHvLxwWPkwKjF0dDTIH2PCI=;
        h=Date:From:To:Cc:Subject:From;
        b=OD9HRUqG1AMzBIz78KZr7n02KVeSNP47d2qzr6j0TJgKClhqEfqvoUMEo9flYaRKg
         3N/EGvA95uBeC/5CWyC7GnNsl1ZR2auzsiZ/d1gW0igbOw0x2kyH3fzVAFrBoFVSdz
         jpJ3O3DMUM0biPkb7aD/ao3Dj3fakfN8wc5k5SYg=
Date:   Mon, 5 Jul 2021 19:12:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging / IIO driver updates for 5.14-rc1
Message-ID: <YOM9gpIGlLDdeiBf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.14-rc1

for you to fetch changes up to 77ad1f0e99bd00af024e650b862cfda3137af660:

  staging: hi6421-spmi-pmic: cleanup some macros (2021-06-25 10:02:57 +0200)

----------------------------------------------------------------
Staging / IIO driver patches for 5.14-rc1

Here is the big set of IIO and staging driver patches for 5.14-rc1.

Loads of IIO driver updates and additions in here, the shortlog has the
full details.

For the staging side, we moved a few drivers out of staging, and deleted
the kpc2000 drivers as the original developer asked us to because no one
was working on them anymore.

Also in here are loads of coding style cleanups due to different intern
projects focusing on the staging tree to try to get experience doing
kernel development.

All of these have been in the linux-next tree for a while with no
reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Vorwerk (1):
      staging: rtl8712: remove multiple multiple assignments

Alexandru Ardelean (9):
      iio: adc: ad_sigma_delta: introduct devm_ad_sd_setup_buffer_and_trigger()
      iio: adc: ad7793: convert to device-managed functions
      iio: adc: ad7791: convert to device-managed functions
      iio: adc: ad7780: convert to device-managed functions
      iio: adc: ad7192: use devm_clk_get_optional() for mclk
      iio: adc: ad7192: convert to device-managed functions
      iio: adc: ad_sigma_delta: remove ad_sd_{setup,cleanup}_buffer_and_trigger()
      iio: imu: remove unused private data assigned with spi_set_drvdata()
      iio: adc: remove unused private data assigned with spi_set_drvdata()

Amos Gross (1):
      Staging: rtl8188eu: rtw_ioctl_set.c: fixed indentation issue

Andy Shevchenko (15):
      staging: fbtft: Rectify GPIO handling
      staging: fbtft: Don't spam logs when probe is deferred
      staging: fbtft: Add support for orientation on Himax HX8347d
      staging: fbtft: Replace custom ->reset() with generic one
      staging: fbtft: Update TODO
      iio: adc: ad7298: Enable on Intel Galileo Gen 1
      iio: accel: st_accel: Move platform data from header to C file
      iio: gyro: st_gyro: Move platform data from header to C file
      iio: magnetometer: st_magn: Provide default platform data
      iio: st_sensors: Call st_sensors_power_enable() from bus drivers
      iio: st_sensors: Make accel, gyro, magn and pressure probe shared
      iio: st_sensors: Add lsm9ds0 IMU support
      dt-bindings: iio: st,st-sensors: Add LSM9DS0 compatible string
      iio: Drop Duplicated "mount-matrix" parameter
      iio: hid-sensors: lighten exported symbols by moving to IIO_HID namespace

Arnd Bergmann (1):
      iio: si1133: fix format string warnings

Ashish Kalra (1):
      staging: wlan-ng: silence incorrect type in argument 1 (different address spaces)

Ashish Vara (1):
      staging: qlge: removed unnecessary debug message to fix coding style warning

Bixuan Cui (1):
      staging: comedi: Remove unused variable ‘min_full_scale’ and function 'get_min_full_scales'

Bryan Brattlof (11):
      staging: rtl8723bs: remove unused argument 'msg'
      staging: rtl8723bs: remove duplicate names for _rtw_read8()
      staging: rtl8723bs: remove duplicate names for _rtw_read16()
      staging: rtl8723bs: remove duplicate names for _rtw_read32()
      staging: rtl8723bs: remove duplicate names for _rtw_write8()
      staging: rtl8723bs: remove duplicate names for _rtw_write16()
      staging: rtl8723bs: remove duplicate names for _rtw_write32()
      staging: rtl8723bs: remove duplicate name for _rtw_write_port()
      staging: rtl8723bs: remove _rtw_sd_f0_read8()
      staging: rtl8723bs: remove if (true) statement
      staging: rtl8723bs: remove sd_f0_read8()

Caleb D.S. Brzezinski (1):
      staging: ks7010: Wrap macro definitions in parenthesis

Christophe JAILLET (5):
      staging: rtl8712: Fix some tests against some 'data' subtype frames
      staging: rtl8188eu: remove enum WIFI_FRAME_SUBTYPE
      staging: rtl8723bs: Fix an error handling path
      staging: rtl8188eu: remove "rtw_ieee80211_back_actioncode"
      staging: rtl8188eu: remove "rtw_ieee80211_back_parties"

Chunyan Zhang (1):
      iio: adc: Add missing MODULE_DEVICE_TABLE

Cláudio Maia (1):
      staging: rtl8192u: Fix variable shadowing warning

Colin Ian King (4):
      staging: wlan-ng: remove redundant initialization of variable txresult
      staging: unisys: visorinput: remove redundant assignment of variable led
      staging: gdm724x: emove redundant initialization of variable hci_len
      staging: rts5208: remove redundant continue statement

Dan Carpenter (15):
      iio: core: Fix an error pointer vs NULL bug in devm_iio_device_alloc()
      iio: light: tsl2591: fix some signedness bugs
      iio: light: tsl2591: delete a stray tab
      staging: rtl8712: fix the bssid in mp_start_test()
      staging: emxx_udc: fix loop in _nbu2ss_nuke()
      iio: adc: tsc2046: fix a warning message in tsc2046_adc_update_scan_mode()
      staging: rtl8188eu: use safe iterator in stop_ap_mode()
      staging: rtl8188eu: use safe iterator in tx_beacon_hdl()
      staging: rtl8188eu: use safe iterator in dequeue_xmitframes_to_sleeping_queue()
      staging: rtl8188eu: use safe iterator in wakeup_sta_to_xmit()
      staging: rtl8188eu: use safe iterator in xmit_delivery_enabled_frames()
      staging: rtl8188eu: use safe iterator in rtl8188eu_xmitframe_complete()
      staging: rtl8188eu: delete some dead code
      staging: gdm724x: check for buffer overflow in gdm_lte_multi_sdu_pkt()
      staging: gdm724x: check for overflow in gdm_lte_netif_rx()

Dave Stevenson (1):
      staging: mmal-vchiq: Fix incorrect static vchiq_instance.

Desmond Cheong Zhi Xi (7):
      Staging: rtl8723bs: remove unnecessary braces in HalBtc8723b1Ant.c
      Staging: rtl8723bs: fix spaces in HalBtc8723b1Ant.c
      Staging: rtl8723bs: fix indentation in HalBtc8723b1Ant.c
      Staging: rtl8723bs: fix comparison formatting in HalBtc8723b1Ant.c
      Staging: rtl8723bs: add missing blank line in HalBtc8723b1Ant.c
      Staging: rtl8723bs: fix line continuations in HalBtc8723b1Ant.c
      Staging: rtl8723bs: remove dead code in HalBtc8723b1Ant.c

Donggyu Kim (1):
      Staging: rtl8723bs: fixed a blank coding style

F.A.Sulaiman (1):
      Staging: greybus: fix open parenthesis error in gbphy.c

Fabio Aiuto (132):
      staging: rtl8723bs: remove unused log function
      staging: rtl8723bs: replace DBG_871X_SEL log macro with netdev_dbg()
      staging: rtl8723bs: add two functions to improve register dump in core/rtw_debug.c
      staging: rtl8723bs: remove DBG_871X_SEL macro declaration
      staging: rtl8723bs: remove unused _DBG_871X_LEVEL macro
      staging: rtl8723bs: remove unused mac_reg_dump() function argument
      staging: rtl8723bs: remove unused bb_reg_dump() function argument
      staging: rtl8723bs: remove unused rf_reg_dump() function argument
      staging: rtl8723bs: remove unused RTW_DBGDUMP macro definition
      staging: rtl8723bs: remove all defs related to _dbgdump macro
      staging: rtl8723bs: remove unused debug variables declarations and initialization
      staging: rtl8723bs: remove unneeded header file include
      staging: rtl8723bs: remove unused debug macro definitions
      staging: rtl8723bs: remove debug macros related to core/rtw_xmit.c tracing
      staging: rtl8723bs: remove debug macros related to os_dep/xmit_linux.c tracing
      staging: rtl8723bs: remove debug macros related to core/rtw_recv.c tracing
      staging: rtl8723bs: remove debug macros related to os_dep/recv_linux.c tracing
      staging: rtl8723bs: remove debug macros related to core/rtw_mlme.c tracing
      staging: rtl8723bs: remove debug macros related to os_dep/mlme_linux.c tracing
      staging: rtl8723bs: move static array definition from header to .c file
      staging: rtl8723bs: remove debug macros related to core/rtw_mlme_ext.c tracing
      staging: rtl8723bs: remove debug macros related to core/rtw_sta_mgt.c tracing
      staging: rtl8723bs: remove debug macros related to core/rtw_cmd.c tracing
      staging: rtl8723bs: remove obsolete debug macro definitions
      staging: rtl8723bs: remove debug macros related to core/rtw_io.c tracing
      staging: rtl8723bs: remove obsolete _IO_OSDEP_C_ debug macro definition
      staging: rtl8723bs: remove debug macros related to os_dep/os_intfs.c tracing
      staging: rtl8723bs: remove debug macros related to core/rtw_security.c tracing
      staging: rtl8723bs: remove debug macros related to core/rtw_eeprom.c tracing
      staging: rtl8723bs: remove debug macros related to hal/hal_intf.c tracing
      staging: rtl8723bs: remove debug macros related to hal/sdio_halinit.c tracing
      staging: rtl8723bs: remove unused debug macros tied to _RTL871X_IOCTL_C_ definition
      staging: rtl8723bs: remove unused debug macros tied to _RTL871X_IOCTL_SET_C_ definition
      staging: rtl8723bs: remove unused debug macros tied to _RTL871X_IOCTL_QUERY_C_ definition
      staging: rtl8723bs: remove unused debug macros tied to _RTL871X_PWRCTRL_C_ definition
      staging: rtl8723bs: remove unused macros tied to core/rtw_pwrctrl.c debug
      staging: rtl8723bs: remove unused macros tied to os_dep/sdio_intf.c debug
      staging: rtl8723bs: remove unused debug macros tied to _HCI_OPS_C_ definition
      staging: rtl8723bs: remove unused debug macros tied to hal/sdio_ops.c debug
      staging: rtl8723bs: remove unused debug macros tied to os_dep/osdep_service.c debug
      staging: rtl8723bs: remove unused _module_mp_ def
      staging: rtl8723bs: remove unused macros tied to _HCI_OPS_OS_C_ definition
      staging: rtl8723bs: remove unused macros tied to _RTL871X_IOCTL_LINUX_C definition
      staging: rtl8723bs: remove unused macros tied to _RTL8712_CMD_C_ definition
      staging: rtl8723bs: remove commented out macro definition
      staging: rtl8723bs: remove unused debug macro definitions
      staging: rtl8723bs: remove unused macros tied to core/rtw_efuse.c debug
      staging: rtl8723bs: remove unsed debug macros tied to no particular code debug
      staging: rtl8723bs: remove last unused debug macros
      staging: rtl8723bs: macro DRIVER_PREFIX expands to lowercase driver name
      staging: rtl8723bs: remove unnecessary hex dumps
      staging: rtl8723bs: remove unused macro DRIVER_PREFIX
      staging: rtl8723bs: remove ODM_RT_TRACE logs
      staging: rtl8723bs: remove if-else blocks left empty by ODM_RT_TRACE deletion
      staging: rtl8723bs: remove empty functions
      staging: rtl8723bs: remove empty hal/odm_PathDiv.c source file
      staging: rtl8723bs: remove undefined function prototypes
      staging: rtl8723bs: remove empty header file
      staging: rtl8723bs: remove ODM_RT_TRACE* unused macro defs
      staging: rtl8723bs: remove all commented out ODM_RT_TRACE logs
      staging: rtl8723bs: replace ODM_RT_ASSERT with netdev_dbg()
      staging: rtl8723bs: remove unused ODM_RT_ASSERT macro
      staging: rtl8723bs: remove unused ODM_PRINT_ADDR macro
      staging: rtl8723bs: remove unused ODM_dbg_trace macro
      staging: rtl8723bs: remove unused ODM_dbg_enter
      staging: rtl8723bs: remove unused ODM_dbg_exit macro
      staging: rtl8723bs: remove empty ifdef block
      staging: rtl8723bs: remove unused ASSERT macro
      staging: rtl8723bs: remove empty #ifndef block
      staging: rtl8723bs: remove commented out RT_ASSERT occurrences
      staging: rtl8723bs: remove unused RT_PRINTK macro
      staging: rtl8723bs: remove BTC_PRINT logs
      staging: rtl8723bs: remove empty if-else blocks after BTC_PRINT removal
      staging: rtl8723bs: remove braces around single statement in if block
      staging: rtl8723bs: remove commented out BTC_PRINT logs
      staging: rtl8723bs: remove BTC_PRINT macro definitions
      staging: rtl8723bs: remove BTC_PRINT_ADDR macro definitions
      staging: rtl8723bs: remove BTC_PRINT_DATA definitions
      staging: rtl8723bs: remove BTC_PRINT_F macro definition
      staging: rtl8723bs: remove empty #ifdef block
      staging: rtl8723bs: remove unsed hal_btcoex_SetDBG() function
      staging: rtl8723bs: remove hal_btcoex_GetDBG() function
      staging: rtl8723bs: remove unnecessary halbtcoutsrc_DbgInit() function
      staging: rtl8723bs: remove obsolete GLBtcDbgType array declarations
      staging: rtl8723bs: remove unused enum
      staging: rtl8723bs: remove obsolete debug macros
      staging: rtl8723bs: remove commented out DbgPrint logs
      staging: rtl8723bs: remove unused DbgPrint macro
      staging: rtl8723bs: remove commented out *RT_DISP logs
      staging: rtl8723bs: remove RT_DISP macro definition
      staging: rtl8723bs: remove ODM_InitDebugSetting() function
      staging: rtl8723bs: remove empty hal/odm_debug.c file
      staging: rtl8723bs: remove member in dm_odm_t struct
      staging: rtl8723bs: remove DebugLevel member in dm_odm_t struct
      staging: rtl8723bs: remove odm_debug.h header file
      staging: rtl8723bs: align argument position in a new line
      staging: rtl8723bs: use in-kernel aes encryption in OMAC1 routines
      staging: rtl8723bs: use in-kernel aes encryption
      staging: rtl8723bs: remove unused macros, arrays and an inline function def
      staging: rtl8723bs: remove more unused encryption macros
      staging: rtl8723bs: remove unused symbolic constant _AES_IV_LEN_
      staging: rtl8723bs: replace private arc4 encryption with in-kernel one
      staging: rtl8723bs: replace private CRC-32 routines with in-kernel ones
      staging: rtl8723bs: remove unneeded comments to silence 'line too long' warning
      staging: rtl8723bs: moved contexts for arc4 encryption in struct security_priv
      staging: rtl8723bs: use list_for_each_safe in loops deleting iterated items
      staging: rtl8723bs: remove unused debug macro
      staging: rtl8723bs: remove unneeded comments
      staging: rtl8723bs: remove unused WAKEUP_GPIO_IDX macro definition
      staging: rtl8723bs: remove unneeded DISABLE_BB_RF macro
      staging: rtl8723bs: remove HAL_{BB,MAC,RF,FW}_ENABLE macros
      staging: rtl8723bs: move LPS_RPWM_WAIT_MS macro
      staging: rtl8723bs: remove include/autoconf.h header file from tree
      staging: rtl8723bs: remove two unused files from tree
      staging: rtl8723bs: remove all 5Ghz network types
      staging: rtl8723bs: remove code related to unsupported channel bandwidth
      staging: rtl8723bs: remove unused enum items related to channel bonding
      staging: rtl8723bs: rename enum items related to channel bonding
      staging: rtl8723bs: remove 5Ghz field in struct registry_priv
      staging: rtl8723bs: remove struct rt_channel_plan_5g
      staging: rtl8723bs: remove all branchings between 2.4Ghz and 5Ghz band types
      staging: rtl8723bs: beautify prototypes in include/hal_com_phycfg.h
      staging: rtl8723bs: remove 5Ghz code related to channel plan definition
      staging: rtl8723bs: remove some unused 5Ghz macro definitions
      staging: rtl8723bs: remove 5Ghz code related to RF power calibration
      staging: rtl8723bs: remove VHT dead code
      staging: rtl8723bs: remove unused ODM_CMNINFO_BOARD_TYPE enum item
      staging: rtl8723bs: fix macro value for 2.4Ghz only device
      staging: rtl8723bs: remove obsolete 5Ghz comments
      staging: rtl8723bs: fix check allowing 5Ghz settings
      staging: rtl8723bs: remove item from TODO list
      staging: rtl8723bs: convert function to static

Fabio M. De Francesco (13):
      staging: rtl8723bs: hal: Remove set but unused variables
      staging: rtl8723bs: core: Remove set but unused variable
      staging: rtl8723bs: hal: Remove set but unused variable
      staging: rtl8723bs: core: Remove unnecessary lines of code
      staging: rtl8723bs: hal: Remove three set but unused variables
      staging: rtl8723bs: hal: Remove set but unused variable
      staging: rtl8723bs: hal: Remove set but unused variables
      staging: rtl8723bs: core: rtw_mlme_ext.c: Remove set but unused variable
      staging: rtl8712: Remove unnecessary alias of printk()
      staging: rtl8723bs: hal: Delete tests with no effects
      staging: rtl8723bs: os_dep: Remove conditions with no effects
      staging: rtl8712: Replace printk() with netdev_dbg()
      staging: unisys: visorhba: Convert module from IDR to XArray

Greg Kroah-Hartman (9):
      Merge 5.13-rc2 into staging-next
      staging: rtl8723bs: HalBtc8723b1Ant.c: fix build warnings about unused variables
      staging: rtl8723bs: rtl8723b_hal_init.c: fix build warnings about unused variables
      staging: rtl8723bs: rename get_ra() due to global symbol collision
      Merge 5.13-rc4 into staging-next
      Merge tag 'iio-for-5.14a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
      staging: drop kpc2000 driver
      Merge tag 'v5.13-rc6' into staging-next
      Merge tag 'iio-for-5.14b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next

Guenter Roeck (8):
      staging: rtl8188eu: Use list iterators and helpers
      staging: rtl8712: Use list iterators and helpers
      staging: rtl8723bs: Use list iterators and helpers
      iio: am2315: Remove acpi_device_id table
      iio:accel:stk8312: Remove acpi_device_id table
      iio: bme680_spi: Remove acpi_device_id table
      iio: bme680_i2c: Remove acpi_device_id table
      staging: rtl8188eu: Drop unnecessary NULL check after container_of

Gustavo A. R. Silva (1):
      staging: rtl8188eu: Fix fall-through warnings for Clang

Hans de Goede (9):
      iio: accel: bmc150: Fix dereferencing the wrong pointer in bmc150_get/set_second_device
      iio: accel: bmc150: Don't make the remove function of the second accelerometer unregister itself
      iio: accel: bmc150: Move check for second ACPI device into a separate function
      iio: accel: bmc150: Add support for dual-accelerometers with a DUAL250E HID
      iio: accel: bmc150: Move struct bmc150_accel_data definition to bmc150-accel.h
      iio: accel: bmc150: Remove bmc150_set/get_second_device() accessor functions
      iio: accel: bmc150: Add support for DUAL250E ACPI DSM for setting the hinge angle
      iio: accel: bmc150: Refactor bmc150_apply_acpi_orientation()
      iio: accel: bmc150: Set label based on accel-location for ACPI DUAL250E fwnodes

Harold Mertzweiller (1):
      staging: emxx_udc: fix alignment issues

Hriday Hegde (1):
      staging: rtl8712: Removed unnecessary blank lines

Iain Craig (1):
      staging: rtl8192u: fix typos in comments

Jarkko Nikula (3):
      counter: Add support for Intel Quadrature Encoder Peripheral
      counter: intel-qep: Mark PM callbacks with __maybe_unused
      counter: intel-qep: Use to_pci_dev() helper

Jiabing Wan (1):
      staging: vc04_services: fix a whitespace coding style issue

Jiapeng Chong (1):
      iio: buffer: Remove redundant assignment to in_loc

Joe Sandom (2):
      iio: light: Added AMS tsl2591 driver implementation
      dt-bindings: iio: light: Added AMS tsl2591 device tree binding

Jonathan Cameron (107):
      dt-bindings:iio:accel:adis16201 and adis16209 bindings
      dt-bindings:iio:accel:bosch,bma220 device tree binding documentation
      dt-bindings:iio:accel:fsl,mma7455 binding doc
      dt-bindings:trivial-devices: Add memsic,mxc4005/mxc6255/mxc6655 entries
      dt-bindings:trivial-devices: Add sensortek,stk8312 and sensortek,s8ba50
      dt-bindings:iio:adc:adi,ad7298 document bindings
      iio:accel:stk8312: Add lowercase i2c device id
      dt-bindings:iio:dac:ti,dac082s085 yaml conversion
      iio:adc:ad7476: Handle the different regulators used by various parts.
      dt-bindings:iio:adc:adi,ad7476: Add missing binding document
      iio:ABI docs: Fix up duplicate *_calibbias_* documentation for icm42600
      iio:ABI docs: Drop device specific docs for _powerdown for the adf4371
      iio:ABI docs: Fix issue around repeated definition of out_currentY_raw
      iio:ABI docs: Move specific description of out_altvoltageX_frequency to main docs.
      iio: adc: stm32-adc: Fix docs wrongly marked as kernel-doc
      iio: accel: bmi088: Drop manual assignment of iio_dev.dev.parent
      iio: dac: ad5766: Drop duplicate setting of iio_dev.dev.parent and of_node
      iio: adc: mp2629: Drop duplicate setting iio_dev.dev.parent
      iio: adc: mt6360: Drop duplicate setting of iio_dev.dev.parent
      iio: adc: ti-ads131e08: Drop duplicate setting of iio_dev.dev.parent
      iio: humidity: hdc2010: Drop duplicate setting of iio_dev.dev.parent
      iio: position: hid-sensor-custom-intel-hinge: Drop duplicate parent setting.
      iio: common: scmi_sensors: Drop duplicate setting of iio_dev.dev.parent
      iio: core: move @id from struct iio_dev to struct iio_dev_opaque
      iio: avoid shadowing of variable name in to_iio_dev_opaque()
      iio: core: move @driver_module from struct iio_dev to struct iio_dev_opaque
      iio: core: move @trig_readonly from struct iio_dev to struct iio_dev_opaque
      iio: core: move @scan_index_timestamp to struct iio_dev_opaque
      iio: core: move @info_exist_lock to struct iio_dev_opaque
      iio: core: move @chrdev from struct iio_dev to struct iio_dev_opaque
      iio: core: move @flags from struct iio_dev to struct iio_dev_opaque
      iio: core: move @clock_id from struct iio_dev to struct iio_dev_opaque
      dt-bindings:iio:dac:ad5755: txt to yaml format conversion.
      iio: gyro: fxa21002c: Balance runtime pm + use pm_runtime_resume_and_get().
      iio: light: isl29028: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: light: tsl2583: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: accel: bmc150-accel: Balanced runtime pm + use pm_runtime_resume_and_get()
      iio: accel: mma9551/3: Balance untime pm + use pm_runtime_resume_and_get()
      iio: accel: kxcjk-1013: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: imu: kmx61: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: adc: stm32-adc: Use pm_runtime_resume_and_get() to replace open coding.
      iio: adc: stm32-dfsdm: Use pm_runtime_resume_and_get() to replace open coding.
      iio: dac: stm32-dac: Use pm_runtime_resume_and_get() to replace open coding.
      iio: light: us5182: Use pm_runtime_resume_and_get() to replace open coding.
      iio: temp: mlx90614: Handle failure in pm_runtime_resume_and_get()
      iio: adc: rcar-gyroadc: Use pm_runtime_resume_and_get() and check in probe()
      iio: proximity: srf04: Use pm_runtime_resume_and_get() and handle error
      iio: light: vcnl4000: Use pm_runtime_resume_and_get() to replace open coding.
      iio: light: vcnl4035: Use pm_runtime_resume_and_get() to replace open coding.
      iio: accel: bmi088: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: magn: bmc150: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: light: rpr0521: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: accel: mma8452: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: accel: bma180: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: bma220: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: hid: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: kxcjk-1013: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: mxc4005: Fix overread of data and alignment issue.
      iio: accel: stk8312: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: accel: stk8ba50: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: ti-ads1015: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: vf610: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: gyro: bmg160: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: humidity: am2315: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: srf08: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: pulsed-light: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: as3935: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: magn: hmc5843: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: magn: bmc150: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: isl29125: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: tcs3414: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: tcs3472: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: chemical: atlas: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: cros_ec_sensors: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: potentiostat: lmp91000: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: light: pa12203001: Use pm_runtime_resume_and_get() to replace open coding.
      iio: hid: trigger: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: chemical: sgp30: Drop use of %hx in format string.
      iio: adc: max11100: Use get_unaligned_be16() rather than opencoding.
      iio: adc: max11100: Use devm_ functions for rest of probe()
      iio: adc: max1118: Use devm_ managed functions for all of probe
      iio: adc: max1118: Avoid jumping back and forth between spi and iio structures
      iio: adc: ti-adc081c: Use devm managed functions for all of probe()
      iio: adc: ti-adc0832: Use devm managed functions for all of probe()
      iio: adc: ti-adc108s102: Use devm managed functions for all of probe()
      iio: adc: ti-adc161s626: Use devm managed functions for all of probe.
      iio: adis: Cleanout unused headers
      i2c: core: Add stub for i2c_verify_client() if !CONFIG_I2C
      Merge branch 'ib-iio-i2c-5.13rc1' into togreg Adds a stub needed to resolve a build conflict for the fxls8962af driver.
      iio: light: si1133: Drop remaining uses of %hhx format string.
      iio: imu: inv_mpu6050: Drop use of %hhx format string.
      iio: light: si1145: Drop use of %hhx format specifier.
      iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop remove()
      iio: adc: at91-sama5d2: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: hx711: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: mxs-lradc: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: ti-ads8688: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: magn: rm3100: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: light: vcnl4000: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: vcnl4035: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: isl29501: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: imu: mpu6050: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: adc: ads1015: Balance runtime pm + pm_runtime_resume_and_get()
      iio: chemical: atlas-sensor: Balance runtime pm + pm_runtime_resume_and_get()
      iio: prox: pulsed-light-v2: Use pm_runtime_resume_and_get()
      iio: pressure: icp10100: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: hid-sensors: Update header includes

Khoa Tran Minh (1):
      Staging: rtl8712: Cleanup coding style warning

Krzysztof Kozlowski (2):
      iio: adc: exynos: drop unneeded variable assignment
      dt-bindings: iio: afe: current-sense-shunt: add io-channel-cells

Lee Jones (44):
      staging: r8192U_core: Remove unused variable 'ret' and demote kernel-doc abuse
      staging: android: ashmem: Supply description for 'new_range'
      staging: r8192U_core: Do not use kernel-doc formatting for !kernel-doc headers
      staging: r819xU_phy: Remove some local variables from the stack
      staging: r819xU_cmdpkt: Remove functionless method 'cmpk_handle_query_config_rx'
      staging: wlan-ng: cfg80211: Move large struct onto the heap
      staging: rtl8188eu: core: rtw_ieee80211: Fix incorrectly documented function
      staging: rtl8723bs: core: rtw_mlme: Remove a bunch of unused variables
      staging: rtl8712: rtl871x_mp_ioctl: Remove a bunch of unused tables
      staging: rtl8723bs: core: rtw_recv: Mark debug variable as __maybe_unused
      staging: rtl8188eu: core: rtw_security: Fix some formatting and misdocumentation
      staging: rtl8723bs: core: rtw_security: Demote non-conformant kernel-doc header
      staging: rtl8723bs: core: rtw_sta_mgt: Remove unused variable 'psta'
      staging: rtl8723bs: core: rtw_sta_mgt: Return error value directly
      staging: octeon: ethernet-tx: Fix formatting issue in function header
      staging: rtl8723bs: core: rtw_wlan_util: Remove unused variable 'start_seq'
      staging: rtl8712: rtl871x_mp_ioctl: Move a large data struct onto the heap
      staging: iio: frequency: ad9834: Provide missing description for 'devid'
      staging: nvec: Fix a bunch of kernel-doc issues
      staging: ks7010: ks_hostif: Remove a bunch of unused variables
      staging: fwserial: Demote a whole host of kernel-doc abuses
      staging: sm750fb: sm750_accel: Provide description for 'accel' and fix function naming
      staging: most: net: Fix some kernel-doc formatting issues
      staging: vt6655: upc: Suppress set but not used warning in macro
      staging: rtl8192u: ieee80211_softmac: Move a large data struct onto the heap
      staging: most: dim2: Provide missing descriptions and fix doc-rot
      staging: rtl8723bs: core: rtw_ieee80211: Remove seemingly pointless copy
      staging: rtl8723bs: core: rtw_mlme: 'retry' is only used if REJOIN is set
      staging: most: i2c: Fix a little doc-rot
      staging: most: dim2: hal: Fix one kernel-doc header and demote two non-conforming ones
      staging: most: dim2: hal: Demote non-conformant kernel-doc headers
      staging: axis-fifo: axis-fifo: Fix some formatting issues
      staging: rtl8188eu: os_dep: ioctl_linux: Move 2 large data buffers into the heap
      staging: fbtft: fb_ili9320: Remove unused variable 'ret'
      staging: rtl8723bs: core: rtw_ieee80211: Fix incorrectly named function
      staging: rtl8723bs: hal: odm_NoiseMonitor: Remove unused variable and dead code
      staging: rtl8188eu: os_dep: mon: Demote non-conforming kernel-doc headers
      staging: rtl8723bs: hal: rtl8723b_phycfg: Fix a bunch of misnamed functions
      staging: rtl8723bs: hal: sdio_ops: Mark used 'err' as __maybe_unused and remove another
      staging: rtl8723bs: os_dep: ioctl_cfg80211: 'ack' is used when debug is enabled
      staging: axis-fifo: axis-fifo: Fix function naming in the documentation
      staging: rtl8723bs: hal: odm_NoiseMonitor: Remove unused variable 'func_start'
      staging: rtl8723bs: core: rtw_mlme_ext: Move very large data buffer onto the heap
      staging: rtl8723bs: hal: sdio_halinit: Remove unused variable 'ret'

Linus Walleij (7):
      iio: st-sensors: Update ST Sensor bindings
      iio: afe: iio-rescale: Support processed channels
      iio: st_sensors: Create extended attr macro
      iio: accel: st_sensors: Support generic mounting matrix
      iio: accel: st_sensors: Stop copying channels
      iio: magnetometer: st_magn: Support mount matrix
      iio: gyro: st_gyro: Support mount matrix

Liu Shixin (2):
      staging: rtl8188eu: Use is_{zero/broadcast}_ether_addr() instead of memcmp()
      staging: rtl8188eu: Use eth_broadcast_addr() to assign broadcast address

Lucas Stankus (5):
      dt-bindings: staging: iio: cdc: ad7746: add binding documentation for AD7746
      staging: iio: cdc: ad7746: use dt for capacitive channel setup.
      staging: iio: cdc: ad7746: remove ordinary comments
      staging: iio: cdc: ad7746: clean up probe return
      staging: iio: cdc: ad7746: extract capac setup to own function

Manikishan Ghantasala (3):
      staging: rtl8192u: r8192U_hw.h: fix spaces preferred around that '|' code style error
      staging: rtl8192u: put parentheses on macros with complex values in r8192U_hw.h
      staging: rtl8192u: fix spaces in r8192U_hw.h

Marc Kleine-Budde (2):
      iio: ltr501: mark register holding upper 8 bits of ALS_DATA{0,1} and PS_DATA as volatile, too
      iio: ltr501: mark ltr501_chip_info as const

Martin Kaiser (42):
      staging: rtl8188eu: make rtw_android_cmdstr_to_num static
      staging: rtl8188eu: rtw_init_cmd_priv never fails
      staging: rtl8188eu: don't block until cmdthread runs
      staging: rtl8188eu: remove padapter from struct cmd_priv
      staging: rtl8188eu: remove padapter from struct mlme_ext_priv
      staging: rtl8188eu: remove nic_hdl from struct mlme_priv
      staging: rtl8188eu: use safe iterator in rtw_free_network_queue
      staging: rtl8188eu: use safe iterator in rtw_free_all_stainfo
      staging: rtl8188eu: use safe iterator in expire_timeout_chk
      staging: rtl8188eu: use safe iterator in rtw_acl_remove_sta
      staging: rtl8188eu: use safe iterator in rtw_sta_flush
      staging: rtl8188eu: use safe iterator in rtw_free_xmitframe_queue
      staging: rtl8188eu: use IW_HANDLER to declare wext handlers
      staging: rtl8188eu: remove dummy wext handlers
      staging: rtl8188eu: remove dummy setfreq handler
      staging: rtl8188eu: remove unused RT_PRINT_DATA macro
      staging: rtl8188eu: remove RT_TRACE and DBG_88E prints from rtw_cmd.c
      staging: rtl8188eu: refactor rtw_lps_ctrl_wk_cmd
      staging: rtl8188eu: make rtw_free_recvframe return void
      staging: rtl8188eu: simplify rtw_get_wireless_stats
      staging: rtl8188eu: remove RT_TRACE and DBG_88E prints from usb_ops_linux.c
      staging: rtl8188eu: use existing define for ethernet header len
      staging: rtl8188eu: use standard kthread handling
      staging: rtl8188eu: remove unused function parameter
      staging: rtl8188eu: remove unused hal_data_8188e members
      staging: rtl8188eu: remove a write-only struct member
      staging: rtl8188eu: remove a write-only power-index members
      staging: rtl8188eu: remove another write-only member
      staging: rtl8188eu: fix usb_submit_urb error handling
      staging: rtl8188eu: handle errors from dev_alloc_name
      staging: rtl8188eu: remove RT_TRACE prints from usb_intf.c
      staging: rtl8188eu: remove RT_TRACE prints from rtl8188e_hal_init.c
      staging: rtl8188eu: remove a couple of unused defines
      staging: rtl8188eu: remove efuse type
      staging: rtl8188eu: remove unnecessary if clause
      staging: rtl8188eu: remove RT_TRACE and MSG_88E prints from usb_halinit.c
      staging: rtl8188eu: remove HAL_INIT_PROFILE_TAG
      staging: rtl8188eu: simplify rtl88eu_mon_init
      staging: rtl8188eu: remove RT_TRACE prints from pwrseqcmd.c
      staging: rtl8188eu: make efuse_ReadEFuse static
      staging: rtl8188eu: remove sdio defines
      staging: rtl8188eu: remove more unused defines

Mauro Carvalho Chehab (11):
      iio: Documentation: move incompatible ABI to obsolete
      staging: phy-hi3670-usb3: do a some minor cleanups
      staging: hisi-spmi-controller: rename spmi-channel property
      phy: phy-hi3670-usb3: move driver from staging into phy
      spmi: hisi-spmi-controller: move driver from staging
      staging: hisilicon,hi6421-spmi-pmic.yaml: cleanup descriptions
      staging: hi6421-spmi-pmic: use devm_request_threaded_irq()
      staging: hi6421-spmi-pmic: better name IRQs
      staging: hi6421-spmi-pmic: change a return code
      staging: hi6421-spmi-pmic: change identation of a table
      staging: hi6421-spmi-pmic: cleanup some macros

Michael Straube (2):
      staging: rtl8188eu: rename struct field bLedOn
      staging: rtl8188eu: remove useless comment

Nguyen Dinh Phi (1):
      Staging: vchiq_arm: Using pr_err and pr_notice instead of printk

Nuno Sa (10):
      iio: adis_buffer: do not return ints in irq handlers
      iio: adis16400: do not return ints in irq handlers
      iio: adis_buffer: check return value on page change
      iio: adis16475: do not return ints in irq handlers
      iio: adis_buffer: update device page after changing it
      iio: adis_buffer: don't push data to buffers on failure
      iio: adis: add burst_max_speed_hz variable
      iio: adis16475: do not directly change spi 'max_speed_hz'
      iio: adis16400: do not directly change spi 'max_speed_hz'
      iio: adis16480: support burst read function

Nuno Sá (2):
      iio: adis16260: make use of adis lock helpers
      iio: adis16136: make use of adis lock helpers

Ojaswin Mujoo (3):
      staging: rtl8192e: Avoid multiple line dereference
      staging: rtl8192e: Add identifier name to function definition
      staging: rtl8192e: Fix whitespace around conditional statement

Oleksij Rempel (3):
      dt-bindings:iio:adc: add generic settling-time-us and oversampling-ratio channel properties
      dt-bindings:iio:adc: add documentation for TI TSC2046 controller
      iio: adc: add ADC driver for the TI TSC2046 controller

Oliver Lang (2):
      iio: ltr501: ltr559: fix initialization of LTR501_ALS_CONTR
      iio: ltr501: ltr501_read_ps(): add missing endianness conversion

Pavel Skripkin (3):
      staging: rtl8712: remove redundant check in r871xu_drv_init
      staging: rtl8712: fix error handling in r871xu_drv_init
      staging: rtl8712: fix memory leak in rtl871x_load_fw_cb

Philippe Dixon (2):
      staging: greybus: spi: add blank line after variable declaration
      staging: rtl8723bs: core: add blank line after variable declaration

Phillip Potter (72):
      staging: rtl8188eu: remove ASSERT and ODM_RT_ASSERT macros
      staging: rtl8188eu: convert pr_info call to dev_err call ODM_RAStateCheck
      staging: rtl8188eu: remove ODM_RT_TRACE calls from hal/phy.c
      staging: rtl8188eu: remove HW_DEF_ODM_DBG_FLAG enum value
      staging: rtl8188eu: convert DBG_88E calls in core/rtw_sta_mgt.c
      staging: rtl8188eu: convert DBG_88E calls in core/rtw_recv.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_efuse.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_xmit.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_mlme_ext.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_wlan_util.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_ap.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_pwrctrl.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_ieee80211.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_security.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_ioctl_set.c
      staging: rtl8188eu: remove all DBG_88E calls from core/rtw_mlme.c
      staging: rtl8188eu: remove all DBG_88E calls from os_dep/ioctl_linux.c
      staging: rtl8188eu: remove all DBG_88E calls from os_dep/usb_intf.c
      staging: rtl8188eu: remove all DBG_88E calls from os_dep/os_intfs.c
      staging: rtl8188eu: remove all DBG_88E calls from os_dep/mlme_linux.c
      staging: rtl8188eu: remove all DBG_88E calls from os_dep/xmit_linux.c
      staging: rtl8188eu: remove all DBG_88E calls from os_dep/rtw_android.c
      staging: rtl8188eu: remove all DBG_88E calls from hal/hal_intf.c
      staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188e_cmd.c
      staging: rtl8188eu: remove all DBG_88E calls from hal/pwrseqcmd.c
      staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188e_hal_init.c
      staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188e_xmit.c
      staging: rtl8188eu: remove all DBG_88E calls from hal/usb_halinit.c
      staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188eu_recv.c
      staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188eu_xmit.c
      staging: rtl8188eu: remove converted netdev_dbg calls from core/rtw_recv.c
      staging: rtl8188eu: remove converted netdev_dbg calls from core/rtw_sta_mgt.c
      staging: rtl8188eu: remove core/rtw_debug.c
      staging: rtl8188eu: remove DBG_88E macro definition
      staging: rtl8188eu: remove empty label from mlmeext_joinbss_event_callback
      staging: rtl8188eu: use prefix decrement operator on trycnt variable
      staging: rtl8188eu: remove unused variables from core/rtw_efuse.c
      staging: rtl8188eu: remove unused variables from core/rtw_mlme_ext.c
      staging: rtl8188eu: remove unused variable from os_dep/ioctl_linux.c
      staging: rtl8188eu: remove unused variables from hal/rtl8188e_cmd.c
      staging: rtl8188eu: remove _dbg_dump_tx_info function
      staging: rtl8188eu: remove all DBG_88E_LEVEL calls from os_dep/ioctl_linux.c
      staging: rtl8188eu: remove all DBG_88E_LEVEL calls from core/rtw_mlmw_ext.c
      staging: rtl8188eu: remove all DBG_88E_LEVEL calls from core/rtw_ioctl_set.c
      staging: rtl8188eu: remove all DBG_88E_LEVEL calls from core/rtw_pwrctrl.c
      staging: rtl8188eu: remove all DBG_88E_LEVEL calls from core/rtw_xmit.c
      staging: rtl8188eu: remove DBG_88E_LEVEL macro from include/rtw_debug.h
      staging: rtl8188eu: remove MSG_88E call from hal/odm.c
      staging: rtl8188eu: remove MSG_88E macro from include/rtw_debug.h
      staging: rtl8188eu: remove all RT_TRACE calls from os_dep/ioctl_linux.c
      staging: rtl8188eu: remove all RT_TRACE calls from os_dep/xmit_linux.c
      staging: rtl8188eu: remove all RT_TRACE calls from os_dep/os_intfs.c
      staging: rtl8188eu: remove all RT_TRACE calls from os_dep/mlme_linux.c
      staging: rtl8188eu: remove all RT_TRACE calls from os_dep/recv_linux.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_security.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_sta_mgt.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_mlme_ext.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_mlme.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_led.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_wlan_util.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_ieee80211.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_ioctl_set.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_recv.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_pwrctrl.c
      staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_xmit.c
      staging: rtl8188eu: remove all RT_TRACE calls from hal/rtl8188eu_xmit.c
      staging: rtl8188eu: remove all RT_TRACE calls from hal/hal_intf.c
      staging: rtl8188eu: remove all RT_TRACE calls from hal/rtl8188eu_recv.c
      staging: rtl8188eu: remove RT_TRACE macro
      staging: rtl8188eu: remove DRIVER_PREFIX preprocessor definition
      staging: rtl8188eu: remove GlobalDebugLevel variable
      staging: rtl8188eu: remove include/rtw_debug.h header

Piyush Thange (1):
      staging: rtl8192u: Fixed warnings of coding style

Puranjay Mohan (2):
      dt-bindings: iio: temperature: Add DT bindings for TMP117
      iio: temperature: add driver support for ti tmp117

Qiang Ma (1):
      staging: r8188eu/core: remove the check for NULL pointer in _rtw_enqueue_cmd()

Rajat Asthana (1):
      staging: greybus: audio: Fix sparse warning.

Saurav Girepunje (3):
      staging: rtl8723bs: core: remove unneeded variable
      staging: rtl8723bs: Change the return type
      staging: rtl8192e: Remove duplicate declartion

Sean Nyekjaer (7):
      iio: imu: st_lsm6dsx: correct ODR in header
      iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers
      dt-bindings: iio: accel: fxls8962af: add bindings
      iio: accel: fxls8962af: add set/get of samplerate
      iio: accel: fxls8962af: add interrupt support
      iio: accel: fxls8962af: add hw buffered sampling
      iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads

Sergio Paracuellos (25):
      staging: mt7621-pci: make use of kernel clock apis
      staging: mt7621-pci: avoid to set gpio mode in driver
      staging: mt7621-pci: remove some not needed includes
      staging: mt7621-pci: group io resource assignments all together
      staging: mt7621-pci: replace mdelay with msleep
      staging: mt7621-pci: directly return 'mt7621_pcie_register_host'
      staging: mt7621-pci: avoid custom 'map_irq' function
      staging: mt7621-pci: remove two blank lines
      staging: mt7621-dts: use 'interrupt-map' and 'interrupt-map-mask'
      staging: mt7621-dts: properly organize pcie node
      staging: mt7621-dts: remove ethsys node
      staging: mt7621-dts: use standard 'syscon' string
      staging: mt7621-dts: remove 'bug-range' property
      staging: mt7621-dts: add missing device_type in pcie root ports
      staging: mt7621-dts: use clock in pci phy nodes
      staging: mt7621-dts: review pcie overlay in 'gbpc1' dts file
      staging: mt7621-pci: make cleaner 'mt7621_pcie_enable_ports'
      staging: mt7621-pci: remove 'RALINK_PCI_BAR0SETUP_ADDR' definition
      staging: mt7621-pci: use {readl|writel}_relaxed instead of readl/writel
      staging: mt7621-dts: move some properties into root port child nodes
      staging: mt7621-pci: parse some dt properties from root port child nodes
      staging: mt7621-pci: make use of 'pcie_port_write'
      MIPS: ralink: Define PCI_IOBASE
      staging: mt7621-pci: remove 'mt7621_pci_parse_request_of_pci_ranges'
      staging: mt7621-dts: fix pci address for PCI memory range

Shaokun Zhang (2):
      staging: rtl8723bs: remove the repeated declaration
      staging: rtl8192u: remove the repeated declaration

Shreyansh Chouhan (4):
      staging: rtl8723bs: fix coding style for if comparisions
      staging: rtl8723bs: refactor to reduce indents
      staging: rtl8723bs: remove unnecessary braces from conditionals
      staging: rtl8723bs: fix suspect indents

Shreyas Krishnakumar (1):
      staging: rtl8723bs: rtw_efuse: Fix coding style

Stefan Wahren (47):
      staging: vchiq_arm: avoid crashing the kernel
      staging: vchiq_core: break early in vchiq_close_service_internal
      staging: vchiq_core: return early in do_abort_bulks
      staging: vchiq_core: introduce get_bulk_reason
      staging: vchiq_core: Drop unnecessary check in notify_bulks
      staging: vchiq_arm: drop return value of vchiq_arm_init_state
      staging: vchiq_2835_arm: drop enum vchiq_status
      staging: vchiq_arm: drop enum vchiq_status from vchiq_*_internal
      staging: vchiq_core: drop vchiq_status from vchiq_set_service_option
      staging: vchiq_core: drop vchiq_status from vchiq_initialise
      staging: vchiq_core: drop vchiq_status from vchiq_init_state
      staging: vchiq_core: fix return type of vchiq_init_state
      staging: vchiq_core: drop unnecessary release_count
      staging: vchiq_core: separate postfix increment
      staging: vc04_services: remove __VCCOREVER__
      staging: vchiq_arm: balance braces for if-else statements
      staging: vchiq_core: introduce poll_services_of_group
      staging: vchiq_core: avoid indention in poll_services_of_group
      staging: vchiq_arm: Use define for doorbell irq
      staging: vchiq_arm: drop ftrace-like logging
      staging: vchiq_arm: Prefer kzalloc(sizeof(*waiter)...)
      staging: vchiq_arm: drop non-beneficial comments
      staging: vchiq_arm: add blank line after declarations
      staging: vchiq_arm: re-arrange function header
      staging: vchiq_core: reduce indention in release_service_messages
      staging: vchiq_core: fix comment in vchiq_shutdown_internal
      staging: vchiq_arm: make vchiq_shutdown_internal return void
      staging: vchiq_arm: Avoid unnecessary line breaks
      staging: vchiq_core: introduce parse_message
      staging: vchiq_core: introduce defines for close_recvd
      staging: vchiq_core: introduce defines for retry_poll
      staging: vchiq_core: fix logic in poll_services_of_group
      staging: vchiq_arm: introduce free_bulk_waiter
      staging: vchiq_core: move internals to C source
      staging: vchiq_core: get the rid of IS_POW2
      staging: vchiq_core: get the rid of vchiq_static_assert
      staging: vchiq_core: put spaces around operators
      staging: vchiq_core: avoid precedence issues
      staging: vchiq_core: use define for message type shift
      staging: vchiq_core: introduce message specific make macros
      staging: vchiq_core: simplify WARN_ON conditions
      staging: vchiq_arm: tidy up service function naming
      staging: vchiq_core: introduce process_free_data_message
      staging: vchiq_core: reduce indentation in parse_open
      staging: vchiq_core: store message id in local variable
      staging: vchiq_connected: move EXPORT_SYMBOL below the right function
      staging: vchiq_core: introduce handle_poll

Stephan Gerhold (16):
      dt-bindings: iio: kionix,kxcjk1013: Document kionix,kx023-1025
      iio: accel: kxcjk-1013: Refactor configuration registers into struct
      iio: accel: kxcjk-1013: Add support for KX023-1025
      iio: accel: bma180: Add missing 500 Hz / 1000 Hz bandwidth
      iio: accel: bma180: Fix BMA25x bandwidth register values
      iio: accel: bmc150: Fix bma222 scale unit
      iio: accel: bmc150: Clarify combo modules in Kconfig
      iio: accel: bmc150: Drop misleading/duplicate chip identifiers
      iio: accel: bmc150: Drop duplicated documentation of supported chips
      iio: accel: bmc150: Sort all chip names alphabetically / by chip ID
      dt-bindings: iio: accel: bma255: Document bosch,bma253
      iio: accel: bmc150: Add device IDs for BMA253
      dt-bindings: iio: bma255: Allow multiple interrupts
      dt-bindings: iio: accel: bma180/bma255: Move bma254 to bma255 schema
      iio: accel: bma180/bmc150: Move BMA254 to bmc150-accel driver
      iio: accel: bmc150: Use more consistent and accurate scale values

Tang Bin (2):
      iio:adc:ad7766: Fix unnecessary check in ad7766_probe()
      staging: iio: cdc: ad7746: Remove unnecessary assignment in ad7746_probe()

Thomas Bracht Laumann Jespersen (2):
      staging: rtl8192e: Fix shadowed variable name
      staging: rtl8192u: Fix shadowed variable name

Tian Tao (3):
      iio:chemical:sps30: Convert sysfs sprintf/snprintf family to sysfs_emit
      iio: light: Convert sysfs sprintf/snprintf family to sysfs_emit
      iio: trigger: stm32-timer: Convert sysfs sprintf/snprintf family to sysfs_emit

Tobias Alam (1):
      staging: qlge: change msleep to usleep_range

Tom Rix (2):
      staging: fpgaboot: change FPGA indirect article to an
      iio: scmi: fix spelling of SPDX tag

Tomas Melin (2):
      dt-bindings: iio: accel: Add SCA3300 documentation
      iio: accel: Add driver for Murata SCA3300 accelerometer

Tomasz Duszynski (3):
      iio: sps30: separate core and interface specific code
      iio: sps30: add support for serial interface
      dt-bindings: iio: chemical: sps30: update binding with serial example

Uwe Kleine-König (2):
      staging: fieldbus: anybus: Make remove callback return void
      staging: fieldbus: anybus: Refuse registering drivers without .probe()

Wang Qing (2):
      staging: iio: fix some formatting issues
      staging: rtl8192e: delete extra blank lines

Wei Yongjun (1):
      iio: dummy: Fix build error when CONFIG_IIO_TRIGGERED_BUFFER is not set

William Breathitt Gray (16):
      docs: counter: Consolidate Counter sysfs attributes documentation
      docs: counter: Fix spelling
      counter: 104-quad-8: Remove pointless comment
      counter: 104-quad-8: Annotate hardware config module parameter
      counter: 104-quad-8: Add const qualifiers for quad8_preset_register_set
      counter: 104-quad-8: Add const qualifier for functions_list array
      counter: interrupt-cnt: Add const qualifier for functions_list array
      counter: microchip-tcb-capture: Add const qualifier for functions_list array
      counter: stm32-lptimer-cnt: Add const qualifier for functions_list array
      counter: stm32-timer-cnt: Add const qualifier for functions_list array
      counter: 104-quad-8: Add const qualifier for actions_list array
      counter: ftm-quaddec: Add const qualifier for actions_list array
      counter: microchip-tcb-capture: Add const qualifier for actions_list array
      counter: stm32-lptimer-cnt: Add const qualifier for actions_list array
      counter: stm32-timer-cnt: Add const qualifier for actions_list array
      counter: interrupt-cnt: Add const qualifier for actions_list array

Yang Yingliang (4):
      iio: frequency: adf4350: disable reg and clk on error in adf4350_probe()
      staging: rtl8723bs: os_dep: use eth_broadcast_addr() to assign broadcast address
      staging: rtl8723bs: core: use eth_broadcast_addr() to assign broadcast address
      staging: rtl8723bs: hal: use eth_broadcast_addr() to assign broadcast address

Yicong Yang (7):
      iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register()
      iio: buffer-dmaengine: simplify __devm_iio_dmaengine_buffer_free()
      iio: hw_consumer: simplify devm_iio_hw_consumer_alloc()
      iio: triggered-buffer: simplify devm_iio_triggered_buffer_setup_ext()
      iio: core: simplify some devm functions
      iio: trigger: simplify __devm_iio_trigger_register
      iio: inkern: simplify some devm functions

Yu Kuai (1):
      staging: rtl8723bs: core: rtw_mlme_ext.c: remove deadcode

Zhen Lei (2):
      staging: rtl8723bs: Delete two redundant condition branches
      iio: ep93xx: Remove redundant error printing in ep93xx_adc_probe()

frank zago (1):
      iio: light: tcs3472: do not free unallocated IRQ

liuhailong (1):
      staging: android: ashmem: add size field in procfs fdinfo

zhaoxiao (2):
      staging: rtl8192e: remove unnecesasry ftrace-like logging
      staging: rtl8192e: replace comparison to NULL by bool

 Documentation/ABI/obsolete/sysfs-bus-iio           |  182 +++
 Documentation/ABI/testing/sysfs-bus-counter        |   85 +-
 .../ABI/testing/sysfs-bus-counter-104-quad-8       |   61 -
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec      |   16 -
 Documentation/ABI/testing/sysfs-bus-iio            |  125 +-
 .../ABI/testing/sysfs-bus-iio-frequency-adf4371    |   33 -
 .../ABI/testing/sysfs-bus-iio-health-afe440x       |   10 +-
 Documentation/ABI/testing/sysfs-bus-iio-icm42600   |   20 -
 .../ABI/testing/sysfs-bus-iio-light-lm3533-als     |   11 +-
 .../bindings/iio/accel/adi,adis16201.yaml          |   55 +
 .../bindings/iio/accel/bosch,bma180.yaml           |    3 +-
 .../bindings/iio/accel/bosch,bma220.yaml           |   50 +
 .../bindings/iio/accel/bosch,bma255.yaml           |    9 +-
 .../devicetree/bindings/iio/accel/fsl,mma7455.yaml |   82 +
 .../bindings/iio/accel/kionix,kxcjk1013.yaml       |    1 +
 .../bindings/iio/accel/murata,sca3300.yaml         |   44 +
 .../bindings/iio/accel/nxp,fxls8962af.yaml         |   80 +
 Documentation/devicetree/bindings/iio/adc/adc.yaml |   12 +
 .../devicetree/bindings/iio/adc/adi,ad7298.yaml    |   48 +
 .../devicetree/bindings/iio/adc/adi,ad7476.yaml    |  174 +++
 .../devicetree/bindings/iio/adc/ti,tsc2046.yaml    |  115 ++
 .../bindings/iio/afe/current-sense-shunt.yaml      |    4 +
 .../devicetree/bindings/iio/cdc/adi,ad7746.yaml    |   77 +
 .../bindings/iio/chemical/sensirion,sps30.yaml     |    7 +-
 .../devicetree/bindings/iio/dac/ad5755.txt         |  124 --
 .../devicetree/bindings/iio/dac/adi,ad5755.yaml    |  169 ++
 .../devicetree/bindings/iio/dac/ti,dac082s085.yaml |   72 +
 .../devicetree/bindings/iio/dac/ti-dac082s085.txt  |   34 -
 .../bindings/iio/light/amstaos,tsl2591.yaml        |   50 +
 .../devicetree/bindings/iio/st,st-sensors.yaml     |  262 +++-
 .../bindings/iio/temperature/ti,tmp117.yaml        |   41 +
 .../bindings/phy/hisilicon,hi3670-usb3.yaml        |    0
 .../spmi}/hisilicon,hisi-spmi-controller.yaml      |   10 +-
 .../devicetree/bindings/trivial-devices.yaml       |   10 +
 Documentation/driver-api/generic-counter.rst       |    2 +-
 MAINTAINERS                                        |   42 +-
 arch/mips/include/asm/mach-ralink/spaces.h         |   10 +
 drivers/comedi/drivers/jr3_pci.c                   |   15 -
 drivers/counter/104-quad-8.c                       |   13 +-
 drivers/counter/Kconfig                            |   10 +
 drivers/counter/Makefile                           |    1 +
 drivers/counter/ftm-quaddec.c                      |    2 +-
 drivers/counter/intel-qep.c                        |  544 +++++++
 drivers/counter/interrupt-cnt.c                    |    8 +-
 drivers/counter/microchip-tcb-capture.c            |    4 +-
 drivers/counter/stm32-lptimer-cnt.c                |    4 +-
 drivers/counter/stm32-timer-cnt.c                  |    4 +-
 drivers/iio/accel/Kconfig                          |   51 +-
 drivers/iio/accel/Makefile                         |    4 +
 drivers/iio/accel/adis16201.c                      |    3 -
 drivers/iio/accel/adis16209.c                      |    3 -
 drivers/iio/accel/adxl372.c                        |    4 +-
 drivers/iio/accel/bma180.c                         |  112 +-
 drivers/iio/accel/bma220_spi.c                     |   10 +-
 drivers/iio/accel/bma400_core.c                    |    2 +-
 drivers/iio/accel/bmc150-accel-core.c              |  234 +--
 drivers/iio/accel/bmc150-accel-i2c.c               |  245 ++-
 drivers/iio/accel/bmc150-accel-spi.c               |   31 +-
 drivers/iio/accel/bmc150-accel.h                   |   72 +-
 drivers/iio/accel/bmi088-accel-core.c              |   27 +-
 drivers/iio/accel/fxls8962af-core.c                |  968 ++++++++++++
 drivers/iio/accel/fxls8962af-i2c.c                 |   57 +
 drivers/iio/accel/fxls8962af-spi.c                 |   57 +
 drivers/iio/accel/fxls8962af.h                     |   22 +
 drivers/iio/accel/hid-sensor-accel-3d.c            |   19 +-
 drivers/iio/accel/kxcjk-1013.c                     |  253 ++-
 drivers/iio/accel/kxsd9.c                          |    2 +-
 drivers/iio/accel/mma8452.c                        |    7 +-
 drivers/iio/accel/mma9551.c                        |    1 -
 drivers/iio/accel/mma9551_core.c                   |    4 +-
 drivers/iio/accel/mma9553.c                        |    1 -
 drivers/iio/accel/mxc4005.c                        |   12 +-
 drivers/iio/accel/sca3300.c                        |  472 ++++++
 drivers/iio/accel/st_accel.h                       |   12 -
 drivers/iio/accel/st_accel_core.c                  |  230 ++-
 drivers/iio/accel/st_accel_i2c.c                   |   17 +-
 drivers/iio/accel/st_accel_spi.c                   |   17 +-
 drivers/iio/accel/stk8312.c                        |   27 +-
 drivers/iio/accel/stk8ba50.c                       |   19 +-
 drivers/iio/adc/Kconfig                            |   12 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7124.c                           |   48 +-
 drivers/iio/adc/ad7192.c                           |   93 +-
 drivers/iio/adc/ad7298.c                           |    8 +
 drivers/iio/adc/ad7476.c                           |  120 +-
 drivers/iio/adc/ad7606.c                           |    3 +-
 drivers/iio/adc/ad7766.c                           |   10 +-
 drivers/iio/adc/ad7768-1.c                         |    4 +-
 drivers/iio/adc/ad7780.c                           |   38 +-
 drivers/iio/adc/ad7791.c                           |   44 +-
 drivers/iio/adc/ad7793.c                           |   53 +-
 drivers/iio/adc/ad7887.c                           |    1 -
 drivers/iio/adc/ad9467.c                           |    2 -
 drivers/iio/adc/ad_sigma_delta.c                   |   82 +-
 drivers/iio/adc/adi-axi-adc.c                      |   24 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    5 +-
 drivers/iio/adc/at91_adc.c                         |    4 +-
 drivers/iio/adc/dln2-adc.c                         |    3 +-
 drivers/iio/adc/ep93xx_adc.c                       |    4 +-
 drivers/iio/adc/exynos_adc.c                       |    2 +-
 drivers/iio/adc/hi8435.c                           |    1 -
 drivers/iio/adc/hx711.c                            |    4 +-
 drivers/iio/adc/ina2xx-adc.c                       |    3 +-
 drivers/iio/adc/max1027.c                          |    2 -
 drivers/iio/adc/max11100.c                         |   34 +-
 drivers/iio/adc/max1118.c                          |   68 +-
 drivers/iio/adc/max1241.c                          |    2 -
 drivers/iio/adc/mp2629_adc.c                       |    1 -
 drivers/iio/adc/mt6360-adc.c                       |    1 -
 drivers/iio/adc/mxs-lradc-adc.c                    |    5 +-
 drivers/iio/adc/rcar-gyroadc.c                     |   15 +-
 drivers/iio/adc/sc27xx_adc.c                       |    1 +
 drivers/iio/adc/stm32-adc.c                        |   28 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |    6 +-
 drivers/iio/adc/ti-adc081c.c                       |   43 +-
 drivers/iio/adc/ti-adc0832.c                       |   39 +-
 drivers/iio/adc/ti-adc084s021.c                    |    3 -
 drivers/iio/adc/ti-adc108s102.c                    |   45 +-
 drivers/iio/adc/ti-adc161s626.c                    |   51 +-
 drivers/iio/adc/ti-ads1015.c                       |   17 +-
 drivers/iio/adc/ti-ads124s08.c                     |    2 -
 drivers/iio/adc/ti-ads131e08.c                     |    3 +-
 drivers/iio/adc/ti-ads8688.c                       |    3 +-
 drivers/iio/adc/ti-tsc2046.c                       |  712 +++++++++
 drivers/iio/adc/vf610_adc.c                        |   10 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    2 +-
 drivers/iio/afe/iio-rescale.c                      |   41 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   22 +-
 drivers/iio/buffer/industrialio-hw-consumer.c      |   25 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |   23 +-
 drivers/iio/chemical/Kconfig                       |   27 +-
 drivers/iio/chemical/Makefile                      |    2 +
 drivers/iio/chemical/atlas-sensor.c                |   19 +-
 drivers/iio/chemical/bme680_i2c.c                  |    8 -
 drivers/iio/chemical/bme680_spi.c                  |    8 -
 drivers/iio/chemical/ccs811.c                      |    2 +-
 drivers/iio/chemical/scd30_core.c                  |    3 +-
 drivers/iio/chemical/sgp30.c                       |    2 +-
 drivers/iio/chemical/sps30.c                       |  275 +---
 drivers/iio/chemical/sps30.h                       |   35 +
 drivers/iio/chemical/sps30_i2c.c                   |  258 +++
 drivers/iio/chemical/sps30_serial.c                |  431 ++++++
 .../iio/common/hid-sensors/hid-sensor-attributes.c |   32 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   24 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |    3 +
 drivers/iio/common/scmi_sensors/Makefile           |    2 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    1 -
 drivers/iio/dac/ad5766.c                           |    2 -
 drivers/iio/dac/stm32-dac.c                        |    3 +-
 drivers/iio/dummy/Kconfig                          |    1 +
 drivers/iio/frequency/adf4350.c                    |    6 +-
 drivers/iio/gyro/adis16136.c                       |   20 +-
 drivers/iio/gyro/adis16260.c                       |    9 +-
 drivers/iio/gyro/adxrs290.c                        |    2 +-
 drivers/iio/gyro/bmg160_core.c                     |   17 +-
 drivers/iio/gyro/fxas21002c_core.c                 |   13 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |    6 +-
 drivers/iio/gyro/itg3200_buffer.c                  |    2 +-
 drivers/iio/gyro/itg3200_core.c                    |    3 +-
 drivers/iio/gyro/mpu3050-core.c                    |    4 +-
 drivers/iio/gyro/st_gyro.h                         |   12 -
 drivers/iio/gyro/st_gyro_core.c                    |   53 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |   17 +-
 drivers/iio/gyro/st_gyro_spi.c                     |   17 +-
 drivers/iio/health/afe4403.c                       |    2 +-
 drivers/iio/health/afe4404.c                       |    2 +-
 drivers/iio/humidity/am2315.c                      |   25 +-
 drivers/iio/humidity/hdc2010.c                     |    1 -
 drivers/iio/humidity/hid-sensor-humidity.c         |    2 +
 drivers/iio/imu/Kconfig                            |    1 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/adis.c                             |    4 -
 drivers/iio/imu/adis16400.c                        |   27 +-
 drivers/iio/imu/adis16460.c                        |    3 -
 drivers/iio/imu/adis16475.c                        |   11 +-
 drivers/iio/imu/adis16480.c                        |  166 +-
 drivers/iio/imu/adis_buffer.c                      |   27 +-
 drivers/iio/imu/adis_trigger.c                     |    3 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |    6 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   27 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |    8 +-
 drivers/iio/imu/kmx61.c                            |    7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    8 +-
 drivers/iio/imu/st_lsm9ds0/Kconfig                 |   28 +
 drivers/iio/imu/st_lsm9ds0/Makefile                |    5 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h            |   23 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |  163 ++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   84 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |   83 +
 drivers/iio/industrialio-buffer.c                  |   13 +-
 drivers/iio/industrialio-core.c                    |  126 +-
 drivers/iio/industrialio-trigger.c                 |   37 +-
 drivers/iio/industrialio-triggered-event.c         |    2 +-
 drivers/iio/inkern.c                               |  107 +-
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/acpi-als.c                       |    3 +-
 drivers/iio/light/hid-sensor-als.c                 |    6 +-
 drivers/iio/light/hid-sensor-prox.c                |    6 +-
 drivers/iio/light/isl29028.c                       |    5 +-
 drivers/iio/light/isl29125.c                       |   10 +-
 drivers/iio/light/ltr501.c                         |   25 +-
 drivers/iio/light/pa12203001.c                     |    4 +-
 drivers/iio/light/rpr0521.c                        |    9 +-
 drivers/iio/light/si1133.c                         |   18 +-
 drivers/iio/light/si1145.c                         |   12 +-
 drivers/iio/light/tcs3414.c                        |   10 +-
 drivers/iio/light/tcs3472.c                        |   16 +-
 drivers/iio/light/tsl2583.c                        |   13 +-
 drivers/iio/light/tsl2591.c                        | 1225 +++++++++++++++
 drivers/iio/light/us5182d.c                        |    4 +-
 drivers/iio/light/vcnl4000.c                       |    9 +-
 drivers/iio/light/vcnl4035.c                       |    9 +-
 drivers/iio/light/veml6030.c                       |    2 +-
 drivers/iio/magnetometer/ak8974.c                  |    3 +-
 drivers/iio/magnetometer/ak8975.c                  |    2 +-
 drivers/iio/magnetometer/bmc150_magn.c             |   26 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    7 +-
 drivers/iio/magnetometer/hmc5843.h                 |    8 +-
 drivers/iio/magnetometer/hmc5843_core.c            |    7 +-
 drivers/iio/magnetometer/rm3100-core.c             |    5 +-
 drivers/iio/magnetometer/st_magn.h                 |    4 -
 drivers/iio/magnetometer/st_magn_core.c            |  181 ++-
 drivers/iio/magnetometer/st_magn_i2c.c             |   14 +-
 drivers/iio/magnetometer/st_magn_spi.c             |   14 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    2 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |    6 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |    5 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |    4 +-
 drivers/iio/potentiostat/lmp91000.c                |    7 +-
 drivers/iio/pressure/hid-sensor-press.c            |    6 +-
 drivers/iio/pressure/icp10100.c                    |    5 +-
 drivers/iio/pressure/st_pressure.h                 |    4 -
 drivers/iio/pressure/st_pressure_core.c            |   15 +-
 drivers/iio/pressure/st_pressure_i2c.c             |   17 +-
 drivers/iio/pressure/st_pressure_spi.c             |   17 +-
 drivers/iio/pressure/zpa2326.c                     |    3 +-
 drivers/iio/proximity/as3935.c                     |   13 +-
 drivers/iio/proximity/isl29501.c                   |    2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   14 +-
 drivers/iio/proximity/srf04.c                      |    8 +-
 drivers/iio/proximity/srf08.c                      |   14 +-
 drivers/iio/proximity/sx9310.c                     |    2 +-
 drivers/iio/proximity/sx9500.c                     |    2 +-
 drivers/iio/temperature/Kconfig                    |   10 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/hid-sensor-temperature.c   |    2 +
 drivers/iio/temperature/mlx90614.c                 |   25 +-
 drivers/iio/temperature/tmp117.c                   |  185 +++
 drivers/iio/trigger/stm32-timer-trigger.c          |    2 +-
 drivers/phy/hisilicon/Kconfig                      |   10 +
 drivers/phy/hisilicon/Makefile                     |    1 +
 .../hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c   |   19 +-
 drivers/rtc/rtc-hid-sensor-time.c                  |    1 +
 drivers/spmi/Kconfig                               |    9 +
 drivers/spmi/Makefile                              |    1 +
 .../hikey9xx => spmi}/hisi-spmi-controller.c       |    2 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/android/ashmem.c                   |    3 +
 drivers/staging/axis-fifo/axis-fifo.c              |   18 +-
 drivers/staging/emxx_udc/emxx_udc.c                |   11 +-
 drivers/staging/fbtft/TODO                         |    5 -
 drivers/staging/fbtft/fb_agm1264k-fl.c             |   30 +-
 drivers/staging/fbtft/fb_bd663474.c                |    4 -
 drivers/staging/fbtft/fb_hx8347d.c                 |   29 +-
 drivers/staging/fbtft/fb_ili9163.c                 |    4 -
 drivers/staging/fbtft/fb_ili9320.c                 |    4 +-
 drivers/staging/fbtft/fb_ili9325.c                 |    4 -
 drivers/staging/fbtft/fb_ili9340.c                 |    1 -
 drivers/staging/fbtft/fb_s6d1121.c                 |    4 -
 drivers/staging/fbtft/fb_sh1106.c                  |    1 -
 drivers/staging/fbtft/fb_ssd1289.c                 |    4 -
 drivers/staging/fbtft/fb_ssd1325.c                 |    2 -
 drivers/staging/fbtft/fb_ssd1331.c                 |    6 +-
 drivers/staging/fbtft/fb_ssd1351.c                 |    1 -
 drivers/staging/fbtft/fb_upd161704.c               |    4 -
 drivers/staging/fbtft/fb_watterott.c               |    1 -
 drivers/staging/fbtft/fbtft-bus.c                  |    3 +-
 drivers/staging/fbtft/fbtft-core.c                 |   25 +-
 drivers/staging/fbtft/fbtft-io.c                   |   12 +-
 drivers/staging/fieldbus/anybuss/anybuss-client.h  |    2 +-
 drivers/staging/fieldbus/anybuss/hms-profinet.c    |    3 +-
 drivers/staging/fieldbus/anybuss/host.c            |    8 +-
 drivers/staging/fwserial/fwserial.c                |   46 +-
 drivers/staging/gdm724x/gdm_lte.c                  |   21 +-
 drivers/staging/greybus/audio_topology.c           |    4 +-
 drivers/staging/greybus/gbphy.c                    |    4 +-
 drivers/staging/greybus/spilib.c                   |    1 +
 drivers/staging/gs_fpgaboot/README                 |    2 +-
 drivers/staging/hikey9xx/Kconfig                   |   22 -
 drivers/staging/hikey9xx/Makefile                  |    3 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c        |  116 +-
 .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml       |    7 +-
 drivers/staging/iio/accel/adis16203.c              |    6 -
 drivers/staging/iio/accel/adis16240.c              |    6 -
 drivers/staging/iio/addac/adt7316.c                |   12 +-
 drivers/staging/iio/cdc/ad7746.c                   |  114 +-
 drivers/staging/iio/cdc/ad7746.h                   |   28 -
 drivers/staging/iio/frequency/ad9834.c             |    5 +-
 drivers/staging/kpc2000/Kconfig                    |   59 -
 drivers/staging/kpc2000/Makefile                   |    6 -
 drivers/staging/kpc2000/TODO                       |    2 -
 drivers/staging/kpc2000/kpc.h                      |   23 -
 drivers/staging/kpc2000/kpc2000/Makefile           |    4 -
 drivers/staging/kpc2000/kpc2000/cell_probe.c       |  548 -------
 drivers/staging/kpc2000/kpc2000/core.c             |  565 -------
 drivers/staging/kpc2000/kpc2000/dma_common_defs.h  |   23 -
 drivers/staging/kpc2000/kpc2000/pcie.h             |   90 --
 drivers/staging/kpc2000/kpc2000/uapi.h             |   22 -
 drivers/staging/kpc2000/kpc2000_i2c.c              |  731 ---------
 drivers/staging/kpc2000/kpc2000_spi.c              |  517 -------
 drivers/staging/kpc2000/kpc_dma/Makefile           |    6 -
 drivers/staging/kpc2000/kpc_dma/dma.c              |  270 ----
 drivers/staging/kpc2000/kpc_dma/fileops.c          |  363 -----
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c   |  249 ---
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h   |  222 ---
 drivers/staging/kpc2000/kpc_dma/uapi.h             |   11 -
 drivers/staging/ks7010/ks_hostif.c                 |   14 +-
 drivers/staging/ks7010/ks_hostif.h                 |   24 +-
 drivers/staging/most/dim2/dim2.c                   |   23 +-
 drivers/staging/most/dim2/hal.c                    |   10 +-
 drivers/staging/most/i2c/i2c.c                     |   12 +-
 drivers/staging/most/net/net.c                     |    6 +-
 drivers/staging/mt7621-dts/gbpc1.dts               |    6 -
 drivers/staging/mt7621-dts/mt7621.dtsi             |   75 +-
 drivers/staging/mt7621-pci/pci-mt7621.c            |  328 ++--
 drivers/staging/nvec/nvec.c                        |    7 +-
 drivers/staging/octeon/ethernet-tx.c               |    1 -
 drivers/staging/qlge/qlge_ethtool.c                |    2 +-
 drivers/staging/qlge/qlge_main.c                   |   10 +-
 drivers/staging/rtl8188eu/Makefile                 |    1 -
 drivers/staging/rtl8188eu/core/rtw_ap.c            |  144 +-
 drivers/staging/rtl8188eu/core/rtw_cmd.c           |  153 +-
 drivers/staging/rtl8188eu/core/rtw_debug.c         |  187 ---
 drivers/staging/rtl8188eu/core/rtw_efuse.c         |   62 +-
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |  111 +-
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c     |  112 +-
 drivers/staging/rtl8188eu/core/rtw_led.c           |   53 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |  236 +--
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |  483 ++----
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c       |   76 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c          |  289 +---
 drivers/staging/rtl8188eu/core/rtw_security.c      |   33 +-
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c       |   59 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c     |  111 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |  210 +--
 .../staging/rtl8188eu/hal/hal8188e_rate_adaptive.c |  123 +-
 drivers/staging/rtl8188eu/hal/hal_intf.c           |    6 -
 drivers/staging/rtl8188eu/hal/odm.c                |  161 +-
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c       |    6 -
 drivers/staging/rtl8188eu/hal/phy.c                |   53 +-
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c          |   28 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c       |   57 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c        |    2 -
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c  |   65 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c    |    2 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c      |   32 -
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c      |    4 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c     |   10 -
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c     |   28 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c        |  117 +-
 drivers/staging/rtl8188eu/include/drv_types.h      |    1 -
 drivers/staging/rtl8188eu/include/hal_intf.h       |    1 -
 drivers/staging/rtl8188eu/include/ieee80211.h      |   14 -
 drivers/staging/rtl8188eu/include/odm.h            |    2 -
 drivers/staging/rtl8188eu/include/odm_debug.h      |   96 --
 drivers/staging/rtl8188eu/include/odm_precomp.h    |    4 -
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h   |   32 -
 drivers/staging/rtl8188eu/include/rtl8188e_spec.h  |  284 +---
 drivers/staging/rtl8188eu/include/rtl8188e_xmit.h  |    3 -
 drivers/staging/rtl8188eu/include/rtw_android.h    |    1 -
 drivers/staging/rtl8188eu/include/rtw_cmd.h        |    5 +-
 drivers/staging/rtl8188eu/include/rtw_debug.h      |  131 --
 drivers/staging/rtl8188eu/include/rtw_efuse.h      |    7 +-
 drivers/staging/rtl8188eu/include/rtw_led.h        |    2 +-
 drivers/staging/rtl8188eu/include/rtw_mlme.h       |    4 -
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h   |    5 +-
 drivers/staging/rtl8188eu/include/rtw_recv.h       |    3 +-
 drivers/staging/rtl8188eu/include/wifi.h           |   36 -
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |  353 +----
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c      |    8 -
 drivers/staging/rtl8188eu/os_dep/mon.c             |   19 +-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c        |   97 +-
 drivers/staging/rtl8188eu/os_dep/recv_linux.c      |    8 +-
 drivers/staging/rtl8188eu/os_dep/rtw_android.c     |   18 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |   30 +-
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c   |  135 +-
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c      |   28 +-
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |    5 -
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |   12 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |    4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |    2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |   10 +-
 drivers/staging/rtl8192e/rtllib.h                  |    2 -
 drivers/staging/rtl8192e/rtllib_rx.c               |    3 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |    1 -
 drivers/staging/rtl8192e/rtllib_tx.c               |    2 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |    4 -
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |    2 -
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |   25 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c  |    2 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   15 +-
 drivers/staging/rtl8192u/r8192U_dm.c               |    6 +-
 drivers/staging/rtl8192u/r8192U_hw.h               |   19 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.c           |   41 -
 drivers/staging/rtl8192u/r819xU_phy.c              |   48 +-
 drivers/staging/rtl8712/hal_init.c                 |    3 +
 drivers/staging/rtl8712/os_intfs.c                 |    4 -
 drivers/staging/rtl8712/rtl8712_cmd.c              |    2 +-
 drivers/staging/rtl8712/rtl8712_recv.c             |    5 +-
 drivers/staging/rtl8712/rtl8712_xmit.c             |    6 +-
 drivers/staging/rtl8712/rtl871x_debug.h            |   23 -
 drivers/staging/rtl8712/rtl871x_mlme.c             |    6 +-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c         |   31 +-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h         |  127 --
 drivers/staging/rtl8712/rtl871x_recv.c             |    2 +-
 drivers/staging/rtl8712/rtl871x_security.c         |   12 +-
 drivers/staging/rtl8712/rtl871x_sta_mgt.c          |    1 -
 drivers/staging/rtl8712/rtl871x_xmit.c             |    1 -
 drivers/staging/rtl8712/usb_intf.c                 |   33 +-
 drivers/staging/rtl8712/xmit_linux.c               |    1 -
 drivers/staging/rtl8723bs/Makefile                 |    2 -
 drivers/staging/rtl8723bs/TODO                     |    2 -
 drivers/staging/rtl8723bs/core/rtw_ap.c            |  244 ++-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |   41 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c         |   74 +-
 drivers/staging/rtl8723bs/core/rtw_eeprom.c        |  210 ---
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   14 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |   28 +-
 drivers/staging/rtl8723bs/core/rtw_io.c            |   35 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |  103 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |  440 ++----
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |    2 -
 drivers/staging/rtl8723bs/core/rtw_recv.c          |   26 +-
 drivers/staging/rtl8723bs/core/rtw_security.c      |  672 +-------
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |   43 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  194 ++-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |   68 +-
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c    |  959 ++----------
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c    |  519 +------
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h       |   68 -
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c   |   79 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_MAC.c  |   49 -
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c   |  658 +++-----
 drivers/staging/rtl8723bs/hal/HalPhyRf.c           |  340 +---
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |  221 +--
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         |  175 ---
 drivers/staging/rtl8723bs/hal/hal_com.c            |  261 ----
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     | 1059 ++-----------
 drivers/staging/rtl8723bs/hal/hal_intf.c           |    3 -
 drivers/staging/rtl8723bs/hal/odm.c                |  103 +-
 drivers/staging/rtl8723bs/hal/odm.h                |   46 +-
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c    |  107 --
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |  322 ----
 drivers/staging/rtl8723bs/hal/odm_EdcaTurboCheck.c |   22 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c       |   38 -
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c   |   36 +-
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c        |   34 -
 drivers/staging/rtl8723bs/hal/odm_PathDiv.h        |   21 -
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c       |    1 -
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c |   71 +-
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h |    2 -
 drivers/staging/rtl8723bs/hal/odm_debug.c          |   44 -
 drivers/staging/rtl8723bs/hal/odm_debug.h          |  165 --
 drivers/staging/rtl8723bs/hal/odm_precomp.h        |    2 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c       |   21 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c        |    1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |   65 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |   69 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |    2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |    9 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       |   35 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |   16 +-
 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h |    2 -
 drivers/staging/rtl8723bs/include/autoconf.h       |   50 -
 drivers/staging/rtl8723bs/include/drv_conf.h       |   19 -
 drivers/staging/rtl8723bs/include/drv_types.h      |   12 +-
 drivers/staging/rtl8723bs/include/hal_btcoex.h     |    4 +-
 drivers/staging/rtl8723bs/include/hal_com.h        |   62 +-
 drivers/staging/rtl8723bs/include/hal_com_phycfg.h |  198 +--
 drivers/staging/rtl8723bs/include/hal_com_reg.h    |    1 -
 drivers/staging/rtl8723bs/include/hal_data.h       |   40 +-
 drivers/staging/rtl8723bs/include/hal_pg.h         |    2 -
 drivers/staging/rtl8723bs/include/hal_phy.h        |   24 -
 drivers/staging/rtl8723bs/include/ieee80211.h      |   67 +-
 drivers/staging/rtl8723bs/include/osdep_intf.h     |    2 +-
 drivers/staging/rtl8723bs/include/rtl8723b_spec.h  |    2 -
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h  |   21 -
 drivers/staging/rtl8723bs/include/rtw_ap.h         |    2 +-
 drivers/staging/rtl8723bs/include/rtw_debug.h      |  170 +-
 drivers/staging/rtl8723bs/include/rtw_ht.h         |    4 -
 drivers/staging/rtl8723bs/include/rtw_io.h         |   44 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |   84 +-
 drivers/staging/rtl8723bs/include/rtw_mp.h         |    1 -
 drivers/staging/rtl8723bs/include/rtw_rf.h         |   33 +-
 drivers/staging/rtl8723bs/include/rtw_security.h   |  104 +-
 drivers/staging/rtl8723bs/include/rtw_xmit.h       |    2 +-
 drivers/staging/rtl8723bs/include/sdio_ops_linux.h |    2 -
 drivers/staging/rtl8723bs/include/wifi.h           |    3 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   32 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |   67 +-
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c      |    4 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |   36 +-
 drivers/staging/rtl8723bs/os_dep/osdep_service.c   |    4 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c      |    2 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |    6 +-
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c  |   28 -
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c       |    4 -
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |   10 +-
 drivers/staging/rts5208/ms.c                       |    1 -
 drivers/staging/sm750fb/sm750_accel.c              |    4 +-
 drivers/staging/unisys/visorhba/visorhba_main.c    |  101 +-
 drivers/staging/unisys/visorinput/visorinput.c     |    1 -
 drivers/staging/vc04_services/Makefile             |    2 +-
 .../include/linux/raspberrypi/vchiq.h              |    2 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |   27 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  307 ++--
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |    2 +-
 .../interface/vchiq_arm/vchiq_connected.c          |    2 +-
 .../interface/vchiq_arm/vchiq_connected.h          |    8 -
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 1636 +++++++++++---------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   93 +-
 .../interface/vchiq_arm/vchiq_debugfs.c            |    6 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |    2 +-
 drivers/staging/vt6655/upc.h                       |    2 +-
 drivers/staging/wlan-ng/cfg80211.c                 |   30 +-
 drivers/staging/wlan-ng/p80211ioctl.h              |    2 +-
 drivers/staging/wlan-ng/p80211netdev.c             |    6 +-
 include/linux/i2c.h                                |    8 +-
 include/linux/iio/adc/ad_sigma_delta.h             |    4 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |    2 +-
 include/linux/iio/common/st_sensors.h              |   36 +-
 include/linux/iio/iio-opaque.h                     |   22 +-
 include/linux/iio/iio.h                            |   32 +-
 include/linux/iio/imu/adis.h                       |    2 +
 include/linux/platform_data/st_sensors_pdata.h     |    3 +-
 538 files changed, 12918 insertions(+), 19922 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-bus-iio
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/fsl,mma7455.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7298.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad5755.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl2591.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
 rename drivers/staging/hikey9xx/phy-hi3670-usb3.yaml => Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml (100%)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/spmi}/hisilicon,hisi-spmi-controller.yaml (89%)
 create mode 100644 arch/mips/include/asm/mach-ralink/spaces.h
 create mode 100644 drivers/counter/intel-qep.c
 create mode 100644 drivers/iio/accel/fxls8962af-core.c
 create mode 100644 drivers/iio/accel/fxls8962af-i2c.c
 create mode 100644 drivers/iio/accel/fxls8962af-spi.c
 create mode 100644 drivers/iio/accel/fxls8962af.h
 create mode 100644 drivers/iio/accel/sca3300.c
 create mode 100644 drivers/iio/adc/ti-tsc2046.c
 create mode 100644 drivers/iio/chemical/sps30.h
 create mode 100644 drivers/iio/chemical/sps30_i2c.c
 create mode 100644 drivers/iio/chemical/sps30_serial.c
 create mode 100644 drivers/iio/imu/st_lsm9ds0/Kconfig
 create mode 100644 drivers/iio/imu/st_lsm9ds0/Makefile
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
 create mode 100644 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
 create mode 100644 drivers/iio/light/tsl2591.c
 create mode 100644 drivers/iio/temperature/tmp117.c
 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (98%)
 rename drivers/{staging/hikey9xx => spmi}/hisi-spmi-controller.c (99%)
 delete mode 100644 drivers/staging/iio/cdc/ad7746.h
 delete mode 100644 drivers/staging/kpc2000/Kconfig
 delete mode 100644 drivers/staging/kpc2000/Makefile
 delete mode 100644 drivers/staging/kpc2000/TODO
 delete mode 100644 drivers/staging/kpc2000/kpc.h
 delete mode 100644 drivers/staging/kpc2000/kpc2000/Makefile
 delete mode 100644 drivers/staging/kpc2000/kpc2000/cell_probe.c
 delete mode 100644 drivers/staging/kpc2000/kpc2000/core.c
 delete mode 100644 drivers/staging/kpc2000/kpc2000/dma_common_defs.h
 delete mode 100644 drivers/staging/kpc2000/kpc2000/pcie.h
 delete mode 100644 drivers/staging/kpc2000/kpc2000/uapi.h
 delete mode 100644 drivers/staging/kpc2000/kpc2000_i2c.c
 delete mode 100644 drivers/staging/kpc2000/kpc2000_spi.c
 delete mode 100644 drivers/staging/kpc2000/kpc_dma/Makefile
 delete mode 100644 drivers/staging/kpc2000/kpc_dma/dma.c
 delete mode 100644 drivers/staging/kpc2000/kpc_dma/fileops.c
 delete mode 100644 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
 delete mode 100644 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
 delete mode 100644 drivers/staging/kpc2000/kpc_dma/uapi.h
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_debug.c
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_debug.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_debug.h
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_eeprom.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.h
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_debug.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_debug.h
 delete mode 100644 drivers/staging/rtl8723bs/include/autoconf.h
 delete mode 100644 drivers/staging/rtl8723bs/include/drv_conf.h
