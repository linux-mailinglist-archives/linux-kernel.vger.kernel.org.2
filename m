Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA8C348305
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbhCXUk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbhCXUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:39:56 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F3C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:39:56 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f19so22927494ion.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g2kxISQVgChxk+tIWjz9sqy2YteywtsxrnN+80jItQI=;
        b=gDj4nY8z8CHs5gOIzc0Z5PIrNUNgdJ1ONi6cvqAiuOnjCOqaV3CK/IKt0F4ea2iaui
         vV5CQNUEzhSto49S50HXcVxIVaFmrFgROsonL2WKgGULH8f1z9Y3BHQowhCIRI07kv+K
         mxKDDA1pGEktvo/KFzmJQ89kfpaxmswxX9flg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g2kxISQVgChxk+tIWjz9sqy2YteywtsxrnN+80jItQI=;
        b=kGup5zXWXsPKCQbNHuye4hgVhE/hehC90DZLcNeOkJQzhlQ1yaHxkhDr7M03fbAUyj
         IAKtDpp43r+1vf3Nr8q9lv17GOeBY7PaEqaBMrkY7xmrVXnLVxuM08vsSLUCjnGugejg
         b8I7LHdHBYv0egzF2U9tqRo867OkR0MaDFCBBgPE4GPMvUNUFvlcFvPdrB24uSOZVhHX
         Y/DINSOc/zVMSAGQYYGOh6buV1+9sO8Ddjz8pkyLAplVwKXFXOKbs068DA18d2uQ7cWS
         QJG652b0in3syZLmCcgoHCsmzg/8FKt0SEWCuQ3zGQP/KL948OOx1pRJFWoMOOQS1xGv
         Mc/Q==
X-Gm-Message-State: AOAM530mj58crz+ZYyhkNgakWRs5sF0qcVyEfesKkq0DnsfcAM3WjaCl
        iZ+EYAzfxsut5cXx3+tQfq53uw==
X-Google-Smtp-Source: ABdhPJzwVuE1vvU7g0VKbDvnEY1lrZmPupI64BAH8qRSuBE+bxOe2PLm6sy0dcjvJNvxTKjhE1qYaQ==
X-Received: by 2002:a05:6638:381c:: with SMTP id i28mr4530716jav.60.1616618395869;
        Wed, 24 Mar 2021 13:39:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t8sm1496648ioc.12.2021.03.24.13.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 13:39:55 -0700 (PDT)
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in vhci_hub_control (2)
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        syzbot <syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, Shuah Khan <skhan@linuxfoundation.org>
References: <0000000000004dcb8c05be4bbcf8@google.com>
 <34e31fabb228da3cca292e6496dfa8a79c25c7d8.camel@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ae9ca7d3-27b5-95bc-258e-1043fdfe0ae7@linuxfoundation.org>
Date:   Wed, 24 Mar 2021 14:39:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <34e31fabb228da3cca292e6496dfa8a79c25c7d8.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 2:05 PM, Muhammad Usama Anjum wrote:
> On Wed, 2021-03-24 at 10:36 -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    84196390 Merge tag 'selinux-pr-20210322' of git://git.kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12ea778ad00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5adab0bdee099d7a
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3dea30b047f41084de66
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15449662d00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f81026d00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+3dea30b047f41084de66@syzkaller.appspotmail.com
>>
>> ================================================================================
>> UBSAN: shift-out-of-bounds in drivers/usb/usbip/vhci_hcd.c:605:42
>> shift exponent 768 is too large for 32-bit type 'int'
>> CPU: 0 PID: 8421 Comm: syz-executor852 Not tainted 5.12.0-rc4-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:79 [inline]
>>   dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>>   ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
>>   __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
>>   vhci_hub_control.cold+0x20b/0x5f0 drivers/usb/usbip/vhci_hcd.c:605
>>   rh_call_control drivers/usb/core/hcd.c:683 [inline]
>>   rh_urb_enqueue drivers/usb/core/hcd.c:841 [inline]
>>   usb_hcd_submit_urb+0xcaf/0x22d0 drivers/usb/core/hcd.c:1544
>>   usb_submit_urb+0x6e4/0x1540 drivers/usb/core/urb.c:585
>>   usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
>>   usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>>   usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>>   do_proc_control+0x4af/0x980 drivers/usb/core/devio.c:1165
>>   proc_control drivers/usb/core/devio.c:1191 [inline]
>>   usbdev_do_ioctl drivers/usb/core/devio.c:2535 [inline]
>>   usbdev_ioctl+0x10e2/0x36c0 drivers/usb/core/devio.c:2708
>>   vfs_ioctl fs/ioctl.c:48 [inline]
>>   __do_sys_ioctl fs/ioctl.c:753 [inline]
>>   __se_sys_ioctl fs/ioctl.c:739 [inline]
>>   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
>>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x443499
>> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffd96535f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000443499
>> RDX: 0000000020000000 RSI: 00000000c0185500 RDI: 0000000000000003
>> RBP: 0000000000403040 R08: 0000000000000000 R09: 00000000004004a0
>> R10: 000000000000000f R11: 0000000000000246 R12: 00000000004030d0
>> R13: 0000000000000000 R14: 00000000004b1018 R15: 00000000004004a0
>> ================================================================================
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
> 
> I've tested with following patch locally and issue is solved.
> Porting fix from: c318840fb2 ("USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug")
> 
> Lets ask the syzbot to test the patch also.
> 
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 84196390
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 3209b5ddd30c..6e12b60d4f5c 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -393,13 +393,24 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>   			else
>   				vhci_hcd->port_status[rhport] &= ~USB_PORT_STAT_POWER;
>   			break;
> -		default:
> -			usbip_dbg_vhci_rh(" ClearPortFeature: default %x\n",
> -					  wValue);
> +		case USB_PORT_FEAT_ENABLE:
> +		case USB_PORT_FEAT_C_ENABLE:
> +		case USB_PORT_FEAT_C_SUSPEND:
> +			/* Not allowed for USB-3 */
> +			if (hcd->speed == HCD_USB3)
> +				goto error;
> +			fallthrough;
> +		case USB_PORT_FEAT_C_CONNECTION:
> +		case USB_PORT_FEAT_C_RESET:
>   			if (wValue >= 32)
>   				goto error;
>   			vhci_hcd->port_status[rhport] &= ~(1 << wValue);
>   			break;
> +		default:
> +		/* Disallow INDICATOR and C_OVER_CURRENT */
> +			usbip_dbg_vhci_rh(" ClearPortFeature: default %x\n",
> +					  wValue);
> +			goto error;
>   		}
>   		break;
>   	case GetHubDescriptor:
> @@ -587,23 +598,22 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>   			/* 50msec reset signaling */
>   			vhci_hcd->re_timeout = jiffies + msecs_to_jiffies(50);
>   			fallthrough;
> +		case USB_PORT_FEAT_C_CONNECTION:
> +		case USB_PORT_FEAT_C_RESET:
> +		case USB_PORT_FEAT_C_ENABLE:
> +		case USB_PORT_FEAT_C_SUSPEND:
> +			/* Not allowed for USB-3, and ignored for USB-2 */
> +			if (hcd->speed == HCD_USB3)
> +				goto error;
> +			break;
>   		default:
> +			/* Disallow TEST, INDICATOR, and C_OVER_CURRENT */
>   			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
>   					  wValue);
> -			if (invalid_rhport) {
> +			if (invalid_rhport)
>   				pr_err("invalid port number %d\n", wIndex);
> -				goto error;
> -			}
> -			if (hcd->speed == HCD_USB3) {
> -				if ((vhci_hcd->port_status[rhport] &
> -				     USB_SS_PORT_STAT_POWER) != 0) {
> -					vhci_hcd->port_status[rhport] |= (1 << wValue);
> -				}
> -			} else
> -				if ((vhci_hcd->port_status[rhport] &
> -				     USB_PORT_STAT_POWER) != 0) {
> -					vhci_hcd->port_status[rhport] |= (1 << wValue);
> -				}

This won't work for vhci_hcd. You don't want to get rid of this
USB_SS_PORT_STAT_POWER and USB_PORT_STAT_POWER handling for sure.

The other changes to check for invalid values for USB3 and USB2 are
valid, but I would like to see them in a separate patch.

This bug can be fixed with a two line change to check which is done
for ClearPortFeature in commit 718bf42b119de652ebcc93655a1f33a9c0d04b3c

I hav a patch ready to go to fix this:

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 3209b5ddd30c..a20a8380ca0c 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -594,6 +594,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 
typeReq, u16 wValue,
  				pr_err("invalid port number %d\n", wIndex);
  				goto error;
  			}
+			if (wValue >= 32)
+				goto error;
  			if (hcd->speed == HCD_USB3) {
  				if ((vhci_hcd->port_status[rhport] &
  				     USB_SS_PORT_STAT_POWER) != 0) {
-- 
2.27.0


thanks,
-- Shuah
