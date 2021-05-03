Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C147E372369
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhECXH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhECXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:07:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEDB61208;
        Mon,  3 May 2021 23:06:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1ldheT-009Y8h-C9; Mon, 03 May 2021 19:06:57 -0400
Message-ID: <20210503230657.245847735@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 03 May 2021 19:05:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        "John Warthog9 Hawley (VMware)" <warthog9@eaglescrag.net>
Subject: [for-next][PATCH 2/7] ktest: Add example config for using VMware VMs
References: <20210503230510.845068955@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John 'Warthog9' Hawley (VMware)" <warthog9@kernel.org>

This duplicates the KVM/Qemu config with specific notes for how
to use it with VMware VMs on Workstation, Player, or Fusion.
The main thing to be aware of is how the serial port is exposed
which is a unix pipe, and will need something like ncat to get
into ktest's monitoring

Signed-off-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/examples/vmware.conf | 137 +++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 tools/testing/ktest/examples/vmware.conf

diff --git a/tools/testing/ktest/examples/vmware.conf b/tools/testing/ktest/examples/vmware.conf
new file mode 100644
index 000000000000..61958163d242
--- /dev/null
+++ b/tools/testing/ktest/examples/vmware.conf
@@ -0,0 +1,137 @@
+#
+# This config is an example usage of ktest.pl with a vmware guest
+#
+# VMware Setup:
+# -------------
+# - Edit the Virtual Machine ("Edit virtual machine settings")
+# - Add a Serial Port
+#   - You almost certainly want it set "Connect at power on"
+#   - Select "Use socket (named pipe)"
+#   - Select a name that you'll recognize, like 'ktestserialpipe'
+#   - From: Server
+#   - To: A Virtual Machine
+#   - Save
+# - Make sure you note the name, it will be in the base directory of the
+#   virtual machine (where the "disks" are stored.  The default
+#   is /var/lib/vmware/<virtual machine name>/<the name you entered above>
+#
+# - Make note of the path to the VM
+# </End VMware setup>
+#
+# The guest is called 'Guest' and this would be something that
+# could be run on the host to test a virtual machine target.
+
+MACHINE = Guest
+
+# Name of the serial pipe you set in the VMware settings
+VMWARE_SERIAL_NAME = <the name you entered above>
+
+# Define a variable of the name of the VM
+# Noting this needs to be the name of the kmx file, and usually, the
+# name of the directory that it's in.  If the directory and name
+# differ change the VMWARE_VM_DIR accordingly.
+# Please ommit the .kmx extension
+VMWARE_VM_NAME = <virtual machine name>
+
+# VM dir name.  This is usually the same as the virtual machine's name,
+# but not always the case.  Change if they differ
+VMWARE_VM_DIR = ${VMWARE_VM_NAME}
+
+# Base directory that the Virtual machine is contained in
+# /var/lib/vmware is the default on Linux
+VMWARE_VM_BASE_DIR = /var/lib/vmware/${VMWARE_VM_DIR}
+
+# Use ncat to read the unix pipe.  Anything that can read the Unix Pipe
+# and output it's contents to stdout will work
+CONSOLE = /usr/bin/ncat -U ${VMWARE_VM_BASE_DIR}/${VMWARE_SERIAL_NAME}
+
+# Define what version of Workstation you are using
+# This is used by vmrun to use the appropriate appripriate pieces to 
+# test this.  In all likelihood you want 'ws' or 'player' 
+# Valid options:
+# 	ws - Workstation (Windows or Linux host)
+# 	fusion - Fusion (Mac host)
+# 	player - Using VMware Player (Windows or Linux host)
+# Note: vmrun has to run directly on the host machine
+VMWARE_HOST_TYPE = ws
+
+# VMware provides `vmrun` to allow you to do certain things to the virtual machine
+# This should hard reset the VM and force a boot
+VMWARE_POWER_CYCLE = /usr/bin/vmrun -T ${VMWARE_HOST_TYPE} reset ${VMWARE_VM_BASE_DIR}/${VMWARE_VM_NAME}.kmx nogui
+
+#*************************************#
+# This part is the same as test.conf  #
+#*************************************#
+
+# The include files will set up the type of test to run. Just set TEST to
+# which test you want to run.
+#
+# TESTS = patchcheck, randconfig, boot, test, config-bisect, bisect, min-config
+#
+# See the include/*.conf files that define these tests
+#
+TEST := patchcheck
+
+# Some tests may have more than one test to run. Define MULTI := 1 to run
+# the extra tests.
+MULTI := 0
+
+# In case you want to differentiate which type of system you are testing
+BITS := 64
+
+# REBOOT = none, error, fail, empty
+#  See include/defaults.conf
+REBOOT := empty
+
+
+# The defaults file will set up various settings that can be used by all
+# machine configs.
+INCLUDE include/defaults.conf
+
+
+#*************************************#
+# Now we are different from test.conf #
+#*************************************#
+
+
+# The example here assumes that Guest is running a Fedora release
+# that uses dracut for its initfs. The POST_INSTALL will be executed
+# after the install of the kernel and modules are complete.
+#
+POST_INSTALL = ${SSH} /sbin/dracut -f /boot/initramfs-test.img $KERNEL_VERSION
+
+# Guests sometimes get stuck on reboot. We wait 3 seconds after running
+# the reboot command and then  do a full power-cycle of the guest.
+# This forces the guest to restart.
+#
+POWERCYCLE_AFTER_REBOOT = 3
+
+# We do the same after the halt command, but this time we wait 20 seconds.
+POWEROFF_AFTER_HALT = 20
+
+
+# As the defaults.conf file has a POWER_CYCLE option already defined,
+# and options can not be defined in the same section more than once
+# (all DEFAULTS sections are considered the same). We use the
+# DEFAULTS OVERRIDE to tell ktest.pl to ignore the previous defined
+# options, for the options set in the OVERRIDE section.
+#
+DEFAULTS OVERRIDE
+
+# Instead of using the default POWER_CYCLE option defined in
+# defaults.conf, we use virsh to cycle it. To do so, we destroy
+# the guest, wait 5 seconds, and then start it up again.
+# Crude, but effective.
+#
+POWER_CYCLE = ${VMWARE_POWER_CYCLE}
+
+
+DEFAULTS
+
+# The following files each handle a different test case.
+# Having them included allows you to set up more than one machine and share
+# the same tests.
+INCLUDE include/patchcheck.conf
+INCLUDE include/tests.conf
+INCLUDE include/bisect.conf
+INCLUDE include/min-config.conf
-- 
2.30.1


