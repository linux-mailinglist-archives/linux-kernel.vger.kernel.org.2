Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA58332E12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCISSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:18:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:38190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhCISSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:18:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B503FAEC4;
        Tue,  9 Mar 2021 18:18:33 +0000 (UTC)
Subject: Re: [PATCH] mm/slub: Add slub_debug option to panic on memory
 corruption
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20210309134720.29052-1-georgi.djakov@linaro.org>
 <390d8a2f-ead9-48a9-99eb-65c73bd18422@suse.cz>
 <6bfebf01-5f52-49bd-380b-04785c474c81@linaro.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8fd43de6-71e4-cfe7-8208-32753cf1c363@suse.cz>
Date:   Tue, 9 Mar 2021 19:18:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <6bfebf01-5f52-49bd-380b-04785c474c81@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 7:14 PM, Georgi Djakov wrote:
> Hi Vlastimil,
> 
> Thanks for the comment!
> 
> On 3/9/21 17:09, Vlastimil Babka wrote:
>> On 3/9/21 2:47 PM, Georgi Djakov wrote:
>>> Being able to stop the system immediately when a memory corruption
>>> is detected is crucial to finding the source of it. This is very
>>> useful when the memory can be inspected with kdump or other tools.
>>
>> Is this in some testing scenarios where you would also use e.g. panic_on_warn?
>> We could hook to that. If not, we could introduce a new
>> panic_on_memory_corruption that would apply also for debug_pagealloc and whatnot?
> 
> I would prefer that we not tie it with panic_on_warn - there might be lots of
> new code in multiple subsystems, so hitting some WARNing while testing is not
> something unexpected.
> 
> Introducing an additional panic_on_memory_corruption would work, but i noticed
> that we already have slub_debug and thought to re-use that. But indeed, аdding
> an option to panic in for example bad_page() sounds also useful, if that's what
> you suggest.

Yes, that would be another example.
Also CCing Kees for input, as besides the "kdump ASAP for debugging" case, I can
imagine security hardening folks could be interested in the "somebody might have
just failed to pwn the kernel, better panic than let them continue" angle. But
I'm naive wrt security, so it might be a stupid idea :)

Vlastimil


> Thanks,
> Georgi

