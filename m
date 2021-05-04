Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E76372D03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhEDPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:35:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:63269 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhEDPfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:35:09 -0400
IronPort-SDR: c1beQtbq4vXTdqQV4EwhTSx6vCpn53YNaMliRQKMIaf0vsUxfGml1+kMFtsxf3yEgfTqTCWsed
 k4pejmIYg7GA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="177547955"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="177547955"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 08:34:14 -0700
IronPort-SDR: KulzZHe3YtLAXjSxtUelZ9opEwFO35+T05pzWl2uTlqinDA3g9oZjpQ2dAIs4byJZf/Ps938c7
 Y9T5F6dxvtNA==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="463271730"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.47.237]) ([10.209.47.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 08:34:13 -0700
Subject: Re: [PATCH] stackdepot: Use a raw spinlock in stack depot
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <20210504024358.894950-1-ak@linux.intel.com>
 <CACT4Y+a5g5JeLJFPJEUxPFbMLXGkYEAJkK3MBctnn7UA-iTkXA@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <77634a8e-74ab-4e95-530e-c2c46db8baa7@linux.intel.com>
Date:   Tue, 4 May 2021 08:34:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a5g5JeLJFPJEUxPFbMLXGkYEAJkK3MBctnn7UA-iTkXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> So why is this a false positive that we just need to silence?
> I see LOCKDEP is saying we are doing something wrong, and your
> description just describes how we are doing something wrong :)
> If this is a special false positive case, it would be good to have a
> comment on DEFINE_RAW_SPINLOCK explaining why we are using it.
>
> I wonder why we never saw this on syzbot. Is it an RT kernel or some
> other special config?

This happened in a special configuration that triggered ACPI errors at 
boot time.

It's probably not something that is normally executed, as well as syzbot is

probably not exercising bootup anyways.

> A similar issue was discussed recently for RT kernel:
> https://groups.google.com/g/kasan-dev/c/MyHh8ov-ciU/m/nahiuqFLAQAJ
> And I think it may be fixable in the same way -- make stackdepot not
> allocate in contexts where it's not OK to allocate.


Yes that's a good idea. I've seen also other errors about the allocator 
triggered

by stack depot being in the wrong context. Probably doing that would be 
the right

fix. But I actually tried to switch depot to GFP_ATOMIC allocations 
(from GFP_NOWAIT),

but it didn't help, so I'm not fully sure what needs to be changed.

-Andi


