Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7A348291
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhCXUF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbhCXUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:05:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE55DC061763;
        Wed, 24 Mar 2021 13:05:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e14so16732313ejz.11;
        Wed, 24 Mar 2021 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eHEzKBnUxmw6UcmNYPEgJ+MgHukSSHeyOYkAQ2waF9M=;
        b=AvGBoQg3m6DKH9FfD/3fsy3RhSQSwwiXRGPRyrOVmKgpIm06BRonxCdM9i9VHGFTMS
         78BZRACnQIJZca1CHHKSX+sDOI6Y0jGY19tWlmAllbshpaTOxJg6KFmoG/2WDAvlHt+y
         Q4jejR3/xQWa0TekTdL3Ehpto9zZENx4BbHKtgjywFxqPtZ/i2G0fvE52QmPgpOUr3lE
         NYk8OsrBU8g96/EYczBkHTipSXuRG4LSWuBUuaBXMKDBMCcVBQLuPDYL7iDv1LWJhI41
         nS4yLFhfZOAqxBEbbSVd0NWig09zh5rggTZBQc1TNzROokk2/ZbGQxdZ1dBWPbvOU3Gg
         +/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eHEzKBnUxmw6UcmNYPEgJ+MgHukSSHeyOYkAQ2waF9M=;
        b=HS7VtIbtJwoqCzF09XfJTu/q6UzB4tr1YG7o2M55ZQOvouv6EbV0c/UFEMtCEbcgPR
         QKoMBSDZgH5LYYC8HcjR3sHWEG/G2vlerdmN76UUJ5le0DENr4ebtelGgo7BWunoMdxP
         jkNwoKud7vab5QLpf9+VhL6KV2R9JMQ3ukLIElqH/kHU6aKpQ5msU4VPjkKrhgYi4yaU
         Jis1pyGZSTJNNqSNCUib7qiJs+0Rp9D1i0cjJygqfrS1EXbEYWTOjx6vkh4IxbOztMPh
         m2UxTHOux6SCmM8Z0sA9Ed/mdGPhL0sJx0LSXt15sSBiIsfW45mI9r0mOMTTx5Jv1W0X
         rIeA==
X-Gm-Message-State: AOAM530GUx7P2ikMNQY2kMOwEN6ytzrrZwTv5YqxmbdGx5ykwADzplvW
        EJDWDj0QFd1Fm+Dk0zUkBIE=
X-Google-Smtp-Source: ABdhPJyF82ROC6/arXqwNMHZ0eCiseuY6fnaxj5OM3pUcBlmyP7T70GgmiLRrkBiHYVkpbixNnDczg==
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr5607945ejw.47.1616616325687;
        Wed, 24 Mar 2021 13:05:25 -0700 (PDT)
Received: from LEGION ([111.119.187.22])
        by smtp.gmail.com with ESMTPSA id nd36sm1391701ejc.21.2021.03.24.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 13:05:25 -0700 (PDT)
Message-ID: <34e31fabb228da3cca292e6496dfa8a79c25c7d8.camel@gmail.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in vhci_hub_control (2)
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     syzbot <syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu
Cc:     musamaanjum@gmail.com
Date:   Thu, 25 Mar 2021 01:05:19 +0500
In-Reply-To: <0000000000004dcb8c05be4bbcf8@google.com>
References: <0000000000004dcb8c05be4bbcf8@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-24 at 10:36 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    84196390 Merge tag 'selinux-pr-20210322' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12ea778ad00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5adab0bdee099d7a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3dea30b047f41084de66
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15449662d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f81026d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com
> 
> ================================================================================
> UBSAN: shift-out-of-bounds in drivers/usb/usbip/vhci_hcd.c:605:42
> shift exponent 768 is too large for 32-bit type 'int'
> CPU: 0 PID: 8421 Comm: syz-executor852 Not tainted 5.12.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
>  __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
>  vhci_hub_control.cold+0x20b/0x5f0 drivers/usb/usbip/vhci_hcd.c:605
>  rh_call_control drivers/usb/core/hcd.c:683 [inline]
>  rh_urb_enqueue drivers/usb/core/hcd.c:841 [inline]
>  usb_hcd_submit_urb+0xcaf/0x22d0 drivers/usb/core/hcd.c:1544
>  usb_submit_urb+0x6e4/0x1540 drivers/usb/core/urb.c:585
>  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>  do_proc_control+0x4af/0x980 drivers/usb/core/devio.c:1165
>  proc_control drivers/usb/core/devio.c:1191 [inline]
>  usbdev_do_ioctl drivers/usb/core/devio.c:2535 [inline]
>  usbdev_ioctl+0x10e2/0x36c0 drivers/usb/core/devio.c:2708
>  vfs_ioctl fs/ioctl.c:48 [inline]
>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>  __se_sys_ioctl fs/ioctl.c:739 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x443499
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd96535f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000443499
> RDX: 0000000020000000 RSI: 00000000c0185500 RDI: 0000000000000003
> RBP: 0000000000403040 R08: 0000000000000000 R09: 00000000004004a0
> R10: 000000000000000f R11: 0000000000000246 R12: 00000000004030d0
> R13: 0000000000000000 R14: 00000000004b1018 R15: 00000000004004a0
> ================================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

I've tested with following patch locally and issue is solved.  
Porting fix from: c318840fb2 ("USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug")

Lets ask the syzbot to test the patch also. 

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 84196390

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 3209b5ddd30c..6e12b60d4f5c 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -393,13 +393,24 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			else
 				vhci_hcd->port_status[rhport] &= ~USB_PORT_STAT_POWER;
 			break;
-		default:
-			usbip_dbg_vhci_rh(" ClearPortFeature: default %x\n",
-					  wValue);
+		case USB_PORT_FEAT_ENABLE:
+		case USB_PORT_FEAT_C_ENABLE:
+		case USB_PORT_FEAT_C_SUSPEND:
+			/* Not allowed for USB-3 */
+			if (hcd->speed == HCD_USB3)
+				goto error;
+			fallthrough;
+		case USB_PORT_FEAT_C_CONNECTION:
+		case USB_PORT_FEAT_C_RESET:
 			if (wValue >= 32)
 				goto error;
 			vhci_hcd->port_status[rhport] &= ~(1 << wValue);
 			break;
+		default:
+		/* Disallow INDICATOR and C_OVER_CURRENT */
+			usbip_dbg_vhci_rh(" ClearPortFeature: default %x\n",
+					  wValue);
+			goto error;
 		}
 		break;
 	case GetHubDescriptor:
@@ -587,23 +598,22 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			/* 50msec reset signaling */
 			vhci_hcd->re_timeout = jiffies + msecs_to_jiffies(50);
 			fallthrough;
+		case USB_PORT_FEAT_C_CONNECTION:
+		case USB_PORT_FEAT_C_RESET:
+		case USB_PORT_FEAT_C_ENABLE:
+		case USB_PORT_FEAT_C_SUSPEND:
+			/* Not allowed for USB-3, and ignored for USB-2 */
+			if (hcd->speed == HCD_USB3)
+				goto error;
+			break;
 		default:
+			/* Disallow TEST, INDICATOR, and C_OVER_CURRENT */
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
-			if (invalid_rhport) {
+			if (invalid_rhport)
 				pr_err("invalid port number %d\n", wIndex);
-				goto error;
-			}
-			if (hcd->speed == HCD_USB3) {
-				if ((vhci_hcd->port_status[rhport] &
-				     USB_SS_PORT_STAT_POWER) != 0) {
-					vhci_hcd->port_status[rhport] |= (1 << wValue);
-				}
-			} else
-				if ((vhci_hcd->port_status[rhport] &
-				     USB_PORT_STAT_POWER) != 0) {
-					vhci_hcd->port_status[rhport] |= (1 << wValue);
-				}
+
+			goto error;
 		}
 		break;
 	case GetPortErrorCount:
-- 
2.25.1


