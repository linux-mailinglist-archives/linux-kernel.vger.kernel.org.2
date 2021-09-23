Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED241636A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbhIWQhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhIWQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:37:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C57C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:36:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t18so19021976wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oRu9ewgFc/39PpVB/GnblVw4+11L82/zU/npG8Ru7+s=;
        b=coG3/AOBNehwTqYXFpr8aL0QNDJ9gGLSLkkP/bOGsthl3rXTCb/+G5CraQ2/T8oisD
         l96spFmY2gnyN9MZp8sxWZWcXCSwJkyYBw0+lqzrvtFEYqNe/tepfi9/Htr2uESXY7Vb
         P/8injtF4uDeGKnDTkUZ1S6XV1XEUPhvQ8aymQ+FqT9htzI03lwB537Aq8C6B4feOfI6
         rJESv5+rAoRiRT22LiiVZiBOj94AjPJr106wJwlM4Cl31S8dAX/E9VrRqZu9y4au4wTC
         EFisSdgE5yJxq+tTBRQUSPo6yvv+XUkv9HUiq+zVu8iv08efy3vM0SOd+8yE5wArdjtU
         LhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oRu9ewgFc/39PpVB/GnblVw4+11L82/zU/npG8Ru7+s=;
        b=CwF1vpgffgwmt6H1eGS/Y+JbQ3ME/mvukVrMPrOIE79Z63I7lsFx5MZpQam2qKuhhe
         Bwn07hxn0z7Ibp34YnYuoN0DEbLVkWH3u0caHHe6koN1HcapKmgBaMS6IY7Ow/INA4LM
         s1WjGA7/zzvXvrKD0H4oFVnG2EZ+UgMudPOw4QSNvWY2GKDiHOjwbn1RBABRJtSagzsF
         w6sd+QZh3rcyngOucf8E8ZEu6a/mQAng1u9Ai8VHa0zJ7Xh+6FRLE/9WrSJThDA5J19O
         JlOYrFxY5WMDkCqP3GPYCCBk66G0lXNgrhmIhm1YEm2L/wtVZTkfacxAunORykR7f8XP
         Ecgg==
X-Gm-Message-State: AOAM533GlQ4tz+jRkR9tykN1YW5F6WKiQ9EvQwr3cfz46IOLDnv3L7MT
        QRMC3APQkOlsQKIYEO849d0hnQ==
X-Google-Smtp-Source: ABdhPJyBMTLykyvPspvag2doCS8kiOD7c2VecbcAQ3BYWz4KCNhiQJW270kq/DPyTOAw3SxLXEzW8g==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr17212585wmp.165.1632414978851;
        Thu, 23 Sep 2021 09:36:18 -0700 (PDT)
Received: from localhost.localdomain (p200300d997223e009514b44ef79a69c4.dip0.t-ipconnect.de. [2003:d9:9722:3e00:9514:b44e:f79a:69c4])
        by smtp.googlemail.com with ESMTPSA id k19sm5620352wmr.21.2021.09.23.09.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:36:18 -0700 (PDT)
Subject: Re: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace
 was changed
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milton Miller <miltonm@bga.com>,
        Jack Miller <millerjo@us.ibm.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian@brauner.io>
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
 <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
 <CAJqdLrpx+xEMGQLZo7jS5BTAw-k2sWPrv9fCt0x8t=6Nbn7u+w@mail.gmail.com>
 <CALgW_8VUk0us_umLncUv2DUMkOi3qixmT+YkHV4Dhpt_nNMZHw@mail.gmail.com>
 <CAJqdLrofd76x_hziq7F3wY3jqZfE1LNZbQ8sD6MUFXbPHVcdVw@mail.gmail.com>
 <CALgW_8WHq051ifcYPta5reoVZ10=fA5Rb1EZuyaievK+OUw99Q@mail.gmail.com>
 <CAJqdLrpxnMThqersqiVsTNr1Y25V8jmDcW_sKWi0ziJXCsi2gw@mail.gmail.com>
 <87y2ab9w8u.fsf@disp2133>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <00ce7bff-e432-8244-1765-12460817baab@colorfullife.com>
Date:   Thu, 23 Sep 2021 18:36:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87y2ab9w8u.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I'd like to restart the discussion, the issue should be fixed.

On 7/12/21 9:18 PM, Eric W. Biederman wrote:
>
> Given that this is a bug I think c) is the safest option.
>
> A couple of suggestions.
> 1) We can replace the test "shm_creator != NULL" with
>     "list_empty(&shp->shm_clist)"

Yes, good idea. list_del() already contains WRITE_ONCE() and 
list_empty() contains READ_ONCE(), i.e. we get clear memory ordering rules.


>   and remove shm_creator.

I do not see how we can remove shm_creator:

- thread A: creates new segment, doesn't map it.

- thread B: shmctl(,IPC_RMID,).

thread B must now locate the lock that protects ->shm_clist. And if the 
lock is per-thread, then I do not see how we can avoid having a pointer 
in shp to the lock.


>     Along with replacing "shm_creator = NULL" with
>     "list_del_init(&shp->shm_clist)".
Correct, list_del_init() is better than shm_create = NULL.
> 2) We can update shmat to do "list_del_init(&shp->shm_clist)"
>     upon shmat.

That would be a (tiny) user space visible change:

echo 0 > /proc/sys/kernel/shm_rmid_forced
shmget()
shmat()
shmdt()
echo 1 > /proc/sys/kernel/shm_rmid_forced
exit()

Right now: segment is destroyed

After your proposal: Segment is not destroyed.

I don't think that we should mix that with the bugfix.


>    The last unmap will still shm_destroy the
>     shm segment as ns->shm_rmid_forced is set.
But what if shm_rmid_forced is modified?
>     For a multi-threaded process I think this will nicely clean up
>     the clist, and make it clear that the clist only cares about
>     those segments that have been created but never attached.

> 3) Put a non-reference counted struct ipc_namespace in struct
>     shmid_kernel, and use it to remove the namespace parameter
>     from shm_destroy.
>
> I think that is enough to fix this bug with no changes in semantics,
> no additional memory consumed, and an implementation that is easier
> to read and perhaps a little faster.

I do not see how this solves the list corruption:

A thread creates 2 shm segments, then switches the namespace and creates 
another 2 segment.

- corruption 1: in each of the namespaces, one thread calls 
shmctl(,IPC_RMID,) -> both will operate in parallel on ->shm_clist.

- corruption 2: exit_shm() in parallel to one thread

- corruption 3: one shmctl(,IPC_RMID,) in parallel to a shmget().

i.e.: we can have list_add() and multiple list_del() in parallel.

I don't see how this should work without a lock.

With regards to memory usage: I would propose to use task_lock(), that 
lock exists already.


--

     Manfred

