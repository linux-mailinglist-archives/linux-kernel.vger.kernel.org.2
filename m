Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC1B308448
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhA2Die (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:38:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11906 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhA2Di3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:38:29 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRjgf3NsYzjDdN;
        Fri, 29 Jan 2021 11:36:46 +0800 (CST)
Received: from [10.174.178.52] (10.174.178.52) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 29 Jan 2021 11:37:40 +0800
Subject: Re: [PATCH] kretprobe: avoid re-registration of the same kretprobe
 earlier
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <cj.chengjian@huawei.com>
References: <20201124115719.11799-1-bobo.shaobowang@huawei.com>
 <20201130161850.34bcfc8a@gandalf.local.home>
 <20201202083253.9dbc76704149261e131345bf@kernel.org>
 <9dff21f8-4ab9-f9b2-64fd-cc8c5f731932@huawei.com>
 <20201215123119.35258dd5006942be247600db@kernel.org>
 <c584f7e2-1d95-4f6a-7e36-4ff2d610bc78@huawei.com>
 <20201222200356.6910b42c165b8756878cc9b0@kernel.org>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <f8679bd1-8f1f-8835-a6c9-52e43f5aca89@huawei.com>
Date:   Fri, 29 Jan 2021 11:37:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20201222200356.6910b42c165b8756878cc9b0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.52]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Masami and Steve,

I have sent v2 but still have confusions:

> OK, I think it is simpler to check the rp->kp.addr && rp->kp.symbol_name
> because it is not allowed (it can lead inconsistent setting).
>
> How about this code? Is this work for you?
>
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 41fdbb7953c6..73500be564be 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2103,6 +2103,14 @@ int register_kretprobe(struct kretprobe *rp)
>          int i;
>          void *addr;
>   
> +       /* It is not allowed to specify addr and symbol_name at the same time */
> +       if (rp->kp.addr && rp->kp.symbol_name)
> +               return -EINVAL;
> +

above sentence can be removed because of kprobe_on_func_entry() do it:

kprobe_on_func_entry()

      -=>_kprobe_addr() {if (rp->kp.addr && rp->kp.symbol_name) ...}

> +       /* If only rp->kp.addr is specified, check reregistering kprobes */
> +       if (rp->kp.addr && check_kprobe_rereg(&rp->kp))
> +               return -EINVAL;

for arch arm64，x86_64, above sentence can be moved behind following 
sentence.

kprobe_on_func_entry()

     -=>arch_kprobe_on_func_entry() {kp->offset can not be 0 ; ...}

So if offset of kprobe if not 0, do not waste time to excute above sentence.


But for Arch ppc64,  I still not figure out better one solution.


Thank you

-- Wang ShaoBo

>          if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
>                  return -EINVAL;
>   
>
> Thank you,
>
