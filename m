Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1135494B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhDEXjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:39:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57954 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhDEXja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:39:30 -0400
Received: from [192.168.4.49] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 04D4220B5680;
        Mon,  5 Apr 2021 16:39:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04D4220B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1617665963;
        bh=82cN00KRRn4Fa/MscxIIVRPS6GobdmM+TCdkLZGrmO8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YHhuEOFJ8Pk7EZjAsfVth4k4oCWz1/NAXCB+97898bbmtXxQ92qcU4huXgMt2gtoo
         FcMOR4lv225PxCByG0b+r14QVjyxHfY3i+KaYzFUetGKWWkJAWGegHhyDQAvKnZp08
         rlz+iO/ldpElClFVN1/hvPngyUw6uZ4mSImvxXSM=
Subject: Re: [BUG] Oops in sidtab_context_to_sid
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <3c63e34b-e54f-9b01-bad4-8fde8528a64d@linux.microsoft.com>
 <CAHC9VhTD2iXw7CkxgwnOx1zNN_AqMV+x1Vy8FijdMQE1m4AOJA@mail.gmail.com>
 <CAFqZXNvZCiE=cKhjBqvxOmebDi3vNr0gS563cCMqTTwpcM6JAw@mail.gmail.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <af058f59-ce8a-7648-25e8-f8b8a2dbb0ba@linux.microsoft.com>
Date:   Mon, 5 Apr 2021 16:39:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvZCiE=cKhjBqvxOmebDi3vNr0gS563cCMqTTwpcM6JAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/2021 8:21 AM, Ondrej Mosnacek wrote:
> On Sat, Apr 3, 2021 at 4:33 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Fri, Apr 2, 2021 at 6:35 PM Vijay Balakrishna
>> <vijayb@linux.microsoft.com> wrote:
>>>
>>> Seeing oops in 5.4.83 sidtab_context_to_sid().  I checked with Tyler (copied),  he said it might be
>>>
>>> https://lore.kernel.org/selinux/CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com/
>>>
>>> Ondrej, can you confirm?  Unfortunately, we don't have a on demand repro.
>>
>> I'm guessing this may be the problem that Tyler reported earlier and
>> which appeared to be fixed by the patch below:
>>
>> https://lore.kernel.org/selinux/20210318215303.2578052-3-omosnace@redhat.com
> 
> Nope, if that's really 5.4.83 with no extra backports, then it can't
> be this issue as it has been introduced only in v5.10.
> 
> Looking at the code in 5.4.83, my initial guess is that it could be a
> memory ordering race between
> sidtab_reverse_lookup()/sidtab_rcache_push() and
> sidtab_rcache_search(). I think the sidtab_rcache_push() call at
> security/selinux/ss/security.c:326 should in fact be after the
> smp_store_release() call. Note that the sidtab_rcache_*() functions
> have been replaced in commit 66f8e2f03c02 ("selinux: sidtab reverse
> lookup hash table") with a different mechanism, which AFAICT doesn't
> have the same issue.
> 
> If that's really it, it will likely be *very* hard to reproduce, so
> you may be unable to verify the fix.
> 
Thank you Ondrej.  We may rebase our kernel in a couple of months.
