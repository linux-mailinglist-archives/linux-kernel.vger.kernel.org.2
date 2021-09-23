Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018D0415489
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 02:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbhIWAT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 20:19:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:8311 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234042AbhIWATz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:19:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223763481"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="223763481"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:18:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="474688899"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.87.52])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:18:24 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v15 0/4] Intel MAX10 BMC Secure Update Driver
Date:   Wed, 22 Sep 2021 17:18:18 -0700
Message-Id: <20210923001822.283220-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel MAX10 BMC Secure Update driver instantiates the FPGA Image
Load framework and provides the callback functions required to
support secure updates on Intel n3000 PAC devices. This driver is
implemented as a sub-driver of the Intel MAX10 BMC mfd driver.

This driver interacts with the HW secure update engine of the FPGA
card BMC in order to transfer new FPGA and BMC images to FLASH on
the FPGA card so that they will be automatically loaded when the
FPGA card reboots. Security is enforced by hardware and firmware.
The MAX10 BMC Secure Update driver interacts with the firmware to
initiate an update, pass in the necessary data, and collect status
on the update.

This driver provides sysfs files for displaying the flash count, the
root entry hashes (REH), and the code-signing-key (CSK) cancellation
vectors.

These patches are dependent on other patches that are under review.
If you want to apply and compile these patches on linux-next, please
apply these patches first:

(5 patches) https://lkml.org/lkml/2021/9/22/1187

Changelog v14 -> v15:
  - Updated the Dates and KernelVersions in the ABI documentation
  - Change driver name from "n3000bmc-secure" to "n3000bmc-sec-update".
  - Change CONFIG_FPGA_M10_BMC_SECURE to CONFIG_FPGA_M10_BMC_SEC_UPDATE.
  - Change instances of *bmc-secure to *bmc-sec-update in file name
    and symbol names.
  - Change instances of *m10bmc_secure* to *m10bmc-sec_update* in symbol
    names.
  - Adapted to changes in the FPGA Image Load framework:
    (1) All enum types (progress and errors) are now type u32
    (2) m10bmc_sec_write_blk() adds *blk_size and max_size parameters
        and uses *blk_size as provided by the caller.
    (3) m10bmc_sec_poll_complete() no long checks the driver_unload
        flag.

Changelog v13 -> v14:
  - Changed symbol and text references to reflect the renaming of the
    Security Manager Class driver to FPGA Image Load.

Changelog v12 -> v13:
  - Updated copyright to 2021
  - Updated Date and KernelVersion fields in ABI documentation
  - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
    functions instead of devm_fpga_sec_mgr_create() and
    devm_fpga_sec_mgr_register().

Changelog v11 -> v12:
  - Updated Date and KernelVersion fields in ABI documentation
  - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
    no longer has a size parameter, and the block size is determined
    in this (the lower-level) driver.

Changelog v10 -> v11:
  - Added Reviewed-by tag to patch #1

Changelog v9 -> v10:
  - Changed the path expressions in the sysfs documentation to
    replace the n3000 reference with something more generic to
    accomodate other devices that use the same driver.

Changelog v8 -> v9:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation

Changelog v7 -> v8:
  - Split out patch "mfd: intel-m10-bmc: support for MAX10 BMC Secure
    Updates" and submitted it separately:
    https://marc.info/?l=linux-kernel&m=161126987101096&w=2

Changelog v6 -> v7:
  - Rebased patches for 5.11-rc2
  - Updated Date and KernelVersion in ABI documentation

Changelog v5 -> v6:
  - Added WARN_ON() prior to several calls to regmap_bulk_read()
    to assert that the (SIZE / stride) calculations did not result
    in remainders.
  - Changed the (size / stride) calculation in regmap_bulk_write()
    call to ensure that we don't write one less than intended.
  - Changed flash_count_show() parameter list to achieve
    reverse-christmas tree format.
  - Removed unnecessary call to rsu_check_complete() in
    m10bmc_sec_poll_complete() and changed while loop to
    do/while loop.
  - Initialized auth_result and doorbell to HW_ERRINFO_POISON
    in m10bmc_sec_hw_errinfo() and removed unnecessary if statements.

Changelog v4 -> v5:
  - Renamed sysfs node user_flash_count to flash_count and updated
    the sysfs documentation accordingly to more accurately descirbe
    the purpose of the count.

Changelog v3 -> v4:
  - Moved sysfs files for displaying the flash count, the root
    entry hashes (REH), and the code-signing-key (CSK) cancellation
    vectors from the FPGA Security Manager class driver to this
    driver (as they are not generic enough for the class driver).
  - Added a new ABI documentation file with informtaion about the
    new sysfs entries: sysfs-driver-intel-m10-bmc-secure
  - Updated the MAINTAINERS file to add the new ABI documentation
    file: sysfs-driver-intel-m10-bmc-secure
  - Removed unnecessary ret variable from m10bmc_secure_probe()
  - Incorporated new devm_fpga_sec_mgr_register() function into
    m10bmc_secure_probe() and removed the m10bmc_secure_remove()
    function.

Changelog v2 -> v3:
  - Changed "MAX10 BMC Security Engine driver" to "MAX10 BMC Secure
    Update driver"
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
  - Changed "_root_entry_hash" to "_reh", with a comment explaining
    what reh is.
  - Renamed get_csk_vector() to m10bmc_csk_vector()
  - Changed calling functions of functions that return "enum fpga_sec_err"
    to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)

Changelog v1 -> v2:
  - These patches were previously submitted as part of a larger V1
    patch set under the title "Intel FPGA Security Manager Class Driver".
  - Grouped all changes to include/linux/mfd/intel-m10-bmc.h into a
    single patch: "mfd: intel-m10-bmc: support for MAX10 BMC Security
    Engine".
  - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
  - Adapted to changes in the Intel FPGA Security Manager by splitting
    the single call to ifpga_sec_mgr_register() into two function
    calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
  - Replaced small function-creation macros for explicit function
    declarations.
  - Bug fix for the get_csk_vector() function to properly apply the
    stride variable in calls to m10bmc_raw_bulk_read().
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
  - Implemented HW_ERRINFO_POISON for m10bmc_sec_hw_errinfo() to
    ensure that corresponding bits are set to 1 if we are unable
    to read the doorbell or auth_result registers.
  - Added comments and additional code cleanup per V1 review.

Russ Weight (4):
  fpga: m10bmc-sec: create max10 bmc secure update driver
  fpga: m10bmc-sec: expose max10 flash update count
  fpga: m10bmc-sec: expose max10 canceled keys in sysfs
  fpga: m10bmc-sec: add max10 secure update functions

 .../sysfs-driver-intel-m10-bmc-sec-update     |  61 ++
 MAINTAINERS                                   |   2 +
 drivers/fpga/Kconfig                          |  22 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/intel-m10-bmc-sec-update.c       | 531 ++++++++++++++++++
 5 files changed, 619 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
 create mode 100644 drivers/fpga/intel-m10-bmc-sec-update.c

-- 
2.25.1

