Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46651453787
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhKPQem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:34:42 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:19148 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhKPQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637080305; x=1668616305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8QLCKX7KLdR2qE03Ri6JtRCS+E7WMMOcwsnXytBH+g=;
  b=v86/JoxAIs8rFBvNdq0LZ25CPi1jH3CqG63VklCdg6GfNb9cGntDdckd
   GWJF2ow/TZwF67PG1wUWp8ix2y0pT9s51Zt6+lMRxdN33ECcOjIgdOoTI
   p7jZBvg0yYEdXyYec8oAh+uv+TgwzDU9zZx+MHZGujCTDGnpGgkm+4NAG
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 16 Nov 2021 08:31:45 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 08:31:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 16 Nov 2021 08:31:43 -0800
Received: from qian-HP-Z2-SFF-G5-Workstation (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 16 Nov 2021 08:31:42 -0800
Date:   Tue, 16 Nov 2021 11:31:40 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <dvyukov@google.com>, <peterz@infradead.org>,
        <valentin.schneider@arm.com>, <will@kernel.org>,
        <woodylin@google.com>
Subject: Re: [PATCH] Reset task stack state in bringup_cpu()
Message-ID: <YZPc7MLxwmd47YYw@qian-HP-Z2-SFF-G5-Workstation>
References: <20211115113310.35693-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211115113310.35693-1-mark.rutland@arm.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:33:10AM +0000, Mark Rutland wrote:
> To hot unplug a CPU, the idle task on that CPU calls a few layers of C
> code before finally leaving the kernel. When KASAN is in use, poisoned
> shadow is left around for each of the active stack frames, and when
> shadow call stacks are in use. When shadow call stacks are in use the
> task's SCS SP is left pointing at an arbitrary point within the task's
> shadow call stack.
> 
> When an offlines CPU is hotlpugged back into the kernel, this stale
> state can adversely affect the newly onlined CPU. Stale KASAN shadow can
> alias new stackframes and result in bogus KASAN warnings. A stale SCS SP
> is effectively a memory leak, and prevents a portion of the shadow call
> stack being used. Across a number of hotplug cycles the task's entire
> shadow call stack can become unusable.
> 
> We previously fixed the KASAN issue in commit:
> 
>   e1b77c92981a5222 ("sched/kasan: remove stale KASAN poison after hotplug")
> 
> In commit:
> 
>   f1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")
> 
> ... we broke both KASAN and SCS, with SCS being fixed up in commit:
> 
>   63acd42c0d4942f7 ("sched/scs: Reset the shadow stack when idle_task_exit")
> 
> ... but as this runs in the context of the idle task being offlines it's
> potentially fragile.
> 
> Fix both of these consistently and more robustly by resetting the SCS SP
> and KASAN shadow immediately before we online a CPU. This ensures the
> idle task always has a consistent state, and removes the need to do so
> when initializing an idle task or when unplugging an idle task.
> 
> I've tested this with both GCC and clang, with reelvant options enabled,
> offlining and online CPUs with:
> 
> | while true; do
> |   for C in /sys/devices/system/cpu/cpu*/online; do
> |     echo 0 > $C;
> |     echo 1 > $C;
> |   done
> | done
> 
> Link: https://lore.kernel.org/lkml/20211012083521.973587-1-woodylin@google.com/
> Link: https://lore.kernel.org/linux-arm-kernel/YY9ECKyPtDbD9q8q@qian-HP-Z2-SFF-G5-Workstation/
> Fixes: 1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Thanks for fixing this quickly, Mark. Triggering an user-after-free in
user namespace but don't think it is related. I'll investigate that
first since it is blocking the rest of regression testing.

