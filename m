Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3B3307236
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhA1JBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231351AbhA1JBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:01:32 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BF1664DD6;
        Thu, 28 Jan 2021 09:02:16 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l53Bu-00AZWy-Bo; Thu, 28 Jan 2021 09:02:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 28 Jan 2021 09:02:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
Cc:     mark.rutland@arm.com, Leo Li <leoyang.li@nxp.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Jiafei Pan <jiafei.pan@nxp.com>,
        linux-arm-kernel@lists.infradead.org, Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [v2] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE to remove
 call trace
In-Reply-To: <DB6PR0401MB2438851F8196DA9C6EF8C3D48FBA9@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20210127085818.23742-1-biwen.li@oss.nxp.com>
 <a0c0cdaee31d49848525332deec6eb75@kernel.org>
 <DB6PR0401MB2438851F8196DA9C6EF8C3D48FBA9@DB6PR0401MB2438.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <6e20a326ebffdb6768a95c15ac743759@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: biwen.li@oss.nxp.com, mark.rutland@arm.com, leoyang.li@nxp.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, jiafei.pan@nxp.com, linux-arm-kernel@lists.infradead.org, ran.wang_1@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28 02:37, Biwen Li (OSS) wrote:
>> -----Original Message-----
>> From: Marc Zyngier <maz@kernel.org>
>> Sent: 2021年1月27日 19:38
>> To: Biwen Li (OSS) <biwen.li@oss.nxp.com>
>> Cc: mark.rutland@arm.com; Leo Li <leoyang.li@nxp.com>; 
>> tglx@linutronix.de;
>> jason@lakedaemon.net; linux-kernel@vger.kernel.org; Jiafei Pan
>> <jiafei.pan@nxp.com>; linux-arm-kernel@lists.infradead.org; Ran Wang
>> <ran.wang_1@nxp.com>; Biwen Li <biwen.li@nxp.com>
>> Subject: Re: [v2] irqchip: ls-extirq: add flag IRQCHIP_SKIP_SET_WAKE 
>> to
>> remove call trace
>> 
>> On 2021-01-27 08:58, Biwen Li wrote:
>> > From: Biwen Li <biwen.li@nxp.com>
>> >
>> > Add flag IRQCHIP_SKIP_SET_WAKE to remove call trace as follow, ...
>> > [   45.605239] Unbalanced IRQ 120 wake disable
>> > [   45.609445] WARNING: CPU: 0 PID: 1124 at kernel/irq/manage.c:800
>> > irq_set_irq_wake+0x154/0x1a0
>> > ...
>> > [   45.645141] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
>> > [   45.651144] pc : irq_set_irq_wake+0x154/0x1a0
>> > [   45.655497] lr : irq_set_irq_wake+0x154/0x1a0
>> > ...
>> > [   45.742825] Call trace:
>> > [   45.745268]  irq_set_irq_wake+0x154/0x1a0
>> > [   45.749278]  ds3232_resume+0x38/0x50
>> >
>> > On ls2088ardb:
>> > In suspend progress(# echo mem > /sys/power/state),
>> >
>> pm_suspend()->suspend_devices_and_enter()->dpm_suspend()->device_suspe
>> > nd()
>> > ->ds3232_suspend()->enable_irq_wake()->irq_set_irq_wake()
>> > ->set_irq_wake_real(), return -ENXIO, there get
>> > "Cannot set wakeup source" in ds3232_suspend().
>> >
>> > In resume progress(wakeup by flextimer)
>> > dpm_resume_end()->dpm_resume()
>> > ->device_resume()->ds3232_resume()
>> > ->disable_irq_wake()->irq_set_irq_wake()
>> > ->set_irq_wake_real(), there get
>> > kernel call trace(Unbalanced IRQ 120 wake
>> > disable)
>> 
>> This is again paraphrasing the stack trace instead of explaining the 
>> problem it
>> fixes. How about:
>> 
>> "The ls-extirq driver doesn't implement the irq_set_wake()
>>   callback, while being wake-up capable. This results in
>>   ugly behaviours across suspend/resume cycles.
>> 
>>   Advertise this by adding IRQCHIP_SKIP_SET_WAKE to the irqchip
>>   flags"
>> 
>> The subject line should be fixed along the same lines, and a Fixes: 
>> tag added.
> Okay, got it. Thanks. Will update in v3.

... and v3 still doesn't have a Fixes: tag.

Frankly, if you can't be bothered to do this, why should I worry
about your platform being broken?

         M.
-- 
Jazz is not dead. It just smells funny...
