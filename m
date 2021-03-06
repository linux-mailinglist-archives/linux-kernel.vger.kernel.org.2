Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8A832FC1E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCFQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 11:58:47 -0500
Received: from netrider.rowland.org ([192.131.102.5]:35541 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229779AbhCFQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 11:58:09 -0500
Received: (qmail 75612 invoked by uid 1000); 6 Mar 2021 11:58:08 -0500
Date:   Sat, 6 Mar 2021 11:58:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using
 xhci_hcd
Message-ID: <20210306165808.GD74411@rowland.harvard.edu>
References: <20210301155321.GA1490228@rowland.harvard.edu>
 <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu>
 <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com>
 <20210305193003.GE48113@rowland.harvard.edu>
 <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
 <20210305194745.GF48113@rowland.harvard.edu>
 <CA+icZUXEWh6G-Bm9-2F1X=S=ZYog37PiaMWHUjZWs1g-KDOqJg@mail.gmail.com>
 <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUBpB9UFEypCFmCYc2grUC11QESNwj0_cXfut9fx0JOQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 07:42:30AM +0100, Sedat Dilek wrote:
> No, with Debian-Kernel 5.10.19-1 there are no xhci-resets:

Is the kernel the only thing that is different?  The rest of the 
operating system and environment is exactly the same?

> But I see there is already a quirk enabled and matches my ASmedia USB
> 3.0 controller (as I have *no* usb-storage-quirks enabled):
> 
> root# LC_ALL=C dmesg -T | grep -i quirks | egrep '174c|55aa'
> [Sat Mar  6 06:52:41 2021] usb-storage 4-1:1.0: Quirks match for vid
> 174c pid 55aa: 400000

Yes, this is because that type of device already has a quirk entry built 
into the kernel.  You can find it by searching for "174c" in the kernel 
source file drivers/usb/storage/unusual_devs.h.

> Thanks Alan for all the hints and tips in the topic "usb-storage and
> quirks" and your patience.

You can try building a 5.11 kernel with the patch below.  I don't know 
whether it will show anything in the dmesg log when one of these resets 
occurs, but it might.

If that doesn't work out, another possibility is to use git bisect to 
find the commit between 5.10 and 5.11 which caused the problem to start.

Alan Stern


--- usb-devel.orig/block/scsi_ioctl.c
+++ usb-devel/block/scsi_ioctl.c
@@ -258,8 +258,11 @@ static int blk_complete_sghdr_rq(struct
 	hdr->host_status = host_byte(req->result);
 	hdr->driver_status = driver_byte(req->result);
 	hdr->info = 0;
-	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
+	if (hdr->masked_status || hdr->host_status || hdr->driver_status) {
 		hdr->info |= SG_INFO_CHECK;
+		printk(KERN_INFO "SCSI ioctl error, cmd %02X, prog %s\n",
+				req->cmd[0], current->comm);
+	}
 	hdr->resid = req->resid_len;
 	hdr->sb_len_wr = 0;
 

