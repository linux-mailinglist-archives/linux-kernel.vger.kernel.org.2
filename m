Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0365399865
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 05:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCDJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 23:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFCDJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 23:09:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 304BF613F2;
        Thu,  3 Jun 2021 03:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622689675;
        bh=NkB4QL7iqQMZQPhSZsQKDdEvp47UO6zsVNxvnyMI1JU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+ulzMVwggK5/7YfsAnW44PvoD9DN2fkHaGKGRcWB7H+rFw/yH5X6Xuw/JKRc3qdz
         EDuqfSLZCqkx4qV+UuynixpK/PB5MjkLMfh5NZykJvhZRoKIY78c3PPc+Sfe6zIDWJ
         Z5WAI9yl7ySgwCyai4xgeastGU4F1BiMBgqsKO8T57wS9lXinXyseN5iHSzn9NaIWY
         Bmi5Ivr7czbNz9FJ/CqQifgluqgSIcIACkmKHJXTXWzAGuuC8EaDHPtU2If/tEaD+w
         gos6Hfh95pW7m2XHRup0m7Haa2cnXD1NQ4Jqa5yOS0nH8TgpkslEQGHTHXbL3dPLGL
         7POuo5VoWn2Bw==
Date:   Thu, 3 Jun 2021 11:07:50 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        p.zabel@pengutronix.de, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        sanm@codeaurora.org
Subject: Re: [BUG] usb: dwc3: Kernel NULL pointer dereference in dwc3_remove()
Message-ID: <20210603030750.GA29274@nchen>
References: <c3c75895-313a-5be7-6421-b32bac741a88@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3c75895-313a-5be7-6421-b32bac741a88@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-01 12:02:34, Alexandru Elisei wrote:
> I've been seeing the following panic when shutting down my rockpro64:
> 
> [   21.459064] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregistered
> [   21.683077] Unable to handle kernel NULL pointer dereference at virtual address
> 00000000000000a0
> [   21.683858] Mem abort info:
> [   21.684104]   ESR = 0x96000004
> [   21.684375]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   21.684841]   SET = 0, FnV = 0
> [   21.685111]   EA = 0, S1PTW = 0
> [   21.685389] Data abort info:
> [   21.685644]   ISV = 0, ISS = 0x00000004
> [   21.686024]   CM = 0, WnR = 0
> [   21.686288] user pgtable: 4k pages, 48-bit VAs, pgdp=000000000757a000
> [   21.686853] [00000000000000a0] pgd=0000000000000000, p4d=0000000000000000
> [   21.687452] Internal error: Oops: 96000004EEMPT SMP
> [   21.687941] Modules linked in:
> [   21.688214] CPU: 4 PID: 1 Comm: shutdown Not tainted
> 5.12.0-rc7-00262-g568262bf5492 #33
> [   21.688915] Hardware name: Pine64 RockPro64 v2.0 (DT)
> [   21.689357] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [   21.689884] pc : down_read_interruptible+0xec/0x200
> [   21.690321] lr : simple_recursive_removal+0x48/0x280
> [   21.690761] sp : ffff800011f4b940
> [   21.691053] x29: ffff800011f4b940 x28: ffff000000809b40
> [   21.691522] x27: ffff000000809b98 x26: ffff8000114f5170
> [   21.691990] x25: 00000000000000a0 x24: ffff800011e84030
> [   21.692459] x23: 0000000000000080 x22: 0000000000000000
> [   21.692927] x21: ffff800011ecaa5c x20: ffff800011ecaa60
> [   21.693395] x19: ffff000000809b40 x18: ffffffffffffffff
> [   21.693863] x17: 0000000000000000 x16: 0000000000000000
> [   21.694331] x15: ffff800091f4ba6d x14: 0000000000000004
> [   21.694799] x13: 0000000000000000 x12: 0000000000000020
> [   21.695267] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> [   21.695735] x9 : 6f6c746364716e62 x8 : 7f7f7f7f7f7f7f7f
> [   21.696203] x7 : fefefeff6364626d x6 : 0000000000001bd8
> [   21.696671] x5 : 0000000000000000 x4 : 0000000000000000
> [   21.697138] x3 : 00000000000000a0 x2 : 0000000000000001
> [   21.697606] x1 : 0000000000000000 x0 : 00000000000000a0
> [   21.698075] Call trace:
> [   21.698291]  down_read_interruptible+0xec/0x200
> [   21.698690]  debugfs_remove+0x60/0x84
> [   21.699016]  dwc3_debugfs_exit+0x1c/0x6c
> [   21.699363]  dwc3_remove+0x34/0x1a0
> [   21.699672]  platform_remove+0x28/0x60
> [   21.700005]  __device_release_driver+0x188/0x230
> [   21.700414]  device_release_driver+0x2c/0x44
> [   21.700791]  bus_remove_device+0x124/0x130
> [   21.701154]  device_del+0x168/0x420
> [   21.701462]  platform_device_del.part.0+0x1c/0x90
> [   21.701877]  platform_device_unregister+0x28/0x44
> [   21.702291]  of_platform_device_destroy+0xe8/0x100
> [   21.702716]  device_for_each_child_reverse+0x64/0xb4
> [   21.703153]  of_platform_depopulate+0x40/0x84
> [   21.703538]  __dwc3_of_simple_teardown+0x20/0xd4
> [   21.703945]  dwc3_of_simple_shutdown+0x14/0x20
> [   21.704337]  platform_shutdown+0x28/0x40
> [   21.704683]  device_shutdown+0x158/0x330
> [   21.705029]  kernel_power_off+0x38/0x7c
> [   21.705372]  __do_sys_reboot+0x16c/0x2a0
> [   21.705719]  __arm64_sys_reboot+0x28/0x34
> [   21.706074]  el0_svc_common.constprop.0+0x60/0x120
> [   21.706499]  do_el0_svc+0x28/0x94
> [   21.706794]  el0_svc+0x2c/0x54
> [   21.707067]  el0_sync_handler+0xa4/0x130
> [   21.707414]  el0_sync+0x170/0x180
> [   21.707711] Code: c8047c62 35ffff84 17fffe5f f9800071 (c85ffc60)
> [   21.708250] ---[ end trace 5ae08147542eb468 ]---
> [   21.708667] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   21.709456] Kernel Offset: disabled
> [   21.709762] CPU features: 0x00240022,2100600c
> [   21.710146] Memory Limit: 2048 MB
> [   21.710443] ---[ end Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b ]---
> 

I find down_read_interruptible is called at sys_perf_event_open, could you find the
relationship between remove debugfs and perf event functions?

-- 

Thanks,
Peter Chen

