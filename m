Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB732FDA5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 22:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCFVvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 16:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCFVvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 16:51:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4CAC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 13:51:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so1071233pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 13:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=I6bsrStB2rIUE+S23uPMxa59Lb+W3W5olg/8ZTIrCJA=;
        b=CxhAS7vH/J8XKf8lBjwqiNyjN6iaAyyXoMXfz1TxyNvR4OVvqRfr6QB99HmoWyBuHK
         cNnKJr6O615faP4StTRPV0xhCjQxZ+jg8iv9SfBNm3nQhfNQaWe0jg1Lng8u118yMDn7
         11Bf45F+Ga+NLFcQfL9/KPA6w1QRAqPdVj7SYo1CqwkPnEAsfGwf4o96NtFmtCgmtDVN
         7PhIgodMQArQL4393LkAyPsaHSSf1xlA7Ptx3qtzUBukapS5zKoCWyVjBsfELAHDYBGW
         EbaoeMI93Rvmg+UM2Bzz/9ak+kpz1gfvhZ+uAmz6tPM0wl1CF1RbdyXwPU/hbvq1R0om
         fP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=I6bsrStB2rIUE+S23uPMxa59Lb+W3W5olg/8ZTIrCJA=;
        b=A1AGaN7Q8Zk9W+eCejYTIWyLuftDCLl3kElMtXcFoN7auUZylpwmt52J2njPmd/ER7
         gWqxqz7ZT1oRSXjw97+lchui4pSYo+n0yfQqpQ9MkAsVlK/FdgayQGdWESIDgEST7w/o
         538+rkp7C0vkOF046RJzMzB4Bvelg65ll2E7yoyw6bjgTM5JwB09vprB2MYo3wbj1IUk
         voM5ZkqOQdYCUy7LNU+Z5jjThMBECnsQyOS+0Yry8mQcTjVeEuP57xJJVWfvd0qlSLFN
         c2UnHPJ/ugUOlioEav8/Hvm22tc/4RtuGOaDWV7NAYmjJyHFDggFBylw51+KeotRrDGi
         /ZAQ==
X-Gm-Message-State: AOAM530aj/LseHBd3hRn8KmrUymADFvTaDtxLP9WuLyeeYOEu5OHBtqn
        7WTODL7cbHM4egmINRx/B7A=
X-Google-Smtp-Source: ABdhPJzBu5LD19bdcUIZuKb7cGsMQ1Prh6NARfgaUdWWphxObNOj5OxyGKJxTQHy4f1g4azzK1ft8w==
X-Received: by 2002:a17:902:9e81:b029:e4:a69:2f92 with SMTP id e1-20020a1709029e81b02900e40a692f92mr14318640plq.83.1615067460604;
        Sat, 06 Mar 2021 13:51:00 -0800 (PST)
Received: from [192.168.0.2] (c-73-202-109-61.hsd1.ca.comcast.net. [73.202.109.61])
        by smtp.googlemail.com with ESMTPSA id gf20sm6025109pjb.39.2021.03.06.13.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 13:51:00 -0800 (PST)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Robert Gadsdon <rhgadsdon@gmail.com>
Subject: 5.12-rc1 and -rc2 - BUG/crash after KVM/USB connect/disconnect.
Message-ID: <43c65825-a272-9e4f-7b63-5693f44c5db3@gmail.com>
Date:   Sat, 6 Mar 2021 13:50:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP Z220 (xeon).  Fedora 33  GCC 10.2.1

Boot system, connect via KVM (DVI/USB) and disconnect, then:

.........................

usb 1-1.1.1: USB disconnect, device number 6
usb 1-1.1.1.2: USB disconnect, device number 8
usb 1-1.1.1.4: USB disconnect, device number 9
usb 1-1.1.1.5: clear tt 5 (90d4) error -71
usb 1-1.1.1.5: USB disconnect, device number 11
usb 1-1.1.1.5.4: USB disconnect, device number 12
cp210x ttyUSB0: cp210x converter now disconnected from ttyUSB0
BUG: kernel NULL pointer dereference, address: 0000000000000278
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 2899 Comm: kworker/0:0 Not tainted 5.12.0-rc2 #1
Hardware name: Hewlett-Packard HP Z220 CMT Workstation/1790, BIOS K51 
v01.87 06/10/2019
Workqueue: usb_hub_wq hub_event
RIP: 0010:gpiodevice_release+0xc/0x70
Code: c0 0f b6 c0 5b c3 85 c0 5b 0f 95 c0 0f b6 c0 c3 0f 0b eb b1 b8 fb 
ff ff ff 5b c3 0f 1f 00 55 48 8b 6f 78 48 c7 c7 d0 24 13 b7 <48> 8b 95 
78 02 00 00 48 8b 85 80 02 00 00 48 89 42 08 48 89 10 8b
RSP: 0018:ffffb7b600a3bb10 EFLAGS: 00010286
RAX: ffffffffb6414650 RBX: 00000000ffffffff RCX: 0000000000000282
RDX: ffff8a255a8d6598 RSI: 0000000000000282 RDI: ffffffffb71324d0
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000282
R10: 0000000000000001 R11: ffffffffb71646a0 R12: ffff8a254f51a100
R13: ffffffffb7145e60 R14: ffff8a255a811790 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8a284dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000278 CR3: 000000012dd6a003 CR4: 00000000001706f0
Call Trace:
  device_release+0x2f/0x80
  kobject_put+0x63/0xc0
  cp210x_disconnect+0x1b/0x30 [cp210x]
  usb_serial_disconnect+0xe1/0x130
  usb_unbind_interface+0x65/0x1c0
  __device_release_driver+0x144/0x1f0
  device_release_driver+0x1f/0x30
  bus_remove_device+0xcd/0x110
  device_del+0x185/0x450
  ? kobject_put+0x70/0xc0
  usb_disable_device+0xac/0x150
  usb_disconnect.cold+0x60/0x1a4
  usb_disconnect.cold+0x29/0x1a4
  usb_disconnect.cold+0x29/0x1a4
  hub_event+0x5cf/0x1230
  ? __switch_to_asm+0x42/0x70
  process_one_work+0x1ea/0x340
  worker_thread+0x48/0x3c0
  ? rescuer_thread+0x380/0x380
  kthread+0x111/0x130
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x22/0x30
Modules linked in: rfcomm cmac hid_logitech_hidpp bnep btusb btrtl btbcm 
btintel bluetooth ecdh_generic ecc hid_logitech_dj cp210x joydev 
uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 snd_usb_audio 
videobuf2_common snd_usbmidi_lib videodev snd_rawmidi mc iptable_filter 
bpfilter sunrpc snd_hda_codec_hdmi snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio x86_pkg_temp_thermal 
intel_powerclamp snd_hda_intel coretemp snd_intel_dspcfg snd_hda_codec 
kvm_intel snd_hda_core snd_hwdep snd_seq kvm snd_seq_device irqbypass 
at24 snd_pcm rapl hp_wmi snd_timer sparse_keymap iTCO_wdt wmi_bmof 
rfkill iTCO_vendor_support snd intel_cstate pcspkr i2c_i801 intel_uncore 
i2c_smbus soundcore lpc_ich wmi drm zram ip_tables x_tables 
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel r8169 
e1000e fuse
CR2: 0000000000000278
---[ end trace a5b6fc6316be72a4 ]---
RIP: 0010:gpiodevice_release+0xc/0x70
Code: c0 0f b6 c0 5b c3 85 c0 5b 0f 95 c0 0f b6 c0 c3 0f 0b eb b1 b8 fb 
ff ff ff 5b c3 0f 1f 00 55 48 8b 6f 78 48 c7 c7 d0 24 13 b7 <48> 8b 95 
78 02 00 00 48 8b 85 80 02 00 00 48 89 42 08 48 89 10 8b
RSP: 0018:ffffb7b600a3bb10 EFLAGS: 00010286
RAX: ffffffffb6414650 RBX: 00000000ffffffff RCX: 0000000000000282
RDX: ffff8a255a8d6598 RSI: 0000000000000282 RDI: ffffffffb71324d0
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000282
R10: 0000000000000001 R11: ffffffffb71646a0 R12: ffff8a254f51a100
R13: ffffffffb7145e60 R14: ffff8a255a811790 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8a284dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000278 CR3: 000000012dd6a003 CR4: 00000000001706f0

................................

Fault is 100% reproducible.   Login/logout no longer works.  Hard power 
cycle required.

No problems with Kernel 5.11.x


