Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2327F347132
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 06:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhCXFqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 01:46:00 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:52174 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbhCXFpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 01:45:30 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 12O5j0XP003907;
        Wed, 24 Mar 2021 14:45:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 12O5j0XP003907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1616564701;
        bh=KXPaQpy/+BxH76Yrb6MR6nf0/LRu7O58bf2V/MOIi0k=;
        h=From:To:Cc:Subject:Date:From;
        b=svsQFVCy8HCB5gGaFwiJstd/hNJLxDvLfb+A/in4B+jYY8J9RQMnMHKj3NaZtscKV
         dRxTpjGZWD7GXypP6K9EdZtMhuQDBDFNmDRPABeotiu4Dzislo3kH9fvejwdTUt44b
         im1ings2O/ubd1WWOqAD/1YUGivIE3dLfxHlLNymwt14UKOSVI8GH4ZdCoTw4oa3uC
         po5cSY9QFqvqiB386HKegFnzKU0HMAUM1SSGampSkUARcbeDKKX3l9XnFX0FrGcDXd
         dC+Mb0QOuVDpx6cVnRNFY4yQjYfQcfp+uk2ptN8o5lke264qldLnA/1RRi2nm05LKH
         qA1UgfbIeLv8Q==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] treewide: remove editor modelines and cruft
Date:   Wed, 24 Mar 2021 14:44:57 +0900
Message-Id: <20210324054457.1477489-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section "19) Editor modelines and other cruft" in
Documentation/process/coding-style.rst clearly says,
"Do not include any of these in source files."

I recently receive a patch to explicitly add a new one.

Let's do treewide cleanups, otherwise some people follow the existing
code and attempt to upstream their favoriate editor setups.

It is even nicer if scripts/checkpatch.pl can check it.

If we like to impose coding style in an editor-independent manner,
I think editorconfig (patch [1]) is a saner solution.

[1] https://lore.kernel.org/lkml/20200703073143.423557-1-danny@kdrag0n.dev/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

You might wonder if I worked on this huge patch manually or generated it by
a tool. I wrote a Python script to generate this patch, but not from a scratch.
I contributed a similar tool to U-Boot some years ago.
(https://github.com/u-boot/u-boot/commit/8ba1f5de4571566be12efaffdad404a506b978e3)
I reused and modified it.

For completeness, this is the code I wrote (ugly since this is not intended for upstream)


#!/usr/bin/env python3

import copy
import os
import re
import sys

pattern_local_variables = re.compile(r'Local (V|v)ariables')
pattern_end = re.compile(r'End:')
pattern_blank = re.compile(r'^\s*$')            #  empty line
pattern_comment_begin = re.compile(r'^(\s*)/\*')
pattern_comment_end = re.compile(r'\*/$')
pattern_comment_null = re.compile(r' \*$')
pattern_dash = re.compile(r'---------------')

def extend_matched_lines(lines, matched, pre_patterns, post_patterns, extend_pre,
                         extend_post):
    extended_matched = []

    j = matched[0]

    for i in matched:
        if i == 0 or i < j:
            continue
        j = i
        while j in matched:
            j += 1
        if j >= len(lines):
            break

        for p in pre_patterns:
            if p.search(lines[i - 1]):
                break
        else:
            # not matched
            continue

        for p in post_patterns:
            if p.search(lines[j]):
                break
        else:
            # not matched
            continue

        if extend_pre:
            extended_matched.append(i - 1)
        if extend_post:
            extended_matched.append(j)

    matched += extended_matched
    matched.sort()


def cleanup_one_file(filepath, patterns):

    #print(filepath)
    with open(filepath) as f:
        lines = f.readlines()

    matched = []
    for i, line in enumerate(lines):
        if i - 1 in matched and lines[i - 1][-2:] == '\\\n':
            matched.append(i)
            continue
        for pattern in patterns:
            if pattern.search(line):
                #print("hit {}".format(line), end='')
                m = pattern_comment_begin.match(line)
                if m and not pattern_comment_end.search(line):
                    #print("replace {}".format(line), end='')
                    lines[i] = m.group(1) + '/*\n'
                    if i + 1 < len(lines) and pattern_comment_end.search(lines[i + 1]):
                        matched.append(i)
                        matched.append(i + 1)
                else:
                    matched.append(i)
                break

    if not matched:
        return

    while True:
        old_matched = copy.copy(matched)
        extend_matched_lines(lines, matched, [pattern_local_variables],
                             [pattern_end], True, True)

        extend_matched_lines(lines, matched, [pattern_comment_begin],
                             [pattern_comment_end], True, True)
        extend_matched_lines(lines, matched, [pattern_blank, pattern_dash],
                             [pattern_comment_end], True, False)
        extend_matched_lines(lines, matched, [pattern_comment_begin, pattern_comment_null],
                             [pattern_comment_null], False, True)
        extend_matched_lines(lines, matched, [pattern_blank],
                             [pattern_blank], False, True)
        if matched == old_matched:
            break

    # remove blank lines at the end of file
    if matched and matched[-1] == len(lines) -1:
        i = matched[-1] - 1
        while i >= 0 and (i in matched or pattern_blank.search(lines[i])):
            matched.append(i)
            i -= 1
        matched.sort()

    with open(filepath, 'w') as f:
        for i, line in enumerate(lines):
            if i not in matched:
                f.write(line)

def main():

    cwd = os.getcwd()

    if len(sys.argv) > 1:
        topdir = os.path.join(cwd, sys.argv[1])
    else:
        topdir = cwd

    exclude_dirs = [ os.path.join(cwd, d) for d in ('.git', 'Documentation') ]

    # patterns to remove
    strings = ('c-indent-level:', 'tab-width:',
               'vim:', 'version-control:', 'c-basic-offset:',
               'indent-tabs-mode:', 'c-file-style:', 'fill-column:', 'kept-new-versions:',
               'ispell-local-dictionary', r'mode: (C|c)$', 'Emacs about preferred coding style',
               'c-indentation-style:', 'mode-name: ',
               'c-brace-imaginary-offset:', 'c-brace-offset:', 'c-argdecl-indent:', 'c-set-style:',
               'c-label-offset:', 'c-continued-statement-offset:', 'c-continued-brace-offset:',
               'Overrides for Emacs so that we almost follow',
               'Emacs will notice this stuff', 'adjust the settings for this buffer only',
               'Overrides for Emacs so that we follow', 'Make Linus happy',
               r'^ \* of the file.$'
    )

    patterns = []
    for s in strings:
        patterns.append(re.compile(s))

    for dirpath, dirnames, filenames in os.walk(topdir, topdown=True):
        # Prune unwanted directories.
        if dirpath in exclude_dirs:
            dirnames[:] = []
            continue

        for filename in filenames:
            if filename.endswith(('.c', '.h', '.py', '.sh')):
                cleanup_one_file(os.path.join(dirpath, filename), patterns)

if __name__ == '__main__':
    main()




 arch/m68k/atari/time.c                        |  7 -------
 arch/parisc/include/asm/pdc_chassis.h         |  1 -
 arch/um/drivers/cow.h                         |  7 -------
 drivers/auxdisplay/panel.c                    |  7 -------
 drivers/gpu/drm/qxl/qxl_drv.c                 |  1 -
 drivers/media/usb/pwc/pwc-uncompress.c        |  3 ---
 drivers/net/ethernet/adaptec/starfire.c       |  8 --------
 drivers/net/ethernet/amd/atarilance.c         |  8 --------
 drivers/net/ethernet/amd/pcnet32.c            |  7 -------
 .../intersil/orinoco/orinoco_nortel.c         |  8 --------
 .../wireless/intersil/orinoco/orinoco_pci.c   |  8 --------
 .../wireless/intersil/orinoco/orinoco_plx.c   |  8 --------
 .../wireless/intersil/orinoco/orinoco_tmd.c   |  8 --------
 drivers/parport/parport_ip32.c                | 12 -----------
 drivers/platform/x86/dell/dell_rbu.c          |  3 ---
 drivers/scsi/53c700.c                         |  1 -
 drivers/scsi/53c700.h                         |  1 -
 drivers/scsi/ch.c                             |  6 ------
 drivers/scsi/ips.c                            | 20 -------------------
 drivers/scsi/ips.h                            | 20 -------------------
 drivers/scsi/lasi700.c                        |  1 -
 drivers/scsi/megaraid/mbox_defs.h             |  2 --
 drivers/scsi/megaraid/mega_common.h           |  2 --
 drivers/scsi/megaraid/megaraid_mbox.c         |  2 --
 drivers/scsi/megaraid/megaraid_mbox.h         |  2 --
 drivers/scsi/qla1280.c                        | 12 -----------
 drivers/scsi/sni_53c710.c                     |  1 -
 drivers/staging/comedi/drivers/ni_routes.c    |  1 -
 drivers/staging/comedi/drivers/ni_routes.h    |  1 -
 .../drivers/ni_routing/ni_device_routes.c     |  1 -
 .../drivers/ni_routing/ni_device_routes.h     |  1 -
 .../drivers/ni_routing/ni_device_routes/all.h |  1 -
 .../ni_routing/ni_device_routes/pci-6070e.c   |  1 -
 .../ni_routing/ni_device_routes/pci-6220.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6221.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6229.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6251.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6254.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6259.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6534.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6602.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6713.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6723.c    |  1 -
 .../ni_routing/ni_device_routes/pci-6733.c    |  1 -
 .../ni_routing/ni_device_routes/pxi-6030e.c   |  1 -
 .../ni_routing/ni_device_routes/pxi-6224.c    |  1 -
 .../ni_routing/ni_device_routes/pxi-6225.c    |  1 -
 .../ni_routing/ni_device_routes/pxi-6251.c    |  1 -
 .../ni_routing/ni_device_routes/pxi-6733.c    |  1 -
 .../ni_routing/ni_device_routes/pxie-6251.c   |  1 -
 .../ni_routing/ni_device_routes/pxie-6535.c   |  1 -
 .../ni_routing/ni_device_routes/pxie-6738.c   |  1 -
 .../drivers/ni_routing/ni_route_values.c      |  1 -
 .../drivers/ni_routing/ni_route_values.h      |  1 -
 .../drivers/ni_routing/ni_route_values/all.h  |  1 -
 .../ni_routing/ni_route_values/ni_660x.c      |  1 -
 .../ni_routing/ni_route_values/ni_eseries.c   |  1 -
 .../ni_routing/ni_route_values/ni_mseries.c   |  1 -
 .../ni_routing/tools/convert_c_to_py.c        |  1 -
 .../ni_routing/tools/convert_csv_to_c.py      |  7 -------
 .../ni_routing/tools/convert_py_to_csv.py     |  1 -
 .../ni_routing/tools/csv_collection.py        |  1 -
 .../ni_routing/tools/make_blank_csv.py        |  1 -
 .../drivers/ni_routing/tools/ni_names.py      |  1 -
 .../comedi/drivers/tests/example_test.c       |  1 -
 .../comedi/drivers/tests/ni_routes_test.c     |  1 -
 .../staging/comedi/drivers/tests/unittest.h   |  1 -
 drivers/video/fbdev/matrox/matroxfb_base.c    |  9 ---------
 drivers/video/fbdev/vga16fb.c                 | 10 ----------
 fs/configfs/configfs_internal.h               |  4 +---
 fs/configfs/dir.c                             |  4 +---
 fs/configfs/file.c                            |  4 +---
 fs/configfs/inode.c                           |  4 +---
 fs/configfs/item.c                            |  4 +---
 fs/configfs/mount.c                           |  4 +---
 fs/configfs/symlink.c                         |  4 +---
 fs/nfs/dir.c                                  |  7 -------
 fs/nfs/nfs4proc.c                             |  6 ------
 fs/nfs/nfs4renewd.c                           |  6 ------
 fs/nfs/nfs4state.c                            |  6 ------
 fs/nfs/nfs4xdr.c                              |  6 ------
 fs/nfsd/nfs4proc.c                            |  6 ------
 fs/nfsd/nfs4xdr.c                             |  6 ------
 fs/nfsd/xdr4.h                                |  6 ------
 fs/ocfs2/acl.c                                |  4 +---
 fs/ocfs2/acl.h                                |  4 +---
 fs/ocfs2/alloc.c                              |  4 +---
 fs/ocfs2/alloc.h                              |  4 +---
 fs/ocfs2/aops.c                               |  4 +---
 fs/ocfs2/aops.h                               |  4 +---
 fs/ocfs2/blockcheck.c                         |  4 +---
 fs/ocfs2/blockcheck.h                         |  4 +---
 fs/ocfs2/buffer_head_io.c                     |  4 +---
 fs/ocfs2/buffer_head_io.h                     |  4 +---
 fs/ocfs2/cluster/heartbeat.c                  |  4 +---
 fs/ocfs2/cluster/heartbeat.h                  |  4 +---
 fs/ocfs2/cluster/masklog.c                    |  4 +---
 fs/ocfs2/cluster/masklog.h                    |  4 +---
 fs/ocfs2/cluster/netdebug.c                   |  4 +---
 fs/ocfs2/cluster/nodemanager.c                |  4 +---
 fs/ocfs2/cluster/nodemanager.h                |  4 +---
 fs/ocfs2/cluster/ocfs2_heartbeat.h            |  4 +---
 fs/ocfs2/cluster/ocfs2_nodemanager.h          |  4 +---
 fs/ocfs2/cluster/quorum.c                     |  4 +---
 fs/ocfs2/cluster/quorum.h                     |  4 +---
 fs/ocfs2/cluster/sys.c                        |  4 +---
 fs/ocfs2/cluster/sys.h                        |  4 +---
 fs/ocfs2/cluster/tcp.c                        |  4 +---
 fs/ocfs2/cluster/tcp.h                        |  4 +---
 fs/ocfs2/cluster/tcp_internal.h               |  4 +---
 fs/ocfs2/dcache.c                             |  4 +---
 fs/ocfs2/dcache.h                             |  4 +---
 fs/ocfs2/dir.c                                |  4 +---
 fs/ocfs2/dir.h                                |  4 +---
 fs/ocfs2/dlm/dlmapi.h                         |  4 +---
 fs/ocfs2/dlm/dlmast.c                         |  4 +---
 fs/ocfs2/dlm/dlmcommon.h                      |  4 +---
 fs/ocfs2/dlm/dlmconvert.c                     |  4 +---
 fs/ocfs2/dlm/dlmconvert.h                     |  4 +---
 fs/ocfs2/dlm/dlmdebug.c                       |  4 +---
 fs/ocfs2/dlm/dlmdebug.h                       |  4 +---
 fs/ocfs2/dlm/dlmdomain.c                      |  4 +---
 fs/ocfs2/dlm/dlmdomain.h                      |  4 +---
 fs/ocfs2/dlm/dlmlock.c                        |  4 +---
 fs/ocfs2/dlm/dlmmaster.c                      |  4 +---
 fs/ocfs2/dlm/dlmrecovery.c                    |  4 +---
 fs/ocfs2/dlm/dlmthread.c                      |  4 +---
 fs/ocfs2/dlm/dlmunlock.c                      |  4 +---
 fs/ocfs2/dlmfs/dlmfs.c                        |  4 +---
 fs/ocfs2/dlmfs/userdlm.c                      |  4 +---
 fs/ocfs2/dlmfs/userdlm.h                      |  4 +---
 fs/ocfs2/dlmglue.c                            |  4 +---
 fs/ocfs2/dlmglue.h                            |  4 +---
 fs/ocfs2/export.c                             |  4 +---
 fs/ocfs2/export.h                             |  4 +---
 fs/ocfs2/extent_map.c                         |  4 +---
 fs/ocfs2/extent_map.h                         |  4 +---
 fs/ocfs2/file.c                               |  4 +---
 fs/ocfs2/file.h                               |  4 +---
 fs/ocfs2/filecheck.c                          |  4 +---
 fs/ocfs2/filecheck.h                          |  4 +---
 fs/ocfs2/heartbeat.c                          |  4 +---
 fs/ocfs2/heartbeat.h                          |  4 +---
 fs/ocfs2/inode.c                              |  4 +---
 fs/ocfs2/inode.h                              |  4 +---
 fs/ocfs2/journal.c                            |  4 +---
 fs/ocfs2/journal.h                            |  4 +---
 fs/ocfs2/localalloc.c                         |  4 +---
 fs/ocfs2/localalloc.h                         |  4 +---
 fs/ocfs2/locks.c                              |  4 +---
 fs/ocfs2/locks.h                              |  4 +---
 fs/ocfs2/mmap.c                               |  4 +---
 fs/ocfs2/move_extents.c                       |  4 +---
 fs/ocfs2/move_extents.h                       |  4 +---
 fs/ocfs2/namei.c                              |  4 +---
 fs/ocfs2/namei.h                              |  4 +---
 fs/ocfs2/ocfs1_fs_compat.h                    |  4 +---
 fs/ocfs2/ocfs2.h                              |  4 +---
 fs/ocfs2/ocfs2_fs.h                           |  4 +---
 fs/ocfs2/ocfs2_ioctl.h                        |  4 +---
 fs/ocfs2/ocfs2_lockid.h                       |  4 +---
 fs/ocfs2/ocfs2_lockingver.h                   |  4 +---
 fs/ocfs2/refcounttree.c                       |  4 +---
 fs/ocfs2/refcounttree.h                       |  4 +---
 fs/ocfs2/reservations.c                       |  4 +---
 fs/ocfs2/reservations.h                       |  4 +---
 fs/ocfs2/resize.c                             |  4 +---
 fs/ocfs2/resize.h                             |  4 +---
 fs/ocfs2/slot_map.c                           |  4 +---
 fs/ocfs2/slot_map.h                           |  4 +---
 fs/ocfs2/stack_o2cb.c                         |  4 +---
 fs/ocfs2/stack_user.c                         |  4 +---
 fs/ocfs2/stackglue.c                          |  4 +---
 fs/ocfs2/stackglue.h                          |  4 +---
 fs/ocfs2/suballoc.c                           |  4 +---
 fs/ocfs2/suballoc.h                           |  4 +---
 fs/ocfs2/super.c                              |  4 +---
 fs/ocfs2/super.h                              |  4 +---
 fs/ocfs2/symlink.c                            |  4 +---
 fs/ocfs2/symlink.h                            |  4 +---
 fs/ocfs2/sysfile.c                            |  4 +---
 fs/ocfs2/sysfile.h                            |  4 +---
 fs/ocfs2/uptodate.c                           |  4 +---
 fs/ocfs2/uptodate.h                           |  4 +---
 fs/ocfs2/xattr.c                              |  4 +---
 fs/ocfs2/xattr.h                              |  4 +---
 fs/reiserfs/procfs.c                          | 10 ----------
 include/linux/configfs.h                      |  4 +---
 include/linux/genl_magic_func.h               |  1 -
 include/linux/genl_magic_struct.h             |  1 -
 include/uapi/linux/if_bonding.h               | 11 ----------
 include/uapi/linux/nfs4.h                     |  6 ------
 include/xen/interface/elfnote.h               | 10 ----------
 include/xen/interface/hvm/hvm_vcpu.h          | 10 ----------
 include/xen/interface/io/xenbus.h             | 10 ----------
 samples/configfs/configfs_sample.c            |  2 --
 tools/usb/hcd-tests.sh                        |  2 --
 197 files changed, 110 insertions(+), 673 deletions(-)

diff --git a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
index 1068670cb741..7e44d0e9d0f8 100644
--- a/arch/m68k/atari/time.c
+++ b/arch/m68k/atari/time.c
@@ -317,10 +317,3 @@ int atari_tt_hwclk( int op, struct rtc_time *t )
 
     return( 0 );
 }
-
-/*
- * Local variables:
- *  c-indent-level: 4
- *  tab-width: 8
- * End:
- */
diff --git a/arch/parisc/include/asm/pdc_chassis.h b/arch/parisc/include/asm/pdc_chassis.h
index ae3e108d22ad..d6d82f53d3d0 100644
--- a/arch/parisc/include/asm/pdc_chassis.h
+++ b/arch/parisc/include/asm/pdc_chassis.h
@@ -365,4 +365,3 @@ void parisc_pdc_chassis_init(void);
 					 PDC_CHASSIS_EOM_SET		)
 
 #endif /* _PARISC_PDC_CHASSIS_H */
-/* vim: set ts=8 */
diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
index 103adac691ed..9a67c017000f 100644
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -24,10 +24,3 @@ extern void cow_sizes(int version, __u64 size, int sectorsize, int align,
 		      int *data_offset_out);
 
 #endif
-
-/*
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index ff5755ee5694..eba04c0de7eb 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1737,10 +1737,3 @@ module_init(panel_init_module);
 module_exit(panel_cleanup_module);
 MODULE_AUTHOR("Willy Tarreau");
 MODULE_LICENSE("GPL");
-
-/*
- * Local variables:
- *  c-indent-level: 4
- *  tab-width: 8
- * End:
- */
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 1864467f1063..6754f578fed2 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -1,4 +1,3 @@
-/* vim: set ts=8 sw=8 tw=78 ai noexpandtab */
 /* qxl_drv.c -- QXL driver -*- linux-c -*-
  *
  * Copyright 2011 Red Hat, Inc.
diff --git a/drivers/media/usb/pwc/pwc-uncompress.c b/drivers/media/usb/pwc/pwc-uncompress.c
index abfc88391036..68bc3829c6b3 100644
--- a/drivers/media/usb/pwc/pwc-uncompress.c
+++ b/drivers/media/usb/pwc/pwc-uncompress.c
@@ -9,9 +9,6 @@
    Please send bug reports and support requests to <luc@saillard.org>.
    The decompression routines have been implemented by reverse-engineering the
    Nemosoft binary pwcx module. Caveat emptor.
-
-
-   vim: set ts=8:
 */
 
 #include <asm/current.h>
diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index 555299737b51..7965e5e3c985 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -2070,11 +2070,3 @@ static void __exit starfire_cleanup (void)
 
 module_init(starfire_init);
 module_exit(starfire_cleanup);
-
-
-/*
- * Local variables:
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
diff --git a/drivers/net/ethernet/amd/atarilance.c b/drivers/net/ethernet/amd/atarilance.c
index 961796abab35..c1eab916438f 100644
--- a/drivers/net/ethernet/amd/atarilance.c
+++ b/drivers/net/ethernet/amd/atarilance.c
@@ -1156,11 +1156,3 @@ static void __exit atarilance_module_exit(void)
 module_init(atarilance_module_init);
 module_exit(atarilance_module_exit);
 #endif /* MODULE */
-
-
-/*
- * Local variables:
- *  c-indent-level: 4
- *  tab-width: 4
- * End:
- */
diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 187b0b9a6e1d..5ef5d27a9445 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -3029,10 +3029,3 @@ static void __exit pcnet32_cleanup_module(void)
 
 module_init(pcnet32_init_module);
 module_exit(pcnet32_cleanup_module);
-
-/*
- * Local variables:
- *  c-indent-level: 4
- *  tab-width: 8
- * End:
- */
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_nortel.c b/drivers/net/wireless/intersil/orinoco/orinoco_nortel.c
index 96a03d10a080..18bd0d9876c2 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_nortel.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_nortel.c
@@ -312,11 +312,3 @@ static void __exit orinoco_nortel_exit(void)
 
 module_init(orinoco_nortel_init);
 module_exit(orinoco_nortel_exit);
-
-/*
- * Local variables:
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_pci.c b/drivers/net/wireless/intersil/orinoco/orinoco_pci.c
index f3c86b07b1b9..7e3a6dd60c15 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_pci.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_pci.c
@@ -255,11 +255,3 @@ static void __exit orinoco_pci_exit(void)
 
 module_init(orinoco_pci_init);
 module_exit(orinoco_pci_exit);
-
-/*
- * Local variables:
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_plx.c b/drivers/net/wireless/intersil/orinoco/orinoco_plx.c
index 16dada94c774..73e6ae124013 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_plx.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_plx.c
@@ -360,11 +360,3 @@ static void __exit orinoco_plx_exit(void)
 
 module_init(orinoco_plx_init);
 module_exit(orinoco_plx_exit);
-
-/*
- * Local variables:
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_tmd.c b/drivers/net/wireless/intersil/orinoco/orinoco_tmd.c
index 9a9d335611ac..939d5a1dce97 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_tmd.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_tmd.c
@@ -235,11 +235,3 @@ static void __exit orinoco_tmd_exit(void)
 
 module_init(orinoco_tmd_init);
 module_exit(orinoco_tmd_exit);
-
-/*
- * Local variables:
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index 48b084e86dc6..0919ed99ba94 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -2224,15 +2224,3 @@ MODULE_PARM_DESC(features,
 		 ", bit 2: hardware SPP mode"
 		 ", bit 3: hardware EPP mode"
 		 ", bit 4: hardware ECP mode");
-
-/*--- Inform (X)Emacs about preferred coding style ---------------------*/
-/*
- * Local Variables:
- * mode: c
- * c-file-style: "linux"
- * indent-tabs-mode: t
- * tab-width: 8
- * fill-column: 78
- * ispell-local-dictionary: "american"
- * End:
- */
diff --git a/drivers/platform/x86/dell/dell_rbu.c b/drivers/platform/x86/dell/dell_rbu.c
index 03c3ff34bcf5..085ad0a0d22e 100644
--- a/drivers/platform/x86/dell/dell_rbu.c
+++ b/drivers/platform/x86/dell/dell_rbu.c
@@ -675,6 +675,3 @@ static __exit void dcdrbu_exit(void)
 
 module_exit(dcdrbu_exit);
 module_init(dcdrbu_init);
-
-/* vim:noet:ts=8:sw=8
-*/
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 3242ff63986f..f51f665bcb94 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8 -*- */
 
 /* NCR (or Symbios) 53c700 and 53c700-66 Driver
  *
diff --git a/drivers/scsi/53c700.h b/drivers/scsi/53c700.h
index c9f8c497babb..2df347ca91af 100644
--- a/drivers/scsi/53c700.h
+++ b/drivers/scsi/53c700.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* -*- mode: c; c-basic-offset: 8 -*- */
 
 /* Driver for 53c700 and 53c700-66 chips from NCR and Symbios
  *
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index cb74ab1ae5a4..9b89c26ccfdb 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -1058,9 +1058,3 @@ static void __exit exit_ch_module(void)
 
 module_init(init_ch_module);
 module_exit(exit_ch_module);
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 1a3c534826ba..bc33d54a4011 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -7099,23 +7099,3 @@ ips_init_phase2(int index)
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IBM ServeRAID Adapter Driver " IPS_VER_STRING);
 MODULE_VERSION(IPS_VER_STRING);
-
-
-/*
- * Overrides for Emacs so that we almost follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 2
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -2
- * c-argdecl-indent: 2
- * c-label-offset: -2
- * c-continued-statement-offset: 2
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
diff --git a/drivers/scsi/ips.h b/drivers/scsi/ips.h
index 6c0678fb9a67..65edf000e447 100644
--- a/drivers/scsi/ips.h
+++ b/drivers/scsi/ips.h
@@ -1211,23 +1211,3 @@ typedef struct {
       IPS_COMPAT_TAMPA, \
       IPS_COMPAT_KEYWEST \
    }
-
-
-/*
- * Overrides for Emacs so that we almost follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 2
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -2
- * c-argdecl-indent: 2
- * c-label-offset: -2
- * c-continued-statement-offset: 2
- * c-continued-brace-offset: 0
- * indent-tabs-mode: nil
- * tab-width: 8
- * End:
- */
diff --git a/drivers/scsi/lasi700.c b/drivers/scsi/lasi700.c
index de71d240a56f..6d14a7a94d0b 100644
--- a/drivers/scsi/lasi700.c
+++ b/drivers/scsi/lasi700.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8 -*- */
 
 /* PARISC LASI driver for the 53c700 chip
  *
diff --git a/drivers/scsi/megaraid/mbox_defs.h b/drivers/scsi/megaraid/mbox_defs.h
index 01a1bfb8ea2a..f0ef8f7f82c1 100644
--- a/drivers/scsi/megaraid/mbox_defs.h
+++ b/drivers/scsi/megaraid/mbox_defs.h
@@ -781,5 +781,3 @@ typedef struct {
 } __attribute__ ((packed)) mbox_sgl32;
 
 #endif		// _MRAID_MBOX_DEFS_H_
-
-/* vim: set ts=8 sw=8 tw=78: */
diff --git a/drivers/scsi/megaraid/mega_common.h b/drivers/scsi/megaraid/mega_common.h
index 3a7596e47a88..2ad0aa2f837d 100644
--- a/drivers/scsi/megaraid/mega_common.h
+++ b/drivers/scsi/megaraid/mega_common.h
@@ -282,5 +282,3 @@ struct mraid_pci_blk {
 };
 
 #endif // _MEGA_COMMON_H_
-
-// vim: set ts=8 sw=8 tw=78:
diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index d57e93872d7b..97ccfb24f7fa 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -4068,5 +4068,3 @@ megaraid_sysfs_show_ldnum(struct device *dev, struct device_attribute *attr, cha
  */
 module_init(megaraid_init);
 module_exit(megaraid_exit);
-
-/* vim: set ts=8 sw=8 tw=78 ai si: */
diff --git a/drivers/scsi/megaraid/megaraid_mbox.h b/drivers/scsi/megaraid/megaraid_mbox.h
index 3e4347c6dab1..d2fe7f69cd5d 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.h
+++ b/drivers/scsi/megaraid/megaraid_mbox.h
@@ -230,5 +230,3 @@ typedef struct {
 #define WROUTDOOR(rdev, value)	writel(value, (rdev)->baseaddr + 0x2C)
 
 #endif // _MEGARAID_H_
-
-// vim: set ts=8 sw=8 tw=78:
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 46de2541af25..337a1b15f0a0 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -4403,15 +4403,3 @@ MODULE_FIRMWARE("qlogic/1040.bin");
 MODULE_FIRMWARE("qlogic/1280.bin");
 MODULE_FIRMWARE("qlogic/12160.bin");
 MODULE_VERSION(QLA1280_VERSION);
-
-/*
- * Overrides for Emacs so that we almost follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-basic-offset: 8
- * tab-width: 8
- * End:
- */
diff --git a/drivers/scsi/sni_53c710.c b/drivers/scsi/sni_53c710.c
index 9e2e196bc202..0b94cdf37a4e 100644
--- a/drivers/scsi/sni_53c710.c
+++ b/drivers/scsi/sni_53c710.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8 -*- */
 
 /* SNI RM driver
  *
diff --git a/drivers/staging/comedi/drivers/ni_routes.c b/drivers/staging/comedi/drivers/ni_routes.c
index c426a9286f15..1f2aa3b239a0 100644
--- a/drivers/staging/comedi/drivers/ni_routes.c
+++ b/drivers/staging/comedi/drivers/ni_routes.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routes.c
  *  Route information for NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routes.h b/drivers/staging/comedi/drivers/ni_routes.h
index b7680fd2afe1..036982315584 100644
--- a/drivers/staging/comedi/drivers/ni_routes.h
+++ b/drivers/staging/comedi/drivers/ni_routes.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routes.h
  *  Route information for NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.c
index 7b6a74dfe48b..58654c2b12d6 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.h b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.h
index b9f1c47d19e1..09e4e172c659 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.h
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/all.h b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/all.h
index 78b24138acb7..001dbb88a874 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/all.h
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/all.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/all.h
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
index f1126a0cb285..7d3064c92643 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
index 74a59222963f..e2c462edb8ec 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
index 44dcbabf2a99..9e02ec0a66ad 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
index fa5794e4e2b3..33f7fff61f74 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
index 645fd1cd2de4..dde676b73624 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
index 056a240cd3a2..167a2da97c14 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
index e0b5fa78c3bc..ba990f98590c 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
index a2472ed288cf..f8d2a91b6c0a 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
index 91de9dac2d6a..2eee91f590eb 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
index d378b36d2084..c07ef3584a4b 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
index e0cc57ab06e7..c37373f8f0e1 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
index f6e1e17ab854..f252fbe19638 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
index 9978d632117f..4ccba4fdf3bc 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
index 1b89e27d7aa5..84fdfa2ef9a7 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
index 10dfc34bc87c..2b99ce0f87a4 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
index 25db4b7363de..1c5164c46306 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
index 27da4433fc4a..a3402b1ca6e8 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
index 8354fe971d59..defcc4cfe1e4 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
index 2ebb679e0129..d2013b9e6767 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
index d88504314d7f..89aff39a4fc2 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values.c b/drivers/staging/comedi/drivers/ni_routing/ni_route_values.c
index 5901762734ed..54a740b39819 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_route_values.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_route_values.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values.c
  *  Route information for NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values.h b/drivers/staging/comedi/drivers/ni_routing/ni_route_values.h
index 80e0145fb82b..6e358efa6f7f 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_route_values.h
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_route_values.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values.h
  *  Route information for NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/all.h b/drivers/staging/comedi/drivers/ni_routing/ni_route_values/all.h
index 7227461500b5..30761e55f746 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/all.h
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_route_values/all.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values/all.h
  *  List of valid routes for specific NI boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_660x.c b/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
index f1c7e6646261..aace60e49507 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values/ni_660x.c
  *  Route information for NI_660X boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c b/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
index d1ab3c9ce585..7a52f024cdbd 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
  *  Route information for NI_ESERIES boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c b/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
index c59d8afe0ae9..d1ddd13b33b5 100644
--- a/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
+++ b/drivers/staging/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
  *  Route information for NI_MSERIES boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/staging/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index dedb6f2fc678..d55521b5bdcb 100644
--- a/drivers/staging/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/staging/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 
 #include <stdint.h>
 #include <stdbool.h>
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/convert_csv_to_c.py b/drivers/staging/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
index 532eb6372a5a..90378fb50580 100755
--- a/drivers/staging/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
+++ b/drivers/staging/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
@@ -1,6 +1,5 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 
 # This is simply to aide in creating the entries in the order of the value of
 # the device-global NI signal/terminal constants defined in comedi.h
@@ -123,7 +122,6 @@ class DeviceRoutes(CSVCollection):
 
   output_file_top = """\
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  List of valid routes for specific NI boards.
@@ -155,7 +153,6 @@ class DeviceRoutes(CSVCollection):
 
   extern_header = """\
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  List of valid routes for specific NI boards.
@@ -193,7 +190,6 @@ class DeviceRoutes(CSVCollection):
 
   single_output_file_top = """\
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  List of valid routes for specific NI boards.
@@ -299,7 +295,6 @@ class RouteValues(CSVCollection):
 
   output_file_top = """\
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  Route information for NI boards.
@@ -337,7 +332,6 @@ class RouteValues(CSVCollection):
 
   extern_header = """\
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  List of valid routes for specific NI boards.
@@ -375,7 +369,6 @@ class RouteValues(CSVCollection):
 
   single_output_file_top = """\
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  Route information for {sheet} boards.
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/convert_py_to_csv.py b/drivers/staging/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
index b3e6472bac22..a273b33edb8f 100755
--- a/drivers/staging/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
+++ b/drivers/staging/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
@@ -1,6 +1,5 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 
 from os import path
 import os, csv
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/csv_collection.py b/drivers/staging/comedi/drivers/ni_routing/tools/csv_collection.py
index 12617329a928..db977ecb4307 100644
--- a/drivers/staging/comedi/drivers/ni_routing/tools/csv_collection.py
+++ b/drivers/staging/comedi/drivers/ni_routing/tools/csv_collection.py
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 
 import os, csv, glob
 
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/make_blank_csv.py b/drivers/staging/comedi/drivers/ni_routing/tools/make_blank_csv.py
index 89c90a0ba24d..c00eaf803299 100755
--- a/drivers/staging/comedi/drivers/ni_routing/tools/make_blank_csv.py
+++ b/drivers/staging/comedi/drivers/ni_routing/tools/make_blank_csv.py
@@ -1,6 +1,5 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 
 from os import path
 import os, csv
diff --git a/drivers/staging/comedi/drivers/ni_routing/tools/ni_names.py b/drivers/staging/comedi/drivers/ni_routing/tools/ni_names.py
index 5f9b825968b1..d4df5f29e3e5 100644
--- a/drivers/staging/comedi/drivers/ni_routing/tools/ni_names.py
+++ b/drivers/staging/comedi/drivers/ni_routing/tools/ni_names.py
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 """
 This file helps to extract string names of NI signals as included in comedi.h
 between NI_NAMES_BASE and NI_NAMES_BASE+NI_NUM_NAMES.
diff --git a/drivers/staging/comedi/drivers/tests/example_test.c b/drivers/staging/comedi/drivers/tests/example_test.c
index fc65158b8e8e..dd94f5dc15ec 100644
--- a/drivers/staging/comedi/drivers/tests/example_test.c
+++ b/drivers/staging/comedi/drivers/tests/example_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/tests/example_test.c
  *  Example set of unit tests.
diff --git a/drivers/staging/comedi/drivers/tests/ni_routes_test.c b/drivers/staging/comedi/drivers/tests/ni_routes_test.c
index 4061b3b5f8e9..23c296a7538d 100644
--- a/drivers/staging/comedi/drivers/tests/ni_routes_test.c
+++ b/drivers/staging/comedi/drivers/tests/ni_routes_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/tests/ni_routes_test.c
  *  Unit tests for NI routes (ni_routes.c module).
diff --git a/drivers/staging/comedi/drivers/tests/unittest.h b/drivers/staging/comedi/drivers/tests/unittest.h
index b8e622ea1de1..cd4c990e7547 100644
--- a/drivers/staging/comedi/drivers/tests/unittest.h
+++ b/drivers/staging/comedi/drivers/tests/unittest.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/tests/unittest.h
  *  Simple framework for unittests for comedi drivers.
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index a3853421b263..4325bf7f388c 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -2608,12 +2608,3 @@ EXPORT_SYMBOL(matroxfb_register_driver);
 EXPORT_SYMBOL(matroxfb_unregister_driver);
 EXPORT_SYMBOL(matroxfb_wait_for_sync);
 EXPORT_SYMBOL(matroxfb_enable_irq);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
-
diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 1e8a38a7967d..e2757ff1c23d 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1451,13 +1451,3 @@ MODULE_DESCRIPTION("Legacy VGA framebuffer device driver");
 MODULE_LICENSE("GPL");
 module_init(vga16fb_init);
 module_exit(vga16fb_exit);
-
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
-
diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 9a3aed249692..c0395363eab9 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset:8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * configfs_internal.h - Internal stuff for configfs
  *
  * Based on sysfs:
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index b6098e02e20b..ac5e0c0e9181 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dir.c - Operations for configfs directories.
  *
  * Based on sysfs:
diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index da8351d1e455..e26060dae70a 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * file.c - operations for regular (text) files.
  *
  * Based on sysfs:
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index 42c348bb2903..eb5ec3e46283 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * inode.c - basic inode and dentry operations.
  *
  * Based on sysfs:
diff --git a/fs/configfs/item.c b/fs/configfs/item.c
index 704a4356f137..254170a82aa3 100644
--- a/fs/configfs/item.c
+++ b/fs/configfs/item.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * item.c - library routines for handling generic config items
  *
  * Based on kobject:
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 0c6e8cf61953..c2d820063ec4 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * mount.c - operations for initializing and mounting configfs.
  *
  * Based on sysfs:
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 77c854364e60..0623c3edcfb9 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * symlink.c - operations for configfs symlinks.
  *
  * Based on sysfs:
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index fc4f490f2d78..3d8e3698d3df 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -3004,10 +3004,3 @@ int nfs_permission(struct user_namespace *mnt_userns,
 	goto out;
 }
 EXPORT_SYMBOL_GPL(nfs_permission);
-
-/*
- * Local variables:
- *  version-control: t
- *  kept-new-versions: 5
- * End:
- */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c65c4b41e2c1..545010d6cbf3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10427,9 +10427,3 @@ const struct xattr_handler *nfs4_xattr_handlers[] = {
 #endif
 	NULL
 };
-
-/*
- * Local variables:
- *  c-basic-offset: 8
- * End:
- */
diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index ff876dda7f06..db3811af0796 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -149,9 +149,3 @@ void nfs4_set_lease_period(struct nfs_client *clp,
 	/* Cap maximum reconnect timeout at 1/2 lease period */
 	rpc_set_connect_timeout(clp->cl_rpcclient, lease, lease >> 1);
 }
-
-/*
- * Local variables:
- *   c-basic-offset: 8
- * End:
- */
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 3a51351bdc6a..2eec5bbb55c8 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2695,9 +2695,3 @@ static int nfs4_run_state_manager(void *ptr)
 	module_put_and_exit(0);
 	return 0;
 }
-
-/*
- * Local variables:
- *  c-basic-offset: 8
- * End:
- */
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index ac6b79ee9355..d4fd3be0e8ca 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7629,9 +7629,3 @@ const struct rpc_version nfs_version4 = {
 	.procs			= nfs4_procedures,
 	.counts			= nfs_version4_counts,
 };
-
-/*
- * Local variables:
- *  c-basic-offset: 8
- * End:
- */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index dd9f38d072dd..79c4219f6801 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3329,9 +3329,3 @@ const struct svc_version nfsd_version4 = {
 	.vs_rpcb_optnl		= true,
 	.vs_need_cong_ctrl	= true,
 };
-
-/*
- * Local variables:
- *  c-basic-offset: 8
- * End:
- */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index eaaa1605b5b5..4fc983ebbf82 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5448,9 +5448,3 @@ nfs4svc_encode_compoundres(struct svc_rqst *rqstp, __be32 *p)
 	nfsd4_sequence_done(resp);
 	return 1;
 }
-
-/*
- * Local variables:
- *  c-basic-offset: 8
- * End:
- */
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index c300885ae75d..a9c1412abec2 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -866,9 +866,3 @@ struct nfsd4_operation {
 
 
 #endif
-
-/*
- * Local variables:
- *  c-basic-offset: 8
- * End:
- */
diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 5259badabb56..5c72a7e6d6c5 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * acl.c
  *
  * Copyright (C) 2004, 2008 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/acl.h b/fs/ocfs2/acl.h
index 4e86450917b2..f59d8d0a61fa 100644
--- a/fs/ocfs2/acl.h
+++ b/fs/ocfs2/acl.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * acl.h
  *
  * Copyright (C) 2004, 2008 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 78710788c237..e032f2e2c2c5 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * alloc.c
  *
  * Extent allocs and frees
diff --git a/fs/ocfs2/alloc.h b/fs/ocfs2/alloc.h
index 7f973dd76dbc..4af7abaa6e40 100644
--- a/fs/ocfs2/alloc.h
+++ b/fs/ocfs2/alloc.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * alloc.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 3bfb4147895a..789189e25428 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * Copyright (C) 2002, 2004 Oracle.  All rights reserved.
  */
 
diff --git a/fs/ocfs2/aops.h b/fs/ocfs2/aops.h
index 70ed4382750d..3a520117fa59 100644
--- a/fs/ocfs2/aops.h
+++ b/fs/ocfs2/aops.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * Copyright (C) 2002, 2004, 2005 Oracle.  All rights reserved.
  */
 
diff --git a/fs/ocfs2/blockcheck.c b/fs/ocfs2/blockcheck.c
index 6e07ddb0e3c0..05434fce302e 100644
--- a/fs/ocfs2/blockcheck.c
+++ b/fs/ocfs2/blockcheck.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * blockcheck.c
  *
  * Checksum and ECC codes for the OCFS2 userspace library.
diff --git a/fs/ocfs2/blockcheck.h b/fs/ocfs2/blockcheck.h
index 8f17d2c85f40..d0578e98ee8d 100644
--- a/fs/ocfs2/blockcheck.h
+++ b/fs/ocfs2/blockcheck.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * blockcheck.h
  *
  * Checksum and ECC codes for the OCFS2 userspace library.
diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index f0b104e483d8..e7758778abef 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * io.c
  *
  * Buffer cache handling
diff --git a/fs/ocfs2/buffer_head_io.h b/fs/ocfs2/buffer_head_io.h
index 1c5e533fba04..2d51649fc090 100644
--- a/fs/ocfs2/buffer_head_io.h
+++ b/fs/ocfs2/buffer_head_io.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * ocfs2_buffer_head.h
  *
  * Buffer cache handling functions defined
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 12a7590601dd..e829c2595543 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
  */
 
diff --git a/fs/ocfs2/cluster/heartbeat.h b/fs/ocfs2/cluster/heartbeat.h
index beed31ea86cf..1d4100abf6f8 100644
--- a/fs/ocfs2/cluster/heartbeat.h
+++ b/fs/ocfs2/cluster/heartbeat.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * heartbeat.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 1d696c96b8b2..810d32815593 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
  */
 
diff --git a/fs/ocfs2/cluster/masklog.h b/fs/ocfs2/cluster/masklog.h
index 446e452ac7a6..b73fc42e46ff 100644
--- a/fs/ocfs2/cluster/masklog.h
+++ b/fs/ocfs2/cluster/masklog.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * Copyright (C) 2005 Oracle.  All rights reserved.
  */
 
diff --git a/fs/ocfs2/cluster/netdebug.c b/fs/ocfs2/cluster/netdebug.c
index 667a5c5e1f66..7524994e3199 100644
--- a/fs/ocfs2/cluster/netdebug.c
+++ b/fs/ocfs2/cluster/netdebug.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * netdebug.c
  *
  * debug functionality for o2net
diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index 7a7640c59f3c..bb82e6b1ff4e 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
  */
 
diff --git a/fs/ocfs2/cluster/nodemanager.h b/fs/ocfs2/cluster/nodemanager.h
index 3e0006631cc4..3490e77a952d 100644
--- a/fs/ocfs2/cluster/nodemanager.h
+++ b/fs/ocfs2/cluster/nodemanager.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * nodemanager.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/cluster/ocfs2_heartbeat.h b/fs/ocfs2/cluster/ocfs2_heartbeat.h
index 760d850be11e..6088c9f974dd 100644
--- a/fs/ocfs2/cluster/ocfs2_heartbeat.h
+++ b/fs/ocfs2/cluster/ocfs2_heartbeat.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * ocfs2_heartbeat.h
  *
  * On-disk structures for ocfs2_heartbeat
diff --git a/fs/ocfs2/cluster/ocfs2_nodemanager.h b/fs/ocfs2/cluster/ocfs2_nodemanager.h
index 21ad307419a8..c9a0b77443e7 100644
--- a/fs/ocfs2/cluster/ocfs2_nodemanager.h
+++ b/fs/ocfs2/cluster/ocfs2_nodemanager.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * ocfs2_nodemanager.h
  *
  * Header describing the interface between userspace and the kernel
diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
index cea739be77c4..189c111bc371 100644
--- a/fs/ocfs2/cluster/quorum.c
+++ b/fs/ocfs2/cluster/quorum.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- *
- * vim: noexpandtab sw=8 ts=8 sts=0:
+/*
  *
  * Copyright (C) 2005 Oracle.  All rights reserved.
  */
diff --git a/fs/ocfs2/cluster/quorum.h b/fs/ocfs2/cluster/quorum.h
index 6d45ce8b18a1..d64bf4482a4a 100644
--- a/fs/ocfs2/cluster/quorum.h
+++ b/fs/ocfs2/cluster/quorum.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * Copyright (C) 2005 Oracle.  All rights reserved.
  */
 
diff --git a/fs/ocfs2/cluster/sys.c b/fs/ocfs2/cluster/sys.c
index d6067c3d84c1..022f716c74ff 100644
--- a/fs/ocfs2/cluster/sys.c
+++ b/fs/ocfs2/cluster/sys.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * sys.c
  *
  * OCFS2 cluster sysfs interface
diff --git a/fs/ocfs2/cluster/sys.h b/fs/ocfs2/cluster/sys.h
index ce380517cf17..70aaba65317e 100644
--- a/fs/ocfs2/cluster/sys.h
+++ b/fs/ocfs2/cluster/sys.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * sys.h
  *
  * Function prototypes for o2cb sysfs interface
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 3bd8119bed5e..f660c0dbdb63 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- *
- * vim: noexpandtab sw=8 ts=8 sts=0:
+/*
  *
  * Copyright (C) 2004 Oracle.  All rights reserved.
  *
diff --git a/fs/ocfs2/cluster/tcp.h b/fs/ocfs2/cluster/tcp.h
index 736338f45c59..a75b551d31c7 100644
--- a/fs/ocfs2/cluster/tcp.h
+++ b/fs/ocfs2/cluster/tcp.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * tcp.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/cluster/tcp_internal.h b/fs/ocfs2/cluster/tcp_internal.h
index e6a2b9dfcd16..601c99bd2611 100644
--- a/fs/ocfs2/cluster/tcp_internal.h
+++ b/fs/ocfs2/cluster/tcp_internal.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * Copyright (C) 2005 Oracle.  All rights reserved.
  */
 
diff --git a/fs/ocfs2/dcache.c b/fs/ocfs2/dcache.c
index 42a61eecdacd..04fc8344063a 100644
--- a/fs/ocfs2/dcache.c
+++ b/fs/ocfs2/dcache.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dcache.c
  *
  * dentry cache handling code
diff --git a/fs/ocfs2/dcache.h b/fs/ocfs2/dcache.h
index 3686a52ba143..7f246c5692d8 100644
--- a/fs/ocfs2/dcache.h
+++ b/fs/ocfs2/dcache.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dcache.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index bdfba9db558a..bd8d534f11cb 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dir.c
  *
  * Creates, reads, walks and deletes directory-nodes
diff --git a/fs/ocfs2/dir.h b/fs/ocfs2/dir.h
index e3e7d5dd29e8..4b9f5a12c7d2 100644
--- a/fs/ocfs2/dir.h
+++ b/fs/ocfs2/dir.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dir.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/dlm/dlmapi.h b/fs/ocfs2/dlm/dlmapi.h
index 6456c0fbcbb2..bae60ca2672a 100644
--- a/fs/ocfs2/dlm/dlmapi.h
+++ b/fs/ocfs2/dlm/dlmapi.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmapi.h
  *
  * externally exported dlm interfaces
diff --git a/fs/ocfs2/dlm/dlmast.c b/fs/ocfs2/dlm/dlmast.c
index 70a10764f249..c681ba957932 100644
--- a/fs/ocfs2/dlm/dlmast.c
+++ b/fs/ocfs2/dlm/dlmast.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmast.c
  *
  * AST and BAST functionality for local and remote nodes
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 58d57e25d384..fd2022712167 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmcommon.h
  *
  * Copyright (C) 2004 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/dlm/dlmconvert.c b/fs/ocfs2/dlm/dlmconvert.c
index 6051edc33aef..450d46eefab3 100644
--- a/fs/ocfs2/dlm/dlmconvert.c
+++ b/fs/ocfs2/dlm/dlmconvert.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmconvert.c
  *
  * underlying calls for lock conversion
diff --git a/fs/ocfs2/dlm/dlmconvert.h b/fs/ocfs2/dlm/dlmconvert.h
index 12d9c28bc52f..1f371716513b 100644
--- a/fs/ocfs2/dlm/dlmconvert.h
+++ b/fs/ocfs2/dlm/dlmconvert.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmconvert.h
  *
  * Copyright (C) 2004 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index 4b8b41d23e91..d442cf5dda8a 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmdebug.c
  *
  * debug functionality for the dlm
diff --git a/fs/ocfs2/dlm/dlmdebug.h b/fs/ocfs2/dlm/dlmdebug.h
index f8fd8680a4b6..e08f7357e7ec 100644
--- a/fs/ocfs2/dlm/dlmdebug.h
+++ b/fs/ocfs2/dlm/dlmdebug.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmdebug.h
  *
  * Copyright (C) 2008 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 357cfc702ce3..9f90fc9551e1 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmdomain.c
  *
  * defines domain join / leave apis
diff --git a/fs/ocfs2/dlm/dlmdomain.h b/fs/ocfs2/dlm/dlmdomain.h
index 7c21664d23d0..815abe30ad09 100644
--- a/fs/ocfs2/dlm/dlmdomain.h
+++ b/fs/ocfs2/dlm/dlmdomain.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmdomain.h
  *
  * Copyright (C) 2004 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/dlm/dlmlock.c b/fs/ocfs2/dlm/dlmlock.c
index 83f0760e4fba..041fd1791ae7 100644
--- a/fs/ocfs2/dlm/dlmlock.c
+++ b/fs/ocfs2/dlm/dlmlock.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmlock.c
  *
  * underlying calls for lock creation
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index f105746063ed..4960a6de768d 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmmod.c
  *
  * standalone DLM module
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 4b566e88582f..7758dd00d516 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmrecovery.c
  *
  * recovery stuff
diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index 5ccc4ff0b82a..c350bd4df770 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmthread.c
  *
  * standalone DLM module
diff --git a/fs/ocfs2/dlm/dlmunlock.c b/fs/ocfs2/dlm/dlmunlock.c
index dcb17ca8ae74..61103b2d69fb 100644
--- a/fs/ocfs2/dlm/dlmunlock.c
+++ b/fs/ocfs2/dlm/dlmunlock.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmunlock.c
  *
  * underlying calls for unlocking locks
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index b2870f1a31df..fa0a14f199eb 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmfs.c
  *
  * Code which implements the kernel side of a minimal userspace
diff --git a/fs/ocfs2/dlmfs/userdlm.c b/fs/ocfs2/dlmfs/userdlm.c
index 339f098d9592..29f183a15798 100644
--- a/fs/ocfs2/dlmfs/userdlm.c
+++ b/fs/ocfs2/dlmfs/userdlm.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * userdlm.c
  *
  * Code which implements the kernel side of a minimal userspace
diff --git a/fs/ocfs2/dlmfs/userdlm.h b/fs/ocfs2/dlmfs/userdlm.h
index 0558ae768200..47ba18eac423 100644
--- a/fs/ocfs2/dlmfs/userdlm.h
+++ b/fs/ocfs2/dlmfs/userdlm.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * userdlm.h
  *
  * Userspace dlm defines
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 8e3a369086db..2af279f17566 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmglue.c
  *
  * Code which implements an OCFS2 specific interface to our DLM.
diff --git a/fs/ocfs2/dlmglue.h b/fs/ocfs2/dlmglue.h
index b8fbed25df89..e5da5809ed95 100644
--- a/fs/ocfs2/dlmglue.h
+++ b/fs/ocfs2/dlmglue.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * dlmglue.h
  *
  * description here
diff --git a/fs/ocfs2/export.c b/fs/ocfs2/export.c
index 69ed278dd84d..eaa8c80ace3c 100644
--- a/fs/ocfs2/export.c
+++ b/fs/ocfs2/export.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * export.c
  *
  * Functions to facilitate NFS exporting
diff --git a/fs/ocfs2/export.h b/fs/ocfs2/export.h
index d485da0c3439..636357400505 100644
--- a/fs/ocfs2/export.h
+++ b/fs/ocfs2/export.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * export.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 7b93e9c766f6..70a768b623cf 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * extent_map.c
  *
  * Block/Cluster mapping functions
diff --git a/fs/ocfs2/extent_map.h b/fs/ocfs2/extent_map.h
index e5464f6cee8a..bc4ed59fb925 100644
--- a/fs/ocfs2/extent_map.h
+++ b/fs/ocfs2/extent_map.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * extent_map.h
  *
  * In-memory file extent mappings for OCFS2.
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 6611c64ca0be..26eb70571e26 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * file.c
  *
  * File open, close, extend, truncate
diff --git a/fs/ocfs2/file.h b/fs/ocfs2/file.h
index 8536cec5f122..71db8f3aa027 100644
--- a/fs/ocfs2/file.h
+++ b/fs/ocfs2/file.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * file.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index 50f11bfdc8c2..90b8d300c1ee 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * filecheck.c
  *
  * Code which implements online file check.
diff --git a/fs/ocfs2/filecheck.h b/fs/ocfs2/filecheck.h
index 4d006777ac54..d3bcb8bcfeb0 100644
--- a/fs/ocfs2/filecheck.h
+++ b/fs/ocfs2/filecheck.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * filecheck.h
  *
  * Online file check.
diff --git a/fs/ocfs2/heartbeat.c b/fs/ocfs2/heartbeat.c
index 60c5f995d30c..9099d8fc7599 100644
--- a/fs/ocfs2/heartbeat.c
+++ b/fs/ocfs2/heartbeat.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * heartbeat.c
  *
  * Register ourselves with the heartbaet service, keep our node maps
diff --git a/fs/ocfs2/heartbeat.h b/fs/ocfs2/heartbeat.h
index 5fedb2d35dc0..f1f8b1802fe4 100644
--- a/fs/ocfs2/heartbeat.h
+++ b/fs/ocfs2/heartbeat.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * heartbeat.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 7c9dfd50c1c1..bc8f32fab964 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * inode.c
  *
  * vfs' aops, fops, dops and iops
diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
index 51a4f7197987..82b28fdacc7e 100644
--- a/fs/ocfs2/inode.h
+++ b/fs/ocfs2/inode.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * inode.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index db52e843002a..4e589ce2fce6 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * journal.c
  *
  * Defines functions of journalling api
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index bfe611ed1b1d..d158acb8b38a 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * journal.h
  *
  * Defines journalling api and structures.
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index fc8252a28cb1..5f6bacbeef6b 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * localalloc.c
  *
  * Node local data allocation
diff --git a/fs/ocfs2/localalloc.h b/fs/ocfs2/localalloc.h
index e8a5cea48639..08f925b7ec6d 100644
--- a/fs/ocfs2/localalloc.h
+++ b/fs/ocfs2/localalloc.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * localalloc.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index 7edc4e5c7c2c..fab7c6a4a7d0 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * locks.c
  *
  * Userspace file locking support
diff --git a/fs/ocfs2/locks.h b/fs/ocfs2/locks.h
index 389fe1fce3a5..b52de3947d5f 100644
--- a/fs/ocfs2/locks.h
+++ b/fs/ocfs2/locks.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * locks.h
  *
  * Function prototypes for Userspace file locking support
diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 25cabbfe87fc..1834f26522ed 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * mmap.c
  *
  * Code to deal with the mess that is clustered mmap.
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 758d9661ef1e..192cad0662d8 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * move_extents.c
  *
  * Copyright (C) 2011 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/move_extents.h b/fs/ocfs2/move_extents.h
index 28cac43892c5..987f9e559f30 100644
--- a/fs/ocfs2/move_extents.h
+++ b/fs/ocfs2/move_extents.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * move_extents.h
  *
  * Copyright (C) 2011 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 3abdd36da2e2..a4d8b85cd984 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * namei.c
  *
  * Create and rename file, directory, symlinks
diff --git a/fs/ocfs2/namei.h b/fs/ocfs2/namei.h
index cc091ed02b4a..9cc891eb874e 100644
--- a/fs/ocfs2/namei.h
+++ b/fs/ocfs2/namei.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * namei.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/ocfs1_fs_compat.h b/fs/ocfs2/ocfs1_fs_compat.h
index 01ae48c4834d..6dbcf3d467fb 100644
--- a/fs/ocfs2/ocfs1_fs_compat.h
+++ b/fs/ocfs2/ocfs1_fs_compat.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * ocfs1_fs_compat.h
  *
  * OCFS1 volume header definitions.  OCFS2 creates valid but unmountable
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 7993d527edae..bb62cc2e0211 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * ocfs2.h
  *
  * Defines macros and structures used in OCFS2
diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index 19137c6d087b..638d875eccc7 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * ocfs2_fs.h
  *
  * On-disk structures for OCFS2.
diff --git a/fs/ocfs2/ocfs2_ioctl.h b/fs/ocfs2/ocfs2_ioctl.h
index d7b31734f6be..79393c7e5b22 100644
--- a/fs/ocfs2/ocfs2_ioctl.h
+++ b/fs/ocfs2/ocfs2_ioctl.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * ocfs2_ioctl.h
  *
  * Defines OCFS2 ioctls.
diff --git a/fs/ocfs2/ocfs2_lockid.h b/fs/ocfs2/ocfs2_lockid.h
index b4be84956bc1..8ac357ce6a30 100644
--- a/fs/ocfs2/ocfs2_lockid.h
+++ b/fs/ocfs2/ocfs2_lockid.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * ocfs2_lockid.h
  *
  * Defines OCFS2 lockid bits.
diff --git a/fs/ocfs2/ocfs2_lockingver.h b/fs/ocfs2/ocfs2_lockingver.h
index 5c9c105b33ee..31a5e1619e7f 100644
--- a/fs/ocfs2/ocfs2_lockingver.h
+++ b/fs/ocfs2/ocfs2_lockingver.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * ocfs2_lockingver.h
  *
  * Defines OCFS2 Locking version values.
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index c19a463fac55..7f6355cbb587 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * refcounttree.c
  *
  * Copyright (C) 2009 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/refcounttree.h b/fs/ocfs2/refcounttree.h
index 0b9014495726..8197a94feec0 100644
--- a/fs/ocfs2/refcounttree.h
+++ b/fs/ocfs2/refcounttree.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * refcounttree.h
  *
  * Copyright (C) 2009 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/reservations.c b/fs/ocfs2/reservations.c
index bf3842e34fb9..769e466887b0 100644
--- a/fs/ocfs2/reservations.c
+++ b/fs/ocfs2/reservations.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * reservations.c
  *
  * Allocation reservations implementation
diff --git a/fs/ocfs2/reservations.h b/fs/ocfs2/reservations.h
index 6ac88122896d..677c50663595 100644
--- a/fs/ocfs2/reservations.h
+++ b/fs/ocfs2/reservations.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * reservations.h
  *
  * Allocation reservations function prototypes and structures.
diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
index 24eb52f9059c..d65d43c61857 100644
--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * resize.c
  *
  * volume resize.
diff --git a/fs/ocfs2/resize.h b/fs/ocfs2/resize.h
index 0af0c023042c..4990637219ef 100644
--- a/fs/ocfs2/resize.h
+++ b/fs/ocfs2/resize.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * resize.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index 4da0e4b1e79b..0b0ae3ebb0cf 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * slot_map.c
  *
  * Copyright (C) 2002, 2004 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/slot_map.h b/fs/ocfs2/slot_map.h
index 93b53e73f0f7..a43644570b53 100644
--- a/fs/ocfs2/slot_map.h
+++ b/fs/ocfs2/slot_map.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * slotmap.h
  *
  * description here
diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
index dbf8b5735808..99d64ddd9941 100644
--- a/fs/ocfs2/stack_o2cb.c
+++ b/fs/ocfs2/stack_o2cb.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * stack_o2cb.c
  *
  * Code which interfaces ocfs2 with the o2cb stack.
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 7397064c3f35..85a47621e0c0 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * stack_user.c
  *
  * Code which interfaces ocfs2 with fs/dlm and a userspace stack.
diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index a191094694c6..8ac17c9ca526 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * stackglue.c
  *
  * Code which implements an OCFS2 specific interface to underlying
diff --git a/fs/ocfs2/stackglue.h b/fs/ocfs2/stackglue.h
index e9d26cbeb3b8..3636847fae19 100644
--- a/fs/ocfs2/stackglue.h
+++ b/fs/ocfs2/stackglue.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * stackglue.h
  *
  * Glue to the underlying cluster stack.
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 8c8cf7f4eb34..8521942f5af2 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * suballoc.c
  *
  * metadata alloc and free
diff --git a/fs/ocfs2/suballoc.h b/fs/ocfs2/suballoc.h
index 50b36250beb6..5805a03d100b 100644
--- a/fs/ocfs2/suballoc.h
+++ b/fs/ocfs2/suballoc.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * suballoc.h
  *
  * Defines sub allocator api
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 079f8826993e..c86bd4e60e20 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * super.c
  *
  * load/unload driver, mount/dismount volumes
diff --git a/fs/ocfs2/super.h b/fs/ocfs2/super.h
index 76facaf63336..8312651135b9 100644
--- a/fs/ocfs2/super.h
+++ b/fs/ocfs2/super.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * super.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
index 94cfacc9bad7..f755a4985821 100644
--- a/fs/ocfs2/symlink.c
+++ b/fs/ocfs2/symlink.c
@@ -1,6 +1,4 @@
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  *  linux/cluster/ssi/cfs/symlink.c
  *
  *	This program is free software; you can redistribute it and/or
diff --git a/fs/ocfs2/symlink.h b/fs/ocfs2/symlink.h
index 167094d1e5aa..ffcf0210545c 100644
--- a/fs/ocfs2/symlink.h
+++ b/fs/ocfs2/symlink.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * symlink.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/sysfile.c b/fs/ocfs2/sysfile.c
index bb701c4e449f..53a945da873b 100644
--- a/fs/ocfs2/sysfile.c
+++ b/fs/ocfs2/sysfile.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * sysfile.c
  *
  * Initialize, read, write, etc. system files.
diff --git a/fs/ocfs2/sysfile.h b/fs/ocfs2/sysfile.h
index a83dd962fccb..2b38c75990fd 100644
--- a/fs/ocfs2/sysfile.h
+++ b/fs/ocfs2/sysfile.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * sysfile.h
  *
  * Function prototypes
diff --git a/fs/ocfs2/uptodate.c b/fs/ocfs2/uptodate.c
index 580852ba05c4..09854925fa5c 100644
--- a/fs/ocfs2/uptodate.c
+++ b/fs/ocfs2/uptodate.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * uptodate.c
  *
  * Tracking the up-to-date-ness of a local buffer_head with respect to
diff --git a/fs/ocfs2/uptodate.h b/fs/ocfs2/uptodate.h
index 77a30cae4879..85d94134001b 100644
--- a/fs/ocfs2/uptodate.h
+++ b/fs/ocfs2/uptodate.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * uptodate.h
  *
  * Cluster uptodate tracking
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 36ae47a4aef6..dd784eb0cd7c 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * xattr.c
  *
  * Copyright (C) 2004, 2008 Oracle.  All rights reserved.
diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
index 9c80382da1f5..00308b57f64f 100644
--- a/fs/ocfs2/xattr.h
+++ b/fs/ocfs2/xattr.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * xattr.h
  *
  * Copyright (C) 2004, 2008 Oracle.  All rights reserved.
diff --git a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
index 155b82870333..4a7cb16e9345 100644
--- a/fs/reiserfs/procfs.c
+++ b/fs/reiserfs/procfs.c
@@ -488,13 +488,3 @@ int reiserfs_proc_info_global_done(void)
  * (available at http://www.namesys.com/legalese.html)
  *
  */
-
-/*
- * Make Linus happy.
- * Local variables:
- * c-indentation-style: "K&R"
- * mode-name: "LC"
- * c-basic-offset: 8
- * tab-width: 8
- * End:
- */
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2e8c69b43c64..97cfd13bae51 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
+/*
  * configfs.h - definitions for the device driver filesystem
  *
  * Based on sysfs:
diff --git a/include/linux/genl_magic_func.h b/include/linux/genl_magic_func.h
index 6cb82301d8e9..939b1a8f571b 100644
--- a/include/linux/genl_magic_func.h
+++ b/include/linux/genl_magic_func.h
@@ -404,4 +404,3 @@ s_fields								\
 
 /* }}}1 */
 #endif /* GENL_MAGIC_FUNC_H */
-/* vim: set foldmethod=marker foldlevel=1 nofoldenable : */
diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index 35d21fddaf2d..f81d48987528 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -283,4 +283,3 @@ enum {									\
 
 /* }}}1 */
 #endif /* GENL_MAGIC_STRUCT_H */
-/* vim: set foldmethod=marker nofoldenable : */
diff --git a/include/uapi/linux/if_bonding.h b/include/uapi/linux/if_bonding.h
index e8eb4ad03cf1..d174914a837d 100644
--- a/include/uapi/linux/if_bonding.h
+++ b/include/uapi/linux/if_bonding.h
@@ -153,14 +153,3 @@ enum {
 #define BOND_3AD_STAT_MAX (__BOND_3AD_STAT_MAX - 1)
 
 #endif /* _LINUX_IF_BONDING_H */
-
-/*
- * Local variables:
- *  version-control: t
- *  kept-new-versions: 5
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
-
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index ed5415e0f1c1..800bb0ffa6e6 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -178,9 +178,3 @@
 #define NFS4_MAX_BACK_CHANNEL_OPS 2
 
 #endif /* _UAPI_LINUX_NFS4_H */
-
-/*
- * Local variables:
- *  c-basic-offset: 8
- * End:
- */
diff --git a/include/xen/interface/elfnote.h b/include/xen/interface/elfnote.h
index 9e9f9bf7c66d..449bd383cb76 100644
--- a/include/xen/interface/elfnote.h
+++ b/include/xen/interface/elfnote.h
@@ -208,13 +208,3 @@
 #define XEN_ELFNOTE_MAX XEN_ELFNOTE_PHYS32_ENTRY
 
 #endif /* __XEN_PUBLIC_ELFNOTE_H__ */
-
-/*
- * Local variables:
- * mode: C
- * c-set-style: "BSD"
- * c-basic-offset: 4
- * tab-width: 4
- * indent-tabs-mode: nil
- * End:
- */
diff --git a/include/xen/interface/hvm/hvm_vcpu.h b/include/xen/interface/hvm/hvm_vcpu.h
index 32ca83edd44d..bfc2138e0bf5 100644
--- a/include/xen/interface/hvm/hvm_vcpu.h
+++ b/include/xen/interface/hvm/hvm_vcpu.h
@@ -131,13 +131,3 @@ struct vcpu_hvm_context {
 typedef struct vcpu_hvm_context vcpu_hvm_context_t;
 
 #endif /* __XEN_PUBLIC_HVM_HVM_VCPU_H__ */
-
-/*
- * Local variables:
- * mode: C
- * c-file-style: "BSD"
- * c-basic-offset: 4
- * tab-width: 4
- * indent-tabs-mode: nil
- * End:
- */
diff --git a/include/xen/interface/io/xenbus.h b/include/xen/interface/io/xenbus.h
index aaf2951b1cce..fb8716112251 100644
--- a/include/xen/interface/io/xenbus.h
+++ b/include/xen/interface/io/xenbus.h
@@ -39,13 +39,3 @@ enum xenbus_state
 };
 
 #endif /* _XEN_PUBLIC_IO_XENBUS_H */
-
-/*
- * Local variables:
- *  c-file-style: "linux"
- *  indent-tabs-mode: t
- *  c-indent-level: 8
- *  c-basic-offset: 8
- *  tab-width: 8
- * End:
- */
diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index f9008be7a8a1..37a657b25d58 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * vim: noexpandtab ts=8 sts=0 sw=8:
- *
  * configfs_example_macros.c - This file is a demonstration module
  *      containing a number of configfs subsystems.  It uses the helper
  *      macros defined by configfs.h
diff --git a/tools/usb/hcd-tests.sh b/tools/usb/hcd-tests.sh
index e8cad6a4f9c9..73f914d13f5c 100644
--- a/tools/usb/hcd-tests.sh
+++ b/tools/usb/hcd-tests.sh
@@ -272,5 +272,3 @@ do
 	echo ''
     done
 done
-
-# vim: sw=4
-- 
2.27.0

