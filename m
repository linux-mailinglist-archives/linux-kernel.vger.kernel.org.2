Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832B63B2565
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFXDXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhFXDXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:23:10 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:20:50 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t40so5756584oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 20:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=esync.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=OWpIeV3YRUBoIiQdfBgwXbQC0N2H7D7TqWlvf7MiC8s=;
        b=AY7PJB1fPC3qyEyusNHEm6P6+B7ap3rU7bDvitZTl+GxftVr3rUySF+FIyg6T0qlee
         L7U/wMcar/jsWmc1FmxbqFtukfOSGjfLcmOdrC8NbsiqffP1jPRiHh/uSjvEm0voTG/X
         9ang3E7+f5YcOsCiiPEzGe9HAAje/JS57YlL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OWpIeV3YRUBoIiQdfBgwXbQC0N2H7D7TqWlvf7MiC8s=;
        b=XrVkeuHlOYcp47MdSzasqj/8T91jUaVw/ihJHxRGUfVeRdeSZ6bgYBMDDKE4JmBzFj
         gpY01p7gPs/9uM3eFLKQe1jC8KfPcEvJeafy7DTRCxYQGtu2/G1h6hMWyBOA2LZohx7T
         Z3uPIV/K1Cvw8I2kdZtF9nuSyxvnNNyJ3+kTCm0/xiysAkty1oUKsKb8hk7OqFi6TEmw
         UeYeYbkuty4+siGLgApQFizjCA0nkDSSMI44WHq1Y9H5LR9hVdH0RRN4k/x+e9KHMQSj
         U0PToNsCaEGJQu56/kw3SreK6lgfoJaYN4MJKOg4sqTx9+N180jLbLcJfuXi+kSb5uc1
         ORKQ==
X-Gm-Message-State: AOAM530Cd3HLC59vbFZGwM56cBjmqAhpkldbi+5kLXZs127LriNqMZx+
        rVzxx81uMsbliagq05fvL+cCUZdJrfytKnhr1BtVD47nVDNJqsAU5YgDJw==
X-Google-Smtp-Source: ABdhPJyWSEnsKT/zj50TIQBILA5l+vWBa/m50IezCqzzOHO1/5mfLcx6E+jHiblZ3Riwwsyfg4/OCSnu8g/VrTIf00g=
X-Received: by 2002:a05:6808:1388:: with SMTP id c8mr5626388oiw.68.1624504849695;
 Wed, 23 Jun 2021 20:20:49 -0700 (PDT)
MIME-Version: 1.0
From:   "pdan@esync.org" <pdan@esync.org>
Date:   Thu, 24 Jun 2021 11:20:38 +0800
Message-ID: <CAHRGjuFOnkEtJGoD7iDLH3N84toMPdoSSURh60BRW57h__iNvw@mail.gmail.com>
Subject: CMCI storm on 16C Intel Denverton on Supermicro A2SDi-16C-TP8F
 running 5.4.0-77
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if this has been brought up before.

I have recently purchased a Supermicro A2SDi-16C-TP8F featuring an
Intel C3958 (Denverton, 16C) processor, and I am seeing CMCI storm log
messages. Hardware details below. I can 100% reproduce the errors:

- On every boot, after the CPU initialization.
- When saturating the 10GBase-T (Intel X533 integrated into Intel
Denverton) network card (iperf3).

My immediate suspicion was that it's a memory error, however this
seems unlikely:

- Important: Supermicro support confirms they repro on their test
A2SDi-16C-TP8F system when running the same OS. This presumably rules
out my specific system, DIMMs, bios config, etc.
- Memtest86 does not find any errors, nor can I get it to reproduce
when stress testing after booting (memtester, stress-ng, etc.)
- I still can reproduce when removing / swapping DIMMs / slots.

As expected mce=no_cmci disables the notifications although the
implications are unclear to me.

Supermicro support advises that the distribution / kernel I am running
is not supported as this affects newer kernel versions on 16C
Denverton and recommends that I downgrade to a supported version
(https://www.supermicro.com/support/resources/OS/Denverton.cfm), which
is not particularly useful.

Is there any context / solution? I am happy to run any tests on the
system to debug further.

Thank you!
Dan

# dmesg -T|grep -B1 -A1 CMCI
[Wed Jun 23 17:54:18 2021] .... node  #0, CPUs:        #1  #2  #3  #4
#5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[Wed Jun 23 17:54:18 2021] mce: CMCI storm detected: switching to poll mode
[Wed Jun 23 17:54:18 2021] smp: Brought up 1 node, 16 CPUs
--
[Wed Jun 23 17:57:43 2021] igb 0000:04:00.1 lan1: igb: lan1 NIC Link
is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[Wed Jun 23 17:59:19 2021] mce: CMCI storm subsided: switching to interrupt mode

# uname -a
Linux atlas 5.4.0-77-generic #86-Ubuntu SMP Thu Jun 17 02:35:03 UTC
2021 x86_64 x86_64 x86_64 GNU/Linux

# lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 20.04.2 LTS
Release: 20.04
Codename: focal

# dmidecode | grep -A 3 "Base Board Information"
Base Board Information
Manufacturer: Supermicro
Product Name: A2SDi-16C-TP8F
Version: 2.00

# dmidecode | grep -A 3 "BIOS Information"
BIOS Information
Vendor: American Megatrends Inc.
Version: 1.5
Release Date: 05/17/2021

# lscpu | grep "Model name"
Model name:                      Intel(R) Atom(TM) CPU C3958 @ 2.00GHz

# lspci
00:00.0 Host bridge: Intel Corporation Atom Processor C3000 Series
System Agent (rev 11)
00:04.0 Host bridge: Intel Corporation Atom Processor C3000 Series
Error Registers (rev 11)
00:05.0 Generic system peripheral [0807]: Intel Corporation Atom
Processor C3000 Series Root Complex Event Collector (rev 11)
00:06.0 PCI bridge: Intel Corporation Atom Processor C3000 Series
Integrated QAT Root Port (rev 11)
00:09.0 PCI bridge: Intel Corporation Atom Processor C3000 Series PCI
Express Root Port #0 (rev 11)
00:0b.0 PCI bridge: Intel Corporation Atom Processor C3000 Series PCI
Express Root Port #2 (rev 11)
00:0e.0 PCI bridge: Intel Corporation Atom Processor C3000 Series PCI
Express Root Port #4 (rev 11)
00:0f.0 PCI bridge: Intel Corporation Atom Processor C3000 Series PCI
Express Root Port #5 (rev 11)
00:12.0 System peripheral: Intel Corporation Atom Processor C3000
Series SMBus Contoller - Host (rev 11)
00:14.0 SATA controller: Intel Corporation Atom Processor C3000 Series
SATA Controller 1 (rev 11)
00:15.0 USB controller: Intel Corporation Atom Processor C3000 Series
USB 3.0 xHCI Controller (rev 11)
00:16.0 PCI bridge: Intel Corporation Atom Processor C3000 Series
Integrated LAN Root Port #0 (rev 11)
00:17.0 PCI bridge: Intel Corporation Atom Processor C3000 Series
Integrated LAN Root Port #1 (rev 11)
00:18.0 Communication controller: Intel Corporation Atom Processor
C3000 Series ME HECI 1 (rev 11)
00:1f.0 ISA bridge: Intel Corporation Atom Processor C3000 Series LPC
or eSPI (rev 11)
00:1f.2 Memory controller: Intel Corporation Atom Processor C3000
Series Power Management Controller (rev 11)
00:1f.4 SMBus: Intel Corporation Atom Processor C3000 Series SMBus
controller (rev 11)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Atom Processor
C3000 Series SPI Controller (rev 11)
01:00.0 Co-processor: Intel Corporation Atom Processor C3000 Series
QuickAssist Technology (rev 11)
04:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
04:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
04:00.2 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
04:00.3 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
05:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 03)
06:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED
Graphics Family (rev 30)
07:00.0 Ethernet controller: Intel Corporation Ethernet Connection
X553/X557-AT 10GBASE-T (rev 11)
07:00.1 Ethernet controller: Intel Corporation Ethernet Connection
X553/X557-AT 10GBASE-T (rev 11)
08:00.0 Ethernet controller: Intel Corporation Ethernet Connection
X553 10 GbE SFP+ (rev 11)
08:00.1 Ethernet controller: Intel Corporation Ethernet Connection
X553 10 GbE SFP+ (rev 11)
