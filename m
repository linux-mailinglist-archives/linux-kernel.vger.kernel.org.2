Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE73FDDB4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbhIAOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233922AbhIAOSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:18:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4F3161074;
        Wed,  1 Sep 2021 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630505825;
        bh=TAIcS1z8j4nTmC2/97iHA3VlAfqBK/nXDt/8aXyNADk=;
        h=Date:From:To:Cc:Subject:From;
        b=P7SuFE8qSky8/jsMS5yhJ4HO1GfjD6G3tN0Yal+FPGG+orlLuOWkrZHFjFK3zDDoF
         46QFsBX2BcUzIVHpRGlgBRb2/GQhuPgnt9QtHPPk1ejwH7xp+VHyehuuT31ucPJEwv
         eSFsTvuBMryBIfZ4dT4FojoE1ymJA8IXLmJVbu6s=
Date:   Wed, 1 Sep 2021 16:17:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging / IIO driver changes for 5.15-rc1
Message-ID: <YS+LXqoDGk0CqU1Q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.15-rc1

for you to fetch changes up to 4adb389e08c95fdf91995271932c59250ff0d561:

  staging: vt6655: Remove filenames in files (2021-08-28 09:45:10 +0200)

----------------------------------------------------------------
IIO / Staging driver update for 5.15-rc1

Here is the big set of staging and IIO driver updates for 5.15-rc1.
Also included in here are the counter driver subsystem updates as the
IIO drivers needed them.

Lots of churn in some staging drivers, we dropped the "old" rtl8188eu
driver and replaced it with a newer version of the driver that had been
maintained out-of-tree by Larry with the end goal of actually being able
to get this driver out of staging eventually.  Despite that driver being
"newer" the line count of this pull request is going up.

Some drivers moved out of staging as well, which is always nice to see,
that is why there are additions to the mfc and misc driver subsystems.
All of these were acked by the various subsystem maintainers involved.

But by far, as normal, it's coding style cleanups all over the
drivers/staging/ tree in here.

Full details of these changes are in the shortlog.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aakash Hemadri (1):
      staging: wlan-ng: fix invalid assignment warning

Agam Kohli (1):
      Staging: rt18712: hal_init: removed filename from beginning comment block

Aldas Taraškevičius (2):
      staging: vt6656: Remove filenames in files
      staging: vt6655: Remove filenames in files

Alexander Greyling (1):
      staging: rtl8712: Fix alignment

Alexander Sverdlin (1):
      iio: ep93xx: Prepare clock before using it

Alexandru Ardelean (19):
      iio: hid-sensors: bind IIO channels alloc to device object
      iio: light: adjd_s311: move buffer on adjd_s311_data object
      iio: light: adjd_s311: convert probe to device-managed functions
      iio: proximity: rfd77402: use i2c_client for rfd77402_{init,powerdown}()
      iio: proximity: rfd77402: convert probe to device-managed functions
      iio: accel: dmard10: convert probe to device-managed functions
      iio: accel: da311: convert probe to device-managed functions
      iio: accel: da280: convert probe to device-managed functions
      iio: accel: bma220: convert probe to device-managed functions
      iio: accel: bma220: make suspend state setting more robust
      iio: temperature: tmp006: convert probe to device-managed
      iio: temperature: tmp006: make sure the chip is powered up in probe
      iio: potentiometer: max5481: convert probe to device-managed
      iio: light: tcs3414: convert probe to device-managed routines
      iio: accel: adxl345: convert probe to device-managed functions
      iio: pressure: st_pressure: use devm_iio_triggered_buffer_setup() for buffer
      iio: accel: st_accel: use devm_iio_triggered_buffer_setup() for buffer
      iio: magn: st_magn: use devm_iio_triggered_buffer_setup() for buffer
      iio: gyro: st_gyro: use devm_iio_triggered_buffer_setup() for buffer

Andreas Klinger (2):
      dt-bindings: iio: chemical: Add trivial DT binding for sgp40
      iio: chemical: Add driver support for sgp40

Baptiste Mansuy (1):
      Add startup time for each chip using inv_mpu6050 driver

Benjamin Philip (7):
      staging: rtl8188eu: remove unnecessary blank lines in core/rtw_ap.c
      staging: sm750fb: Rename maxH to max_h in lynx_cursor
      staging: sm750fb: Rename maxW to max_w in lynx_cursor
      staging: sm750fb: Rename oScreen to o_screen in lynxfb_crtc
      staging: sm750fb: Rename oCursor to o_cursor in lynxfb_crtc
      staging: sm750fb: Rename vCursor to v_cursor in lynxfb_crtc
      staging: sm750fb: Rename vScreen to v_screen in lynxfb_crtc

Bryan Brattlof (2):
      staging: rtl8723bs: remove custom endian conversion macros
      staging: rtl8723bs: remove unused BT structures

Cai Huoqing (1):
      staging: r8188eu: Remove unused including <linux/version.h>

Christophe Branchereau (5):
      iio/adc: ingenic: rename has_aux2 to has_aux_md
      dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
      iio/adc: ingenic: add JZ4760 support to the sadc driver
      iio/adc: ingenic: add JZ4760B support to the sadc driver
      dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc Documentation

Christophe JAILLET (4):
      iio: buffer: Save a few cycles in 'iio_scan_mask_set()'
      iio: buffer: Move a sanity check at the beginning of 'iio_scan_mask_set()'
      staging: rtl8712: Remove some unused #define and enum
      staging: ks7010: Fix the initialization of the 'sleep_status' structure

Colin Ian King (2):
      iio: light: si1145: remove redundant continue statement
      staging: r8188eu: Fix while-loop that iterates only once

Dan Carpenter (2):
      staging: r8188eu: Fix a couple scheduling in atomic bugs
      staging: r8188eu: scheduling in atomic in rtw_createbss_cmd()

David Wu (1):
      iio: adc: rockchip_saradc: add voltage notifier so get referenced voltage once at probe

Dee-Jay Anthony Logozzo (1):
      staging: gdm724x: Place macro argument within parentheses

Diego Roux (1):
      staging: bcm2835-audio: Enclose complex macro value in parentheses

Fabio Aiuto (61):
      staging: rtl8723bs: fix wpa_set_auth_algs() function
      staging: rtl8723bs: add get_channel cfg80211 implementation
      staging: rtl8723bs: convert IsSupportedHT to snake_case
      staging: rtl8723bs: fix camel case issue
      staging: rtl8723bs: fix camel case name in macro IsLegacyOnly()
      staging: rtl8723bs: fix camel case in argument of macro is_legacy_only
      staging: rtl8723bs: fix camel case name in macro IsSupported24G
      staging: rtl8723bs: fix post-commit camel case issues
      staging: rtl8723bs: remove unused macros in include/ieee80211.h
      staging: rtl8723bs: fix camel case name in macro IsSupportedTxCCK
      staging: rtl8723bs: fix camel case argument name in macro is_supported_tx_cck
      staging: rtl8723bs: simplify function selecting channel group
      staging: rtl8723bs: fix camel case inside function
      staging: rtl8723bs: convert function name to snake case
      staging: rtl8723bs: add spaces around operator
      staging: rtl8723bs: remove 5Ghz code blocks
      staging: rtl8723bs: remove commented out condition
      staging: rtl8723bs: fix camel case in struct wlan_bssid_ex
      staging: rtl8723bs: fix camel case in struct ndis_802_11_conf
      staging: rtl8723bs: remove struct ndis_802_11_conf_fh
      staging: rtl8723bs: fix camel case in struct ndis_802_11_ssid
      staging: rtl8723bs: fix camel case in struct wlan_phy_info
      staging: rtl8723bs: fix camel case in struct wlan_bcn_info
      staging: rtl8723bs: fix camel case in IE structures
      staging: rtl8723bs: remove unused struct ndis_802_11_ai_reqfi
      staging: rtl8723bs: remove unused struct ndis_801_11_ai_resfi
      staging: rtl8723bs: fix camel case in struct ndis_802_11_wep
      staging: rtl8723bs: remove BT debug code
      staging: rtl8723bs: remove unused BT static variables
      staging: rtl8723bs: remove unused BIT macros definitions
      staging: rtl8723bs: fix camel case issue in struct wlan_bssid_ex
      staging: rtl8723bs: remove unnecessary parentheses
      staging: rtl8723bs: align condition to match open parentheses
      staging: rtl8723bs: put condition parentheses at the end of a line
      staging: rtl8723bs: remove unused macros
      staging: rtl8723bs: remove code related to unsupported MCS index values
      staging: rtl8723bs: remove unneeded loop
      staging: rtl8723bs: do some code cleaning in modified function
      staging: rtl8723bs: move function to file hal/odm_HWConfig.c
      staging: rtl8723bs: remove empty files
      staging: rtl8723bs: remove wrapping static function
      staging: rtl8723bs: beautify function ODM_PhyStatusQuery()
      staging: rtl8723bs: fix right side of condition
      staging: rtl8723bs: clean driver from unused RF paths
      staging: rtl8723bs: remove unused macros
      staging: rtl8723bs: remove unused struct member
      staging: rtl8723bs: remove rf type branching (first patch)
      staging: rtl8723bs: remove rf type branching (second patch)
      staging: rtl8723bs: remove rf type branching (third patch)
      staging: rtl8723bs: remove rf type branching (fourth patch)
      staging: rtl8723bs: remove unused rtw_rf_config module param
      staging: rtl8723bs: remove unused macro in include/hal_data.h
      staging: rtl8723bs: remove RF_*TX enum
      staging: rtl8723bs: use MAX_RF_PATH_NUM as ceiling to rf path index
      staging: rtl8723bs: fix tx power tables size
      staging: rtl8723bs: remove unused RF_*T*R enum
      staging: rtl8723bs: remove obsolete wext support
      staging: rtl8723bs: fix code indent issues
      staging: rtl8723bs: fix logical continuation issue
      staging: rtl8723bs: remove functions notifying wext events
      staging: rtl8723bs: remove unused rtw_set_802_11_bssid() function

Fabio M. De Francesco (22):
      staging: rtl8188eu: Remove unused iw_operation_mode[]
      staging: rtl8188eu: Replace a custom function with crc32_le()
      staging: rtl8188eu: Remove no more used functions and variables
      staging: rtl8723bs: core: Fix incorrect type in assignment
      staging: r8188eu: Replace a custom function with crc32_le()
      staging: r8188eu: Remove no more used functions and variables
      staging: r8188eu: Fix different base types in assignments and parameters
      staging: r8188eu: Remove set but unused variables
      staging: r8188eu: include: Remove unused const definitions
      staging: r8188eu: Fix cast between incompatible function type
      staging: r8188eu: core: Remove rtw_mfree_all_stainfo()
      staging: r8188eu: Remove unneeded comments in rtw_mp_ioctl.h
      staging: r8188eu: Fix incorrect types in arguments
      staging: r8188eu: Remove all 5GHz network types
      staging: r8188eu: Remove code related to unsupported channels
      staging: r8188eu: Remove no more necessary definitions and code
      staging: r8188eu: Remove variables and simplify PHY_SwChnl8188E()
      staging: r8188eu: os_dep: Remove defined but not used variables
      staging: r8188eu: Remove unused nat25_handle_frame()
      staging: r8188eu: Remove code depending on NAT25_LOOKUP
      staging: r8188eu: Remove empty rtw_mfree_xmit_priv_lock()
      staging: r8188eu: Provide a TODO file for this driver

Geert Uytterhoeven (1):
      staging: board: Fix uninitialized spinlock when attaching genpd

Greg Kroah-Hartman (22):
      staging: vt665X: remove unused CONFIG_PATH
      staging: r8188eu: remove empty ODM_ResetIQKResult() function
      staging: r8188eu: move ODM_TARGET_CHNL_NUM_2G_5G
      staging: r8188eu: move ODM_GetRightChnlPlaceforIQK()
      staging: r8188eu: remove include/h2clbk.h
      staging: r8188eu: remove include/autoconf.h
      staging: r8188eu: remove include/Hal8188EReg.h
      staging: r8188eu: remove rtw_mfree2d() function
      staging: r8188eu: remove rtw_buf_free() function
      staging: r8188eu: remove unused enum _NIC_VERSION
      staging: r8188eu: remove include/nic_spec.h
      staging: r8188eu: remove rtw_usb_bulk_msg() macro
      staging: r8188eu: remove rtw_usb_control_msg() macro
      staging: r8188eu: fix include directory mess
      Revert "staging: r8188eu: remove rtw_buf_free() function"
      Revert "staging: r8188eu: Fix different base types in assignments and parameters"
      Merge 5.14-rc5 into staging-next
      Merge tag 'iio-for-5.15a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
      Merge 5.14-rc6 into staging-next
      staging: r8188eu: remove inline markings from functions in rtw_br_ext.c
      staging: r8188eu: remove ipx support from driver
      Merge tag 'iio-for-5.15b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next

Gustavo A. R. Silva (1):
      staging: r8188eu: Fix fall-through warnings for Clang

Gwendal Grignou (1):
      iio: sx9310: Support ACPI property

Ivan Mikhaylov (3):
      iio: proximity: vcnl3020: add DMA safe buffer
      iio: proximity: vcnl3020: add periodic mode
      iio: proximity: vcnl3020: remove iio_claim/release_direct

Jan Gruber (2):
      staging: rtl8188eu: remove unnecessary braces
      staging: rtl8188eu: remove unnecessary logging

Jarkko Nikula (1):
      counter: intel-qep: Remove linux/bitops.h include

Jignesh Patel (1):
      staging: rtl8188eu: Line over 100 characters

Jing Yangyang (2):
      staging: r8188eu: remove unneeded conversions to bool
      staging: r8188eu: remove unneeded variable

Jonathan Cameron (15):
      dt-bindings: iio: dac: adi,ad5421: Add missing binding document.
      dt-bindings: iio: dac: adi,ad5064: Document bindings for many different DACs
      dt-bindings: iio: dac: adi,ad5360: Add missing binding document
      dt-bindings: iio: dac: ad5380: Add missing binding document
      dt-bindings: iio: dac: ad5449: Add missing binding document.
      dt-bindings: iio: dac: ad5504: Add missing binding document
      iio: dac: ad5624r: Fix incorrect handling of an optional regulator.
      dt-bindings: iio: dac: ad5624r: Add missing binding document
      dt-bindings: iio: dac: ad5686 and ad5696: Add missing binding document.
      dt-bindings: iio: dac: ad5761: Add missing binding doc.
      dt-bindings: iio: dac: adi,ad5764: Add missing binding document
      dt-bindings: iio: dac: adi,ad5791: Add missing bindings document
      dt-bindings: iio: dac: adi,ad8801: Add missing binding document.
      dt-bindings: iio: dac: microchip,mcp4922: Add missing binding document
      iio: st-sensors: Remove some unused includes and add some that should be there

Kees Cook (7):
      staging: rtl8192e: Avoid field-overflowing memcpy()
      staging: rtl8192u: Avoid field-overflowing memcpy()
      staging: rtl8723bs: Avoid field-overflowing memcpy()
      staging: rts5208: Fix get_ms_information() heap buffer size
      staging: wlan-ng: Disable buggy MIB ioctl
      staging: wlan-ng: Remove pointless a3/a4 union
      staging: wlan-ng: Avoid duplicate header in tx/rx frames

Lad Prabhakar (2):
      dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L A/D converter
      iio: adc: Add driver for Renesas RZ/G2L A/D converter

Larry Finger (36):
      staging: r8188eu: Convert header copyright info to SPDX format, part 1
      staging: r8188eu: Convert header copyright info to SPDX format, part 2
      staging: r8188eu: Convert header copyright info to SPDX format, part 3
      staging: r8188eu: Convert header copyright info to SPDX format, part 4
      staging: r8188eu: Convert header copyright info to SPDX format, part 5
      staging: r8188eu: Convert copyright header info to SPDX format, part 6
      staging: r8188eu: Remove empty header file
      staging: r8188eu: Remove tests of kernel version
      staging: r8188eu: Remove include/rtw_qos.h
      staging: r8188eu: Remove header file include/usb_hal.h
      staging: r8188eu: Remove header file include/rtw_version.h
      staging: r8188eu: Add "fallthrough" statement to quiet compiler
      staging: r8188eu: Fix sleeping function called from invalid context
      staging: r8188eu: Remove wrappers for atomic operations
      staging: r8188eu: Remove 4 empty routines from os_sep/service.c
      staging: r8188eu: Remove rtw_division64()
      staging: r8188eu: Remove wrapper around do_div
      staging: r8188eu: Remove some unused and ugly macros
      staging: r8188eu: Remove some bit manipulation macros
      staging: r8188eu: Remove wrappers for kalloc() and kzalloc()
      staging: r8188eu: Remove wrapper around vfree
      staging: r8188eu: Remove all calls to _rtw_spinlock_free()
      staging: r8188eu: Remove more empty routines
      staging: r8188eu: Remove rtw_buf_free()
      staging: r8188eu: Remove rtw_yield_os()
      staging: r8188eu: Remove wrapper routine rtw_msleep_os()
      staging: r8188eu: Remove wrapper rtw_mdelay_os()
      staging: r8188eu: Remove wrapper rtw_udelay_os()
      staging: r8188eu: Remove wrapper rtw_get_time_interval_ms()
      staging: r8188eu: Remove wrapper rtw_sleep_schedulable()
      staging: r8188eu: Fix potential memory leak or NULL dereference
      staging: r8188eu: Replace BITn with BIT(n)
      staging: r8188eu: Fix Smatch warnings for core/*.c
      staging: r8188eu: Fix smatch problems in hal/*.c
      staging: r8188eu: Fix smatch warnings in os_dep/*.c
      staging: r8188eu: Make mult-byte entities in dhcp header be big endian

Len Baker (13):
      staging/rtl8712: Remove all strcpy() uses in favor of strscpy()
      staging/most: Remove all strcpy() uses in favor of strscpy()
      staging/wlan-ng: Remove all strcpy() uses in favor of strscpy()
      staging/rtl8192e: Remove all strcpy() uses
      staging/ks7010: Remove all strcpy() uses in favor of strscpy()
      staging/rtl8192u: Remove all strcpy() uses in favor of strscpy()
      staging/vc04_services: Remove all strcpy() uses in favor of strscpy()
      staging/fbtft: Remove all strcpy() uses
      staging/fbtft: Remove unnecessary variable initialization
      staging/fbtft: Fix braces coding style
      staging/rtl8192u: Avoid CamelCase in names of variables
      staging/rtl8192u: Initialize variables in the definition block
      staging/rtl8192u: Prefer kcalloc over open coded arithmetic

Lucas Henneman (15):
      staging: vt6655: remove filename from baseband.h
      staging: vt6655: remove filename from baseband.c
      staging: vt6655: remove filename from card.c
      staging: vt6655: remove filename from card.h
      staging: vt6655: remove filename from channel.c
      staging: vt6655: remove filename from channel.h
      staging: vt6655: remove filename from device_cfg.h
      staging: vt6655: remove filename from device_main.c
      staging: vt6655: remove filename from dpc.c
      staging: vt6655: remove filename from dpc.h
      staging: vt6655: remove filename from key.c
      staging: vt6655: remove filename from key.h
      staging: vt6655: kernel style cleanup of mac.c
      staging: vt6655: remove filename from mac.h
      staging: vt6655: remove filename from upc.h

Lukas Bulwahn (3):
      MAINTAINERS: remove section HISILICON STAGING DRIVERS FOR HIKEY 960/970
      MAINTAINERS: update STAGING - REALTEK RTL8188EU DRIVERS
      clk: staging: correct reference to config IOMEM to config HAS_IOMEM

Martin Blumenstingl (3):
      iio: adc: meson-saradc: Disable BL30 integration on G12A and newer SoCs
      iio: adc: meson-saradc: Add missing space between if and parenthesis
      iio: adc: meson-saradc: Fix indentation of arguments after a line-break

Martin Kaiser (57):
      staging: rtl8188eu: merge two functions
      staging: rtl8188eu: remove the "trigger gpio 0" hal variable
      staging: rtl8188eu: remove RTL871X_HCI_TYPE enum
      staging: rtl8188eu: remove _CHIP_TYPE enum
      staging: rtl8188eu: remove struct eeprom_priv's EepromOrEfuse
      staging: rtl8188eu: remove efuse write support
      staging: rtl8188eu: remove unused power flows and transitions
      staging: rtl8188eu: remove constant function parameter
      staging: rtl8188eu: remove PWR_CMD_READ
      staging: rtl8188eu: remove cut_mask field from wl_pwr_cfg
      staging: rtl8188eu: remove unused defines
      staging: rtl8188eu: remove HW_VAR_MEDIA_STATUS1
      staging: rtl8188eu: remove HW_VAR_TXPAUSE
      staging: rtl8188eu: simplify Hal_EfuseParseMACAddr_8188EU
      staging: rtl8188eu: remove an unused enum
      staging: rtl8188eu: remove another unused enum
      staging: rtl8188eu: remove a bunch of unused defines
      staging: rtl8188eu: remove yet another unused enum
      staging: rtl8188eu: remove unused _HAL_INTF_C_ define
      staging: rtl8188eu: remove write-only power struct component
      staging: rtl8188eu: remove two write-only hal components
      staging: rtl8188eu: remove unused IntrMask
      staging: rtl8188eu: remove write-only HwRxPageSize
      staging: rtl8188eu: simplify rtl88eu_phy_iq_calibrate
      staging: rtl8188eu: simplify phy_iq_calibrate
      staging: rtl8188eu: simplify path_adda_on
      staging: rtl8188eu: simplify phy_lc_calibrate
      staging: rtl8188eu: remove unused IQKMatrixRegSetting array
      staging: r8188eu: remove RT_TRACE prints from usb_intf.c
      staging: r8188eu: remove RT_TRACE prints from usb_ops_linux.c
      staging: r8188eu: remove RT_TRACE prints from ioctl_linux.c
      staging: r8188eu: remove empty function
      staging: r8188eu: remove RT_TRACE prints from mlme_linux.c
      staging: r8188eu: remove RT_TRACE prints from os_intfs.c
      staging: r8188eu: remove an RT_TRACE print from osdep_service.c
      staging: r8188eu: remove RT_TRACE prints from recv_linux.c
      staging: r8188eu: remove RT_TRACE prints from xmit_linux.c
      staging: r8188eu: use IW_HANDLER to declare wext handlers
      staging: r8188eu: remove unused DEBUG_OID macro
      staging: r8188eu: remove the RT_TRACE macro
      staging: r8188eu: remove unused efuse hal components
      staging: r8188eu: remove unused function parameters
      staging: r8188eu: (trivial) remove a duplicate debug print
      staging: r8188eu: use proper way to build a module
      staging: r8188eu: remove CONFIG_USB_HCI from Makefile
      staging: r8188eu: ctrl vendor req value is always 0x05
      staging: r8188eu: ctrl vendor req index is not used
      staging: r8188eu: remove unnecessary cast
      staging: r8188eu: remove unused define
      staging: rtl8188eu: use actual request type as parameter
      staging: r8188eu: rewrite usb vendor request defines
      staging: r8188eu: remove an unused enum
      staging: r8188eu: clean up the usb_readXY functions
      staging: r8188eu: clean up the usb_writeXY functions
      staging: r8188eu: clean up the usb_writeN
      staging: r8188eu: remove unused members of struct _io_ops
      staging: r8188eu: set pipe only once

Mauro Carvalho Chehab (7):
      staging: hi6421-spmi-pmic: rename spmi_device struct
      staging: hi6421-spmi-pmic: rename GPIO IRQ OF node
      staging: hi6421-spmi-pmic: add a missing dot at copyright
      staging: hikey9xx: split hi6421v600 irq into a separate driver
      staging: hisilicon,hi6421-spmi-pmic.yaml: fix patternProperties
      mfd: hi6421-spmi-pmic: move driver from staging
      dt-bindings: hisilicon,hi6421-spmi-pmic.yaml: make some rules stricter

Michael Straube (92):
      staging: rtl8188eu: remove blank lines
      staging: rtl8188eu: remove braces from single line if blocks
      staging: r8188eu: rename odm_EVMdbToPercentage()
      staging: r8188eu: rename parameter of odm_evm_db_to_percentage()
      staging: r8188eu: simplify odm_evm_db_to_percentage()
      staging: r8188eu: clean up comparsions to NULL in os_dep directory
      staging: r8188eu: remove spaces before ',' and ')'
      staging: r8188eu: add missing spaces after ',' and before braces
      staging: r8188eu: clean up comparsions to NULL in hal directory
      staging: r8188eu: clean up comparsions to NULL in core directory
      staging: r8188eu: remove return from void functions
      staging: r8188eu: remove empty function odm_DynamicPrimaryCCA()
      staging: r8188eu: fix build error
      staging: r8188eu: replace custom macros with is_broadcast_ether_addr
      staging: r8188eu: remove unnecessary parentheses in os_dep dir
      staging: r8188eu: remove unnecessary parentheses in hal dir
      staging: r8188eu: remove unnecessary parentheses in core/rtw_mlme_ext.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_ap.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_wlan_util.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_led.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_p2p.c
      staging: r8188eu: clean up comparsions to true/false
      staging: r8188eu: remove unnecessary parentheses in core/rtw_mlme.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_xmit.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_sta_mgt.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_recv.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_pwrctrl.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_io.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_ioctl_set.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_cmd.c
      staging: r8188eu: remove remaining unnecessary parentheses in core dir
      staging: r8188eu: replace custom hwaddr_aton_i() with mac_pton()
      staging: r8188eu: remove 5GHz code from Hal_GetChnlGroup88E()
      staging: r8188eu: convert return type of Hal_GetChnlGroup88E() to void
      staging: r8188eu: rename parameter of Hal_GetChnlGroup88E()
      staging: r8188eu: rename Hal_GetChnlGroup88E()
      staging: r8188eu: remove ODM_GetRightChnlPlaceforIQK()
      staging: r8188eu: remove kernel version depended code paths
      staging: r8188eu: use common ieee80211 constants
      staging: r8188eu: add spaces around operators in core/rtw_ap.c
      staging: r8188eu: rewrite subtraction in core/rtw_cmd.c
      staging: r8188eu: remove unnecessary parentheses in core/rtw_cmd.c
      staging: r8188eu: clean up spacing style issues in core/rtw_cmd.c
      staging: r8188eu: clean up spacing style issues in core/rtw_efuse.c
      staging: r8188eu: clean up spacing style issues in core/rtw_ieee80211.c
      staging: r8188eu: simplify multiplication in core/rtw_ioctl_set.c
      staging: r8188eu: clean up spacing style issues in core/rtw_ioctl_set.c
      staging: r8188eu: add spaces around operators in core/rtw_iol.c
      staging: r8188eu: clean up spacing style issues in core/rtw_mlme.c
      staging: r8188eu: clean up spacing style issues in core/rtw_mlme_ext.c
      staging: r8188eu: clean up spacing style issues in core/rtw_mp.c
      staging: r8188eu: clean up spacing style issues in core/rtw_mp_ioctl.c
      staging: r8188eu: clean up spacing style issues in core/rtw_p2p.c
      staging: r8188eu: clean up spacing style issues in core/rtw_pwrctrl.c
      staging: r8188eu: clean up spacing style issues in core/rtw_recv.c
      staging: r8188eu: clean up spacing style issues in core/rtw_security.c
      staging: r8188eu: add spaces around operators in core/rtw_wlan_util.c
      staging: r8188eu: clean up spacing style issues in core/rtw_xmit.c
      staging: r8188eu: clean up spacing style issues in core/rtw_debug.c
      staging: r8188eu: add space around operator in core/rtw_sreset.c
      staging: r8188eu: clean up spacing style issues in core/rtw_sta_mgt.c
      staging: r8188eu: clean up spacing style issues in hal dir, part 1
      staging: r8188eu: clean up spacing style issues in hal dir, part 2
      staging: r8188eu: clean up spacing style issues in hal dir, part 3
      staging: r8188eu: clean up spacing style issues in os_dep dir
      staging: r8188eu: remove null pointer checks before kfree
      staging: r8188eu: clean up comparsions to true
      staging: r8188eu: clean up comparsions to false
      staging: r8188eu: fix scheduling while atomic bugs
      staging: r8188eu: use GFP_ATOMIC under spinlock
      staging: r8188eu: remove unused function rtw_add_bcn_ie()
      staging: r8188eu: remove unused function rtw_remove_bcn_ie()
      staging: rtl8723bs: remove header file ethernet.h
      staging: r8188eu: remove cmd_osdep.h header file
      staging: r8188eu: remove 5 GHz code
      staging: r8188eu: remove dead code
      staging: r8188eu: remove unnecessary parentheses
      staging: r8188eu: ensure proper alignment for eth address buffers
      staging: r8188eu: use is_multicast_ether_addr in core/rtw_mlme.c
      staging: r8188eu: use is_multicast_ether_addr in core/rtw_mp.c
      staging: r8188eu: use is_multicast_ether_addr in core/rtw_recv.c
      staging: r8188eu: use is_multicast_ether_addr in core/rtw_security.c
      staging: r8188eu: use is_multicast_ether_addr in core/rtw_xmit.c
      staging: r8188eu: use is_multicast_ether_addr in hal/rtl8188eu_xmit.c
      staging: r8188eu: use is_multicast_ether_addr in os_dep/recv_linux.c
      staging: r8188eu: remove if_ether.h header file
      staging: r8188eu: remove ip.h header file
      staging: r8188eu: remove ethernet.h header file
      staging: r8188eu: rename struct field Wifi_Error_Status
      staging: r8188eu: rename fields of struct dyn_primary_cca
      staging: r8188eu: remove ODM_DynamicPrimaryCCA_DupRTS()
      staging: r8188eu: rename fields of struct rtl_ps

Mugilraj Dhavachelvan (2):
      dt-bindings: iio: potentiometer: Add AD5110 in trivial-devices
      iio: potentiometer: Add driver support for AD5110

Nathan Chancellor (9):
      staging: r8188eu: Remove unnecessary parentheses
      staging: r8188eu: Remove self assignment in get_rx_power_val_by_reg()
      staging: r8188eu: Remove pointless NULL check in rtw_check_join_candidate()
      staging: r8188eu: os_dep: Hoist vmalloc.h include into osdep_service.h
      staging: r8188eu: Remove unused static inline functions in rtw_recv.h
      staging: r8188eu: Remove uninitialized use of ether_type in portctrl()
      staging: r8188eu: Reorganize error handling in rtw_drv_init()
      staging: r8188eu: Remove unnecessary ret variable in rtw_drv_init()
      staging: rtl8192u: Fix bitwise vs logical operator in TranslateRxSignalStuff819xUsb()

Nishal Kulkarni (1):
      staging: qlge: Remove unnecessary parentheses around references

Nuno Sá (1):
      iio: ltc2983: fix device probe

Ojaswin Mujoo (7):
      staging: vchiq: Refactor vchiq cdev code
      staging: vchiq: Move certain declarations to vchiq_arm.h
      staging: vchiq: Move vchiq char driver to its own file
      staging: vchiq: Make creation of vchiq cdev optional
      staging: vchiq: Combine vchiq platform code into single file
      staging: vchiq: Set $CONFIG_BCM2835_VCHIQ to imply $CONFIG_VCHIQ_CDEV
      staging: vchiq: Add details to Kconfig help texts

Paul Cercueil (2):
      iio: core: Forbid use of both labels and extended names
      iio: core: Support reading extended name as label

Pavel Skripkin (2):
      staging: r8188eu: make rtw_deinit_intf_priv return void
      staging: r8188eu: remove {read,write}_macreg

Phillip Potter (78):
      staging: rtl8188eu: remove set but unused variable from rtw_get_sec_ie
      staging: rtl8188eu: remove rtw_wx_set_rate handler function
      staging: rtl8188eu: move hal/mac_cfg.c and rename function and array
      staging: r8188eu: introduce new core dir for RTL8188eu driver
      staging: r8188eu: introduce new hal dir for RTL8188eu driver
      staging: r8188eu: introduce new os_dep dir for RTL8188eu driver
      staging: r8188eu: introduce new include dir for RTL8188eu driver
      staging: r8188eu: introduce new supporting files for RTL8188eu driver
      staging: r8188eu: attach newly imported driver to build system
      staging: r8188eu: remove ODM_PRINT_ADDR macro definition
      staging: r8188eu: remove ODM_dbg_* macro definitions
      staging: r8188eu: remove ODM_RT_ASSERT macro definition and caller
      staging: r8188eu: remove ODM_RT_TRACE_F macro definition
      staging: r8188eu: remove ASSERT ifndef and macro definition
      staging: r8188eu: remove ODM_RT_TRACE calls from hal/Hal8188ERateAdaptive.c
      staging: r8188eu: remove ODM_RT_TRACE calls from hal/HalPhyRf_8188e.c
      staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_HWConfig.c
      staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_RTL8188E.c
      staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_RegConfig8188E.c
      staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm.c
      staging: r8188eu: remove ODM_RT_TRACE macro definition
      staging: r8188eu: remove DbgPrint and RT_PRINTK macro definitions
      staging: r8188eu: remove include/odm_debug.h
      staging: r8188eu: correct set/defined but unused warnings from debug cleanup
      staging: rtl8188eu: remove rtl8188eu driver from staging dir
      staging: r8188eu: remove RT_PRINT_DATA macro
      staging: r8188eu: remove RT_TRACE calls from core/rtw_pwrctrl.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_wlan_util.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_ieee80211.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_io.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_led.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_mp_ioctl.c
      staging: r8188eu: remove RT_TRACE calls from hal/rtl8188eu_xmit.c
      staging: r8188eu: remove RT_TRACE calls from hal/rtl8188eu_recv.c
      staging: r8188eu: remove RT_TRACE calls from hal/HalPwrSeqCmd.c
      staging: r8188eu: remove RT_TRACE calls from hal/hal_intf.c
      staging: r8188eu: remove RT_TRACE calls from hal/rtl8188e_hal_init.c
      staging: r8188eu: remove RT_TRACE calls from hal/rtl8188e_mp.c
      staging: r8188eu: remove RT_TRACE calls from hal/usb_halinit.c
      staging: r8188eu: remove RT_TRACE calls from hal/usb_ops_linux.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_cmd.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_ioctl_set.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme_ext.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_mp.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_security.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_sta_mgt.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_xmit.c
      staging: r8188eu: remove RT_TRACE calls from core/rtw_recv.c
      staging: r8188eu: fix unused variable warnings in core/rtw_ieee80211.c
      staging: r8188eu: remove two set but unused variables in core/rtw_mp_ioctl.c
      staging: r8188eu: remove rtw_ioctl function
      staging: r8188eu: remove unused functions from os_dep/ioctl_linux.c
      staging: r8188eu: remove unused oid_null_function function
      staging: r8188eu: remove unused label from recv_indicatepkt_reorder
      staging: r8188eu: remove rtw_mfree_sta_priv_lock function
      staging: r8188eu: remove unused variable from rtl8188e_init_dm_priv
      staging: r8188eu: remove unused variable from rtw_init_drv_sw
      staging: r8188eu: remove unused variable from rtw_init_recv_timer
      staging: r8188eu: remove lines from Makefile that silence build warnings
      staging: r8188eu: remove set but unused variable from rtl8188e_Add_RateATid
      staging: r8188eu: remove unneeded DBG_88E call from rtl8188e_Add_RateATid
      staging: r8188eu: rename variable within rtl8188e_Add_RateATid
      staging: r8188eu: remove _dbg_dump_tx_info function
      staging: r8188eu: remove unused function dump_txrpt_ccx_88e
      staging: r8188eu: remove txrpt_ccx_sw_88e and txrpt_ccx_qtime_88e macros
      staging: r8188eu: remove empty function rtl8188eu_free_xmit_priv
      staging: r8188eu: remove function rtw_hal_free_xmit_priv
      staging: r8188eu: remove free_xmit_priv field from struct hal_ops
      staging: r8188eu: convert only rtw_vmalloc call to vmalloc
      staging: r8188eu: remove rtw_vmalloc preprocessor definition
      staging: r8188eu: remove function _rtw_vmalloc
      staging: r8188eu: convert all rtw_zvmalloc calls to vzalloc calls
      staging: r8188eu: remove rtw_zvmalloc preprocessor definition
      staging: r8188eu: remove function _rtw_zvmalloc
      staging: r8188eu: remove rtw_update_mem_stat macro and associated flags
      staging: r8188eu: change declaration of Efuse_Read1ByteFromFakeContent
      staging: r8188eu: add extra TODO entries

Saurav Girepunje (3):
      staging: rtl8192e: rtl8192e: rtl_core: remove unused global variable
      staging: rtl8723bs: os_dep: remove unused variable
      staging: r8188eu: core: remove condition with no effect

Scott J. Crouch (1):
      staging: rtl8723bs: Remove initialisation of globals to 0

Sergio Paracuellos (1):
      staging: mt7621-pci: fix hang when nothing is connected to pcie ports

Siddharth Manthan (2):
      dt-bindings: Add bindings for Capella cm3323 Ambient Light Sensor
      iio: light: cm3323: Add of_device_id table

Simon Xue (2):
      dt-bindings: iio: adc: rockchip-saradc: add description for rk3568
      iio: adc: rockchip_saradc: add support for rk3568 saradc

Stephan Gerhold (7):
      dt-bindings: iio: accel: bma255: Fix interrupt type
      dt-bindings: iio: accel: bma255: Sort compatibles
      dt-bindings: iio: accel: bma255: Merge bosch,bma180 schema
      dt-bindings: iio: accel: bma255: Add interrupt-names
      dt-bindings: iio: accel: bma255: Add bosch,bmc156_accel
      iio: accel: bmc150: Make it possible to configure INT2 instead of INT1
      iio: accel: bmc150: Add support for BMC156

Tang Bin (2):
      iio: adc: fsl-imx25-gcq: Use the defined variable to clean code
      iio: adc: fsl-imx25-gcq: adjust irq check to match docs and simplify code

Théo Borém Fabris (2):
      iio: dac: max5821: convert device register to device managed function
      iio: pressure: hp03: update device probe to register with devm functions

Tuo Li (1):
      staging: rtl8192e: rtl_core: Fix possible null-pointer dereference in _rtl92e_pci_disconnect()

William Breathitt Gray (6):
      counter: 104-quad-8: Return error when invalid mode during ceiling_write
      counter: Return error code on invalid modes
      counter: Standardize to ERANGE for limit exceeded errors
      counter: Rename counter_signal_value to counter_signal_level
      counter: Rename counter_count_function to counter_function
      counter: 104-quad-8: Describe member 'lock' in 'quad8'

Xiangyang Zhang (1):
      staging: r8188eu: Fix a resource leak in update_bcn_wps_ie

Yang Li (1):
      staging: r8188eu: remove unneeded semicolon

Yang Yingliang (1):
      staging: r8188eu: Use GFP_ATOMIC under spin lock

Ye Xiang (1):
      iio: hid-sensor-press: Add timestamp channel

kernel test robot (1):
      staging: r8188eu: fix duplicated inclusion

 .../ABI/testing/sysfs-bus-iio-chemical-sgp40       |   31 +
 .../bindings/iio/accel/bosch,bma180.yaml           |   61 -
 .../bindings/iio/accel/bosch,bma255.yaml           |   55 +-
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml   |   19 +
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |  134 +
 .../bindings/iio/adc/rockchip-saradc.yaml          |    1 +
 .../devicetree/bindings/iio/dac/adi,ad5064.yaml    |  268 +
 .../devicetree/bindings/iio/dac/adi,ad5360.yaml    |   79 +
 .../devicetree/bindings/iio/dac/adi,ad5380.yaml    |   70 +
 .../devicetree/bindings/iio/dac/adi,ad5421.yaml    |   51 +
 .../devicetree/bindings/iio/dac/adi,ad5449.yaml    |   97 +
 .../devicetree/bindings/iio/dac/adi,ad5504.yaml    |   50 +
 .../devicetree/bindings/iio/dac/adi,ad5624r.yaml   |   47 +
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |   75 +
 .../devicetree/bindings/iio/dac/adi,ad5761.yaml    |   60 +
 .../devicetree/bindings/iio/dac/adi,ad5764.yaml    |   62 +
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |   52 +
 .../devicetree/bindings/iio/dac/adi,ad8801.yaml    |   60 +
 .../bindings/iio/dac/microchip,mcp4922.yaml        |   46 +
 .../bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml  |   31 +-
 .../devicetree/bindings/trivial-devices.yaml       |    6 +
 MAINTAINERS                                        |   31 +-
 drivers/counter/104-quad-8.c                       |   47 +-
 drivers/counter/counter.c                          |   50 +-
 drivers/counter/ftm-quaddec.c                      |    5 +-
 drivers/counter/intel-qep.c                        |    7 +-
 drivers/counter/interrupt-cnt.c                    |   11 +-
 drivers/counter/microchip-tcb-capture.c            |   16 +-
 drivers/counter/stm32-lptimer-cnt.c                |   18 +-
 drivers/counter/stm32-timer-cnt.c                  |   10 +-
 drivers/counter/ti-eqep.c                          |   37 +-
 drivers/iio/accel/Kconfig                          |    5 +-
 drivers/iio/accel/adxl345.h                        |    1 -
 drivers/iio/accel/adxl345_core.c                   |   29 +-
 drivers/iio/accel/adxl345_i2c.c                    |    6 -
 drivers/iio/accel/adxl345_spi.c                    |    6 -
 drivers/iio/accel/bma220_spi.c                     |   79 +-
 drivers/iio/accel/bmc150-accel-core.c              |   78 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |   10 +-
 drivers/iio/accel/bmc150-accel-spi.c               |   10 +-
 drivers/iio/accel/bmc150-accel.h                   |   20 +-
 drivers/iio/accel/da280.c                          |   26 +-
 drivers/iio/accel/da311.c                          |   26 +-
 drivers/iio/accel/dmard10.c                        |   27 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   10 +-
 drivers/iio/accel/st_accel.h                       |    4 -
 drivers/iio/accel/st_accel_buffer.c                |   16 +-
 drivers/iio/accel/st_accel_core.c                  |   14 +-
 drivers/iio/accel/st_accel_i2c.c                   |    3 +-
 drivers/iio/accel/st_accel_spi.c                   |    2 +-
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ep93xx_adc.c                       |    6 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |   17 +-
 drivers/iio/adc/ingenic-adc.c                      |  102 +-
 drivers/iio/adc/meson_saradc.c                     |   20 +-
 drivers/iio/adc/rockchip_saradc.c                  |   69 +-
 drivers/iio/adc/rzg2l_adc.c                        |  600 ++
 drivers/iio/chemical/Kconfig                       |   11 +
 drivers/iio/chemical/Makefile                      |    1 +
 drivers/iio/chemical/sgp40.c                       |  378 +
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |    2 -
 drivers/iio/common/st_sensors/st_sensors_core.c    |    1 +
 drivers/iio/common/st_sensors/st_sensors_core.h    |    1 +
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |    3 +-
 drivers/iio/common/st_sensors/st_sensors_spi.c     |    3 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |    1 -
 drivers/iio/dac/ad5624r_spi.c                      |   18 +-
 drivers/iio/dac/max5821.c                          |   41 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   11 +-
 drivers/iio/gyro/st_gyro.h                         |    4 -
 drivers/iio/gyro/st_gyro_buffer.c                  |   16 +-
 drivers/iio/gyro/st_gyro_core.c                    |   15 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |    2 +-
 drivers/iio/gyro/st_gyro_spi.c                     |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   22 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   18 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   15 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |    1 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |    3 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |    3 +-
 drivers/iio/industrialio-buffer.c                  |    9 +-
 drivers/iio/industrialio-core.c                    |   33 +-
 drivers/iio/light/adjd_s311.c                      |   53 +-
 drivers/iio/light/cm3323.c                         |    7 +
 drivers/iio/light/hid-sensor-als.c                 |   11 +-
 drivers/iio/light/hid-sensor-prox.c                |   11 +-
 drivers/iio/light/si1145.c                         |    1 -
 drivers/iio/light/tcs3414.c                        |   48 +-
 drivers/iio/magnetometer/st_magn.h                 |   12 -
 drivers/iio/magnetometer/st_magn_buffer.c          |   16 +-
 drivers/iio/magnetometer/st_magn_core.c            |   17 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |    2 +-
 drivers/iio/magnetometer/st_magn_spi.c             |    2 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |   11 +-
 drivers/iio/potentiometer/Kconfig                  |   10 +
 drivers/iio/potentiometer/Makefile                 |    1 +
 drivers/iio/potentiometer/ad5110.c                 |  344 +
 drivers/iio/potentiometer/max5481.c                |   22 +-
 drivers/iio/pressure/hid-sensor-press.c            |   51 +-
 drivers/iio/pressure/hp03.c                        |   36 +-
 drivers/iio/pressure/st_pressure.h                 |    5 -
 drivers/iio/pressure/st_pressure_buffer.c          |   16 +-
 drivers/iio/pressure/st_pressure_core.c            |   16 +-
 drivers/iio/pressure/st_pressure_i2c.c             |    3 +-
 drivers/iio/pressure/st_pressure_spi.c             |    2 +-
 drivers/iio/proximity/rfd77402.c                   |   83 +-
 drivers/iio/proximity/sx9310.c                     |   48 +-
 drivers/iio/proximity/vcnl3020.c                   |  351 +-
 drivers/iio/temperature/ltc2983.c                  |   30 +-
 drivers/iio/temperature/tmp006.c                   |   53 +-
 drivers/mfd/Kconfig                                |   16 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/hi6421-spmi-pmic.c                     |   72 +
 drivers/misc/Kconfig                               |   10 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/hi6421v600-irq.c                      |  307 +
 drivers/staging/Kconfig                            |    4 +-
 drivers/staging/Makefile                           |    3 +-
 drivers/staging/board/board.c                      |    7 +-
 drivers/staging/clocking-wizard/Kconfig            |    2 +-
 drivers/staging/fbtft/fbtft-core.c                 |   23 +-
 drivers/staging/gdm724x/netlink_k.c                |    4 +-
 drivers/staging/hikey9xx/Kconfig                   |   19 -
 drivers/staging/hikey9xx/Makefile                  |    3 -
 drivers/staging/hikey9xx/TODO                      |    5 -
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c        |  311 -
 drivers/staging/ks7010/ks7010_sdio.c               |    2 +-
 drivers/staging/ks7010/ks_wlan_net.c               |   10 +-
 drivers/staging/most/video/video.c                 |    4 +-
 drivers/staging/mt7621-pci/pci-mt7621.c            |   13 +-
 drivers/staging/qlge/qlge_dbg.c                    |    4 +-
 drivers/staging/{rtl8188eu => r8188eu}/Kconfig     |    7 +-
 drivers/staging/r8188eu/Makefile                   |  106 +
 drivers/staging/r8188eu/TODO                       |   16 +
 .../staging/{rtl8188eu => r8188eu}/core/rtw_ap.c   |  763 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c          |  717 ++
 drivers/staging/r8188eu/core/rtw_cmd.c             | 2128 +++++
 drivers/staging/r8188eu/core/rtw_debug.c           |  904 +++
 drivers/staging/r8188eu/core/rtw_efuse.c           |  848 ++
 drivers/staging/r8188eu/core/rtw_ieee80211.c       | 1539 ++++
 drivers/staging/r8188eu/core/rtw_io.c              |  299 +
 drivers/staging/r8188eu/core/rtw_ioctl_set.c       |  891 +++
 drivers/staging/r8188eu/core/rtw_iol.c             |  192 +
 drivers/staging/r8188eu/core/rtw_led.c             | 1612 ++++
 .../staging/{rtl8188eu => r8188eu}/core/rtw_mlme.c | 1114 ++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        | 8327 ++++++++++++++++++++
 drivers/staging/r8188eu/core/rtw_mp.c              |  935 +++
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c        | 1170 +++
 drivers/staging/r8188eu/core/rtw_p2p.c             | 1997 +++++
 .../{rtl8188eu => r8188eu}/core/rtw_pwrctrl.c      |  354 +-
 .../staging/{rtl8188eu => r8188eu}/core/rtw_recv.c |  888 ++-
 .../staging/{rtl8188eu => r8188eu}/core/rtw_rf.c   |   34 +-
 drivers/staging/r8188eu/core/rtw_security.c        | 1656 ++++
 drivers/staging/r8188eu/core/rtw_sreset.c          |   62 +
 .../{rtl8188eu => r8188eu}/core/rtw_sta_mgt.c      |  271 +-
 .../{rtl8188eu => r8188eu}/core/rtw_wlan_util.c    |  940 ++-
 .../staging/{rtl8188eu => r8188eu}/core/rtw_xmit.c |  840 +-
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c       |   69 +
 .../hal/Hal8188ERateAdaptive.c}                    |  148 +-
 .../bb_cfg.c => r8188eu/hal/HalHWImg8188E_BB.c}    |  473 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c    |  213 +
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c     |  250 +
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c       | 1264 +++
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c         |   95 +
 .../staging/{rtl8188eu => r8188eu}/hal/hal_com.c   |  189 +-
 drivers/staging/r8188eu/hal/hal_intf.c             |  441 ++
 drivers/staging/r8188eu/hal/odm.c                  | 1968 +++++
 drivers/staging/r8188eu/hal/odm_HWConfig.c         |  567 ++
 drivers/staging/r8188eu/hal/odm_RTL8188E.c         |  337 +
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c   |   98 +
 drivers/staging/r8188eu/hal/odm_debug.c            |    6 +
 drivers/staging/r8188eu/hal/odm_interface.c        |  178 +
 .../{rtl8188eu => r8188eu}/hal/rtl8188e_cmd.c      |  422 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c          |  238 +
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    | 2304 ++++++
 drivers/staging/r8188eu/hal/rtl8188e_mp.c          |  798 ++
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      | 1105 +++
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c      |  550 ++
 .../{rtl8188eu => r8188eu}/hal/rtl8188e_rxdesc.c   |   43 +-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c      |   64 +
 .../{rtl8188eu => r8188eu}/hal/rtl8188e_xmit.c     |   13 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c        |   94 +
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c       |  117 +
 .../{rtl8188eu => r8188eu}/hal/rtl8188eu_xmit.c    |  204 +-
 .../{rtl8188eu => r8188eu}/hal/usb_halinit.c       | 1178 ++-
 drivers/staging/r8188eu/hal/usb_ops_linux.c        |  562 ++
 .../include/Hal8188EPhyCfg.h}                      |  140 +-
 drivers/staging/r8188eu/include/Hal8188EPhyReg.h   | 1072 +++
 drivers/staging/r8188eu/include/Hal8188EPwrSeq.h   |  155 +
 .../staging/r8188eu/include/Hal8188ERateAdaptive.h |   64 +
 drivers/staging/r8188eu/include/HalHWImg8188E_BB.h |   27 +
 drivers/staging/r8188eu/include/HalHWImg8188E_FW.h |   16 +
 .../staging/r8188eu/include/HalHWImg8188E_MAC.h    |   13 +
 drivers/staging/r8188eu/include/HalHWImg8188E_RF.h |   13 +
 drivers/staging/r8188eu/include/HalPhyRf_8188e.h   |   41 +
 drivers/staging/r8188eu/include/HalPwrSeqCmd.h     |  110 +
 drivers/staging/r8188eu/include/HalVerDef.h        |  149 +
 .../{rtl8188eu => r8188eu}/include/basic_types.h   |  101 +-
 drivers/staging/r8188eu/include/drv_types.h        |  323 +
 .../{rtl8188eu => r8188eu}/include/hal_com.h       |   28 +-
 drivers/staging/r8188eu/include/hal_intf.h         |  411 +
 .../{rtl8188eu => r8188eu}/include/ieee80211.h     |  680 +-
 drivers/staging/r8188eu/include/ieee80211_ext.h    |  271 +
 drivers/staging/r8188eu/include/ioctl_cfg80211.h   |   91 +
 .../{rtl8188eu => r8188eu}/include/mlme_osdep.h    |   14 +-
 drivers/staging/r8188eu/include/mp_custom_oid.h    |  333 +
 .../staging/{rtl8188eu => r8188eu}/include/odm.h   |  227 +-
 .../include/odm_HWConfig.h}                        |   37 +-
 drivers/staging/r8188eu/include/odm_RTL8188E.h     |   36 +
 .../staging/r8188eu/include/odm_RegConfig8188E.h   |   27 +
 .../staging/r8188eu/include/odm_RegDefine11AC.h    |   29 +
 drivers/staging/r8188eu/include/odm_RegDefine11N.h |  143 +
 drivers/staging/r8188eu/include/odm_interface.h    |  147 +
 .../{rtl8188eu => r8188eu}/include/odm_precomp.h   |   45 +-
 drivers/staging/r8188eu/include/odm_reg.h          |   89 +
 drivers/staging/r8188eu/include/odm_types.h        |   45 +
 drivers/staging/r8188eu/include/osdep_intf.h       |   64 +
 drivers/staging/r8188eu/include/osdep_service.h    |  315 +
 drivers/staging/r8188eu/include/recv_osdep.h       |   37 +
 .../{rtl8188eu => r8188eu}/include/rtl8188e_cmd.h  |   48 +-
 .../{rtl8188eu => r8188eu}/include/rtl8188e_dm.h   |   21 +-
 .../{rtl8188eu => r8188eu}/include/rtl8188e_hal.h  |  223 +-
 drivers/staging/r8188eu/include/rtl8188e_led.h     |   18 +
 .../{rtl8188eu => r8188eu}/include/rtl8188e_recv.h |   22 +-
 drivers/staging/r8188eu/include/rtl8188e_rf.h      |   19 +
 .../{rtl8188eu => r8188eu}/include/rtl8188e_spec.h |  457 +-
 drivers/staging/r8188eu/include/rtl8188e_sreset.h  |   15 +
 .../{rtl8188eu => r8188eu}/include/rtl8188e_xmit.h |   51 +-
 .../{rtl8188eu => r8188eu}/include/rtw_android.h   |    9 +-
 .../{rtl8188eu => r8188eu}/include/rtw_ap.h        |   18 +-
 drivers/staging/r8188eu/include/rtw_br_ext.h       |   49 +
 drivers/staging/r8188eu/include/rtw_cmd.h          |  975 +++
 drivers/staging/r8188eu/include/rtw_debug.h        |  231 +
 .../{rtl8188eu => r8188eu}/include/rtw_eeprom.h    |   32 +-
 drivers/staging/r8188eu/include/rtw_efuse.h        |  134 +
 drivers/staging/r8188eu/include/rtw_event.h        |   97 +
 drivers/staging/r8188eu/include/rtw_ht.h           |   28 +
 drivers/staging/r8188eu/include/rtw_io.h           |  367 +
 .../{rtl8188eu => r8188eu}/include/rtw_ioctl.h     |   35 +-
 drivers/staging/r8188eu/include/rtw_ioctl_rtl.h    |   63 +
 drivers/staging/r8188eu/include/rtw_ioctl_set.h    |   33 +
 drivers/staging/r8188eu/include/rtw_iol.h          |   68 +
 drivers/staging/r8188eu/include/rtw_led.h          |  181 +
 drivers/staging/r8188eu/include/rtw_mlme.h         |  632 ++
 .../{rtl8188eu => r8188eu}/include/rtw_mlme_ext.h  |  355 +-
 drivers/staging/r8188eu/include/rtw_mp.h           |  474 ++
 drivers/staging/r8188eu/include/rtw_mp_ioctl.h     |  242 +
 .../staging/r8188eu/include/rtw_mp_phy_regdef.h    | 1063 +++
 drivers/staging/r8188eu/include/rtw_p2p.h          |  119 +
 .../{rtl8188eu => r8188eu}/include/rtw_pwrctrl.h   |   75 +-
 drivers/staging/r8188eu/include/rtw_recv.h         |  413 +
 .../{rtl8188eu => r8188eu}/include/rtw_rf.h        |   37 +-
 .../{rtl8188eu => r8188eu}/include/rtw_security.h  |  168 +-
 drivers/staging/r8188eu/include/rtw_sreset.h       |   34 +
 .../{rtl8188eu => r8188eu}/include/rtw_xmit.h      |   71 +-
 .../{rtl8188eu => r8188eu}/include/sta_info.h      |   61 +-
 drivers/staging/r8188eu/include/usb_ops.h          |   72 +
 drivers/staging/r8188eu/include/usb_ops_linux.h    |   39 +
 drivers/staging/r8188eu/include/usb_osintf.h       |   29 +
 drivers/staging/r8188eu/include/usb_vendor_req.h   |   35 +
 drivers/staging/r8188eu/include/wifi.h             | 1029 +++
 .../{rtl8188eu => r8188eu}/include/wlan_bssdef.h   |  149 +-
 drivers/staging/r8188eu/include/xmit_osdep.h       |   51 +
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       | 6649 ++++++++++++++++
 drivers/staging/r8188eu/os_dep/mlme_linux.c        |  216 +
 drivers/staging/r8188eu/os_dep/os_intfs.c          | 1199 +++
 drivers/staging/r8188eu/os_dep/osdep_service.c     |  343 +
 .../{rtl8188eu => r8188eu}/os_dep/recv_linux.c     |  128 +-
 .../{rtl8188eu => r8188eu}/os_dep/rtw_android.c    |  116 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c          |  781 ++
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c     |  253 +
 .../{rtl8188eu => r8188eu}/os_dep/xmit_linux.c     |  130 +-
 drivers/staging/rtl8188eu/Makefile                 |   56 -
 drivers/staging/rtl8188eu/TODO                     |   14 -
 drivers/staging/rtl8188eu/core/rtw_cmd.c           | 1219 ---
 drivers/staging/rtl8188eu/core/rtw_efuse.c         |  876 --
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |  992 ---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c     |  512 --
 drivers/staging/rtl8188eu/core/rtw_iol.c           |   19 -
 drivers/staging/rtl8188eu/core/rtw_led.c           |  460 --
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      | 5172 ------------
 drivers/staging/rtl8188eu/core/rtw_security.c      |  869 --
 drivers/staging/rtl8188eu/core/rtw_sreset.c        |   21 -
 drivers/staging/rtl8188eu/hal/fw.c                 |  202 -
 drivers/staging/rtl8188eu/hal/hal_intf.c           |   60 -
 drivers/staging/rtl8188eu/hal/mac_cfg.c            |  120 -
 drivers/staging/rtl8188eu/hal/odm.c                |  966 ---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c       |  397 -
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c       |  335 -
 drivers/staging/rtl8188eu/hal/phy.c                | 1276 ---
 drivers/staging/rtl8188eu/hal/pwrseq.c             |   88 -
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c          |   80 -
 drivers/staging/rtl8188eu/hal/rf.c                 |  289 -
 drivers/staging/rtl8188eu/hal/rf_cfg.c             |  247 -
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c        |  217 -
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c  |  523 --
 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c      |   55 -
 drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c     |   83 -
 drivers/staging/rtl8188eu/include/HalVerDef.h      |   37 -
 drivers/staging/rtl8188eu/include/drv_types.h      |  176 -
 drivers/staging/rtl8188eu/include/fw.h             |   44 -
 .../staging/rtl8188eu/include/hal8188e_phy_reg.h   |  201 -
 .../rtl8188eu/include/hal8188e_rate_adaptive.h     |   74 -
 drivers/staging/rtl8188eu/include/hal_intf.h       |  223 -
 drivers/staging/rtl8188eu/include/mon.h            |   28 -
 drivers/staging/rtl8188eu/include/odm_rtl8188e.h   |   39 -
 drivers/staging/rtl8188eu/include/odm_types.h      |   24 -
 drivers/staging/rtl8188eu/include/osdep_intf.h     |   35 -
 drivers/staging/rtl8188eu/include/osdep_service.h  |   81 -
 drivers/staging/rtl8188eu/include/phy.h            |   26 -
 drivers/staging/rtl8188eu/include/phydm_reg.h      |   22 -
 .../staging/rtl8188eu/include/phydm_regdefine11n.h |   53 -
 drivers/staging/rtl8188eu/include/pwrseq.h         |  242 -
 drivers/staging/rtl8188eu/include/pwrseqcmd.h      |   52 -
 drivers/staging/rtl8188eu/include/recv_osdep.h     |   26 -
 drivers/staging/rtl8188eu/include/rf.h             |   12 -
 drivers/staging/rtl8188eu/include/rtw_cmd.h        |  361 -
 drivers/staging/rtl8188eu/include/rtw_efuse.h      |   67 -
 drivers/staging/rtl8188eu/include/rtw_event.h      |   81 -
 drivers/staging/rtl8188eu/include/rtw_ht.h         |   26 -
 drivers/staging/rtl8188eu/include/rtw_ioctl_set.h  |   28 -
 drivers/staging/rtl8188eu/include/rtw_iol.h        |   14 -
 drivers/staging/rtl8188eu/include/rtw_led.h        |   98 -
 drivers/staging/rtl8188eu/include/rtw_mlme.h       |  355 -
 drivers/staging/rtl8188eu/include/rtw_recv.h       |  262 -
 drivers/staging/rtl8188eu/include/rtw_sreset.h     |   30 -
 drivers/staging/rtl8188eu/include/usb_ops_linux.h  |   26 -
 drivers/staging/rtl8188eu/include/wifi.h           |  355 -
 drivers/staging/rtl8188eu/include/xmit_osdep.h     |   32 -
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     | 2780 -------
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c      |  167 -
 drivers/staging/rtl8188eu/os_dep/mon.c             |  183 -
 drivers/staging/rtl8188eu/os_dep/os_intfs.c        |  657 --
 drivers/staging/rtl8188eu/os_dep/osdep_service.c   |   63 -
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |  485 --
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c   |  644 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |    2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |    5 -
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |    4 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |   57 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |    3 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |   18 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |    4 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      |    4 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  |   49 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |    3 +-
 drivers/staging/rtl8192u/r8192U_core.c             |    2 +-
 drivers/staging/rtl8192u/r819xU_phy.c              |   92 +-
 drivers/staging/rtl8712/hal_init.c                 |    1 -
 drivers/staging/rtl8712/os_intfs.c                 |    2 +-
 drivers/staging/rtl8712/osdep_service.h            |    2 +-
 drivers/staging/rtl8712/wifi.h                     |   48 -
 drivers/staging/rtl8723bs/Kconfig                  |    3 +-
 drivers/staging/rtl8723bs/Makefile                 |    1 -
 drivers/staging/rtl8723bs/core/rtw_ap.c            |  135 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |   54 +-
 drivers/staging/rtl8723bs/core/rtw_debug.c         |   19 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |  154 +-
 drivers/staging/rtl8723bs/core/rtw_io.c            |   13 +-
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |  103 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |  263 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |  297 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          |    6 +-
 drivers/staging/rtl8723bs/core/rtw_rf.c            |    1 -
 drivers/staging/rtl8723bs/core/rtw_security.c      |   36 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  147 +-
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c    |  464 --
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.h    |    1 -
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c    |  414 -
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.h    |    1 -
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h       |    8 -
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_BB.c   |   17 +-
 drivers/staging/rtl8723bs/hal/HalHWImg8723B_RF.c   |   86 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf.c           |   67 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |  191 +-
 drivers/staging/rtl8723bs/hal/Mp_Precomp.h         |    2 -
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         |  111 +-
 drivers/staging/rtl8723bs/hal/hal_com.c            |  172 +-
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |  447 +-
 drivers/staging/rtl8723bs/hal/hal_sdio.c           |    1 -
 drivers/staging/rtl8723bs/hal/odm.c                |   56 +-
 drivers/staging/rtl8723bs/hal/odm.h                |   25 -
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c    |   36 +-
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.h    |    2 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |    5 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c       |  343 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h       |   29 +-
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c   |   23 +-
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c       |   36 -
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.h       |   14 -
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.c |    7 +-
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h |   11 +-
 drivers/staging/rtl8723bs/hal/odm_RegDefine11N.h   |    2 -
 drivers/staging/rtl8723bs/hal/odm_precomp.h        |    1 -
 drivers/staging/rtl8723bs/hal/odm_reg.h            |    4 -
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c       |   23 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c        |   12 -
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |   84 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |   52 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c    |   21 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_rxdesc.c    |    1 -
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |    3 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |    1 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       |    2 -
 drivers/staging/rtl8723bs/include/Hal8192CPhyReg.h |    4 -
 drivers/staging/rtl8723bs/include/HalVerDef.h      |   18 -
 drivers/staging/rtl8723bs/include/drv_types.h      |    9 -
 drivers/staging/rtl8723bs/include/ethernet.h       |   14 -
 drivers/staging/rtl8723bs/include/hal_btcoex.h     |    3 -
 drivers/staging/rtl8723bs/include/hal_com.h        |   35 +-
 drivers/staging/rtl8723bs/include/hal_com_phycfg.h |   20 +-
 drivers/staging/rtl8723bs/include/hal_com_reg.h    |   19 -
 drivers/staging/rtl8723bs/include/hal_data.h       |   24 +-
 drivers/staging/rtl8723bs/include/hal_pg.h         |    8 +-
 drivers/staging/rtl8723bs/include/hal_phy.h        |    3 +-
 drivers/staging/rtl8723bs/include/ieee80211.h      |   42 +-
 drivers/staging/rtl8723bs/include/osdep_service.h  |    4 -
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h  |    8 -
 drivers/staging/rtl8723bs/include/rtw_ioctl_set.h  |    1 -
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |    6 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h       |    2 +
 drivers/staging/rtl8723bs/include/rtw_rf.h         |   10 -
 drivers/staging/rtl8723bs/include/wifi.h           |    8 -
 drivers/staging/rtl8723bs/include/wlan_bssdef.h    |   92 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  173 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     | 3289 +-------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c      |    4 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |   31 +-
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c  |    1 -
 drivers/staging/rts5208/rtsx_scsi.c                |   10 +-
 drivers/staging/sm750fb/sm750.c                    |   52 +-
 drivers/staging/sm750fb/sm750.h                    |   12 +-
 drivers/staging/sm750fb/sm750_cursor.c             |    4 +-
 drivers/staging/sm750fb/sm750_hw.c                 |   62 +-
 drivers/staging/vc04_services/Kconfig              |   28 +-
 drivers/staging/vc04_services/Makefile             |    5 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  |    2 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |    2 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |  564 --
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 2330 ++----
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |   82 +
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |    2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  | 1440 ++++
 drivers/staging/vt6655/baseband.c                  |    2 -
 drivers/staging/vt6655/baseband.h                  |    2 -
 drivers/staging/vt6655/card.c                      |    1 -
 drivers/staging/vt6655/card.h                      |    2 -
 drivers/staging/vt6655/channel.c                   |    2 -
 drivers/staging/vt6655/channel.h                   |    1 -
 drivers/staging/vt6655/desc.h                      |    2 -
 drivers/staging/vt6655/device.h                    |    2 -
 drivers/staging/vt6655/device_cfg.h                |    6 +-
 drivers/staging/vt6655/device_main.c               |    2 -
 drivers/staging/vt6655/dpc.c                       |    2 -
 drivers/staging/vt6655/dpc.h                       |    2 -
 drivers/staging/vt6655/key.c                       |    2 -
 drivers/staging/vt6655/key.h                       |    2 -
 drivers/staging/vt6655/mac.c                       |    3 -
 drivers/staging/vt6655/mac.h                       |    2 -
 drivers/staging/vt6655/power.c                     |    2 -
 drivers/staging/vt6655/power.h                     |    2 -
 drivers/staging/vt6655/rf.c                        |    2 -
 drivers/staging/vt6655/rf.h                        |    2 -
 drivers/staging/vt6655/rxtx.c                      |    2 -
 drivers/staging/vt6655/rxtx.h                      |    2 -
 drivers/staging/vt6655/srom.c                      |    2 -
 drivers/staging/vt6655/srom.h                      |    2 -
 drivers/staging/vt6655/tmacro.h                    |    2 -
 drivers/staging/vt6655/upc.h                       |    2 -
 drivers/staging/vt6656/baseband.c                  |    2 -
 drivers/staging/vt6656/baseband.h                  |    2 -
 drivers/staging/vt6656/card.c                      |    1 -
 drivers/staging/vt6656/card.h                      |    2 -
 drivers/staging/vt6656/channel.c                   |    2 -
 drivers/staging/vt6656/channel.h                   |    2 -
 drivers/staging/vt6656/desc.h                      |    2 -
 drivers/staging/vt6656/device.h                    |    4 -
 drivers/staging/vt6656/key.c                       |    2 -
 drivers/staging/vt6656/key.h                       |    2 -
 drivers/staging/vt6656/mac.c                       |    2 -
 drivers/staging/vt6656/mac.h                       |    2 -
 drivers/staging/vt6656/main_usb.c                  |    2 -
 drivers/staging/vt6656/power.c                     |    2 -
 drivers/staging/vt6656/power.h                     |    2 -
 drivers/staging/vt6656/rf.c                        |    2 -
 drivers/staging/vt6656/rf.h                        |    2 -
 drivers/staging/vt6656/rxtx.c                      |    2 -
 drivers/staging/vt6656/rxtx.h                      |    2 -
 drivers/staging/vt6656/usbpipe.c                   |    2 -
 drivers/staging/vt6656/usbpipe.h                   |    2 -
 drivers/staging/vt6656/wcmd.c                      |    2 -
 drivers/staging/vt6656/wcmd.h                      |    2 -
 drivers/staging/wlan-ng/hfa384x.h                  |   19 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |   13 +-
 drivers/staging/wlan-ng/p80211conv.c               |   48 +-
 drivers/staging/wlan-ng/p80211conv.h               |    2 +-
 drivers/staging/wlan-ng/p80211hdr.h                |   30 +-
 drivers/staging/wlan-ng/p80211mgmt.h               |   24 +-
 drivers/staging/wlan-ng/p80211netdev.c             |   12 +-
 drivers/staging/wlan-ng/p80211netdev.h             |    2 +-
 drivers/staging/wlan-ng/prism2fw.c                 |    8 +-
 drivers/staging/wlan-ng/prism2mib.c                |   10 +
 drivers/staging/wlan-ng/prism2sta.c                |    6 +-
 include/dt-bindings/iio/adc/ingenic,adc.h          |    1 +
 include/linux/counter.h                            |   32 +-
 include/linux/mfd/hi6421-spmi-pmic.h               |    5 -
 507 files changed, 70255 insertions(+), 37571 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (87%)
 create mode 100644 drivers/iio/adc/rzg2l_adc.c
 create mode 100644 drivers/iio/chemical/sgp40.c
 create mode 100644 drivers/iio/potentiometer/ad5110.c
 create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
 create mode 100644 drivers/misc/hi6421v600-irq.c
 delete mode 100644 drivers/staging/hikey9xx/Kconfig
 delete mode 100644 drivers/staging/hikey9xx/Makefile
 delete mode 100644 drivers/staging/hikey9xx/TODO
 delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
 rename drivers/staging/{rtl8188eu => r8188eu}/Kconfig (63%)
 create mode 100644 drivers/staging/r8188eu/Makefile
 create mode 100644 drivers/staging/r8188eu/TODO
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_ap.c (66%)
 create mode 100644 drivers/staging/r8188eu/core/rtw_br_ext.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_cmd.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_debug.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_efuse.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_ieee80211.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_io.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_ioctl_set.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_iol.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_led.c
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_mlme.c (61%)
 create mode 100644 drivers/staging/r8188eu/core/rtw_mlme_ext.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_mp.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_mp_ioctl.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_p2p.c
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_pwrctrl.c (57%)
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_recv.c (64%)
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_rf.c (70%)
 create mode 100644 drivers/staging/r8188eu/core/rtw_security.c
 create mode 100644 drivers/staging/r8188eu/core/rtw_sreset.c
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_sta_mgt.c (60%)
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_wlan_util.c (52%)
 rename drivers/staging/{rtl8188eu => r8188eu}/core/rtw_xmit.c (65%)
 create mode 100644 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
 rename drivers/staging/{rtl8188eu/hal/hal8188e_rate_adaptive.c => r8188eu/hal/Hal8188ERateAdaptive.c} (80%)
 rename drivers/staging/{rtl8188eu/hal/bb_cfg.c => r8188eu/hal/HalHWImg8188E_BB.c} (56%)
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
 rename drivers/staging/{rtl8188eu => r8188eu}/hal/hal_com.c (63%)
 create mode 100644 drivers/staging/r8188eu/hal/hal_intf.c
 create mode 100644 drivers/staging/r8188eu/hal/odm.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_HWConfig.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_RTL8188E.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_debug.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_interface.c
 rename drivers/staging/{rtl8188eu => r8188eu}/hal/rtl8188e_cmd.c (52%)
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_dm.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_mp.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
 rename drivers/staging/{rtl8188eu => r8188eu}/hal/rtl8188e_rxdesc.c (84%)
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_sreset.c
 rename drivers/staging/{rtl8188eu => r8188eu}/hal/rtl8188e_xmit.c (55%)
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_led.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_recv.c
 rename drivers/staging/{rtl8188eu => r8188eu}/hal/rtl8188eu_xmit.c (77%)
 rename drivers/staging/{rtl8188eu => r8188eu}/hal/usb_halinit.c (53%)
 create mode 100644 drivers/staging/r8188eu/hal/usb_ops_linux.c
 rename drivers/staging/{rtl8188eu/include/hal8188e_phy_cfg.h => r8188eu/include/Hal8188EPhyCfg.h} (50%)
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPhyReg.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
 create mode 100644 drivers/staging/r8188eu/include/HalPhyRf_8188e.h
 create mode 100644 drivers/staging/r8188eu/include/HalPwrSeqCmd.h
 create mode 100644 drivers/staging/r8188eu/include/HalVerDef.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/basic_types.h (53%)
 create mode 100644 drivers/staging/r8188eu/include/drv_types.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/hal_com.h (86%)
 create mode 100644 drivers/staging/r8188eu/include/hal_intf.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/ieee80211.h (51%)
 create mode 100644 drivers/staging/r8188eu/include/ieee80211_ext.h
 create mode 100644 drivers/staging/r8188eu/include/ioctl_cfg80211.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/mlme_osdep.h (57%)
 create mode 100644 drivers/staging/r8188eu/include/mp_custom_oid.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/odm.h (86%)
 rename drivers/staging/{rtl8188eu/include/odm_hwconfig.h => r8188eu/include/odm_HWConfig.h} (69%)
 create mode 100644 drivers/staging/r8188eu/include/odm_RTL8188E.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegConfig8188E.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11AC.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11N.h
 create mode 100644 drivers/staging/r8188eu/include/odm_interface.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/odm_precomp.h (59%)
 create mode 100644 drivers/staging/r8188eu/include/odm_reg.h
 create mode 100644 drivers/staging/r8188eu/include/odm_types.h
 create mode 100644 drivers/staging/r8188eu/include/osdep_intf.h
 create mode 100644 drivers/staging/r8188eu/include/osdep_service.h
 create mode 100644 drivers/staging/r8188eu/include/recv_osdep.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_cmd.h (59%)
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_dm.h (58%)
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_hal.h (57%)
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_led.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_recv.h (56%)
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_rf.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_spec.h (71%)
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_sreset.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtl8188e_xmit.h (67%)
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_android.h (81%)
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_ap.h (80%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_br_ext.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_cmd.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_debug.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_eeprom.h (80%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_efuse.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_event.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ht.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_io.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_ioctl.h (69%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_set.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_iol.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_led.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mlme.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_mlme_ext.h (63%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp_ioctl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_p2p.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_pwrctrl.h (81%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_recv.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_rf.h (80%)
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_security.h (53%)
 create mode 100644 drivers/staging/r8188eu/include/rtw_sreset.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/rtw_xmit.h (87%)
 rename drivers/staging/{rtl8188eu => r8188eu}/include/sta_info.h (86%)
 create mode 100644 drivers/staging/r8188eu/include/usb_ops.h
 create mode 100644 drivers/staging/r8188eu/include/usb_ops_linux.h
 create mode 100644 drivers/staging/r8188eu/include/usb_osintf.h
 create mode 100644 drivers/staging/r8188eu/include/usb_vendor_req.h
 create mode 100644 drivers/staging/r8188eu/include/wifi.h
 rename drivers/staging/{rtl8188eu => r8188eu}/include/wlan_bssdef.h (65%)
 create mode 100644 drivers/staging/r8188eu/include/xmit_osdep.h
 create mode 100644 drivers/staging/r8188eu/os_dep/ioctl_linux.c
 create mode 100644 drivers/staging/r8188eu/os_dep/mlme_linux.c
 create mode 100644 drivers/staging/r8188eu/os_dep/os_intfs.c
 create mode 100644 drivers/staging/r8188eu/os_dep/osdep_service.c
 rename drivers/staging/{rtl8188eu => r8188eu}/os_dep/recv_linux.c (50%)
 rename drivers/staging/{rtl8188eu => r8188eu}/os_dep/rtw_android.c (64%)
 create mode 100644 drivers/staging/r8188eu/os_dep/usb_intf.c
 create mode 100644 drivers/staging/r8188eu/os_dep/usb_ops_linux.c
 rename drivers/staging/{rtl8188eu => r8188eu}/os_dep/xmit_linux.c (56%)
 delete mode 100644 drivers/staging/rtl8188eu/Makefile
 delete mode 100644 drivers/staging/rtl8188eu/TODO
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_cmd.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_efuse.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_ieee80211.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_iol.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_led.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_security.c
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_sreset.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/fw.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/hal_intf.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/mac_cfg.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/odm.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/odm_hwconfig.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/phy.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/pwrseq.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/pwrseqcmd.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rf.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rf_cfg.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188eu_led.c
 delete mode 100644 drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
 delete mode 100644 drivers/staging/rtl8188eu/include/HalVerDef.h
 delete mode 100644 drivers/staging/rtl8188eu/include/drv_types.h
 delete mode 100644 drivers/staging/rtl8188eu/include/fw.h
 delete mode 100644 drivers/staging/rtl8188eu/include/hal8188e_phy_reg.h
 delete mode 100644 drivers/staging/rtl8188eu/include/hal8188e_rate_adaptive.h
 delete mode 100644 drivers/staging/rtl8188eu/include/hal_intf.h
 delete mode 100644 drivers/staging/rtl8188eu/include/mon.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_rtl8188e.h
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_types.h
 delete mode 100644 drivers/staging/rtl8188eu/include/osdep_intf.h
 delete mode 100644 drivers/staging/rtl8188eu/include/osdep_service.h
 delete mode 100644 drivers/staging/rtl8188eu/include/phy.h
 delete mode 100644 drivers/staging/rtl8188eu/include/phydm_reg.h
 delete mode 100644 drivers/staging/rtl8188eu/include/phydm_regdefine11n.h
 delete mode 100644 drivers/staging/rtl8188eu/include/pwrseq.h
 delete mode 100644 drivers/staging/rtl8188eu/include/pwrseqcmd.h
 delete mode 100644 drivers/staging/rtl8188eu/include/recv_osdep.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rf.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_cmd.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_efuse.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_event.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_ht.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_ioctl_set.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_iol.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_led.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_mlme.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_recv.h
 delete mode 100644 drivers/staging/rtl8188eu/include/rtw_sreset.h
 delete mode 100644 drivers/staging/rtl8188eu/include/usb_ops_linux.h
 delete mode 100644 drivers/staging/rtl8188eu/include/wifi.h
 delete mode 100644 drivers/staging/rtl8188eu/include/xmit_osdep.h
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/mlme_linux.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/mon.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/os_intfs.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/osdep_service.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/usb_intf.c
 delete mode 100644 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_RTL8723B.h
 delete mode 100644 drivers/staging/rtl8723bs/include/ethernet.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
