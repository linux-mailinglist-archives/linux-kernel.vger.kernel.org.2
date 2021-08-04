Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989D53DFC66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhHDIBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236015AbhHDIBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:01:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5418A60F8F;
        Wed,  4 Aug 2021 08:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628064049;
        bh=yqVr2Xf0PupBBoMlNNz5r0ZGYK8L6rLo/4MbhYKFS8g=;
        h=Date:From:To:Cc:Subject:From;
        b=SNQOJU7H9wv7x963NCA5TmYlQmyeu7hKYSE3P6dw9o15zVVDuA8XXmKqO8mJbubve
         Xh3A/2OIFFiJ7qvWBcqeDOIGL1ATh2et14umpEtp/kDAzUEwVhs7x1XSCTFGJbeIxL
         Sv9UCHJY0FWQ5BG9LAyRbUHW04DsptY4LJni8/Fg=
Date:   Wed, 4 Aug 2021 10:00:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: USB xhci crash under load on 5.14-rc3
Message-ID: <YQpJLk42b+0g7WFB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was doing some filesystem backups from one USB device to another one
this weekend and kept running into the problem of the xhci controller
shutting down after an hour or so of high volume traffic.

I finally captured the problem in the kernel log as this would also take
out my keyboard, making it hard to recover from :)

The log is below for when the problem happens, and then the devices are
disconnected from the bus (ignore the filesystem errors, those are
expected when i/o is in flight and we disconnect a device.

Any hint as to what the IO_PAGE_FAULT error messages are?

I'll go back to 5.13.y now and see if I can reproduce it there or not,
as my backups are not yet done...

thanks,

greg k-h


[Aug 4 09:48] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff00000 flags=0x0000]
[  +0.000012] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff00f80 flags=0x0000]
[  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff01000 flags=0x0000]
[  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff01f80 flags=0x0000]
[  +0.000005] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff02000 flags=0x0000]
[  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff02f80 flags=0x0000]
[  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff03000 flags=0x0000]
[  +0.000005] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff03f80 flags=0x0000]
[  +0.000006] xhci_hcd 0000:47:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0032 address=0xfffffff04000 flags=0x0000]
[Aug 4 09:49] sd 3:0:0:0: [sdc] tag#21 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN 
[  +0.000011] sd 3:0:0:0: [sdc] tag#21 CDB: Read(16) 88 00 00 00 00 01 8a 44 08 b0 00 00 00 08 00 00
[  +5.106493] xhci_hcd 0000:47:00.1: xHCI host not responding to stop endpoint command.
[  +0.000010] xhci_hcd 0000:47:00.1: USBSTS: HCHalted HSE
[  +0.000006] xhci_hcd 0000:47:00.1: xHCI host controller not responding, assume dead
[  +0.000164] xhci_hcd 0000:47:00.1: HC died; cleaning up
[  +0.000025] xhci_hcd 0000:47:00.1: xHCI host not responding to stop endpoint command.
[  +0.000008] xhci_hcd 0000:47:00.1: USBSTS: HCHalted HSE
[  +0.000008] usb 7-1: USB disconnect, device number 2
[  +0.000004] usb 7-1.4: USB disconnect, device number 4
[  +0.000002] usb 7-1.4.4: USB disconnect, device number 7
[  +0.000226] usb 8-1.4.3: cmd cmplt err -108
[  +0.000005] usb 8-1.4.3: cmd cmplt err -108
[  +0.000003] usb 8-1.4.3: cmd cmplt err -108
[  +0.000046] sd 3:0:0:0: [sdc] tag#18 uas_eh_abort_handler 0 uas-tag 3 inflight: CMD 
[  +0.000006] sd 3:0:0:0: [sdc] tag#18 CDB: Write(16) 8a 00 00 00 00 01 23 18 f6 28 00 00 04 00 00 00
[  +0.000004] sd 3:0:0:0: [sdc] tag#17 uas_eh_abort_handler 0 uas-tag 2 inflight: CMD 
[  +0.000002] sd 3:0:0:0: [sdc] tag#17 CDB: Write(16) 8a 00 00 00 00 01 23 18 f2 28 00 00 04 00 00 00
[  +0.000002] sd 3:0:0:0: [sdc] tag#16 uas_eh_abort_handler 0 uas-tag 4 inflight: CMD 
[  +0.000002] sd 3:0:0:0: [sdc] tag#16 CDB: Write(16) 8a 00 00 00 00 01 23 18 fa 28 00 00 01 30 00 00
[  +0.000298] usb 8-1: USB disconnect, device number 2
[  +0.000002] usb 8-1.4: USB disconnect, device number 4
[  +0.000002] usb 8-1.4.1: USB disconnect, device number 7
[  +0.000447] usb 7-2: USB disconnect, device number 3
[  +0.000002] usb 7-2.2: USB disconnect, device number 6
[  +0.000001] usb 7-2.2.2: USB disconnect, device number 8
[  +0.011526] blk_update_request: I/O error, dev sdd, sector 3905595064 op 0x1:(WRITE) flags 0x4800 phys_seg 256 prio class 0
[  +0.000094] blk_update_request: I/O error, dev sdd, sector 1005570048 op 0x1:(WRITE) flags 0x4000 phys_seg 18 prio class 0
[  +0.000010] blk_update_request: I/O error, dev sdd, sector 1005572096 op 0x1:(WRITE) flags 0x4000 phys_seg 19 prio class 0
[  +0.000005] blk_update_request: I/O error, dev sdd, sector 1005574144 op 0x1:(WRITE) flags 0x4000 phys_seg 33 prio class 0
[  +0.000005] blk_update_request: I/O error, dev sdd, sector 1005576192 op 0x1:(WRITE) flags 0x4000 phys_seg 33 prio class 0
[  +0.000004] blk_update_request: I/O error, dev sdd, sector 1005578240 op 0x1:(WRITE) flags 0x4000 phys_seg 21 prio class 0
[  +0.000005] blk_update_request: I/O error, dev sdd, sector 1005580288 op 0x1:(WRITE) flags 0x4000 phys_seg 17 prio class 0
[  +0.000006] blk_update_request: I/O error, dev sdd, sector 1005582336 op 0x1:(WRITE) flags 0x4000 phys_seg 19 prio class 0
[  +0.000073] blk_update_request: I/O error, dev sdd, sector 1005584384 op 0x1:(WRITE) flags 0x0 phys_seg 17 prio class 0
[  +0.000002] EXT4-fs warning (device sdd1): ext4_end_bio:342: I/O error 10 writing to inode 81661954 starting block 125698304)
[  +0.000008] blk_update_request: I/O error, dev sdd, sector 1005591088 op 0x1:(WRITE) flags 0x0 phys_seg 7 prio class 0
[  +0.000002] EXT4-fs warning (device sdd1): ext4_end_bio:342: I/O error 10 writing to inode 81661954 starting block 125698981)
[  +0.000013] Buffer I/O error on device sdd1, logical block 125696000
[  +0.000005] Buffer I/O error on device sdd1, logical block 125696001
[  +0.000001] Buffer I/O error on device sdd1, logical block 125696002
[  +0.000002] Buffer I/O error on device sdd1, logical block 125696003
[  +0.000001] Buffer I/O error on device sdd1, logical block 125696004
[  +0.000001] Buffer I/O error on device sdd1, logical block 125696005
[  +0.000001] Buffer I/O error on device sdd1, logical block 125696006
[  +0.000000] Buffer I/O error on device sdd1, logical block 125696007
[  +0.000001] Buffer I/O error on device sdd1, logical block 125696008
[  +0.000001] Buffer I/O error on device sdd1, logical block 125696009
[  +0.000658] EXT4-fs warning (device sdd1): ext4_end_bio:342: I/O error 10 writing to inode 81661955 starting block 125702400)
[  +0.000064] Aborting journal on device sdd1-8.
[  +0.000093] EXT4-fs (sdd1): Delayed block allocation failed for inode 81661956 at logical offset 0 with max blocks 2048 with error 30
[  +0.000003] EXT4-fs (sdd1): This should not happen!! Data will be lost
[  +0.000002] EXT4-fs error (device sdd1) in ext4_writepages:2813: Journal has aborted
[  +0.000411] EXT4-fs error (device sdd1): ext4_journal_check_start:83: comm kworker/u256:1: Detected aborted journal
[  +0.000006] EXT4-fs warning (device sdd1): ext4_end_bio:342: I/O error 10 writing to inode 81661955 starting block 125699482)
[  +0.000015] EXT4-fs error (device sdd1): ext4_journal_check_start:83: comm kworker/u256:0: Detected aborted journal
[  +0.000003] Buffer I/O error on dev sdd1, logical block 488144896, lost sync page write
[  +0.000012] JBD2: Error -5 detected when updating journal superblock for sdd1-8.
[  +0.000003] Buffer I/O error on dev sdd1, logical block 0, lost sync page write
[  +0.000005] EXT4-fs (sdd1): I/O error while writing superblock
[  +0.000065] Buffer I/O error on dev sdd1, logical block 0, lost sync page write
[  +0.000017] EXT4-fs (sdd1): previous I/O error to superblock detected
[  +0.000011] Buffer I/O error on dev sdd1, logical block 0, lost sync page write
[  +0.000004] EXT4-fs (sdd1): I/O error while writing superblock
[  +0.000001] EXT4-fs (sdd1): Remounting filesystem read-only
[  +0.000001] EXT4-fs (sdd1): failed to convert unwritten extents to written extents -- potential data loss!  (inode 81661955, error -30)
[  +0.000001] EXT4-fs (sdd1): ext4_writepages: jbd2_start: 9223372036854775807 pages, ino 81661957; err -30
[  +0.010132] Buffer I/O error on dev sdd1, logical block 125304834, lost async page write
[  +0.000006] Buffer I/O error on dev sdd1, logical block 125304835, lost async page write
[  +0.000002] Buffer I/O error on dev sdd1, logical block 125304836, lost async page write
[  +0.000002] Buffer I/O error on dev sdd1, logical block 125304837, lost async page write
[  +0.000002] Buffer I/O error on dev sdd1, logical block 125304838, lost async page write
[  +0.000001] Buffer I/O error on dev sdd1, logical block 125304839, lost async page write
[  +0.001952] scsi host3: uas_eh_device_reset_handler FAILED to get lock err -19
[  +0.000004] sd 3:0:0:0: Device offlined - not ready after error recovery
[  +0.000002] sd 3:0:0:0: Device offlined - not ready after error recovery
[  +0.000001] sd 3:0:0:0: Device offlined - not ready after error recovery
[  +0.000001] sd 3:0:0:0: Device offlined - not ready after error recovery
[  +0.000006] sd 3:0:0:0: [sdc] tag#16 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=33s
[  +0.000001] sd 3:0:0:0: [sdc] tag#16 CDB: Write(16) 8a 00 00 00 00 01 23 18 fa 28 00 00 01 30 00 00
[  +0.000026] sd 3:0:0:0: [sdc] tag#17 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=33s
[  +0.000001] sd 3:0:0:0: [sdc] tag#17 CDB: Write(16) 8a 00 00 00 00 01 23 18 f2 28 00 00 04 00 00 00
[  +0.000035] sd 3:0:0:0: [sdc] tag#18 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=33s
[  +0.000001] sd 3:0:0:0: [sdc] tag#18 CDB: Write(16) 8a 00 00 00 00 01 23 18 f6 28 00 00 04 00 00 00
[  +0.000025] sd 3:0:0:0: [sdc] tag#21 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK cmd_age=36s
[  +0.000001] sd 3:0:0:0: [sdc] tag#21 CDB: Read(16) 88 00 00 00 00 01 8a 44 08 b0 00 00 00 08 00 00
[  +0.000034] sd 3:0:0:0: rejecting I/O to offline device
[  +0.000024] Aborting journal on device sdc1-8.
[  +0.000023] JBD2: Error -5 detected when updating journal superblock for sdc1-8.
[  +0.000057] EXT4-fs error (device sdc1): ext4_journal_check_start:83: comm rsync: Detected aborted journal
[  +0.000028] EXT4-fs (sdc1): I/O error while writing superblock
[  +0.000001] EXT4-fs (sdc1): Remounting filesystem read-only
[  +0.000142] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350499: lblock 0: comm rsync: error -5 reading directory block
[  +0.000019] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350500: lblock 0: comm rsync: error -5 reading directory block
[  +0.000016] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350501: lblock 0: comm rsync: error -5 reading directory block
[  +0.000015] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350502: lblock 0: comm rsync: error -5 reading directory block
[  +0.000015] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350503: lblock 0: comm rsync: error -5 reading directory block
[  +0.000013] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350504: lblock 0: comm rsync: error -5 reading directory block
[  +0.000014] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350505: lblock 0: comm rsync: error -5 reading directory block
[  +0.000014] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350506: lblock 0: comm rsync: error -5 reading directory block
[  +0.000016] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350507: lblock 0: comm rsync: error -5 reading directory block
[  +0.000013] EXT4-fs warning (device sdc1): htree_dirblock_to_tree:1027: inode #103350508: lblock 0: comm rsync: error -5 reading directory block
[ +14.831953] usb 9-2: USB disconnect, device number 2
[  +1.799368] usb 7-5: USB disconnect, device number 5
[  +0.127876] usb 7-6: USB disconnect, device number 9
[  +0.257672] print_req_error: 551 callbacks suppressed
[  +0.000005] blk_update_request: I/O error, dev sdc, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
[  +0.021782] blk_update_request: I/O error, dev sdc, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
[  +0.026911] usb 8-1.4.3: USB disconnect, device number 6
