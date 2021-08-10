Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660893D82FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhG0WbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:31:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:58649 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232607AbhG0WbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:31:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212531039"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="212531039"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:31:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="437502385"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.69.186])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:31:13 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v14 0/6] FPGA Security Manager Class Driver
Date:   Tue, 27 Jul 2021 15:30:59 -0700
Message-Id: <20210727223105.152142-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: This patchset is undergoing changes in response to feedback
on the mailing lists. There are additional changes that need to
be made, but this patchset is being sent out as a refresh.

-----

The FPGA Security Manager class driver provides a common
API for user-space tools to manage updates for secure FPGA
devices. Device drivers that instantiate the FPGA Security
Manager class driver will interact with a HW secure update
engine in order to transfer new FPGA and BMC images to FLASH so
that they will be automatically loaded when the FPGA card reboots.

A significant difference between the FPGA Manager and the FPGA 
Security Manager is that the FPGA Manager does a live update (Partial
Reconfiguration) to a device whereas the FPGA Security Manager
updates the FLASH images for the Static Region and the BMC so that
they will be loaded the next time the FPGA card boots. Security is
enforced by hardware and firmware. The security manager interacts
with the firmware to initiate an update, pass in the necessary data,
and collect status on the update.

The n3000bmc-secure driver is the first driver to use the FPGA
Security Manager. This driver was previously submitted in the same
patch set, but has been split out into a separate patch set starting
with V2. Future devices will also make use of this common API for
secure updates.

In addition to managing secure updates of the FPGA and BMC images,
the FPGA Security Manager update process may also be used to
program root entry hashes and cancellation keys for the FPGA static
region, the FPGA partial reconfiguration region, and the BMC.
The image files are self-describing, and contain a header describing
the image type.

Secure updates make use of the request_firmware framework, which
requires that image files are accessible under /lib/firmware. A request
for a secure update returns immediately, while the update itself
proceeds in the context of a kernel worker thread. Sysfs files provide
a means for monitoring the progress of a secure update and for
retrieving error information in the event of a failure.

The API includes a "name" sysfs file to export the name of the parent
driver. It also includes an "update" sub-directory containing files that
that can be used to instantiate and monitor a secure update.

Changelog v13 -> v14:
 - Dropped the patch: fpga: sec-mgr: expose hardware error info
 - Updated copyrights to 2021
 - Updated ABI documentation date and kernel version
 - Removed the name sysfs entry from the class driver
 - Use xa_alloc() instead of ida_simple_get()
 - Rename dev to parent for parent devices
 - Remove fpga_sec_mgr_create(), devm_fpga_sec_mgr_create(), and
   fpga_sec_mgr_free() functions and update the fpga_sec_mgr_register()
   function to both create and register a new security manager.
 - Populate the fpga_sec_mgr_dev_release() function.
 - Added MAINTAINERS reference for
   Documentation/ABI/testing/sysfs-class-fpga-sec-mgr

Changelog v12 -> v13:
  - Change "if (count == 0 || " to "if (!count || "
  - Improve error message: "Attempt to register without all required ops\n"
  - Change set_error() to fpga_sec_set_error()
  - Change set_hw_errinfo() to fpga_sec_set_hw_errinfo()

Changelog v11 -> v12:
  - Updated Date and KernelVersion fields in ABI documentation
  - Removed size parameter from write_blk() op - it is now up to
    the lower-level driver to determine the appropriate size and
    to update smgr->remaining_size accordingly.
  - Changed syntax of sec_mgr_prog_str[] and sec_mgr_err_str array definitions
    from:
	"idle",			/* FPGA_SEC_PROG_IDLE */
    to:
	[FPGA_SEC_PROG_IDLE]	    = "idle",

Changelog v10 -> v11:
  - Fixed a spelling error in a comment
  - Initialize smgr->err_code and smgr->progress explicitly in
    fpga_sec_mgr_create() instead of accepting the default 0 value.

Changelog v9 -> v10:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation

Changelog v8 -> v9:
  - Rebased patches for 5.11-rc2
  - Updated Date and KernelVersion in ABI documentation

Changelog v7 -> v8:
  - Fixed grammatical error in Documentation/fpga/fpga-sec-mgr.rst

Changelog v6 -> v7:
  - Changed dates in documentation file to December 2020
  - Changed filename_store() to use kmemdup_nul() instead of
    kstrndup() and changed the count to not assume a line-return.

Changelog v5 -> v6:
  - Removed sysfs support and documentation for the display of the
    flash count, root entry hashes, and code-signing-key cancellation
    vectors from the class driver. This information can vary by device
    and will instead be displayed by the device-specific parent driver.

Changelog v4 -> v5:
  - Added the devm_fpga_sec_mgr_unregister() function, following recent
    changes to the fpga_manager() implementation.
  - Changed most of the *_show() functions to use sysfs_emit()
    instead of sprintf(
  - When checking the return values for functions of type enum
    fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0

Changelog v3 -> v4:
  - This driver is generic enough that it could be used for non Intel
    FPGA devices. Changed from "Intel FPGA Security Manager" to FPGA
    Security Manager" and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
    Note that this also affects some filenames.

Changelog v2 -> v3:
  - Use dev_err() to report invalid progress in sec_progress()
  - Use dev_err() to report invalid error code in sec_error()
  - Modified sysfs handler check in check_sysfs_handler() to make
    it more readable.
  - Removed unnecessary "goto done"
  - Added a comment to explain imgr->driver_unload in
    ifpga_sec_mgr_unregister()

Changelog v1 -> v2:
  - Separated out the MAX10 BMC Security Engine to be submitted in
    a separate patch-set.
  - Bumped documentation dates and versions
  - Split ifpga_sec_mgr_register() into create() and register() functions
  - Added devm_ifpga_sec_mgr_create()
  - Added Documentation/fpga/ifpga-sec-mgr.rst 
  - Changed progress state "read_file" to "reading"
  - Added sec_error() function (similar to sec_progress())
  - Removed references to bmc_flash_count & smbus_flash_count (not supported)
  - Removed typedefs for imgr ops
  - Removed explicit value assignments in enums
  - Other minor code cleanup per review comments 

Russ Weight (6):
  fpga: sec-mgr: fpga security manager class driver
  fpga: sec-mgr: enable secure updates
  fpga: sec-mgr: expose sec-mgr update status
  fpga: sec-mgr: expose sec-mgr update errors
  fpga: sec-mgr: expose sec-mgr update size
  fpga: sec-mgr: enable cancel of secure update

 .../ABI/testing/sysfs-class-fpga-sec-mgr      |  61 +++
 Documentation/fpga/fpga-sec-mgr.rst           |  44 ++
 Documentation/fpga/index.rst                  |   1 +
 MAINTAINERS                                   |   9 +
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/fpga-sec-mgr.c                   | 443 ++++++++++++++++++
 include/linux/fpga/fpga-sec-mgr.h             |  85 ++++
 8 files changed, 655 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
 create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
 create mode 100644 drivers/fpga/fpga-sec-mgr.c
 create mode 100644 include/linux/fpga/fpga-sec-mgr.h

-- 
2.25.1

