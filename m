Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C273430762F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhA1MbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:31:22 -0500
Received: from foss.arm.com ([217.140.110.172]:58114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhA1MbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:31:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C6A31B;
        Thu, 28 Jan 2021 04:30:35 -0800 (PST)
Received: from [10.37.12.15] (unknown [10.37.12.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81F103F719;
        Thu, 28 Jan 2021 04:30:33 -0800 (PST)
Subject: Re: KASAN: invalid-access Read in kmem_cache_destroy
To:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, mbenes@suse.cz,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
References: <0000000000008d396205b9e4adee@google.com>
 <CACT4Y+ZisDCO0w9O57tOp+7FL6VqJiFdxaRJ739rjW5z52PeXg@mail.gmail.com>
 <20210127174322.GH4387@sirena.org.uk>
 <CAAeHK+yW_GCbKAdLEdQpFsjfBKy8_nkFKpBydg3icpb5rbA69g@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <bf5e0465-2935-a3a0-f003-de2b837dadf6@arm.com>
Date:   Thu, 28 Jan 2021 12:34:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+yW_GCbKAdLEdQpFsjfBKy8_nkFKpBydg3icpb5rbA69g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/21 7:50 PM, Andrey Konovalov wrote:
> On Wed, Jan 27, 2021 at 6:44 PM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Wed, Jan 27, 2021 at 06:14:13PM +0100, Dmitry Vyukov wrote:
>>> On Wed, Jan 27, 2021 at 5:58 PM syzbot
>>> <syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12eb4ad8d00000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=2a52b6c31dbefb1e9d9f
>>>> userspace arch: arm64
>>>>
>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+2a52b6c31dbefb1e9d9f@syzkaller.appspotmail.com
>>>
>>> This happens on arm64 instance with MTE enabled.
>>> I don't see any corresponding reports on x86_64. So I would assume
>>> it's a generic latent bug, or probably more likely a bug in MTE
>>> support.
>>
>> Copying in Vincenso who's done a bunch of MTE stuff recently.
> 
> Could be the same issue as:
> 
> https://lkml.org/lkml/2021/1/27/1109
> 

I had a look at the trace and I agree with Andrey it seems the same issue.

-- 
Regards,
Vincenzo
