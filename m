Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8611A3744B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbhEEQ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:59:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:17204 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236788AbhEEQuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:50:40 -0400
IronPort-SDR: gi1n5t0nY4g1qzPaixI/H3i4gMiaKfLX+O2MPkwpuIDi7XDniZcRgsMqywulBDr4wWgYdVkGhb
 +VaLOOAy0VgQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="259532499"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="259532499"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 09:48:59 -0700
IronPort-SDR: Yi0pqyiLHdZUJPiYaOEO9OzZCRUx5JnU+c6yPbfqsCoxO4w09k7+O5Tndp3LyQFURANRYVzkjF
 ZUTH/AGmpyXA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="433911466"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.54.13]) ([10.209.54.13])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 09:48:59 -0700
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class
 checking
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
References: <20210505033945.1282851-1-ak@linux.intel.com>
 <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
 <875yzxh8j8.fsf@oldenburg.str.redhat.com>
 <20210505143916.GS4032392@tassilo.jf.intel.com>
 <CAKwvOdneTkwm1xmte2SxwR=pcp3vi320kQuQHtVNVbnqLbcP3Q@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <a4d64648-6726-2046-0883-ac7f20c70445@linux.intel.com>
Date:   Wed, 5 May 2021 09:48:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdneTkwm1xmte2SxwR=pcp3vi320kQuQHtVNVbnqLbcP3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/2021 9:41 AM, Nick Desaulniers wrote:
> On Wed, May 5, 2021 at 7:39 AM Andi Kleen <ak@linux.intel.com> wrote:
>>>   Would you please provide a
>>> minimal test case?
>> You can only reproduce it with a LTO build because it needs knowledge
>> between different translation units for this specific case.
>>
>> But gcc will totally do the optimization even without LTO if it can
>> prove the same inside a single TU.
> It would be helpful to isolate a test case that doesn't rely on LTO,
> if possible.

Like I wrote earlier we used to see it all the time in __pa_symbol 
before it used RELOC_HIDE. I bet if you make RELOC_HIDE a nop you'll see 
multiple instances.

But not sure why you want a test case?

-Andi

