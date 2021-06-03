Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86F39A950
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFCRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:38:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33924 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhFCRid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:38:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622741809; h=In-Reply-To: Content-Transfer-Encoding:
 Content-Type: MIME-Version: References: Message-ID: Subject: Cc: To:
 From: Date: Sender; bh=XtQuwLBy84TOV83GbyO9x2e6mJXGe6zvbbbdlhvAkw0=; b=HRpOTkwX6eK2iE0iWeoO0tKqOXOFdUD0OwrqAbuhmYwxPmLshVts7S8L+yBabx0ivQBLiy55
 2yiTBV2WeqzwHy398mRueoRKKsXOsAQbuhVTSJYkKJBAWlJYkCZNo0DMSaQ4D20Ctx4Xl2jW
 R3ft8E4B7pNQegGhrZ5xTQFBQwA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60b913286ddc3305c4e7780c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 17:36:40
 GMT
Sender: jackp=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51FD3C433D3; Thu,  3 Jun 2021 17:36:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2396FC4338A;
        Thu,  3 Jun 2021 17:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2396FC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jackp@codeaurora.org
Date:   Thu, 3 Jun 2021 10:36:32 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        p.zabel@pengutronix.de, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        sanm@codeaurora.org
Subject: Re: [BUG] usb: dwc3: Kernel NULL pointer dereference in dwc3_remove()
Message-ID: <20210603173632.GA25299@jackp-linux.qualcomm.com>
References: <c3c75895-313a-5be7-6421-b32bac741a88@arm.com>
 <87r1hjcvf6.fsf@kernel.org>
 <70be179c-d36b-de6f-6efc-2888055b1312@arm.com>
 <YLi/u9J5f+nQO4Cm@kroah.com>
 <8272121c-ac8a-1565-a047-e3a16dcf13b0@arm.com>
 <877djbc8xq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877djbc8xq.fsf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 05:35:45PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Alexandru Elisei <alexandru.elisei@arm.com> writes:
> > On 6/3/21 12:40 PM, Greg Kroah-Hartman wrote:
> >> On Thu, Jun 03, 2021 at 11:41:45AM +0100, Alexandru Elisei wrote:
> >>> Hello Felipe,
> >>>
> >>> Thank you for having a look!
> >>>
> >>> On 6/3/21 7:30 AM, Felipe Balbi wrote:
> >>>> Hi,
> >>>>
> >>>> Alexandru Elisei <alexandru.elisei@arm.com> writes:
> >>>>> I've been seeing the following panic when shutting down my rockpro64:
> >>>>>
> >>>>> [�� 21.459064] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregistered
> >>>>> [�� 21.683077] Unable to handle kernel NULL pointer dereference at virtual address
> >>>>> 00000000000000a0
> >>>>> [�� 21.683858] Mem abort info:
> >>>>> [�� 21.684104]�� ESR = 0x96000004
> >>>>> [�� 21.684375]�� EC = 0x25: DABT (current EL), IL = 32 bits
> >>>>> [�� 21.684841]�� SET = 0, FnV = 0
> >>>>> [�� 21.685111]�� EA = 0, S1PTW = 0
> >>>>> [�� 21.685389] Data abort info:
> >>>>> [�� 21.685644]�� ISV = 0, ISS = 0x00000004
> >>>>> [�� 21.686024]�� CM = 0, WnR = 0
> >>>>> [�� 21.686288] user pgtable: 4k pages, 48-bit VAs, pgdp=000000000757a000
> >>>>> [�� 21.686853] [00000000000000a0] pgd=0000000000000000, p4d=0000000000000000
> >>>>> [�� 21.687452] Internal error: Oops: 96000004EEMPT SMP
> >>>>> [�� 21.687941] Modules linked in:
> >>>>> [�� 21.688214] CPU: 4 PID: 1 Comm: shutdown Not tainted
> >>>>> 5.12.0-rc7-00262-g568262bf5492 #33
> >>>>> [�� 21.688915] Hardware name: Pine64 RockPro64 v2.0 (DT)
> >>>>> [�� 21.689357] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> >>>>> [�� 21.689884] pc : down_read_interruptible+0xec/0x200
> >>>>> [�� 21.690321] lr : simple_recursive_removal+0x48/0x280
> >>>>> [�� 21.690761] sp : ffff800011f4b940
> >>>>> [�� 21.691053] x29: ffff800011f4b940 x28: ffff000000809b40
> >>>>> [�� 21.691522] x27: ffff000000809b98 x26: ffff8000114f5170
> >>>>> [�� 21.691990] x25: 00000000000000a0 x24: ffff800011e84030
> >>>>> [�� 21.692459] x23: 0000000000000080 x22: 0000000000000000
> >>>>> [�� 21.692927] x21: ffff800011ecaa5c x20: ffff800011ecaa60
> >>>>> [�� 21.693395] x19: ffff000000809b40 x18: ffffffffffffffff
> >>>>> [�� 21.693863] x17: 0000000000000000 x16: 0000000000000000
> >>>>> [�� 21.694331] x15: ffff800091f4ba6d x14: 0000000000000004
> >>>>> [�� 21.694799] x13: 0000000000000000 x12: 0000000000000020
> >>>>> [�� 21.695267] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> >>>>> [�� 21.695735] x9 : 6f6c746364716e62 x8 : 7f7f7f7f7f7f7f7f
> >>>>> [�� 21.696203] x7 : fefefeff6364626d x6 : 0000000000001bd8
> >>>>> [�� 21.696671] x5 : 0000000000000000 x4 : 0000000000000000
> >>>>> [�� 21.697138] x3 : 00000000000000a0 x2 : 0000000000000001
> >>>>> [�� 21.697606] x1 : 0000000000000000 x0 : 00000000000000a0
> >>>>> [�� 21.698075] Call trace:
> >>>>> [�� 21.698291]� down_read_interruptible+0xec/0x200
> >>>>> [�� 21.698690]� debugfs_remove+0x60/0x84
> >>>>> [�� 21.699016]� dwc3_debugfs_exit+0x1c/0x6c
> >>>>> [�� 21.699363]� dwc3_remove+0x34/0x1a0
> >>>>> [�� 21.699672]� platform_remove+0x28/0x60
> >>>>> [�� 21.700005]� __device_release_driver+0x188/0x230
> >>>>> [�� 21.700414]� device_release_driver+0x2c/0x44
> >>>>> [�� 21.700791]� bus_remove_device+0x124/0x130
> >>>>> [�� 21.701154]� device_del+0x168/0x420
> >>>>> [�� 21.701462]� platform_device_del.part.0+0x1c/0x90
> >>>>> [�� 21.701877]� platform_device_unregister+0x28/0x44
> >>>>> [�� 21.702291]� of_platform_device_destroy+0xe8/0x100
> >>>>> [�� 21.702716]� device_for_each_child_reverse+0x64/0xb4
> >>>>> [�� 21.703153]� of_platform_depopulate+0x40/0x84
> >>>>> [�� 21.703538]� __dwc3_of_simple_teardown+0x20/0xd4
> >>>>> [�� 21.703945]� dwc3_of_simple_shutdown+0x14/0x20
> >>>>> [�� 21.704337]� platform_shutdown+0x28/0x40
> >>>>> [�� 21.704683]� device_shutdown+0x158/0x330
> >>>>> [�� 21.705029]� kernel_power_off+0x38/0x7c
> >>>>> [�� 21.705372]� __do_sys_reboot+0x16c/0x2a0
> >>>>> [�� 21.705719]� __arm64_sys_reboot+0x28/0x34
> >>>>> [�� 21.706074]� el0_svc_common.constprop.0+0x60/0x120
> >>>>> [�� 21.706499]� do_el0_svc+0x28/0x94
> >>>>> [�� 21.706794]� el0_svc+0x2c/0x54
> >>>>> [�� 21.707067]� el0_sync_handler+0xa4/0x130
> >>>>> [�� 21.707414]� el0_sync+0x170/0x180
> >>>>> [�� 21.707711] Code: c8047c62 35ffff84 17fffe5f f9800071 (c85ffc60)
> >>>>> [�� 21.708250] ---[ end trace 5ae08147542eb468 ]---
> >>>>> [�� 21.708667] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> >>>>> [�� 21.709456] Kernel Offset: disabled
> >>>>> [�� 21.709762] CPU features: 0x00240022,2100600c
> >>>>> [�� 21.710146] Memory Limit: 2048 MB
> >>>>> [�� 21.710443] ---[ end Kernel panic - not syncing: Attempted to kill init!
> >>>>> exitcode=0x0000000b ]---
> >>>>>
> >>>>> I've been able to bisect the panic and the offending commit is 568262bf5492 ("usb:
> >>>>> dwc3: core: Add shutdown callback for dwc3"). I can provide more diagnostic
> >>>>> information if needed and I can help test the fix.
> >>>> if you simply revert that commit in HEAD, does the problem really go
> >>>> away?
> >>> Kernel built from commit 324c92e5e0ee, which is the kernel tip today, the panic is
> >>> there. Reverting the offending commit, 568262bf5492, makes the panic disappear.
> >> Want to send a revert so I can take it now?
> >
> > I can send a revert, but Felipe was asking Sandeep (the commit author) for a fix,
> > so I'll leave it up to Felipe to decide how to proceed.
> 
> I'm okay with a revert. Feel free to add my Acked-by: Felipe Balbi
> <balbi@kernel.org> or it.
> 
> Sandeep, please send a new version that doesn't encounter the same
> issue. Make sure to test by reloading the driver in a tight loop for
> several iterations.

This would probably be tricky to test on other "glue" drivers as the
problem appears to be specific only to dwc3_of_simple.  It looks like
both dwc3_of_simple and the dwc3 core now (due to 568262bf5492) each
implement respective .shutdown callbacks. The latter is simply a wrapper
around dwc3_remove(). And from the panic call stack above we see that
dwc3_of_simple_shutdown() calls of_platform_depopulate() which will 
again call dwc3_remove() resulting in the double remove.

So would an alternative approach be to protect against dwc3_remove()
getting called multiple times? IMO it'd be a bit messy to have to add
additional checks there to know if it had already been called. So maybe
avoid it altogether--should dwc3_of_simple_shutdown() just skip calling
of_platform_depopulate()?

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
