Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867843A04AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhFHTze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhFHTzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:55:33 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CDCC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 12:53:39 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w14so11391822ilv.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=3dzfYFpJCrotn8xF2SUuDZbP0Plaz1Ii4sIXlMrsbY0=;
        b=mvroWSIkpdwX6d+VEftt4Y1aRzQeEHEXnZAVRIVccDsROOa57p7q+wJ5nAXJFN9QE4
         +nd/PwqxDnNLpA8lGWHUEXrXemYQELH/jmBQOydS2MCtjV5YRHB1G5x4LhC6MhuVu/Hp
         iTZ7Nk+qD/ITmlixIdBzb26b1w64sWaw9DMVylQ6ECDiePJSyo1Icq+JkE1XoAe0uSfp
         NfaAKyYc5Rht18tFzejRr+PxlXnUP3ltq/aBuouP9kogcQhAKwNyrjIyemrlTrnqtib0
         DGllg6X64K1QngfvXh435J3rNXmzYtITbWOuZga0Ty6Xgp9tBwLTf40vtWYgmM3QYLoz
         YNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3dzfYFpJCrotn8xF2SUuDZbP0Plaz1Ii4sIXlMrsbY0=;
        b=CPAL2wgKfIbEQN3enFopIP3JLkuOpa+JBU6VNzQonkGhzdLRNpt+vsbK99PP/dITAG
         TOW0MzszMdM6+wCNJJGKvOpYDXFOqB4dZ+jO/oiA8eG3bcgCPyYWFkgG673/dYsI3UMW
         oJ1p9zX4GvrCpD7d4ohfxLSfv4OA6Zn/xYAibs+WI06Mk9NzItoHVNqKRc9C6/gL6hqZ
         OthJgxq4MYRHL76jX0jr0u84Ii7PkwCgB90ur9Zc5z6HSj2k/hfS4ie7+xhbw07ps6Zc
         oSloaM6c1HFV2iwLulP5WpRVzXYJCSg4LFMKFGPdAPAGrXDklLmKCFek4gb5g99dT+5C
         CIOg==
X-Gm-Message-State: AOAM533LJxOa36oT81oJzOtA+yCuPX0Kms3n2KcFyMq5NBUvoGsptSQQ
        Mj46Kkcc4uzSmK+zFD46ryOH06Uv78PR9GQB1HEyVk8cjTjIrg==
X-Google-Smtp-Source: ABdhPJznD+7XtluBHCJQVMd/y9WU/oB/WH2+sQ/vjTYeWHgu9qLOR5bf+7Qxf5tKgn5xHo9oypcbUTOtyvImn2hdSjw=
X-Received: by 2002:a05:6602:2587:: with SMTP id p7mr1444523ioo.12.1623182018969;
 Tue, 08 Jun 2021 12:53:38 -0700 (PDT)
MIME-Version: 1.0
From:   Sean Quinn <spq@g.ucla.edu>
Date:   Tue, 8 Jun 2021 12:53:13 -0700
Message-ID: <CAMcO1Vu0e3mfK-s-vh57UmRu8_L_E_Q6n_d95U88j3wG3Sxaow@mail.gmail.com>
Subject: Reserving memory
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel newb here, sorry if this is could be sent to a more suitable list.

I have an embedded project using a Zynq based SoM (Enclustra
MA-ZX2-10-2I-D9 SOM). We have a device using a DMA that writes data
into system SDRAM shared by the processing system/OS.

Using Xilinx tools ("2019.2"), which are based on kernel 4.19 I am
able to build an image and use the "mem=384M" boot arg kernel command
to prevent overlap with a reserved region (top 128M of 512M) where our
device is writing data to a ring buffer.

I am still debugging, but unfortunately, this same tactic seems to
fail with newer tools ("2020.1") based on kernel 5.4. That boot arg
results in a kernel panic. I have also tried using a device tree
approach, e.g.

reserved-memory {
  #address-cells = <1>;
  #size-cells = <1>;
  ranges;

  reserved: rambuffer@0x18000000 {
   no-map;
   reg = <0x18000000 0x8000000>;
  };
};

also results in kernel panic during boot (pasted at end of msg)

Perhaps my understanding of what mem does is poor and got lucky the
first time. If the kernel error is the correct behavior, could I ask
what is the proper way to configure reserved regions? Any
feedback/criticisms/links welcome

Cheers,

U-Boot 2020.01 (Jun 08 2021 - 01:46:49 +0000)

CPU:   Zynq 7z010
Silicon: v3.1
Model: Enclustra MA-ZX2-10-2I-D9 SOM
DRAM:  ECC disabled 512 MiB
Flash: 0 Bytes
NAND:  0 MiB
MMC:   mmc@e0100000: 0
Loading Environment from FAT... *** Warning - bad CRC, using default environment

Loading Environment from SPI Flash... SF: Detected s25fl512s_256k with
page size 256 Bytes, erase size 256 KiB, total 64 MiB
*** Warning - bad CRC, using default environment

In:    serial@e0000000
Out:   serial@e0000000
Err:   serial@e0000000
Net:
ZYNQ GEM: e000b000, mdio bus e000b000, phyaddr 3, interface rgmii-id
eth0: ethernet@e000b000
Hit any key to stop autoboot:  0
switch to partitions #0, OK
mmc0 is current device
Scanning mmc 0:1...
Found U-Boot script /boot.scr
ERROR: reserving fdt memory region failed (addr=18000000 size=8000000)
2010 bytes read in 19 ms (102.5 KiB/s)
## Executing script at 03000000
ERROR: reserving fdt memory region failed (addr=18000000 size=8000000)
4349960 bytes read in 328 ms (12.6 MiB/s)
## Loading kernel from FIT Image at 10000000 ...
   Using 'conf@system-top.dtb' configuration
   Verifying Hash Integrity ... OK
   Trying 'kernel@1' kernel subimage
     Description:  Linux kernel
     Type:         Kernel Image
     Compression:  uncompressed
     Data Start:   0x100000f8
     Data Size:    4328048 Bytes = 4.1 MiB
     Architecture: ARM
     OS:           Linux
     Load Address: 0x00200000
     Entry Point:  0x00200000
     Hash algo:    sha256
     Hash value:
efedbd67e6d5dc525817819550a182c9650143669af52c31fa7d49cf57156a25
   Verifying Hash Integrity ... sha256+ OK
## Loading fdt from FIT Image at 10000000 ...
   Using 'conf@system-top.dtb' configuration
   Verifying Hash Integrity ... OK
   Trying 'fdt@system-top.dtb' fdt subimage
     Description:  Flattened Device Tree blob
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x10420c74
     Data Size:    20014 Bytes = 19.5 KiB
     Architecture: ARM
     Hash algo:    sha256
     Hash value:
640e1e4ba0f8d7d0a696e3cffd4de243b1f193782df8dfb57ab64ddcebb2d2ef
   Verifying Hash Integrity ... sha256+ OK
   Booting using the fdt blob at 0x10420c74
   Loading Kernel Image
ERROR: reserving fdt memory region failed (addr=18000000 size=8000000)
   Loading Device Tree to 1eafe000, end 1eb05e2d ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 5.4.0-xilinx-v2020.1 (oe-user@oe-host) (gcc version
9.2.0 (GCC)) #1 SMP PREEMPT Sat Jun 5 00:08:36 UTC 2021
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
OF: fdt: Machine model: Enclustra MA-ZX2-10-2I-D9 SOM
earlycon: cdns0 at MMIO 0xe0000000 (options '115200n8')
printk: bootconsole [cdns0] enabled
Memory policy: Data cache writealloc
cma: Reserved 16 MiB at 0x17000000
8<--- cut here ---
Unable to handle kernel paging request at virtual address deafe000
pgd = (ptrval)
[deafe000] *pgd=00000000
Internal error: Oops - BUG: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.4.0-xilinx-v2020.1 #1
Hardware name: Xilinx Zynq Platform
PC is at fdt32_ld+0x0/0xc
LR is at fdt_check_header+0xc/0x124
pc : [<c06a2b30>]    lr : [<c06a2bf4>]    psr: a00000d3
sp : c0b01f20  ip : 00b582ff  fp : d6ffff00
r10: c0b130f4  r9 : c0a1fe78  r8 : 00000000
r7 : deafe000  r6 : c0b51b58  r5 : c0b0833c  r4 : c0a1fe78
r3 : deafe000  r2 : c0b51b58  r1 : 00000000  r0 : deafe000
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 18c5387d  Table: 0000404a  DAC: 00000051
Process swapper (pid: 0, stack limit = 0x(ptrval))
Stack: (0xc0b01f20 to 0xc0b02000)
1f20: c0a1fe78 c0b0833c c0b51b58 c055c45c c0a1fe78 c0b0833c c0b06f40 c0b37500
1f40: 00000000 c0b46f90 c0b130f4 c0a20fe0 00000000 0000000c c0a2b36c c0a041e8
1f60: ffffffff 18c5387d c0b03c40 c08694b4 00000000 c0b37380 00000001 18c5387d
1f80: 00000000 c0157f9c c07f9851 c0b03c48 00000001 c0a00330 c0b03c40 10c0387d
1fa0: 00000000 c0b37380 00000001 18c5387d 00000000 c0a00970 00000000 00000000
1fc0: 00000000 00000000 00000000 c0a2da40 00000000 c0b03c48 c0a00330 00000051
1fe0: 10c0387d 00000000 1eafe000 413fc090 18c5387d 00000000 00000000 00000000
[<c06a2b30>] (fdt32_ld) from [<c06a2bf4>] (fdt_check_header+0xc/0x124)
[<c06a2bf4>] (fdt_check_header) from [<c055c45c>]
(__unflatten_device_tree+0x28/0xfc)
[<c055c45c>] (__unflatten_device_tree) from [<c0a20fe0>]
(unflatten_device_tree+0x24/0x40)
[<c0a20fe0>] (unflatten_device_tree) from [<c0a041e8>] (setup_arch+0x63c/0xa6c)
[<c0a041e8>] (setup_arch) from [<c0a00970>] (start_kernel+0x58/0x440)
[<c0a00970>] (start_kernel) from [<00000000>] (0x0)
Code: ebf2196f e28dd014 e49df004 c06a2a28 (e5900000)
random: get_random_bytes called from init_oops_id+0x20/0x3c with crng_init=0
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

--
Sean Quinn
Postdoctoral researcher, GAPS project

475 Portola Plaza
Los Angeles, CA 90095

spq@ucla.edu | Office: 310-825-0344  | Web: gaps1.astro.ucla.edu/gaps/
