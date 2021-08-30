Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51E53FBAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhH3R1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:27:17 -0400
Received: from lb1.peda.net ([130.234.6.152]:35069 "EHLO lb1.peda.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229709AbhH3R1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:27:15 -0400
Received: from [84.251.221.37] (dsl-jklbng12-54fbdd-37.dhcp.inet.fi [84.251.221.37])
        by lb1.peda.net (Postfix) with ESMTPSA id 08CFF60001C;
        Mon, 30 Aug 2021 20:26:20 +0300 (EEST)
Subject: Re: Why is Shmem included in Cached in /proc/meminfo?
To:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <5a42eb2b-fd7b-6296-f5d6-619661ad1418@peda.net>
 <0d11f620-0562-e150-259d-85de8d10cd7a@infradead.org>
 <YSzuLbHr7fHshafX@casper.infradead.org>
 <14465cfe-281a-0f67-dc17-ead34ec48365@suse.cz>
 <YS0Eq+tNe4Pr7O0X@casper.infradead.org>
From:   Mikko Rantalainen <mikko.rantalainen@peda.net>
Message-ID: <0cdd0624-fcc3-386e-c651-7173dc3cbb59@peda.net>
Date:   Mon, 30 Aug 2021 20:26:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YS0Eq+tNe4Pr7O0X@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox (2021-08-30 19:17 Europe/Helsinki):
> On Mon, Aug 30, 2021 at 06:05:58PM +0200, Vlastimil Babka wrote:
>> On 8/30/21 16:41, Matthew Wilcox wrote:
>>> Another point of view is that everything in tmpfs is part of the page
>>> cache and can be written out to swap, so keeping it as part of Cached
>>> is not misleading.
>>
>> Yeah, but with that view, anonymous memory can be also written out to swap. But
>> it's non-intuitive that something called "Cached" will contain something that
>> (if not dirty) can't be just dropped.
> 
> That's equally true for normal filesystems & shmem though.  Consider shmem
> written to swap, then brought back in by a read.  Now it can be dropped
> without being swapped out.  Or even a file on shmem ftruncated to a
> large size, then only read.  The pages will be clean and full of zeroes.
> They can be dropped under memory pressure without being written out.
> 
>> I've had to point this Shmem oddity out a
>> number of times to someone, so I would say that it would be much better if it
>> was not part of Cached.
>> However, if we change it now, we might create even larger confusion. People
>> looking at the output for the first time (and IIRC also the 'free' command uses
>> it) on a new kernel wouldn't be misled anymore. But people working with both old
>> and new kernels will now have to take in account that it changed at some
>> point... not good.
> 
> Another good point.

I agree that backwards compatibility is a huge point to consider.

That said, I always assumed that Shmem was in *addition* to Cached and I
was happy to see lots of Cached on all my systems. However, when I
started to run into OOM situations with 10+ GB of Cached I guessed that
something was not working correctly with memory reclaim - it turned out
that the problem was that over 95% of my "Cached" was actually Shmem.

Do you know any existing software where it's important to have the
behavior of Cached and Shmem that the current kernel has?

Without backwards compatibility issues I'd prefer following fields:

- Dirty: total amount of RAM used to buffer data to be written on
permanent storage (dirty). Gets converted to Cached when write is
complete. (Actually I would call this "Buffers" but Dirty is okay, too.)
- Cached: total amount of RAM used to improve *performance* that can be
*immediately dropped* without any data-loss – note that this includes
all untouched RAM backed by swap.
- Shared: total amount of RAM shared between multiple process that
cannot be freed even if any single process gets killed. (If this is even
possible to know - note that this would *only* contain COW pages in
practice. We already have Committed_AS which is about as good for real
world heuristics.)
- RamDrive: total amount of RAM used for tmpfs storage and similar. Note
that this would tend towards zero when tmpfs storage is written to swap.
- Committed_RamDrive: virtual amount of space used for tmpfs (e.g. large
truncated files that, if written, will require to be backed for real).
- Swapped_RamDrive: the amount of swap backing tmpfs and similar.
- LegacyIPCS: all stuff reported by ipcs.

That is, I would declare "Cached" as true cache and split Shmem into
separate parts that are easier to understand. The Shmem currently seems
to be catch-all class for more and more stuff. Obviously the Shmem field
could be kept as precomputed sum of the separate parts for backwards
compatibility. Does Shmem nowadays include other big memory users but
ipcs and tmpfs?

My point is that it's currently too hard to understand (at least) tmpfs
and ipcs load on RAM and swap.

I guess the important thing to decide is if "Cached" should represent
actual cache size or is backwards compatibility more important? My guess
is that the backwards compability would affect statistics and heuristics
only but that's obviously just a guess.

Of course one possible solution is to keep "Cached" as is and introduce
"Cache" with the real cache semantics (that is, it includes sum of
(Cached - Shmem) and memory backed RAM). That way system administrators
would at least see two different fields with unique values and look for
the documentation.

-- 
Mikko
