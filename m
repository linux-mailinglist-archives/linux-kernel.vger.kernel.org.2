Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD7421B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJEAx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhJEAx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:53:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69FD460F6E;
        Tue,  5 Oct 2021 00:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633395097;
        bh=QrIIJoWY9BAxpyYAsUv/GufuYaX5OfLNAqqeNZ+sLvk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=MJPOv6ix/VXW9+JiizAh45MfVBPCnP/1mmFsEjUAUchkzXmLzaSK+vuYUQ/8oa7Ht
         81VR4xIpPHWIvu6aqLiBCUpzR5oMXF9wEWs9jOeKys3vzu2hcR1l+W83OFyH9mVb5c
         WnETJNJrAVv8Q9GCxFvFFPdjPlwlRq2Yp9M2N9T+1rzJ9yr6CatRA2LRgQ7zqT2bog
         TnAZfeWA/ZRwCv1vtNTmtO8B/88Z8gE+jbvAkuDv45aOn7c8PGxzT0sjEuQB3Bsncu
         iAQ2x8UPQdWwfDDVFIx3bdc6Il+1QX5gF+GcmQ2IOX1qODiv+ZoV/7D47soH6/bjFm
         tiUYcoREok+QQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 85E0527C0054;
        Mon,  4 Oct 2021 20:51:35 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Mon, 04 Oct 2021 20:51:35 -0400
X-ME-Sender: <xms:lqFbYdUZJP5aM7S3JnlNrMpZRDqb0i6W7CMp03Bnt3ogNnAReKt6vw>
    <xme:lqFbYdl55nJ7AcHviR594Ky0QK5kPPhDuxgjbtu6cILhfDLVfFdTjvN0djljrTB63
    VgNAb4nqUcFiALZuZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudelfedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpefhlefhudegtedvhfefueevvedtgeeukefhffehtefftdelvedthedt
    iedvueevudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuth
    hopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:lqFbYZYvB3d77TOIFv5qovc9oPPDjA6eAhrIq_-DAJ6QVM-_bfe6SQ>
    <xmx:lqFbYQVz-1nASxMII31HM5J5Q6Z_KN8DlgQQbmlkwF_BYgB75VL58g>
    <xmx:lqFbYXk7RtTUm71zU9202cmOSMC6iGwmJTfdORZoFodL1a-wYTeIQA>
    <xmx:l6FbYSuFRMHdBZtcJSrjb9rZuw0xdiie8penbZx3YhZ54bQWcVKAyg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E86C521E0063; Mon,  4 Oct 2021 20:51:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1322-g921842b88a-fm-20210929.001-g921842b8
Mime-Version: 1.0
Message-Id: <b255e8ec-911e-4ddd-8e0f-1ff0f7938469@www.fastmail.com>
In-Reply-To: <930f0c5e-0fd4-aae7-334f-ec9cc42998a4@bytedance.com>
References: <20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com>
 <20210922001537.4ktg3r2ky3b3r6yp@treble>
 <930f0c5e-0fd4-aae7-334f-ec9cc42998a4@bytedance.com>
Date:   Mon, 04 Oct 2021 17:51:14 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Qi Zheng" <zhengqi.arch@bytedance.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Vito Caputo" <vcaputo@pengaru.com>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Jann Horn" <jannh@google.com>, "Kees Cook" <keescook@chromium.org>
Subject: Re: CONFIG_ORC_UNWINDER=y breaks get_wchan()?
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021, at 8:30 PM, Qi Zheng wrote:
> On 9/22/21 8:15 AM, Josh Poimboeuf wrote:
>> On Tue, Sep 21, 2021 at 12:32:49PM -0700, Vito Caputo wrote:
>>> Is this an oversight of the ORC_UNWINDER implementation?  It's
>>> arguably a regression to completely break wchans for tools like `ps -o
>>> wchan` and `top`, or my window manager and its separate monitoring
>>> utility.  Presumably there are other tools out there sampling wchans
>>> for monitoring as well, there's also an internal use of get_chan() in
>>> kernel/sched/fair.c for sleep profiling.
>>>
>>> I've occasionally seen when monitoring at a high sample rate (60hz) on
>>> something churny like a parallel kernel or systemd build, there's a
>>> spurious non-zero sample coming out of /proc/[pid]/wchan containing a
>>> hexadecimal address like 0xffffa9ebc181bcf8.  This all smells broken,
>>> is get_wchan() occasionally spitting out random junk here kallsyms
>>> can't resolve, because get_chan() is completely ignorant of
>>> ORC_UNWINDER's effects?
>> 
>> Hi Vito,
>> 
>> Thanks for reporting this.  Does this patch fix your issue?
>> 
>>    https://lkml.kernel.org/r/20210831083625.59554-1-zhengqi.arch@bytedance.com
>> 
>> Though, considering wchan has been silently broken for four years, I do
>> wonder what the impact would be if we were to just continue to show "0"
>> (and change frame pointers to do the same).
>
> Agree, Or remove get_wchan() directly.

I agree.  wchan is a hack that may or may not do anything useful.  We certainly should not be reporting things derived from the stack trace to unprivileged tasks.  And it's probably just as racy as /proc/.../stack.
