Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A43D2780
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhGVPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGVPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:43:56 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D74BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 09:24:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id n10so5893789qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/9A1U2tjpytF5BH9ed6fRKKNW2jxsdKaY9uVSZrlrao=;
        b=LO2v+Tbc5n3HU+hSI3V7LpaW0jNBn8dQdj67evpCUFdWIUr7s5l5hUBU0TjYQMlXcD
         l/lM9Kd9j4dV6D5G9pPrUmQwILrX0JsK3WRCzlSupTrWJd9kjrcDH9jgHsXqr577VXBN
         ZH+Q6m/oC1LVCkmbSWBmU02aF9MNt672rnSLHV/aw89vKBkHzO5m0pA1e7HqU28W02Sp
         9FltWsA+iZUtOzlRa3necZVcwLmFVcWAfyryTTMF6X/gK5x+8gMV69LriQBsJRGkM801
         5VlaSPteuF74Ui4ddAW+ySFwpKdf/SUv733NCS3CZ5/+aqTlOpuVEk2ZeWlKsFuyjZ+U
         zQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:from:to:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=/9A1U2tjpytF5BH9ed6fRKKNW2jxsdKaY9uVSZrlrao=;
        b=WANbxu0ecklcECxWw0f+xKULRX6KVrVkCeis4GEXKPO2j7ilrp3VHRK4GzdT+5Dn9v
         rZ2A3+uarYXBMHmPnuhV0FWVM5AVEUJPgklCQo++U/syzekZT5lNzQoeX76iyRgb+TEz
         czlUwEh5K3G/Tau3vj+dVMIO+SqamSdm+n7jPEV6/0G88QyLgXFUMNBx65fpNDG1JxWc
         6fbX/t2DI1glswpNh2pNzTQkARJvKRtaPAmvh2tjkwL4t4/kurFFxj7FPxi/8XZanfN9
         TRGzOMWc1mjt+6ih6Ns2fH6u9h8+Oxa2go66SL84DjCWexy3soF/y8k/fyZi9NKL/QbI
         4irA==
X-Gm-Message-State: AOAM532bDdJ/zS9BEDohcnXckCmqYvwYar8H4xYOTygP7lRX5XirOnWd
        xkFCfL6U9kJNZ3HAkE5xCiaFkw6afek=
X-Google-Smtp-Source: ABdhPJwOcCmvGnNzwZgzVxh/Hq4t1IPPm4ZWgucSSERYipPgX1jJLELWxKY3pZIYCIl01eqP9BiUyg==
X-Received: by 2002:a05:620a:913:: with SMTP id v19mr450104qkv.429.1626971069058;
        Thu, 22 Jul 2021 09:24:29 -0700 (PDT)
Received: from mua.localhost ([2600:1700:e380:2c20::47])
        by smtp.gmail.com with ESMTPSA id l29sm6805316qtn.8.2021.07.22.09.24.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 09:24:28 -0700 (PDT)
Reply-To: pgnet.dev@gmail.com
From:   PGNet Dev <pgnet.dev@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: boot of J1900 (quad-core Celeron) mobo: kernel <= 5.12.15, OK; kernel
 >= 5.12.17, 5.13.4, slow boot (>> 660 secs) + hang/FAIL
Message-ID: <eee39f4a-b929-3284-fa4b-a7174dd01321@gmail.com>
Date:   Thu, 22 Jul 2021 12:26:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My servers run Fedora 34, with latest kernels.

Updating to any of minimally- or un- patched 5.12.17 or 5.13.4 hangs/fails, as follows.

On just one server , an old ASRockRack J1900D2Y (quad-core Celeron) motherboard build,

	hwinfo --bios
		01: None 00.0: 10105 BIOS
		  [Created at bios.186]
		  Unique ID: rdCR.lZF+r4EgHp4
		  Hardware Class: bios
		  BIOS Keyboard LED Status:
		    Scroll Lock: off
		    Num Lock: off
		    Caps Lock: off
		  Serial Port 0: 0x3f8
		  Base Memory: 626 kB
		  PnP BIOS: @@@0000
		  MP spec rev 1.4 info:
		    OEM id: "A M I"
		    Product id: "ALASKA"
		    4 CPUs (0 disabled)
		  SMBIOS Version: 2.8
		  BIOS Info: #0
		    Vendor: "American Megatrends Inc."
		    Version: "P1.10"
		    Date: "01/23/2015"
		    Start Address: 0xf0000
		    ROM Size: 8192 kB
		    Features: 0x0d03000000013f8b9880
		      PCI supported
		      BIOS flashable
		      BIOS shadowing allowed
		      CD boot supported
		      Selectable boot supported
		      BIOS ROM socketed
		      EDD spec supported
		      1.2MB Floppy supported
		      720kB Floppy supported
		      2.88MB Floppy supported
		      Print Screen supported
		      8042 Keyboard Services supported
		      Serial Services supported
		      Printer Services supported
		      ACPI supported
		      USB Legacy supported
		      BIOS Boot Spec supported
		  System Info: #1
		    Manufacturer: "To Be Filled By O.E.M."
		    Product: "To Be Filled By O.E.M."
		    Version: "To Be Filled By O.E.M."
		    Serial: "To Be Filled By O.E.M."
		    UUID: 03000200-0400-0500-0006-000700080009
		    Wake-up: 0x06 (Power Switch)
		  Board Info: #2
		    Manufacturer: "ASRock"
		    Product: "J1900D2Y"
		    Type: 0x0a (Motherboard)
		    Features: 0x09
		      Hosting Board
		      Replaceable
		    Chassis: #3
		...

with Fedora34 Kernel <=

	Fedora (5.12.15-300.fc34.x86_64) 34 (Thirty Four)

the box boots/runs OK,

	[    0.000000] microcode: microcode updated early to revision 0x838, date = 2019-04-22
	[    0.000000] Linux version 5.12.15-300.fc34.x86_64 (mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3), GNU ld version 2.35.1-41.fc34) #1 SMP Wed Jul 7 19:46:50 UTC 2021
	[    0.000000] Command line: BOOT_IMAGE=(mduuid/5687b25f8f25671a243a83cb661f7841)/vmlinuz-5.12.15-300.fc34.x86_64 root=/dev/mapper/VG0-LV_ROOT ro i915.modeset=1 vconsole.keymap=us vconsole.font=eurlatgr vconsole.font_map=trivial domdadm_
	[    0.000000] x86/fpu: x87 FPU will use FXSAVE
	[    0.000000] BIOS-provided physical RAM map:
	[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
	[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
	[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
	[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000200fffff] reserved
	[    0.000000] BIOS-e820: [mem 0x0000000020100000-0x000000006d66cfff] usable
	[    0.000000] BIOS-e820: [mem 0x000000006d66d000-0x000000006d69cfff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000006d69d000-0x000000006d6acfff] ACPI data
	[    0.000000] BIOS-e820: [mem 0x000000006d6ad000-0x000000006d7f1fff] ACPI NVS
	[    0.000000] BIOS-e820: [mem 0x000000006d7f2000-0x000000006db80fff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000006db81000-0x000000006db81fff] usable
	[    0.000000] BIOS-e820: [mem 0x000000006db82000-0x000000006dbc3fff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000006dbc4000-0x000000006dd31fff] usable
	[    0.000000] BIOS-e820: [mem 0x000000006dd32000-0x000000006dff9fff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000006dffa000-0x000000006dffffff] usable
	[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
	[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
	[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reserved
	[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047fffffff] usable
	[    0.000000] printk: console [earlyser0] enabled
	Memory KASLR using RDRAND RDTSC...
	Poking KASLR using RDRAND RDTSC...

	Welcome to Fedora 34 (Thirty Four) dracut-055-3.fc34 (Initramfs)!

	[  OK  ] Started Dispatch Password …ts to Console Directory Watch.
	[  OK  ] Reached target Local File Systems.
	[  OK  ] Reached target Path Units.
	...
	Fedora 34 (Thirty Four)
	Kernel 5.12.15-300.fc34.x86_64 on an x86_64 (ttyS0)

	srv01 login:
	...
	lsb_release -rd
		Description:    Fedora release 34 (Thirty Four)
		Release:        34
	uname -rm
		5.12.15-300.fc34.x86_64 x86_64

updating to any of minimally- or un- patched,

	Fedora (5.12.17-300.fc34.x86_64) 34 (Thirty Four)
		https://koji.fedoraproject.org/koji/buildinfo?buildID=1780670

	Fedora (5.13.4-200.fc34.x86_64) 34 (Thirty Four)
		https://koji.fedoraproject.org/koji/buildinfo?buildID=1782334

	Fedora (5.13.4-250.vanilla.1.fc34.x86_64) 34 (Thirty Four)
	    https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories
	    https://repos.fedorapeople.org/repos/thl/kernel-vanilla-stable/fedora-34/x86_64/
		https://fedorapeople.org/cgit/thl/public_git/kernel.git/tree/?h=kernel-5.13.3-250.vanilla.1.fc34

and re-gen'ing initrd, system boot hangs early in each case,


	[    0.000000] microcode: microcode updated early to revision 0x838, date = 2019-04-22
	[    0.000000] Linux version 5.13.4-200.fc34.x86_64 (mockbuild@bkernel01.iad2.fedoraproject.org) (gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3), GNU ld version 2.35.1-41.fc34) #1 SMP Tue Jul 20 20:27:29 UTC 2021
	[    0.000000] Command line: BOOT_IMAGE=(mduuid/5687b25f8f25671a243a83cb661f7841)/vmlinuz-5.13.4-200.fc34.x86_64 root=/dev/mapper/VG0-LV_ROOT ro i915.modeset=1 vconsole.keymap=us vconsole.font=eurlatgr vconsole.font_map=trivial domdadm b
	[    0.000000] x86/fpu: x87 FPU will use FXSAVE
	[    0.000000] BIOS-provided physical RAM map:
	[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
	[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
	[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
	[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000200fffff] reserved
	[    0.000000] BIOS-e820: [mem 0x0000000020100000-0x000000006d66cfff] usable
	[    0.000000] BIOS-e820: [mem 0x000000006d66d000-0x000000006d69cfff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000006d69d000-0x000000006d6acfff] ACPI data
	[    0.000000] BIOS-e820: [mem 0x000000006d6ad000-0x000000006d7f1fff] ACPI NVS
	[    0.000000] BIOS-e820: [mem 0x000000006d7f2000-0x000000006db80fff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000006db81000-0x000000006db81fff] usable
	[    0.000000] BIOS-e820: [mem 0x000000006db82000-0x000000006dbc3fff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000006dbc4000-0x000000006dd31fff] usable
	[    0.000000] BIOS-e820: [mem 0x000000006dd32000-0x000000006dff9fff] reserved
	[    0.000000] BIOS-e820: [mem 0x000000006dffa000-0x000000006dffffff] usable
	[    0.000000] BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
	[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed01fff] reserved
	[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reserved
	[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047fffffff] usable
	[    0.000000] printk: console [earlyser0] enabled
	Memory KASLR using RDRAND RDTSC...
	Poking KASLR using RDRAND RDTSC...

, and proceeds no further.

drop-back to

	Fedora (5.12.15-300.fc34.x86_64) 34 (Thirty Four)

boots, again, with no issues.

for the

	Fedora (5.13.4-200.fc34.x86_64) 34 (Thirty Four)

case, with logging dialed up,

logs show a sloooooow boot process ( 700+ seconds and counting ), with eventual, complete hang @

	"Starting Apply Kernel Variables..."

--> https://pastebin.com/dP6Lm84J

So far, this occurs on this J1900 box only; other-hardware F34 installs with kernel >= 5.12.17 are booting fine.

AND, for _this_ J1900, all kernels <= 5.12.15 boot OK.



if there's specific, additional logging that'd be informative, I can attach.  or, redirect to other list.
