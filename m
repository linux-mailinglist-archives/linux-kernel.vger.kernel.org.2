Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5F35BACA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhDLHZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:25:35 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:54282 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhDLHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:25:31 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 64D7720CF94C
Received: from LanCloud
Received: from LanCloud
Subject: Re: Mutual debugging of 2 processes can stuck in unkillable stopped
 state
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     <linux-trace-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <f2f32ffa-52ad-ff67-19d8-95305a70a6f8@omprussia.ru>
 <20210329164900.GB24849@redhat.com>
 <4124a89e-a62e-0c51-1f46-8409867a626a@omprussia.ru>
 <20210329173848.GC24849@redhat.com>
 <c0131d23-fb09-7622-d51d-30e094d92136@omprussia.ru>
Message-ID: <f7c84257-70a3-e482-0d3a-8ea95cbc8b62@omprussia.ru>
Date:   Mon, 12 Apr 2021 10:25:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c0131d23-fb09-7622-d51d-30e094d92136@omprussia.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To LFEX15.lancloud.ru
 (fd00:f066::45)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

So what is the cause of this problem?

Thank you.

On 29.03.2021 20:44, Igor Zhbanov wrote:
> 
> Here is the processes stack before sending any signals to them:
> 
> izh@suse2:~> sudo cat /proc/1751/stack
> [<0>] ptrace_stop+0x14e/0x260
> [<0>] ptrace_do_notify+0x91/0xb0
> [<0>] ptrace_notify+0x4e/0x70
> [<0>] syscall_slow_exit_work+0x90/0x150
> [<0>] do_syscall_64+0x129/0x1f0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> izh@suse2:~> sudo cat /proc/1979/stack
> [<0>] ptrace_stop+0x14e/0x260
> [<0>] get_signal+0x4d5/0x840
> [<0>] do_signal+0x30/0x6a0
> [<0>] exit_to_usermode_loop+0x8b/0x120
> [<0>] do_syscall_64+0x1c3/0x1f0
> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>> Igor, thanks for your report, but (I think) this has nothing to do
>> with mutual debugging. I'll return to this problem in a couple of
>> days, I'm a bit busy right now.
