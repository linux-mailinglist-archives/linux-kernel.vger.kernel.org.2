Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7E3E839C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhHJTZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231152AbhHJTZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628623488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMD9b/hP3x1fPYrhGrNkImlTo/6vlXT13PvAhB2yObQ=;
        b=TZuNryU9rbijIe3Z7kCqfgghJEmsDGbzjBvpYPJWtXIXwNTIABFQxjptn+js1T9Bc/IAHC
        phTcKYKo69cGUdWmkOwSrZF6WlJDE1gIOGTx6YP/7LeityClFqkuTtKG3BDpJ9fzUnv11E
        uTaVQykpvUiFsxu09LGcVplJ9PSf4aE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-R0MKdaNmPwusVO-JFaAsoA-1; Tue, 10 Aug 2021 15:24:47 -0400
X-MC-Unique: R0MKdaNmPwusVO-JFaAsoA-1
Received: by mail-qv1-f70.google.com with SMTP id kk20-20020a0562145094b029034e3ec4ffb4so11719595qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xMD9b/hP3x1fPYrhGrNkImlTo/6vlXT13PvAhB2yObQ=;
        b=kRHrGieaZy39WzYKrzbJsv3vpX0vINPIVy9Kj9wsQmwLdr5xQSnTkqq9atUG7qXZj8
         6GNxPS+I+jmiAC7WjieYRibuls0f2aJgkT0afL96jgLS2n/3mu4lxizarqaKBzd8+TpY
         wO9ZfZcs4YH3FU3m2O0dMulLFv9EEjACGKt3UFeHP6NT5nofovehBA7o74Q2x3i18Hpp
         PeD6OCOa9ueqdVbpZ6aulbTuyy7SO9tz9HqKnFJoXAPeD7Qd5hnkvKYgLh6wNb2yx/Ok
         uHnW6pksRCe9VSdysYkwbOIotOSxcxE+x4FfzTKJUc5bxZrq/QxvS07wetZ95GRxbzhO
         2Vgw==
X-Gm-Message-State: AOAM532DQBIY6Sc/x6ygIBGDLU9HmT3FtNNlHXKNdlcrMjN764I4TLJg
        gIAFn4RcxMOzbYx8xeiHuL6z4FDslTTZ7XCs3fb3Wjaetc7VgpC4GFM0tV37wG+4tVAnMmrMBM0
        3m3NXiPCXVE31LPilcwiW8A8X
X-Received: by 2002:a37:5a02:: with SMTP id o2mr30399280qkb.476.1628623486941;
        Tue, 10 Aug 2021 12:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWL+NFpWrrLCOwbdN9suzlxrWwMNccU+3YN9IA6pcNSTJWP0QMcAx2romXuMH30XZw+2HdaA==
X-Received: by 2002:a37:5a02:: with SMTP id o2mr30399257qkb.476.1628623486753;
        Tue, 10 Aug 2021 12:24:46 -0700 (PDT)
Received: from ?IPv6:2601:184:4180:af10::540e? ([2601:184:4180:af10::540e])
        by smtp.gmail.com with ESMTPSA id v10sm3168518qkj.104.2021.08.10.12.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 12:24:46 -0700 (PDT)
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, aquini@redhat.com,
        shakeelb@google.com, llong@redhat.com, mhocko@suse.com,
        hakavlad@inbox.lv
References: <20210809223740.59009-1-npache@redhat.com>
 <YRKa0yzEDALtvSZO@cmpxchg.org>
From:   Nico Pache <npache@redhat.com>
Message-ID: <a7afc485-9036-8f09-e582-f2eb45620670@redhat.com>
Date:   Tue, 10 Aug 2021 15:24:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRKa0yzEDALtvSZO@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/21 11:27 AM, Johannes Weiner wrote:
> Hello Nico,
> 
> On Mon, Aug 09, 2021 at 06:37:40PM -0400, Nico Pache wrote:
>> Since commit 170b04b7ae49 ("mm/workingset: prepare the workingset detection
>> infrastructure for anon LRU") and commit b91ac374346b ("mm: vmscan: enforce
>> inactive:active ratio at the reclaim root") swappiness can start prematurely
> 
> Could clarify what you mean by "prematurely"?

Hi Johannes! 

The reason I used the words prematurely and indiscriminately when trying to describe the behavior is because AFAICS the swappiness value is not being considered and this isnt a OOM case, so its prematurely going for anon memory. 

> 
> The new balancing algorithm targets the lowest amount of overall
> paging IO performed across the anon and file sets. It doesn't swap
> unless it has an indication that a couple of swap writes are
> outweighed by a reduction of reads on the cache side.
> 
> Is this not working for you?

Well it is for the most part, but to your point below, the sc->is_file_tiny case can directly bypass the meaning of swappiness and chooses to do whatever it likes.

> 
>> swapping anon memory. This is due to the assumption that refaulting anon should
>> always allow the shrinker to target anon memory.
> 
> This doesn't sound right. Did you mean "refaulting file"?

<code> 
   
refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_ANON);
    if (refaults != target_lruvec->refaults[0] || 
	inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
	sc->may_deactivate |= DEACTIVATE_ANON;

</code> 

Perhaps this is incorrect then? target_lruvec is using refaults[0] which is collected in snapshot_refaults. snapshot_refaults is populating index 0 with the WORKINGSET_ACTIVATE_ANON page state. the refaults variable is doing the same. So I assumed the refaulting ( new refault count != snapshot count) is comparing that of the anon workingset memory, not the refaulting of file cache.  

> 
>> Add a check for swappiness being >0 before indiscriminately
>> targeting Anon.
> 
>> Before these commits when a user had swappiness=0 anon memory would
>> rarely get swapped; this behavior has remained constant sense
>> RHEL5. This commit keeps that behavior intact and prevents the new
>> workingset refaulting from challenging the anon memory when
>> swappiness=0.
> 
> I'm wondering how you're getting anon scans with swappiness=0. If you
> look at get_scan_count(), SCAN_FRACT with swappines=0 should always
> result in ap = fraction[0] = 0, which never yields any anon scan
> targets. So I'm thinking you're running into sc->file_is_tiny
> situations, meaning remaining file pages alone are not enough to
> restore watermarks anymore. Is that possible?

Yes DEACTIVATE_ANON is enabling the file_is_tiny case in shrink_node(). That is what im trying to prevent in the swappiness=0 case. 

> 
> In that case, anon scanning is forced, and always has been. But the
> difference is that before the above-mentioned patches, we'd usually
> force scan just the smaller inactive list, whereas now we disable
> active list protection due to swapins and target the entire anon
> set. I suppose you'd prefer we go back to that, so that more pressure
> remains proportionally on the file set, and just enough anon to get
> above the watermarks again

Well kind of. It used to be that inactive_list_is_low would allow allow for the scanning of anon memory, but I am not removing that case here. Thats why my V3 separated the swappiness check from the inactive_is_low. Furthermore, the active list protection use to only be considered on the file LRU, as seem in ~4.18 inactive_list_is_low.  

> 
> One complication I could see with that is that we no longer start anon
> pages on the active list like we used to. We used to say active until
> proven otherwise; now it's inactive until proven otherwise. It's
> possible for the inactive list to contain a much bigger share of the
> total anon set now than before, in which case your patch wouldn't have
> the desired effect of targetting just a small amount of anon pages to
> get over the watermark hump.

Yes I believe this is also makes the problem worst. Im not sure if given the anon memory the same read-once optimization (starts on the inactive list) as file cache is the way to go. 

> 
> We may need a get_scan_count() solution after all, and I agree with
> previous reviews that this is the better location for such an issue...

I cant see why a get_scan_count solution is better then removing the problem where it starts.

> 
> One thing I think we should do - whether we need more on top or not -
> is allowing file reclaim to continue when sc->file_is_tiny. Yes, we
> also need anon to meet the watermarks, but it's not clear why we
> should stop scanning file pages altogether: it's possible they get us
> there 99% of the way, and somebody clearly wanted us to swap as little
> as possible to end up in a situation like that, so:> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eeab6611993c..90dac3dc9903 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2477,7 +2477,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  	 * If the system is almost out of file pages, force-scan anon.
>  	 */
>  	if (sc->file_is_tiny) {
> -		scan_balance = SCAN_ANON;
> +		scan_balance = SCAN_EQUAL;
>  		goto out;
>  	}

I agree, I think allowing it to scan both would be better as well. 

Cheers!
-- Nico 
  

