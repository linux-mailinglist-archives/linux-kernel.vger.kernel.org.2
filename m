Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04703BB963
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhGEIgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:36:40 -0400
Received: from m12-14.163.com ([220.181.12.14]:51993 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhGEIgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=ird5s
        xD8dDmx7765tccMXUYQOtjiwkg5wX+vZTdU4aI=; b=X7zM0S2NnvnL4i6UuTYOP
        ZTHq715ur5YzfOl4s4t8mp/gsMnPZ+MA0HfoUPImmLymUApQUsj8G4wcmjzFplUI
        ZpREGTJlRQDCoy1Cb9/cDQQFZuJEJGapVqcl7q8//8bGxEiB4FaXpWou0UP+XF0r
        WXaEqIr99PPEMGccvkpx5Q=
Received: from [192.168.3.109] (unknown [218.201.129.20])
        by smtp10 (Coremail) with SMTP id DsCowABHTyP5w+JggIBcSQ--.27087S2;
        Mon, 05 Jul 2021 16:34:02 +0800 (CST)
To:     linux-kernel@vger.kernel.org
From:   qianfan <qianfanguijin@163.com>
Subject: how to debug linux kernel by JLink
Message-ID: <4f2c24f2-fc96-eaf7-16c0-04ae7e9f825c@163.com>
Date:   Mon, 5 Jul 2021 16:34:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABHTyP5w+JggIBcSQ--.27087S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xr4xtw4rXr1xZFWxCFW8Xrb_yoW8Jr1Dp3
        90gr93Cw4DJ3yj9wn7Ga1UuFyrJasxXF45AFWkC3sYyFy7WryrZr92qrnI9w17Aayjqay3
        trnrXFn29ay5ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b0Z2-UUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiQhrG7VaD-ecKwgAAs0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I'm reading linux kernel source code and try debugging linux by using 
JLink. I had developed env on my bananapi-m2u and can connected it in gdb.

I add some breakpoints in gdb and seems only code before thread ready 
can hit: (next is the log)

(gdb) i b
Num     Type           Disp Enb Address    What
1       breakpoint     keep y   0xc0b00940 in start_kernel at 
init/main.c:877
2       breakpoint     keep y   0xc07f7a30 in kernel_init at 
init/main.c:1441
3       breakpoint     keep y   0xc0690ce4 in of_platform_populate at 
drivers/of/platform.c:472
4       breakpoint     keep y   0xc0603234 in mv64xxx_i2c_probe at 
drivers/i2c/busses/i2c-mv64xxx.c:935
(gdb) c
Continuing.

Breakpoint 1, start_kernel () at init/main.c:877
877     {
(gdb) c
Continuing.

Breakpoint 2, kernel_init (unused=0x0) at init/main.c:1441
1441    {
(gdb) bt
#0  kernel_init (unused=0x0) at init/main.c:1441
#1  0xc0100150 in ret_from_fork () at arch/arm/kernel/entry-common.S:158
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb) c
Continuing.

breakpoints start_kernel and kernel_init hited, but of_platform_populate 
and device probe functions doesn't.

Is it a good way debugging linux kernel by using hardware debug tools?

Thanks

qianfan



