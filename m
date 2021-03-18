Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA533FD77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCRC4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:56:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13562 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhCRC4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:56:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F1BSL6lTqzNpPV;
        Thu, 18 Mar 2021 10:54:10 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Mar 2021 10:56:26 +0800
Subject: Re: [PATCH v2] smp: kernel/panic.c - silence warnings
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <frederic@kernel.org>, <paulmck@kernel.org>, <clg@kaod.org>,
        <qais.yousef@arm.com>, <johnny.chenyi@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20210316084150.75201-1-heying24@huawei.com>
 <20210317094908.GB1724119@gmail.com>
 <9691919b-d014-7433-3345-812c9b19a677@csgroup.eu>
 <YFH0sDpUIUmdpNkQ@hirez.programming.kicks-ass.net>
 <fa3f9880-eb05-f18e-ae7f-4735209f4c94@csgroup.eu>
 <YFI+YMo7zml+spKc@hirez.programming.kicks-ass.net>
 <20210317200922.GC3830960@gmail.com>
From:   "heying (H)" <heying24@huawei.com>
Message-ID: <d94077e7-8599-a3c1-af76-65e588ea8d33@huawei.com>
Date:   Thu, 18 Mar 2021 10:56:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210317200922.GC3830960@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/3/18 4:09, Ingo Molnar Ð´µÀ:
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
>> Now, the C people figured that distinction was useless and allowed
>> sloppiness. But I still think there's merrit to that. And as
>> mentioned earlier, it is consistent with variable declarations.
> Fully agreed, and my other point was that it's also consistent with
> the other existing externs were used *in the same header file*
> already.
>
> I.e. there's nothing more sloppy than mixing different styles within
> the same header. Checkpatch needs to be fixed or ignored here.

Thank you all for the reply!

There are already mixing different styles within linux/smp.h. I mean 
'extern' and

non 'extern' func declarations both exist in this header. Since two of 
you three

think that 'extern' is needed, I'll add it and resend my patch.


Thanks again.


