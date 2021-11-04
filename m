Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7225445383
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhKDNIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhKDNIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:08:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90DC660F9D;
        Thu,  4 Nov 2021 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636031163;
        bh=USkhxGiCg8N2GFKj/4jNlDShUI/JoS9yBKQeisRG8FA=;
        h=Date:From:To:Cc:Subject:From;
        b=GJnCiwlYaKoOOsjxodHMbcyKCzzhVCtajw3/ZX5/7h9EuzHJQ7uA2vsxeE1qCXGCr
         SbEuXxIurgMWavKRpihXCtAKJWw1wXVKOTn619+c0PBEpCWARDkSHYgHAu1S3T5GaN
         FO3a8JX4eQUI4txkZPhgxSLsPmzYgzWD37M/uN8k=
Date:   Thu, 4 Nov 2021 14:06:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 5.16-rc1
Message-ID: <YYPauAJfmnePbPF5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.16-rc1

for you to fetch changes up to 10508ae08ed8ce8794785194ad7309f1437d43fd:

  staging: r8188eu: hal: remove goto statement and local variable (2021-10-30 11:15:55 +0200)

----------------------------------------------------------------
Staging driver update for 5.16-rc1

Here is the big set of staging driver updates and cleanups for 5.16-rc1.

Overall we ended up removing a lot of code this time, a bit over 20,000
lines are now gone thanks to a lot of cleanup work by many developers.

Nothing huge in here functionality wise, just loads of cleanups:
	- r8188eu driver major cleanups and removal of unused and dead
	  code
	- wlan-ng minor cleanups
	- fbtft driver cleanups
	- most driver cleanups
	- rtl8* drivers cleanups
	- rts5208 driver cleanups
	- vt6655 driver cleanups
	- vc04_services drivers cleanups
	- wfx cleanups on the way to almost getting this merged out of
	  staging (it's close!)
	- tiny mips changes needed for the mt7621 drivers, they have
	  been acked by the respective subsystem maintainers to go
	  through this tree.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajith P V (1):
      staging: fieldbus: anybus: reframe comment to avoid warning

Aldas Taraškevičius (1):
      staging: wlan-ng: Remove filenames from files

Benjamin Philip (9):
      staging: rts5208: remove unnecessary parentheses in ms.c
      staging: rts5208: remove unnecessary parentheses in rtsx_card.c
      staging: rts5208: remove unnecessary parentheses in rtsx.c
      staging: rts5208: remove unnecessary parentheses in rtsx_chip.c
      staging: rts5208: remove unnecessary parentheses in rtsx_transport.c
      staging: rts5208: remove unnecessary parentheses in sd.c
      staging: rts5208: remove unnecessary parentheses in xd.c
      staging: rts5208: remove unnecessary parentheses in rtsx_scsi.c
      staging: rts5208: remove parentheses pair in sd.c

Bryan Brattlof (1):
      staging: rtl8723bs: ignore unused wiphy_wowlan object warnings

Changcheng Deng (1):
      staging: r8188eu: use swap()

Colin Ian King (1):
      staging: r8188eu: remove redundant variable hoffset

Dawid Esterhuizen (1):
      staging: rtl8712: Statements should start on a tabstop

Fabio Aiuto (5):
      staging: rtl8723bs: unwrap initialization of queues
      staging: rtl8723bs: remove unnecessary parentheses
      staging: rtl8723bs: remove unused _rtw_init_queue() function
      staging: rtl8723bs: remove possible deadlock when disconnect
      staging: rtl8723bs: remove possible deadlock when disconnect (v2)

Fabio M. De Francesco (23):
      staging: r8188eu: Remove _enter/_exit_critical_mutex()
      staging: r8188eu: remove unnedeed parentheses in usbctrl_vendorreq()
      staging: r8188eu: remove unnecessary space in usbctrl_vendorreq()
      staging: r8188eu: clean up symbols in usbctrl_vendorreq()
      staging: r8188eu: reorder declarations in usbctrl_vendorreq()
      staging: r8188eu: remove test in usbctrl_vendorreq()
      staging: r8188eu: reorder comments in usbctrl_vendorreq()
      staging: r8188eu: remove a comment from usbctrl_vendorreq()
      staging: r8188eu: rename symbols in rtw_read*() and rtw_write*()
      staging: r8188eu: remove casts from rtw_{read,write}*()
      staging: r8188eu: change the type of a variable in rtw_write16()
      staging: r8188eu: remove a buffer from rtw_writeN()
      staging: r8188eu: remove a bitwise AND from rtw_writeN()
      staging: r8188eu: change the type of a variable in rtw_read16()
      staging: r8188eu: Remove a test from usbctrl_vendorreq()
      staging: r8188eu: call new usb_read() from rtw_read{8,16,32}()
      staging: r8188eu: call new usb_write() from rtw_write{8,16,32,N}()
      staging: r8188eu: Use completions for signaling start / end kthread
      staging: r8188eu: Use completions for signaling enqueueing
      staging: r8188eu: Remove redundant 'if' statement
      staging: r8188eu: Remove initialized but unused semaphore
      staging: r8188eu: Remove unused semaphore "io_retevt"
      staging: r8188eu: Use a Mutex instead of a binary Semaphore

Gaston Gonzalez (21):
      staging: vchiq_dev: remove braces from if block
      staging: vchiq_dev: cleanup code alignment issues
      staging: vchiq: remove braces from if block
      staging: vchiq: add braces to if block
      staging: vchiq: cleanup code alignment issues
      staging: vchiq_arm: cleanup code alignment issues
      staging: vchiq_arm: remove unnecessary space in cast
      staging: vchiq_arm: clarify multiplication expressions
      staging: vchiq_arm: cleanup blank lines
      staging: vchiq_arm: fix quoted strings split across lines
      staging: vchiq_arm: remove extra blank line
      staging: vchiq_arm: use __func__ to get function name in debug message
      staging: vchiq_core: cleanup blank lines
      staging: vchiq_core: cleanup code alignment issues
      staging: vchiq_core.h: fix CamelCase in function declaration
      staging: vchiq_core.h: use preferred kernel types
      staging: vchiq: drop trailing semicolon in macro definition
      staging: vchiq_core: drop extern prefix in function declarations
      staging: vchiq_core: cleanup lines that end with '(' or '['
      staging: vchiq_core: fix quoted strings split across lines
      staging: vchiq_core: get rid of typedef

Greg Kroah-Hartman (5):
      staging: vchiq: convert to use a miscdevice
      staging: axis-fifo: convert to use miscdevice
      Revert "staging: rtl8723bs: remove possible deadlock when disconnect"
      Merge branch 5.15-rc3 into staging-next
      Merge 5.15-rc6 into staging-next

Gustavo A. R. Silva (3):
      staging: rtl8723bs: Replace zero-length array with flexible-array member
      staging: r8188eu: Replace zero-length array with flexible-array member
      staging: r8188eu: Use zeroing allocator in wpa_set_encryption()

Hans de Goede (2):
      staging: rtl8723bs: remove a second possible deadlock
      staging: rtl8723bs: remove a third possible deadlock

Jakub Kicinski (8):
      staging: use eth_hw_addr_set()
      staging: use eth_hw_addr_set() instead of ether_addr_copy()
      staging: use eth_hw_addr_set() for dev->addr_len cases
      staging: qlge: use eth_hw_addr_set()
      staging: rtl8712: prepare for const netdev->dev_addr
      staging: unisys: use eth_hw_addr_set()
      staging: rtl: use eth_hw_addr_set()
      staging: use eth_hw_addr_set() in orphan drivers

Johan Hovold (2):
      staging: rtl8192u: fix control-message timeouts
      staging: r8712u: fix control-message timeout

Julian Braha (1):
      staging: rtl8723bs: fix unmet dependency on CRYPTO for CRYPTO_LIB_ARC4

Jérôme Pouiller (32):
      staging: wfx: use abbreviated message for "incorrect sequence"
      staging: wfx: do not send CAB while scanning
      staging: wfx: ignore PS when STA/AP share same channel
      staging: wfx: wait for SCAN_CMPL after a SCAN_STOP
      staging: wfx: avoid possible lock-up during scan
      staging: wfx: drop unused argument from hif_scan()
      staging: wfx: fix atomic accesses in wfx_tx_queue_empty()
      staging: wfx: take advantage of wfx_tx_queue_empty()
      staging: wfx: declare support for TDLS
      staging: wfx: fix support for CSA
      staging: wfx: relax the PDS existence constraint
      staging: wfx: simplify API coherency check
      staging: wfx: update with the firmware API 3.8
      staging: wfx: uniformize counter names
      staging: wfx: fix misleading 'rate_id' usage
      staging: wfx: declare variables at beginning of functions
      staging: wfx: simplify hif_join()
      staging: wfx: reorder function for slightly better eye candy
      staging: wfx: fix error names
      staging: wfx: apply naming rules in hif_tx_mib.c
      staging: wfx: remove unused definition
      staging: wfx: remove useless debug statement
      staging: wfx: fix space after cast operator
      staging: wfx: remove references to WFxxx in comments
      staging: wfx: update files descriptions
      staging: wfx: reformat comment
      staging: wfx: avoid c99 comments
      staging: wfx: fix comments styles
      staging: wfx: remove useless comments after #endif
      staging: wfx: explain the purpose of wfx_send_pds()
      staging: wfx: indent functions arguments
      staging: wfx: ensure IRQ is ready before enabling it

Kai Song (1):
      staging: r8188eu: Use kmemdup() to replace kmalloc + memcpy

Karolina Drobnik (17):
      staging: vt6655: Rename byPreambleType field
      staging: vt6655: Rename `by_preamble_type` parameter
      staging: vt6655: Rename `dwAL2230InitTable` array
      staging: vt6655: Use named constants when checking preamble type
      staging: vt6655: Rename `ii` variable
      staging: vt6655: Rename `byInitCount` variable
      staging: vt6655: Rename `bySleepCount` variable
      staging: vt6655: Rename `uChannel` variable
      staging: vt6655: Rename `byRFType` variable
      staging: vt6655: Rename `dwAL2230ChannelTable0` array
      staging: vt6655: Rename `dwAL2230ChannelTable1` array
      staging: vt6655: Rename `dwAL7230ChannelTable0` array
      staging: vt6655: Rename `dwAL7230ChannelTable1` array
      staging: vt6655: Rename `dwAL7230ChannelTable2` array
      staging: vt6655: Rename `dwAL7230InitTableAMode` array
      staging: vt6655: Rename `dwAL2230PowerTable` array
      staging: vt6655: Rename `dwAL7230InitTable` array

Krish Jain (1):
      staging/mt7621-dma: Format lines in "hsdma-mt7621.c" ending with an open parenthesis

Krzysztof Kozlowski (1):
      staging; wlan-ng: remove duplicate USB device ID

Kushal Kothari (5):
      staging: rtl8723bs: core: Remove true and false comparison
      staging: rtl8723bs: core: Remove true and false comparison
      staging: rtl8723bs: core: Remove unnecessary parentheses
      staging: rtl8723bs: core: Remove unnecessary space after a cast
      staging: rtl8723bs: core: Remove unnecessary blank lines

Larry Finger (3):
      staging: r8188eu: Remove conditionals CONFIG_88EU_{AP_MODE,P2P}
      staging: r8188eu: Remove mp, a.k.a. manufacturing process, code
      staging: r8188eu: Remove unused macros and defines from odm.h

Longji Guo (1):
      staging: rtl8723bs: remove meaningless pstat->passoc_req check in OnAssocReq()

Martin Kaiser (85):
      staging: r8188eu: remove unused function prototype
      staging: r8188eu: remove unused define
      staging: r8188eu: this endless loop is executed only once
      staging: r8188eu: remove write-only variable bLCKInProgress
      staging: r8188eu: remove unused function usb_endpoint_is_int
      staging: r8188eu: remove unused function RT_usb_endpoint_is_bulk_in
      staging: r8188eu: remove unused function RT_usb_endpoint_num
      staging: r8188eu: remove the remaining usb endpoint functions
      staging: r8188eu: btcoex_rfon is always false
      staging: r8188eu: setting HW_VAR_SET_RPWM does nothing
      staging: r8188eu: remove write-only variable cpwm
      staging: r8188eu: remove write-only variable tog
      staging: r8188eu: bHWPwrPindetect is always false
      staging: r8188eu: remove rtw_hw_suspend
      staging: r8188eu: remove rtw_set_rpwm
      staging: r8188eu: remove unused power state defines
      staging: r8188eu: _free_pwrlock is empty
      staging: r8188eu: remove unused pwrctrl definitions
      staging: r8188eu: remove unused enum and array
      staging: r8188eu: rtw_set_ips_deny is not used
      staging: r8188eu: remove unused variable cpwm_tog
      staging: r8188eu: remove unused variable b_hw_radio_off
      staging: r8188eu: brfoffbyhw is always false
      staging: r8188eu: remove rtw_hw_resume
      staging: r8188eu: remove rtw_free_pwrctrl_priv prototype
      staging: r8188eu: remove the HW_VAR_CHECK_TXBUF "hal variable"
      staging: r8188eu: do not write past the end of an array
      staging: r8188eu: remove an obsolete comment
      staging: r8188eu: remove unused led component
      staging: r8188eu: remove write-only HwRxPageSize
      staging: r8188eu: remove unused IntrMask
      staging: r8188eu: remove two write-only hal components
      staging: r8188eu: HardwareType is write-only
      staging: r8188eu: chip_type is write-only
      staging: r8188eu: interface type is always usb
      staging: r8188eu: support interface is always usb
      staging: r8188eu: hal data's customer id is always 0
      staging: r8188eu: Odm PatchID is always 0
      staging: r8188eu: merge two signal scale mapping functions
      staging: r8188eu: remove an unused define
      staging: r8188eu: remove specific device table
      staging: r8188eu: RfOnOffDetect is unused
      staging: r8188eu: remove odm fab version info
      staging: r8188eu: remove odm cut version info
      staging: r8188eu: remove odm dualmac smart concurrent info
      staging: r8188eu: remove odm wifi test info
      staging: r8188eu: remove odm hct test info
      staging: r8188eu: remove odm ext trsw info
      staging: r8188eu: remove odm ext pa info
      staging: r8188eu: remove odm ext lna info
      staging: r8188eu: remove dm_CheckStatistics
      staging: r8188eu: simplify rtl8188e_HalDmWatchDog
      staging: r8188eu: remove rtl8188e_deinit_dm_priv
      staging: r8188eu: remove LastMinUndecoratedPWDBForDM
      staging: r8188eu: SupportICType is always ODM_RTL8188E
      staging: r8188eu: remove odm_SwAntDivInit
      staging: r8188eu: odm BoardType is never set
      staging: r8188eu: odm SupportPlatform is always ODM_CE
      staging: r8188eu: remove empty trigger gpio code
      staging: r8188eu: interface type is always usb
      staging: r8188eu: remove two checks that are always false
      staging: r8188eu: remove unused function prototypes
      staging: r8188eu: PHY_SetRFPathSwitch_8188E is not used
      staging: r8188eu: clean up Hal8188EPhyCfg.h
      staging: r8188eu: remove procfs functions
      staging: r8188eu: CurrentWirelessMode is not used
      staging: r8188eu: remove unused components in pwrctrl_priv
      staging: r8188eu: remove BT_COEXIST settings from Makefile
      staging: r8188eu: res_to_status is unused
      staging: r8188eu: daemonize is not defined
      staging: r8188eu: don't accept SIGTERM for cmd thread
      staging: r8188eu: Makefile: remove unused driver config
      staging: r8188eu: Makefile: don't overwrite global settings
      staging: r8188eu: Makefile: use one file list
      staging: r8188eu: fix memleak in rtw_wx_set_enc_ext
      staging: r8188eu: remove unused dm_priv components
      staging: r8188eu: odm_rate_adapt Type is constant
      staging: r8188eu: use helper to check for broadcast address
      staging: r8188eu: use helper to set broadcast address
      staging: r8188eu: remove unused defines and enums
      staging: r8188eu: silent_reset_inprogress is never read
      staging: r8188eu: wifi_error_status is write-only
      staging: r8188eu: silentreset_mutex is unused
      staging: r8188eu: remove last_tx_complete_time
      staging: r8188eu: remove the sreset_priv structure

Michael Straube (285):
      staging: rtl8723bs: clean up comparsions to NULL
      staging: r8188eu: remove rtl8188e_PHY_ConfigRFWithHeaderFile()
      staging: r8188eu: remove rtl8188e_PHY_ConfigRFWithParaFile()
      staging: r8188eu: remove rtw_get_oper_bw()
      staging: r8188eu: remove rtw_get_oper_choffset()
      staging: r8188eu: remove get_bsstype()
      staging: r8188eu: remove CAM_empty_entry()
      staging: r8188eu: remove is_ap_in_wep()
      staging: r8188eu: remove should_forbid_n_rate()
      staging: r8188eu: convert type of second parameter of rtw_*_encrypt()
      staging: r8188eu: convert type of second parameter of rtw_*_decrypt()
      staging: r8188eu: remove unnecessary type casts
      staging: r8188eu: remove local variable Indexforchannel
      staging: r8188eu: refactor field of struct odm_rf_cal
      staging: r8188eu: remove unused constants from wifi.h
      staging: r8188eu: remove commented constants from wifi.h
      staging: r8188eu: remove Hal_MPT_CCKTxPowerAdjustbyIndex()
      staging: r8188eu: remove set but unused variable
      staging: r8188eu: remove ICType from struct HAL_VERSION
      staging: r8188eu: remove unused function SetBcnCtrlReg()
      staging: r8188eu: use mac_pton() in rtw_macaddr_cfg()
      staging: r8188eu: ensure mac address buffer is properly aligned
      staging: r8188eu: use ETH_ALEN
      staging: r8188eu: use is_*_ether_addr() in rtw_macaddr_cfg()
      staging: r8188eu: use random default mac address
      staging: r8188eu: use ether_addr_copy() in rtw_macaddr_cfg()
      staging: r8188eu: add missing blank line after declarations
      staging: r8188eu: remove unnecessary parentheses
      staging: r8188eu: remove header file rtw_ioctl_rtl.h
      staging: r8188eu: remove unused defines from mp_custom_oid.h
      staging: r8188eu: remove unused enum from ieee80211.h.
      staging: r8188eu: remove unused enum rt_eeprom_type
      staging: r8188eu: remove IS_HARDWARE_TYPE_8188* macros
      staging: r8188eu: remove enum hardware_type
      staging: r8188eu: remove unused constant CRC32_POLY
      staging: r8188eu: use in-kernel arc4 encryption
      staging: r8188eu: remove rtw_use_tkipkey_handler()
      staging: r8188eu: remove intf_chip_configure from hal_ops
      staging: r8188eu: remove read_adapter_info from hal_ops
      staging: r8188eu: remove read_chip_version from hal_ops
      staging: r8188eu: remove wrapper around ReadChipVersion8188E()
      staging: r8188eu: remove GetHalODMVarHandler from hal_ops
      staging: r8188eu: remove init_default_value from hal_ops
      staging: r8188eu: remove InitSwLeds from hal_ops
      staging: r8188eu: remove DeInitSwLeds from hal_ops
      staging: r8188eu: remove dm_init from hal_ops
      staging: r8188eu: remove dm_deinit from hal_ops
      staging: r8188eu: remove SetHalODMVarHandler from hal_ops
      staging: r8188eu: remove empty functions
      staging: r8188eu: remove unused function rtw_interface_ps_func()
      staging: r8188eu: remove interface_ps_func from hal_ops
      staging: r8188eu: remove hal_dm_watchdog from hal_ops
      staging: r8188eu: remove set_bwmode_handler from hal_ops
      staging: r8188eu: remove set_channel_handler from hal_ops
      staging: r8188eu: remove unused enum hal_intf_ps_func
      staging: r8188eu: remove Add_RateATid from hal_ops
      staging: r8188eu: remove hal_power_on from hal_ops
      staging: r8188eu: remove sreset_init_value from hal_ops
      staging: r8188eu: remove sreset_reset_value from hal_ops
      staging: r8188eu: remove silentreset from hal_ops
      staging: r8188eu: remove sreset_xmit_status_check from hal_ops
      staging: r8188eu: remove sreset_linked_status_check from hal_ops
      staging: r8188eu: remove sreset_get_wifi_status from hal_ops
      staging: r8188eu: remove EfusePowerSwitch from hal_ops
      staging: r8188eu: rename hal_EfusePowerSwitch_RTL8188E()
      staging: r8188eu: remove wrapper Efuse_PowerSwitch()
      staging: r8188eu: remove ReadEFuse from hal_ops
      staging: r8188eu: remove EFUSEGetEfuseDefinition from hal_ops
      staging: r8188eu: remove EfuseGetCurrentSize from hal_ops
      staging: r8188eu: remove empty comments
      staging: r8188eu: remove Efuse_PgPacketRead from hal_ops
      staging: r8188eu: remove Efuse_PgPacketWrite from hal_ops
      staging: r8188eu: remove Efuse_WordEnableDataWrite from hal_ops
      staging: r8188eu: remove useless assignment
      staging: r8188eu: remove AntDivBeforeLinkHandler from hal_ops
      staging: r8188eu: remove AntDivCompareHandler from hal_ops
      staging: r8188eu: remove empty function rtl8188e_start_thread()
      staging: r8188eu: remove empty function rtl8188e_stop_thread()
      staging: r8188eu: remove hal_notch_filter from hal_ops
      staging: r8188eu: remove free_hal_data from hal_ops
      staging: r8188eu: remove unused function rtl8188e_clone_haldata()
      staging: r8188eu: remove SetBeaconRelatedRegistersHandler from hal_ops
      staging: r8188eu: remove UpdateHalRAMask8188EUsb from hal_ops
      staging: r8188eu: remove unused function Hal_ProSetCrystalCap()
      staging: r8188eu: remove unused PHY_GetTxPowerLevel8188E()
      staging: r8188eu: remove unused PHY_ScanOperationBackup8188E()
      staging: r8188eu: remove unused PHY_UpdateTxPowerDbm8188E()
      staging: r8188eu: remove unused rtl8192c_PHY_GetHWRegOriginalValue()
      staging: r8188eu: remove unused odm_Init_RSSIForDM()
      staging: r8188eu: remove unused ODM_MacStatusQuery()
      staging: r8188eu: remove unused macro READ_AND_CONFIG_TC
      staging: r8188eu: remove unused macro ROUND
      staging: rtl8723bs: remove unused macros from ioctl_linux.c
      staging: r8188eu: remove IOL_exec_cmds_sync() from struct hal_ops
      staging: r8188eu: remove wrapper rtw_IOL_exec_cmds_sync()
      staging: r8188eu: remove rtw_IOL_append_LLT_cmd()
      staging: r8188eu: remove empty ODM_ReleaseTimer()
      staging: r8188eu: remove unused ODM_AcquireSpinLock()
      staging: r8188eu: remove unused ODM_ReleaseSpinLock()
      staging: r8188eu: remove unused ODM_FillH2CCmd()
      staging: r8188eu: remove unused ODM_sleep_us()
      staging: r8188eu: remove unused ODM_InitializeWorkItem()
      staging: r8188eu: remove unused ODM_StartWorkItem()
      staging: r8188eu: remove unused ODM_StopWorkItem()
      staging: r8188eu: remove unused ODM_FreeWorkItem()
      staging: r8188eu: remove unused ODM_ScheduleWorkItem()
      staging: r8188eu: remove unused ODM_IsWorkItemScheduled()
      staging: r8188eu: remove unused ODM_SetTimer()
      staging: r8188eu: remove unused ODM_Read2Byte()
      staging: r8188eu: remove unused ODM_FreeMemory()
      staging: r8188eu: remove unused ODM_AllocateMemory()
      staging: r8188eu: remove unused prototype ODM_InitializeTimer()
      staging: r8188eu: remove unused ODM_CancelAllTimers()
      staging: r8188eu: remove unused ODM_InitAllTimers()
      staging: r8188eu: remove mgnt_xmit from struct hal_ops
      staging: r8188eu: remove hal_xmit from struct hal_ops
      staging: r8188eu: remove read_bbreg from struct hal_ops
      staging: r8188eu: remove write_bbreg from struct hal_ops
      staging: r8188eu: remove read_rfreg from struct hal_ops
      staging: r8188eu: remove write_rfreg from struct hal_ops
      staging: r8188eu: remove rtl8188e_set_hal_ops()
      staging: r8188eu: remove header file HalHWImg8188E_FW.h
      staging: r8188eu: remove macro GET_EEPROM_EFUSE_PRIV
      staging: r8188eu: remove unused register definitions from odm_reg.h
      staging: r8188eu: remove header file odm_reg.h
      staging: r8188eu: remove unused enum RT_SPINLOCK_TYPE
      staging: r8188eu: remove unused defines from odm_types.h
      staging: r8188eu: remove unnecessary include from odm_types.h
      staging: r8188eu: remove unused enum odm_bt_coexist
      staging: r8188eu: remove unused ODM_RASupport_Init()
      staging: r8188eu: remove RaSupport88E from struct odm_dm_struct
      staging: r8188eu: remove dead code from odm_RxPhyStatus92CSeries_Parsing()
      staging: r8188eu: remove unused macros from rtl8188e_hal.h
      staging: r8188eu: remove write-only fields from struct hal_data_8188e
      staging: r8188eu: remove unused enums from rtl8188e_hal.h
      staging: r8188eu: remove unused field from struct hal_data_8188e
      staging: r8188eu: remove IS_1T1R, IS_1T2R, IS_2T2R macros
      staging: r8188eu: remove if test that is always true
      staging: r8188eu: remove NumTotalRFPath from struct hal_data_8188e
      staging: r8188eu: remove switches from phy_RF6052_Config_ParaFile()
      staging: r8188eu: remove ap_sta_info_defer_update()
      staging: r8188eu: remove rtw_acl_add_sta()
      staging: r8188eu: remove rtw_acl_remove_sta()
      staging: r8188eu: remove rtw_ap_inform_ch_switch()
      staging: r8188eu: remove rtw_check_beacon_data()
      staging: r8188eu: remove rtw_set_macaddr_acl()
      staging: r8188eu: remove odm_ConfigRF_RadioB_8188E()
      staging: r8188eu: remove ODM_DIG_LowerBound_88E()
      staging: r8188eu: remove rtl8188e_RF_ChangeTxPath()
      staging: r8188eu: remove unused struct rf_shadow
      staging: r8188eu: remove HalDetectPwrDownMode88E()
      staging: r8188eu: remove rtw_IOL_cmd_tx_pkt_buf_dump()
      staging: r8188eu: remove rtl8188e_set_rssi_cmd()
      staging: r8188eu: remove EFUSE_Read1Byte()
      staging: r8188eu: remove comments from odm_interface.h
      staging: r8188eu: remove unused macros from odm_interface.h
      staging: r8188eu: remove _ic_type from macro _cat in odm_interface.h
      staging: r8188eu: remove dead code from ODM_Write_DIG()
      staging: r8188eu: remove unnecessary if statement
      staging: r8188eu: remove more dead code from ODM_Write_DIG()
      staging: r8188eu: remove macro ODM_REG
      staging: r8188eu: remove macro ODM_BIT
      staging: r8188eu: remove unnecessary if statements
      staging: r8188eu: remove dead code from odm.c
      staging: r8188eu: remove macros ODM_IC_11{N,AC}_SERIES
      staging: r8188eu: remove header file odm_RegDefine11AC.h
      staging: r8188eu: remove unused defines from odm_RegDefine11N.h
      staging: r8188eu: clean up indentation in odm_RegDefine11N.h
      staging: r8188eu: remove ODM_SingleDualAntennaDetection()
      staging: r8188eu: remove EFUSE_ShadowRead()
      staging: r8188eu: remove efuse_GetCurrentSize()
      staging: r8188eu: remove efuse_GetMaxSize()
      staging: r8188eu: remove rtw_BT_efuse_map_write()
      staging: r8188eu: remove rtw_efuse_access()
      staging: r8188eu: remove rtw_efuse_map_write()
      staging: r8188eu: remove rtw_BT_efuse_map_read()
      staging: r8188eu: remove rtw_efuse_map_read()
      staging: r8188eu: remove _rtw_dequeue_network()
      staging: r8188eu: remove _rtw_enqueue_network()
      staging: r8188eu: remove rtw_get_timestampe_from_ie()
      staging: r8188eu: remove rtw_scan_abort()
      staging: r8188eu: remove issue_action_spct_ch_switch()
      staging: r8188eu: remove issue_probereq_p2p_ex()
      staging: r8188eu: remove sreset_get_wifi_status()
      staging: r8188eu: remove build_deauth_p2p_ie()
      staging: r8188eu: remove rtw_freq2ch()
      staging: r8188eu: remove rtw_set_802_11_add_key()
      staging: r8188eu: remove rtw_set_802_11_remove_key()
      staging: r8188eu: remove rtw_set_802_11_remove_wep()
      staging: r8188eu: remove rtw_set_country()
      staging: r8188eu: remove rtw_set_scan_mode()
      staging: r8188eu: remove rtw_validate_ssid()
      staging: r8188eu: remove rtw_set_channel_plan()
      staging: r8188eu: remove rtw_atoi()
      staging: r8188eu: remove rtw_cbuf_push()
      staging: r8188eu: remove rtw_cbuf_full()
      staging: r8188eu: remove rtw_os_read_port()
      staging: r8188eu: remove rtw_IOL_cmd_buf_dump()
      staging: r8188eu: remove action_public_str()
      staging: r8188eu: remove dump_ies()
      staging: r8188eu: remove hal_ch_offset_to_secondary_ch_offset()
      staging: r8188eu: remove secondary_ch_offset_to_hal_ch_offset()
      staging: r8188eu: remove ieee80211_get_hdrlen()
      staging: r8188eu: remove ieee80211_is_empty_essid()
      staging: r8188eu: remove rtw_action_frame_parse()
      staging: r8188eu: remove rtw_ies_remove_ie()
      staging: r8188eu: remove rtw_set_ie_ch_switch()
      staging: r8188eu: remove rtw_set_ie_mesh_ch_switch_parm()
      staging: r8188eu: remove rtw_set_ie_secondary_ch_offset()
      staging: r8188eu: remove enum secondary_ch_offset
      staging: r8188eu: remove rtw_dequeue_recvbuf()
      staging: r8188eu: remove rtw_enqueue_recvbuf()
      staging: r8188eu: remove rtw_enqueue_recvbuf_to_head()
      staging: r8188eu: remove rtw_init_recvframe()
      staging: r8188eu: remove rtw_calculate_wlan_pkt_size_by_attribue()
      staging: r8188eu: remove rtw_sctx_done()
      staging: r8188eu: remove odm_DynamicTxPowerNIC()
      staging: r8188eu: remove odm_DynamicTxPowerAP()
      staging: r8188eu: remove odm_DynamicTxPower()
      staging: r8188eu: remove write-only fields from struct dm_priv
      staging: r8188eu: remove PowerIndex_backup from struct dm_priv
      staging: r8188eu: remove dead code from rtl8188e_rf6052.c
      staging: r8188eu: remove DynamicTxHighPowerLvl from struct dm_priv
      staging: r8188eu: remove odm_DynamicTxPowerInit()
      staging: r8188eu: remove rtw_proc_{init,remove}_one()
      staging: r8188eu: remove rtw_cmd_clr_isr()
      staging: r8188eu: remove rtw_createbss_cmd_ex()
      staging: r8188eu: remove rtw_getbbreg_cmd()
      staging: r8188eu: remove rtw_getrfreg_cmd()
      staging: r8188eu: remove rtw_getrttbl_cmd()
      staging: r8188eu: remove rtw_led_blink_cmd()
      staging: r8188eu: remove rtw_readtssi_cmdrsp_callback()
      staging: r8188eu: remove rtw_set_ch_cmd()
      staging: r8188eu: remove rtw_set_csa_cmd()
      staging: r8188eu: remove rtw_setassocsta_cmd()
      staging: r8188eu: remove rtw_setbasicrate_cmd()
      staging: r8188eu: remove rtw_setbbreg_cmd()
      staging: r8188eu: remove rtw_setphy_cmd()
      staging: r8188eu: remove rtw_setrfreg_cmd()
      staging: r8188eu: remove rtw_setrttbl_cmd()
      staging: r8188eu: remove rtw_setstandby_cmd()
      staging: r8188eu: remove rtw_tdls_cmd()
      staging: r8188eu: remove dead led blink functions
      staging: r8188eu: remove dead led control functions
      staging: r8188eu: remove unnecessary comments
      staging: r8188eu: remove _InitHWLed()
      staging: r8188eu: remove LedStrategy from struct led_priv
      staging: r8188eu: remove ODM_CheckPowerStatus()
      staging: r8188eu: remove odm_DynamicBBPowerSaving()
      staging: r8188eu: remove odm_GlobalAdapterCheck()
      staging: r8188eu: remove SetHalDefVarHandler from struct hal_ops
      staging: r8188eu: remove GetHalDefVarHandler from struct hal_ops
      staging: r8188eu: remove init_xmit_priv from struct hal_ops
      staging: r8188eu: remove init_recv_priv from struct hal_ops
      staging: r8188eu: remove free_recv_priv from struct hal_ops
      staging: r8188eu: remove inirp_init from struct hal_ops
      staging: r8188eu: remove inirp_deinit from struct hal_ops
      staging: r8188eu: remove rtl8188e_silentreset_for_specific_platform()
      staging: r8188eu: remove SetHwRegHandler from hal_ops
      staging: r8188eu: remove GetHwRegHandler from hal_ops
      staging: r8188eu: remove hal_init from hal_ops
      staging: r8188eu: remove hal_ops
      staging: r8188eu: rename rtl8188eu_set_hal_ops()
      staging: r8188eu: remove unused defines from rtw_sreset.h
      staging: r8188eu: remove some dead code
      staging: r8188eu: remove unused macros and defines from rtl8188e_hal.h
      staging: r8188eu: replace MACADDRLEN with ETH_ALEN
      staging: r8188eu: remove enum _RTL8712_RF_MIMO_CONFIG_
      staging: r8188eu: remove empty functions from odm.c
      staging: r8188eu: remove ODM_SingleDualAntennaDefaultSetting()
      staging: r8188eu: remove GetPSDData()
      staging: r8188eu: remove ODM_AntselStatistics_88C()
      staging: r8188eu: pBandType is never set
      staging: r8188eu: pMacPhyMode is not used
      staging: r8188eu: remove ODM_CmnInfoPtrArrayHook()
      staging: r8188eu: remove unused constants and variables
      staging: r8188eu: remove unnecessary assignment
      staging: r8188eu: fix a gcc warning
      staging: r8188eu: remove duplicate structure
      staging: r8188eu: BTRxRSSIPercentage is set but never used
      staging: r8188eu: rename ODM_PhyStatusQuery_92CSeries()
      staging: r8188eu: remove unused cases from ODM_CmnInfo{Hook,Update}
      staging: r8188eu: remove unused fields from enum odm_common_info_def
      staging: r8188eu: remove unused enums and defines from odm.h
      staging: r8188eu: RFType type is always ODM_1T1R

Nathan Chancellor (1):
      staging: wlan-ng: Avoid bitwise vs logical OR warning in hfa384x_usb_throttlefn()

Nikita Yushchenko (4):
      staging: most: dim2: force fcnt=3 on Renesas GEN3
      staging: most: dim2: use if statements instead of ?: expressions
      staging: most: dim2: do not double-register the same device
      staging: most: dim2: use device release method

Ojaswin Mujoo (1):
      staging: vchiq: Replace function typedefs with equivalent declaration

Paulo Miguel Almeida (1):
      staging: pi433: fix docs typos and references to previous struct names

Pavel Skripkin (22):
      staging: r8188eu: fix memory leak in rtw_set_key
      staging: r8188eu: remove useless memset
      staging: r8188eu: remove useless check
      staging: r8188eu: remove _rtw_mutex_{init,free}
      staging: r8188eu: make _rtw_init_queue a macro
      staging: r8188eu: remove usb_{read,write}_mem()
      staging: r8188eu: remove the helpers of rtw_read8()
      staging: r8188eu: remove the helpers of rtw_read16()
      staging: r8188eu: remove the helpers of rtw_read32()
      staging: r8188eu: remove the helpers of usb_write8()
      staging: r8188eu: remove the helpers of usb_write16()
      staging: r8188eu: remove the helpers of usb_write32()
      staging: r8188eu: remove the helpers of usb_writeN()
      staging: r8188eu: remove the helpers of usb_read_port()
      staging: r8188eu: remove the helpers of usb_write_port()
      staging: r8188eu: remove the helpers of usb_read_port_cancel()
      staging: r8188eu: remove the helpers of usb_write_port_cancel()
      staging: r8188eu: remove core/rtw_io.c
      staging: r8188eu: remove struct _io_ops
      staging: r8188eu: remove shared buffer for USB requests
      staging: r8188eu: remove mutex 'usb_vendor_req_mutex'
      staging: rtl8712: fix use-after-free in rtl8712_dl_fw

Phillip Potter (18):
      staging: r8188eu: remove c2h_handler field from struct hal_ops
      staging: r8188eu: simplify c2h_evt_hdl function
      staging: r8188eu: remove rtw_hal_c2h_handler function
      staging: r8188eu: remove rtw_hal_reset_security_engine function
      staging: r8188eu: remove hal_reset_security_engine from struct hal_ops
      staging: r8188eu: remove rtw_hal_enable_interrupt function
      staging: r8188eu: remove enable_interrupt from struct hal_ops
      staging: r8188eu: remove rtw_hal_disable_interrupt function
      staging: r8188eu: remove disable_interrupt from struct hal_ops
      staging: r8188eu: remove rtw_hal_interrupt_handler function
      staging: r8188eu: remove interrupt_handler from struct hal_ops
      staging: r8188eu: remove rtw_hal_xmitframe_enqueue function
      staging: r8188eu: remove hal_xmitframe_enqueue from struct hal_ops
      staging: r8188eu: remove Efuse_PgPacketWrite_BT function
      staging: r8188eu: remove Efuse_PgPacketWrite_BT from struct hal_ops
      staging: r8188eu: remove rtw_hal_c2h_id_filter_ccx function
      staging: r8188eu: remove c2h_id_filter_ccx from struct hal_ops
      staging: r8188eu: remove MSG_88E calls from hal/usb_halinit.c

Saurav Girepunje (27):
      staging: r8188eu: core: remove null check before vfree
      staging: r8188eu: os_dep: remove unused static variable
      staging: r8188eu: core: remove unused function
      staging: r8188eu: core: remove condition with no effect
      staging: r8188eu: os_dep: use kmemdup instead of kzalloc and memcpy
      staging: r8188eu: hal: remove condition with no effect
      staging: r8188eu: core: remove condition never execute
      staging: r8188eu: include: remove duplicate declaration.
      staging: r8188eu: core: remove unused variable padapter
      staging: r8188eu: core: remove unused variable Adapter
      staging: r8188eu: os_dep: simplifiy the rtw_resume function
      staging: r8188eu: core: remove unused function rtw_set_tx_chksum_offload
      staging: rtl8723bs: core: remove condition never execute
      staging: rtl8723bs: core: remove reassignment of same value to variable
      staging: rtl8192e: remove unused variable ieee
      staging: rtl8192u: remove unused static variable
      staging: r8188eu: core: remove power_saving_wk_hdl function
      staging: r8188eu: core: remove unused variable pAdapter
      staging: r8188eu: core: remove unused variable local variable
      staging: r8188eu: hal: remove assignment to itself
      staging: r8188eu: core: remove duplicate condition check
      staging: rtl8723bs: hal: remove duplicate check
      staging: r8188eu: remove unused local variable
      staging: r8188eu: core: remove goto statement
      staging: r8188eu: core: remove the goto from rtw_IOL_accquire_xmit_frame
      staging: rtl8723bs: hal remove the assignment to itself
      staging: r8188eu: hal: remove goto statement and local variable

Sergio Paracuellos (16):
      MIPS: ralink: don't define PC_IOBASE but increase IO_SPACE_LIMIT
      staging: mt7621-pci: set end limit for 'ioport_resource'
      Revert "MIPS: ralink: don't define PC_IOBASE but increase IO_SPACE_LIMIT"
      Revert "staging: mt7621-pci: set end limit for 'ioport_resource'"
      MIPS: ralink: set PCI_IOBASE to 'mips_io_port_base'
      PCI: Allow architecture-specific pci_remap_iospace()
      MIPS: implement architecture-specific 'pci_remap_iospace()'
      staging: mt7621-pci: properly adjust base address for the IO window
      staging: mt7621-dts: properly define 'cpc' and 'mc' nodes
      MIPS: asm: pci: define arch-specific 'pci_remap_iospace()' dependent on 'CONFIG_PCI_DRIVERS_GENERIC'
      staging: mt7621-dts: change some node hex addresses to lower case
      staging: mt7621-dts: get rid of nodes with no in-tree driver
      staging: mt7621-dts: change palmbus address to lower case
      staging: mt7621-dts: make use of 'IRQ_TYPE_LEVEL_HIGH' instead of magic numbers
      staging: mt7621-dts: complete 'cpus' node
      staging: mt7621-dts: add missing SPDX license to files

Sidong Yang (1):
      staging: pi433: goto abort when setting failed in tx_thread

Siou-Jhih, Guo (1):
      staging: r8188eu: Fix misspelling in comment

Srivathsa Dara (2):
      staging: fbtft: fbtft-core: fix 'trailing statements should be on next line' coding style error
      staging: wfx: sta: Fix 'else' coding style warning

Stefan Wahren (3):
      staging: vchiq_arm: re-order vchiq_arm_init_state
      staging: vchiq_arm: drop unnecessary declarations
      staging: vchiq_arm: move platform structs to vchiq_arm.c

Tommaso Merciai (6):
      staging: vt6655: fix camelcase in pbyCxtBuf
      staging: vt6655: fix camelcase in bShortSlotTime
      staging: vt6655: fix camelcase in ldBmThreshold
      staging: vt6655: fix camelcase in PortOffset
      staging: vt6655: fix camelcase in byLocalID
      staging: vt6655: fix camelcase in byRate

Uwe Kleine-König (1):
      staging: fbtft: Make fbtft_remove_common() return void

Vegard Nossum (1):
      staging: ks7010: select CRYPTO_HASH/CRYPTO_MICHAEL_MIC

Wan Jiabing (1):
      staging: r8188eu: Use memdup_user instead of kmalloc/copy_from_user

Yang Yingliang (1):
      staging: r8188eu: fix missing unlock in rtw_resume()

xu xin (1):
      staging: r8118eu: remove useless parts of judgements from os_dep/ioctl_linux.

 arch/mips/include/asm/mach-ralink/spaces.h         |    4 +-
 arch/mips/include/asm/pci.h                        |    4 +
 arch/mips/pci/pci-generic.c                        |   14 +
 drivers/pci/pci.c                                  |    2 +
 drivers/staging/axis-fifo/axis-fifo.c              |   88 +-
 drivers/staging/fbtft/fbtft-core.c                 |   11 +-
 drivers/staging/fbtft/fbtft.h                      |    8 +-
 drivers/staging/fieldbus/anybuss/host.c            |    8 +-
 drivers/staging/gdm724x/gdm_lte.c                  |    4 +-
 drivers/staging/ks7010/Kconfig                     |    3 +
 drivers/staging/ks7010/ks_hostif.c                 |    2 +-
 drivers/staging/ks7010/ks_wlan_net.c               |    4 +-
 drivers/staging/most/dim2/Makefile                 |    2 +-
 drivers/staging/most/dim2/dim2.c                   |  115 +-
 drivers/staging/most/dim2/sysfs.c                  |   49 -
 drivers/staging/most/dim2/sysfs.h                  |   11 -
 drivers/staging/most/net/net.c                     |    2 +-
 drivers/staging/mt7621-dma/hsdma-mt7621.c          |    6 +-
 drivers/staging/mt7621-dts/gbpc1.dts               |    3 +-
 drivers/staging/mt7621-dts/gbpc2.dts               |    1 +
 drivers/staging/mt7621-dts/mt7621.dtsi             |   74 +-
 drivers/staging/mt7621-pci/pci-mt7621.c            |    2 +-
 drivers/staging/octeon/ethernet.c                  |    2 +-
 drivers/staging/pi433/pi433_if.c                   |   18 +-
 drivers/staging/pi433/pi433_if.h                   |   23 +-
 drivers/staging/qlge/qlge_main.c                   |   18 +-
 drivers/staging/qlge/qlge_mpi.c                    |    2 +-
 drivers/staging/r8188eu/Kconfig                    |   10 -
 drivers/staging/r8188eu/Makefile                   |  155 +-
 drivers/staging/r8188eu/core/rtw_ap.c              |  607 +----
 drivers/staging/r8188eu/core/rtw_br_ext.c          |    3 +-
 drivers/staging/r8188eu/core/rtw_cmd.c             |  618 +-----
 drivers/staging/r8188eu/core/rtw_debug.c           |  904 --------
 drivers/staging/r8188eu/core/rtw_efuse.c           |  582 +----
 drivers/staging/r8188eu/core/rtw_ieee80211.c       |  339 +--
 drivers/staging/r8188eu/core/rtw_io.c              |  299 ---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c       |  397 +---
 drivers/staging/r8188eu/core/rtw_iol.c             |   34 +-
 drivers/staging/r8188eu/core/rtw_led.c             | 1365 +-----------
 drivers/staging/r8188eu/core/rtw_mlme.c            |  126 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        |  386 +---
 drivers/staging/r8188eu/core/rtw_mp.c              |  935 --------
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c        | 1170 ----------
 drivers/staging/r8188eu/core/rtw_p2p.c             |   43 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c         |  140 +-
 drivers/staging/r8188eu/core/rtw_recv.c            |  116 +-
 drivers/staging/r8188eu/core/rtw_rf.c              |   17 -
 drivers/staging/r8188eu/core/rtw_security.c        |  197 +-
 drivers/staging/r8188eu/core/rtw_sreset.c          |   62 -
 drivers/staging/r8188eu/core/rtw_sta_mgt.c         |   34 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c       |  157 +-
 drivers/staging/r8188eu/core/rtw_xmit.c            |  121 +-
 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c |   22 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c     |   32 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c    |   10 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c     |   15 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c       |  171 +-
 drivers/staging/r8188eu/hal/hal_com.c              |   26 +-
 drivers/staging/r8188eu/hal/hal_intf.c             |  391 +---
 drivers/staging/r8188eu/hal/odm.c                  | 1188 +---------
 drivers/staging/r8188eu/hal/odm_HWConfig.c         |  393 +---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c         |   31 +-
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c   |    8 -
 drivers/staging/r8188eu/hal/odm_interface.c        |   85 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c         |   48 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c          |   93 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    |  310 +--
 drivers/staging/r8188eu/hal/rtl8188e_mp.c          |  798 -------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      |  215 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c      |  226 +-
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c      |    2 +-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c      |   27 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c       |    4 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |   60 +-
 drivers/staging/r8188eu/hal/usb_halinit.c          |  328 +--
 drivers/staging/r8188eu/hal/usb_ops_linux.c        |  256 +--
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h   |   91 -
 .../staging/r8188eu/include/Hal8188ERateAdaptive.h |    2 -
 drivers/staging/r8188eu/include/HalHWImg8188E_FW.h |   16 -
 drivers/staging/r8188eu/include/HalVerDef.h        |   70 -
 drivers/staging/r8188eu/include/drv_types.h        |   37 +-
 drivers/staging/r8188eu/include/hal_intf.h         |  312 +--
 drivers/staging/r8188eu/include/ieee80211.h        |   71 -
 drivers/staging/r8188eu/include/ioctl_cfg80211.h   |    2 -
 drivers/staging/r8188eu/include/mp_custom_oid.h    |  333 ---
 drivers/staging/r8188eu/include/odm.h              |  457 +---
 drivers/staging/r8188eu/include/odm_HWConfig.h     |   11 +-
 drivers/staging/r8188eu/include/odm_RTL8188E.h     |    2 -
 .../staging/r8188eu/include/odm_RegConfig8188E.h   |    3 -
 .../staging/r8188eu/include/odm_RegDefine11AC.h    |   29 -
 drivers/staging/r8188eu/include/odm_RegDefine11N.h |  112 +-
 drivers/staging/r8188eu/include/odm_interface.h    |   88 -
 drivers/staging/r8188eu/include/odm_precomp.h      |   22 -
 drivers/staging/r8188eu/include/odm_reg.h          |   89 -
 drivers/staging/r8188eu/include/odm_types.h        |   24 -
 drivers/staging/r8188eu/include/osdep_intf.h       |    5 -
 drivers/staging/r8188eu/include/osdep_service.h    |   42 +-
 drivers/staging/r8188eu/include/recv_osdep.h       |    2 -
 drivers/staging/r8188eu/include/rtl8188e_cmd.h     |   16 -
 drivers/staging/r8188eu/include/rtl8188e_dm.h      |   13 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h     |  102 +-
 drivers/staging/r8188eu/include/rtl8188e_led.h     |    2 -
 drivers/staging/r8188eu/include/rtl8188e_recv.h    |    2 +-
 drivers/staging/r8188eu/include/rtl8188e_rf.h      |    1 -
 drivers/staging/r8188eu/include/rtl8188e_spec.h    |    4 -
 drivers/staging/r8188eu/include/rtl8188e_sreset.h  |    2 -
 drivers/staging/r8188eu/include/rtw_ap.h           |   11 -
 drivers/staging/r8188eu/include/rtw_br_ext.h       |    3 +-
 drivers/staging/r8188eu/include/rtw_cmd.h          |   27 +-
 drivers/staging/r8188eu/include/rtw_debug.h        |  156 --
 drivers/staging/r8188eu/include/rtw_eeprom.h       |   57 +-
 drivers/staging/r8188eu/include/rtw_efuse.h        |   21 -
 drivers/staging/r8188eu/include/rtw_io.h           |   87 +-
 drivers/staging/r8188eu/include/rtw_ioctl_rtl.h    |   63 -
 drivers/staging/r8188eu/include/rtw_ioctl_set.h    |    8 -
 drivers/staging/r8188eu/include/rtw_iol.h          |    5 -
 drivers/staging/r8188eu/include/rtw_led.h          |   20 -
 drivers/staging/r8188eu/include/rtw_mlme.h         |   11 -
 drivers/staging/r8188eu/include/rtw_mlme_ext.h     |   14 -
 drivers/staging/r8188eu/include/rtw_mp.h           |  474 ----
 drivers/staging/r8188eu/include/rtw_mp_ioctl.h     |  242 --
 .../staging/r8188eu/include/rtw_mp_phy_regdef.h    | 1063 ---------
 drivers/staging/r8188eu/include/rtw_p2p.h          |    1 -
 drivers/staging/r8188eu/include/rtw_pwrctrl.h      |  130 +-
 drivers/staging/r8188eu/include/rtw_recv.h         |    6 -
 drivers/staging/r8188eu/include/rtw_rf.h           |   12 -
 drivers/staging/r8188eu/include/rtw_security.h     |   20 +-
 drivers/staging/r8188eu/include/rtw_sreset.h       |   34 -
 drivers/staging/r8188eu/include/rtw_xmit.h         |    6 -
 drivers/staging/r8188eu/include/sta_info.h         |    7 -
 drivers/staging/r8188eu/include/usb_ops.h          |    5 -
 drivers/staging/r8188eu/include/usb_ops_linux.h    |    8 -
 drivers/staging/r8188eu/include/usb_osintf.h       |    5 +-
 drivers/staging/r8188eu/include/wifi.h             |   52 -
 drivers/staging/r8188eu/include/xmit_osdep.h       |    2 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       | 2331 +-------------------
 drivers/staging/r8188eu/os_dep/mlme_linux.c        |    6 -
 drivers/staging/r8188eu/os_dep/os_intfs.c          |  399 +---
 drivers/staging/r8188eu/os_dep/osdep_service.c     |   82 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c        |   14 -
 drivers/staging/r8188eu/os_dep/usb_intf.c          |  285 +--
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c     |   40 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c        |    4 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |    7 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |    4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |    2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |    9 +-
 drivers/staging/rtl8192u/r8192U.h                  |    3 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   36 +-
 drivers/staging/rtl8712/os_intfs.c                 |    9 +-
 drivers/staging/rtl8712/rtl871x_cmd.c              |    2 +-
 drivers/staging/rtl8712/rtl871x_cmd.h              |    2 +-
 drivers/staging/rtl8712/rtl871x_xmit.h             |   10 +-
 drivers/staging/rtl8712/usb_intf.c                 |    6 +-
 drivers/staging/rtl8712/usb_ops_linux.c            |    2 +-
 drivers/staging/rtl8723bs/Kconfig                  |    1 +
 drivers/staging/rtl8723bs/core/rtw_ap.c            |   23 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |  210 +-
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |    4 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |   24 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   79 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          |   22 +-
 drivers/staging/rtl8723bs/core/rtw_security.c      |    6 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |   48 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |   49 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |    2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |   12 -
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |    6 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |    2 -
 drivers/staging/rtl8723bs/include/osdep_service.h  |    2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   26 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |   34 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |    8 +-
 drivers/staging/rtl8723bs/os_dep/osdep_service.c   |   11 +-
 drivers/staging/rts5208/ms.c                       |   42 +-
 drivers/staging/rts5208/rtsx.c                     |    2 +-
 drivers/staging/rts5208/rtsx_card.c                |    8 +-
 drivers/staging/rts5208/rtsx_chip.c                |   16 +-
 drivers/staging/rts5208/rtsx_scsi.c                |  106 +-
 drivers/staging/rts5208/rtsx_transport.c           |    6 +-
 drivers/staging/rts5208/sd.c                       |   68 +-
 drivers/staging/rts5208/xd.c                       |   48 +-
 drivers/staging/unisys/visornic/visornic_main.c    |    5 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  298 ++-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |   52 -
 .../interface/vchiq_arm/vchiq_connected.c          |   20 +-
 .../interface/vchiq_arm/vchiq_connected.h          |    4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  771 +++----
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |  107 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |  182 +-
 drivers/staging/vt6655/baseband.c                  |   74 +-
 drivers/staging/vt6655/baseband.h                  |    2 +-
 drivers/staging/vt6655/card.c                      |   98 +-
 drivers/staging/vt6655/channel.c                   |   12 +-
 drivers/staging/vt6655/device.h                    |   10 +-
 drivers/staging/vt6655/device_main.c               |  162 +-
 drivers/staging/vt6655/dpc.c                       |    2 +-
 drivers/staging/vt6655/key.c                       |    2 +-
 drivers/staging/vt6655/mac.c                       |   50 +-
 drivers/staging/vt6655/mac.h                       |    6 +-
 drivers/staging/vt6655/power.c                     |   24 +-
 drivers/staging/vt6655/rf.c                        |  140 +-
 drivers/staging/vt6655/rf.h                        |    2 +-
 drivers/staging/vt6655/rxtx.c                      |   64 +-
 drivers/staging/wfx/bh.c                           |   37 +-
 drivers/staging/wfx/bh.h                           |    4 +-
 drivers/staging/wfx/bus_sdio.c                     |   25 +-
 drivers/staging/wfx/bus_spi.c                      |   22 +-
 drivers/staging/wfx/data_rx.c                      |    7 +-
 drivers/staging/wfx/data_rx.h                      |    4 +-
 drivers/staging/wfx/data_tx.c                      |   87 +-
 drivers/staging/wfx/data_tx.h                      |    6 +-
 drivers/staging/wfx/debug.c                        |   56 +-
 drivers/staging/wfx/debug.h                        |    2 +-
 drivers/staging/wfx/fwio.c                         |   26 +-
 drivers/staging/wfx/fwio.h                         |    2 +-
 drivers/staging/wfx/hif_api_cmd.h                  |   14 +-
 drivers/staging/wfx/hif_api_general.h              |   25 +-
 drivers/staging/wfx/hif_api_mib.h                  |   85 +-
 drivers/staging/wfx/hif_rx.c                       |   23 +-
 drivers/staging/wfx/hif_rx.h                       |    3 +-
 drivers/staging/wfx/hif_tx.c                       |   60 +-
 drivers/staging/wfx/hif_tx.h                       |    6 +-
 drivers/staging/wfx/hif_tx_mib.c                   |   14 +-
 drivers/staging/wfx/hif_tx_mib.h                   |    2 +-
 drivers/staging/wfx/hwio.c                         |    6 +-
 drivers/staging/wfx/hwio.h                         |   20 +-
 drivers/staging/wfx/key.c                          |   30 +-
 drivers/staging/wfx/key.h                          |    4 +-
 drivers/staging/wfx/main.c                         |   37 +-
 drivers/staging/wfx/main.h                         |    3 +-
 drivers/staging/wfx/queue.c                        |   43 +-
 drivers/staging/wfx/queue.h                        |    6 +-
 drivers/staging/wfx/scan.c                         |   51 +-
 drivers/staging/wfx/scan.h                         |    4 +-
 drivers/staging/wfx/sta.c                          |  118 +-
 drivers/staging/wfx/sta.h                          |    8 +-
 drivers/staging/wfx/traces.h                       |    2 +-
 drivers/staging/wfx/wfx.h                          |   14 +-
 drivers/staging/wlan-ng/hfa384x.h                  |    2 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |   24 +-
 drivers/staging/wlan-ng/p80211conv.c               |    2 +-
 drivers/staging/wlan-ng/p80211conv.h               |    2 +-
 drivers/staging/wlan-ng/p80211hdr.h                |    2 +-
 drivers/staging/wlan-ng/p80211ioctl.h              |    2 +-
 drivers/staging/wlan-ng/p80211mgmt.h               |    2 +-
 drivers/staging/wlan-ng/p80211msg.h                |    2 +-
 drivers/staging/wlan-ng/p80211netdev.c             |    4 +-
 drivers/staging/wlan-ng/p80211netdev.h             |    2 +-
 drivers/staging/wlan-ng/p80211req.c                |    2 +-
 drivers/staging/wlan-ng/p80211req.h                |    2 +-
 drivers/staging/wlan-ng/p80211types.h              |    2 +-
 drivers/staging/wlan-ng/p80211wep.c                |    2 +-
 drivers/staging/wlan-ng/prism2mgmt.c               |    2 +-
 drivers/staging/wlan-ng/prism2mgmt.h               |    2 +-
 drivers/staging/wlan-ng/prism2mib.c                |    2 +-
 drivers/staging/wlan-ng/prism2sta.c                |    6 +-
 drivers/staging/wlan-ng/prism2usb.c                |    3 +-
 258 files changed, 3323 insertions(+), 22353 deletions(-)
 delete mode 100644 drivers/staging/most/dim2/sysfs.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_debug.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_io.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_mp.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_mp_ioctl.c
 delete mode 100644 drivers/staging/r8188eu/core/rtw_sreset.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_mp.c
 delete mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
 delete mode 100644 drivers/staging/r8188eu/include/mp_custom_oid.h
 delete mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11AC.h
 delete mode 100644 drivers/staging/r8188eu/include/odm_reg.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_mp.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_mp_ioctl.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
 delete mode 100644 drivers/staging/r8188eu/include/rtw_sreset.h
