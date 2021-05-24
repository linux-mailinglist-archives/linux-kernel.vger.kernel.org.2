Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DAC38E7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhEXNnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232842AbhEXNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621863744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdCvQOrGWjsKZxZwOOVoEv2iDDtEdHzVz0K+vqaSd8c=;
        b=OznwIRICTH24zzW5gMa9gEsoTDyle4BU3ee+JgUiJIVKpl3pM09ZZ1uHJu02reUAlnptTI
        RhST/fPWO6X6PD4Kmxkaa6SWDmK7it39OPE8Aj6advPoDxpltxSciAtuf1cmHcYpDss7e8
        2BWgPXtxgu0zFrCiDkdBJXS+kIf/WHA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-NDW0gLubP4S_Mw1LOlBMFQ-1; Mon, 24 May 2021 09:42:23 -0400
X-MC-Unique: NDW0gLubP4S_Mw1LOlBMFQ-1
Received: by mail-qk1-f199.google.com with SMTP id n3-20020a378b030000b02903a624ca95adso9709983qkd.17
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 06:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LdCvQOrGWjsKZxZwOOVoEv2iDDtEdHzVz0K+vqaSd8c=;
        b=fOYBkS1ABNVu26sGmsQ21rzeo2URZVwBhgGmr1WyOSrY30U6U8uAUGptsFGJcBH20t
         OiqcOwf3aHdMJyX0SFZGuXiRoqZEZIrAU4q/ASZgsd/ATQ3gq1JN+qMFuR5QjMRteP6Y
         3pZw/HfgZYVMveRrCxKsEKa3yhstVDY4Uu86P6n3Nl86XZhh3MBVTtwweCah/pPIVLlZ
         KLMBgD5ds31EtEcUMsdBRf+AsViJu79XLD2S+C5dgnZBID2OCiz1ctCEvqAkqqQnhqCn
         SgNp3BibbM7DrQDXH5a0nlFahrEZVUlvNIZc5prcPUeUORWWZefKT35PDbW2EAvGhc27
         BCWQ==
X-Gm-Message-State: AOAM530bKyqbTv3qShF3jVAAgUFAInxwDdA106o8d6t9RUI2jB9ui5ZL
        8UkPCcdNJxymF2caPeB9vP8XkwxUyiuN5WBcZMsiAcAwX3mUEjVJ1NbaP2Yz2JRFKdP2c1S8EoS
        dmrIf+mFhcFL+QDzez5FFPdVr
X-Received: by 2002:ac8:41cc:: with SMTP id o12mr26663196qtm.225.1621863742580;
        Mon, 24 May 2021 06:42:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN2E6OyuJT27NGON0ll9bXuQZKU5qzeFUWBdBB/qU4w1rut3dBJP1eWoBaCwE7Gm43LKEigw==
X-Received: by 2002:ac8:41cc:: with SMTP id o12mr26663182qtm.225.1621863742394;
        Mon, 24 May 2021 06:42:22 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id c185sm10971448qkg.96.2021.05.24.06.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 06:42:21 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] docs: lockdep-design: correct the notation for writer
To:     Boqun Feng <boqun.feng@gmail.com>,
        Xiongwei Song <sxwjean@gmail.com>
Cc:     Waiman Long <llong@redhat.com>, Xiongwei Song <sxwjean@me.com>,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <1621578594-13237-1-git-send-email-sxwjean@me.com>
 <e0c0302f-e63f-7eba-872b-85e21b0b1622@redhat.com>
 <CAEVVKH9nwPmQo8L-eRsWST+gPaJ73MSHZfJ-mM8qWvPaiejdrA@mail.gmail.com>
 <YKuAvt3WXBVASuhY@boqun-archlinux>
Message-ID: <ab3c5c38-1447-99e1-ee22-9e5af906d8b4@redhat.com>
Date:   Mon, 24 May 2021 09:42:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YKuAvt3WXBVASuhY@boqun-archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 6:32 AM, Boqun Feng wrote:
> On Mon, May 24, 2021 at 12:24:00PM +0800, Xiongwei Song wrote:
>> On Fri, May 21, 2021 at 11:17 PM Waiman Long <llong@redhat.com> wrote:
>>> On 5/21/21 2:29 AM, Xiongwei Song wrote:
>>>> From: Xiongwei Song <sxwjean@gmail.com>
>>>>
>>>> The block condition matrix is using 'E' as the writer noation here, so it
>>>> would be better to use 'E' as the reminder rather than 'W'.
>>>>
>>>> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
>>>> ---
>>>>    Documentation/locking/lockdep-design.rst | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
>>>> index 9f3cfca..c3b923a 100644
>>>> --- a/Documentation/locking/lockdep-design.rst
>>>> +++ b/Documentation/locking/lockdep-design.rst
>>>> @@ -462,7 +462,7 @@ Block condition matrix, Y means the row blocks the column, and N means otherwise
>>>>        | R | Y | Y | N |
>>>>        +---+---+---+---+
>>>>
>>>> -     (W: writers, r: non-recursive readers, R: recursive readers)
>>>> +     (E: writers, r: non-recursive readers, R: recursive readers)
>>>>
>>>>
>>>>    acquired recursively. Unlike non-recursive read locks, recursive read locks
>>> I would say it should be the other way around. Both W and E refer to the
>>> same type of lockers. W emphasizes writer aspect of it and E for
>>> exclusive. I think we should change the block condition matrix to use W
>>> instead of E.
>> The doc uses 'E'  to describe dependency egdes too. Should we change them
>> to 'W'? Personally,  both 'W' and 'E' are fine.
>>
> I also think Waiman's suggestion is solid, there are two ways to
> classify locks:
>
> 1.	W (Writers), R (Recursive Readers), r (Non-recursive Readers)
>
> 2.	E (Exclusive locks), S (Shared locks), R (Recursive Readers),
> 	N (Non-recursive locks)
>
> And the relations between them are as follow:
>
> 	E = W
> 	R = R
> 	N = W \/ r
> 	S = R \/ r
>
> , where "\/" is the set union.
>
> The story is that I used the way #1 at first, and later on realized way
> #2 is better for BFS implementation, also for reasoning, so here came
> this leftover..
>
My suggestion was based on the fact that it is harder to associate E 
with writer. So from a readability perspective, it is better to change 
the block condition matrix to use 'W' to make it more readable.

Cheers,
Longman

