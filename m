Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C593D2478
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhGVMiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 08:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231925AbhGVMiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:38:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13F5161285;
        Thu, 22 Jul 2021 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626959926;
        bh=bcv6IlJoNXeSdpHKVKcs8UYSOQPfqrUyXA/cjo4gCLQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hpa/PlOmQWI4uX70I/rgeb4xwoQsWfZ5+S7/FELSskTu0VDMgrehUQZHQjcQjhK/z
         1YW/Ai5InjBhbpPSszqaDqhKu5srzn/C2zP/T0n1ZRzWKXZSVFXTQzc01+KK4w1U+s
         WtPXuf78f31l3M6nFFgvTBmqSlgh+WC9uxguYKNdx31d2uiJRRyxd/jcCpeO0rLq6j
         7Ua/trlfpu8yS0Eo7OTRZ24J2cuI69i9Y+19GD0IPFSo2JeGSzis2qiODsqshR2dUi
         Lm5KXgRIKwJH8xDl85Qsdz2mDJ71kwGO1DcEUG9EM960/oUjUhJsgTg5VWMXRcrckY
         UjadbOyfJ9TlQ==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix wrong inflight page stats for
 directIO
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210719084548.25895-1-chao@kernel.org>
 <YPi/4kMUAhlRZV3M@sol.localdomain> <YPjNGoFzQojO5Amr@sol.localdomain>
From:   Chao Yu <chao@kernel.org>
Message-ID: <311ab257-2d67-fd73-8359-af5b44e1447c@kernel.org>
Date:   Thu, 22 Jul 2021 21:18:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPjNGoFzQojO5Amr@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/22 9:42, Eric Biggers wrote:
> On Wed, Jul 21, 2021 at 05:46:26PM -0700, Eric Biggers wrote:
>> On Mon, Jul 19, 2021 at 04:45:48PM +0800, Chao Yu wrote:
>>> Previously, we use sbi->nr_pages[] to account direct IO, the count should
>>> be based on page granularity rather than bio granularity, fix it.
>>>
>>> Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
>>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> Also, do we have to do this, as opposed to just moving F2FS_DIO_WRITE and
> F2FS_DIO_READ out of ->nr_pages[] and into separate counters that are clearly
> defined to be per-request?  As Christoph pointed out
> (https://lkml.kernel.org/r/YPU+3inGclUtcSpJ@infradead.org), these counters are
> only used to check whether there is any in-flight direct I/O at all.  (They're
> also shown in /sys/kernel/debug/f2fs/status, but that doesn't really matter.)
> 
> As Christoph mentioned, there is a way to avoid needing f2fs_dio_submit_bio()
> (which would save a memory allocation for every bio, which can fail).  But it
> will only work if the counters remain per-request.
> 
> Can we leave these as per-request?

I updated the patch, could you please check that?

Thanks,

> 
> - Eric
> 
