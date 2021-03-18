Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB0234062F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCRM4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:56:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:49692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhCRM4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:56:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8637AAC1E;
        Thu, 18 Mar 2021 12:56:06 +0000 (UTC)
Subject: Re: [PATCH] mm/slub: Add slub_debug option to panic on memory
 corruption
To:     Kees Cook <keescook@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210309134720.29052-1-georgi.djakov@linaro.org>
 <390d8a2f-ead9-48a9-99eb-65c73bd18422@suse.cz>
 <6bfebf01-5f52-49bd-380b-04785c474c81@linaro.org>
 <8fd43de6-71e4-cfe7-8208-32753cf1c363@suse.cz>
 <202103172244.D5ADB06A96@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ea740a0a-6225-3d6c-095d-1c456e497e3a@suse.cz>
Date:   Thu, 18 Mar 2021 13:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <202103172244.D5ADB06A96@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 6:48 AM, Kees Cook wrote:
> On Tue, Mar 09, 2021 at 07:18:32PM +0100, Vlastimil Babka wrote:
>> On 3/9/21 7:14 PM, Georgi Djakov wrote:
>> > Hi Vlastimil,
>> > 
>> > Thanks for the comment!
>> > 
>> > On 3/9/21 17:09, Vlastimil Babka wrote:
>> >> On 3/9/21 2:47 PM, Georgi Djakov wrote:
>> >>> Being able to stop the system immediately when a memory corruption
>> >>> is detected is crucial to finding the source of it. This is very
>> >>> useful when the memory can be inspected with kdump or other tools.
>> >>
>> >> Is this in some testing scenarios where you would also use e.g. panic_on_warn?
>> >> We could hook to that. If not, we could introduce a new
>> >> panic_on_memory_corruption that would apply also for debug_pagealloc and whatnot?
>> > 
>> > I would prefer that we not tie it with panic_on_warn - there might be lots of
>> > new code in multiple subsystems, so hitting some WARNing while testing is not
>> > something unexpected.
>> > 
>> > Introducing an additional panic_on_memory_corruption would work, but i noticed
>> > that we already have slub_debug and thought to re-use that. But indeed, аdding
>> > an option to panic in for example bad_page() sounds also useful, if that's what
>> > you suggest.
>> 
>> Yes, that would be another example.
>> Also CCing Kees for input, as besides the "kdump ASAP for debugging" case, I can
>> imagine security hardening folks could be interested in the "somebody might have
>> just failed to pwn the kernel, better panic than let them continue" angle. But
>> I'm naive wrt security, so it might be a stupid idea :)
> 
> I've really wanted such things, but Linus has been pretty adamant about
> not wanting to provide new "panic" paths (or even BUG usage[1]). It
> seems that panic_on_warn remains the way to get this behavior,
> with the understanding that WARN should only be produced on
> expected-to-be-impossible situations[1].
> 
> Hitting a WARN while testing should result in either finding and fixing
> a real bug, or removing the WARN in favor of pr_warn(). :)

I was going to suggest adding a panic_on_taint parameter... but turns out it was
already added last year! And various memory corruption detections already use
TAINT_BAD_PAGE, including SLUB.
If anything's missing an add_taint() it can be added, and with the parameter you
should get what you want.

> -Kees
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
> 

