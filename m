Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3717444F146
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 05:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhKMExO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 23:53:14 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37896 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232958AbhKMExM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 23:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636779021; x=1668315021;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9Z7JEgNqK69mdItEfNZmsW5+aKBPzFg+GccRl7MFlYo=;
  b=fUTDJlH53vIPUOdnBVnHUM6BypbZ/uBPIOYCgtSxuNu3T0RwXsNyr3JG
   naoeOZNo+5xw8pfs7gRTHJDZ912+h1Lb2e7HS34fAkxd7Xa9tNnlt8v2q
   Sq11f2hxvQeAt8H0x+Y/sDTnsE9IZl/Y/Wh05jo6fqY3FdxFOrwKAm0W7
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Nov 2021 20:50:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 20:50:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 12 Nov 2021 20:50:19 -0800
Received: from qian-HP-Z2-SFF-G5-Workstation (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 12 Nov 2021 20:50:18 -0800
Date:   Fri, 12 Nov 2021 23:50:16 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: KASAN + CPU soft-hotplug = stack-out-of-bounds at cpuinfo_store_cpu
Message-ID: <YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, running CPU soft-hotplug with KASAN on arm64 defconfig will
always trigger a stack-out-of-bounds below. I am not right sure where
exactly KASAN pointed at, so I am just doing the brute-force
bisect. The progress so far:

# git bisect log
git bisect start
# bad: [e73f0f0ee7541171d89f2e2491130c7771ba58d3] Linux 5.14-rc1
git bisect bad e73f0f0ee7541171d89f2e2491130c7771ba58d3
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect good 62fb9874f5da54fdb243003b386128037319b219
# bad: [e058a84bfddc42ba356a2316f2cf1141974625c9] Merge tag 'drm-next-2021-07-01' of git://anongit.freedesktop.org/drm/drm
git bisect bad e058a84bfddc42ba356a2316f2cf1141974625c9
# bad: [a6eaf3850cb171c328a8b0db6d3c79286a1eba9d] Merge tag 'sched-urgent-2021-06-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad a6eaf3850cb171c328a8b0db6d3c79286a1eba9d
# bad: [31e798fd6f0ff0acdc49c1a358b581730936a09a] Merge tag 'media/v5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect bad 31e798fd6f0ff0acdc49c1a358b581730936a09a

I am going to test the "arm64-upstream" merge request next which has
some interesting arm64/cpuinfo patches.

 BUG: KASAN: stack-out-of-bounds in vsnprintf
 Read of size 8 at addr ffff800016297db8 by task swapper/0/0

 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-next-20211110 #157
 Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  print_address_description.constprop.0
  kasan_report
  __asan_report_load8_noabort
  vsnprintf
  vsnprintf at /root/linux-next/lib/vsprintf.c:2807
  vprintk_store
  vprintk_store at /root/linux-next/kernel/printk/printk.c:2138 (discriminator 5)
  vprintk_emit
  vprintk_emit at /root/linux-next/kernel/printk/printk.c:2232
  vprintk_default
  vprintk_default at /root/linux-next/kernel/printk/printk.c:2260
  vprintk
  vprintk at /root/linux-next/kernel/printk/printk_safe.c:50
  _printk
  printk at /root/linux-next/kernel/printk/printk.c:2264
  __cpuinfo_store_cpu
  __cpuinfo_store_cpu at /root/linux-next/arch/arm64/kernel/cpuinfo.c:412
  cpuinfo_store_cpu
  cpuinfo_store_cpu at /root/linux-next/arch/arm64/kernel/cpuinfo.c:418
  secondary_start_kernel
  secondary_start_kernel at /root/linux-next/arch/arm64/kernel/smp.c:241
  __secondary_switched


 addr ffff800016297db8 is located in stack of task swapper/0/0 at offset 136 in frame:
  _printk

 this frame has 1 object:
  [32, 64) 'args'

 Memory state around the buggy address:
  ffff800016297c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff800016297d00: 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 f3 f3
 >ffff800016297d80: f3 f3 00 00 00 00 f3 f3 00 00 00 00 00 00 00 00
                                         ^
  ffff800016297e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff800016297e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
