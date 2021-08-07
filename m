Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920583E3297
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 03:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhHGBhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 21:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229749AbhHGBhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 21:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628300236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iFTgxVqFqggRkC0Q/K2gaTe9Bsal3TVpnvpZS5yDXGw=;
        b=Rnxb+lA/TcgQb6OrP4HxKpxsv/lgRQTqOYxN1SzeKbQcJr6VZFRlit7341aHb4VDMbUXaO
        Iih0Ru8/l0+zwLPNVm6ss5geov7Zlw+d/6NNquU5da+XSeXsY6wi9kE2mGi77LNaUUoVyS
        4GKq4LK0IMLTU6BHwSvFWc/vEPQY7os=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-Q0xt2diIMeuLdJugl0oAwA-1; Fri, 06 Aug 2021 21:37:15 -0400
X-MC-Unique: Q0xt2diIMeuLdJugl0oAwA-1
Received: by mail-qv1-f72.google.com with SMTP id z25-20020a0ca9590000b029033ba243ffa1so7662621qva.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 18:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iFTgxVqFqggRkC0Q/K2gaTe9Bsal3TVpnvpZS5yDXGw=;
        b=jGJv1e9gXkaSnpaLEg/9tO9jdzmV95E78CjWlR1mVZxMJKB5v4Txid/hrZ42Qj//By
         24Ca6+ssyzSO0J4iv3g12cMh+wxLME6a1zOaIKWK7/JcOZrhOKXbX4aGuaw5qK70i++P
         +K8qrI6B7j5ku5/e8IbBYd+aIgB62MOF5PCtRuPEdPd2ZwePURSKpvIZoxxeJ4JkqyJo
         YVG2921098b9hAyzsoyCWbUMZAI6+wVaK3ZBjNJCkilFsHWf65Eb+VamVwqwUsDGzKcI
         ITRrZcI9TKs/Tuh/kXwRLfBT3aNUSc+YPVRMrFTaLTrb0xZWgOBMNgB95c1ZPjWDmWQ1
         bRjg==
X-Gm-Message-State: AOAM530bFzX82mfkYh5s7XSN4wcQB/SjkELJ92+x3Ob3p5AVmmeCA8ke
        oZaxm59082NKAl4Mqu6ejJ4rQmhOgzIMNzDxcbf17h9oneQTo+9hfx14W2PyxoSTgAaj9ANisFj
        8rcBEkMbbx21xvyIjnR1DHoS0
X-Received: by 2002:ac8:58d3:: with SMTP id u19mr11655105qta.306.1628300234985;
        Fri, 06 Aug 2021 18:37:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyio54RO4lKJEISxBN0ISWIhJ8pL76foRv8ZsxvUzEKBOcdR92OA6qObAVFSkHCxb4tetZaHg==
X-Received: by 2002:ac8:58d3:: with SMTP id u19mr11655097qta.306.1628300234809;
        Fri, 06 Aug 2021 18:37:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:4180:af10::8eb3])
        by smtp.gmail.com with ESMTPSA id n189sm2002998qka.69.2021.08.06.18.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 18:37:14 -0700 (PDT)
Subject: Re: [PATCH] vm_swappiness=0 should still try to avoid swapping anon
 memory
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rafael Aquini <aquini@redhat.com>, longman@redhat.com
References: <20210806231701.106980-1-npache@redhat.com>
 <CALvZod6gCof1bhVwdU7vYYKBRCn_HZBFi4BjSYoSK-dyrmswMA@mail.gmail.com>
From:   Nico Pache <npache@redhat.com>
Message-ID: <91605888-e343-2712-c097-bcade4cb389d@redhat.com>
Date:   Fri, 6 Aug 2021 21:37:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6gCof1bhVwdU7vYYKBRCn_HZBFi4BjSYoSK-dyrmswMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/6/21 9:00 PM, Shakeel Butt wrote:
> On Fri, Aug 6, 2021 at 4:17 PM Nico Pache <npache@redhat.com> wrote:
>> Since commit b91ac374346b ("mm: vmscan: enforce inactive:active ratio at the
>> reclaim root") swappiness can start prematurely swapping anon memory.
>> This is due to the assumption that refaulting anon should always allow
>> the shrinker to target anon memory. Add a check for vm_swappiness being
>>> 0 before indiscriminately targeting Anon.
> Did you actually observe this behavior?
Yes, and I've successfully tested this patch. It does solve the issue.
>
>> Signed-off-by: Nico Pache <npache@redhat.com>
>> ---
>>  mm/vmscan.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 4620df62f0ff..8b932ff72e37 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2909,8 +2909,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>
>>                 refaults = lruvec_page_state(target_lruvec,
>>                                 WORKINGSET_ACTIVATE_ANON);
>> -               if (refaults != target_lruvec->refaults[0] ||
>> -                       inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
>> +               if (vm_swappiness && (refaults != target_lruvec->refaults[0] ||
>> +                       inactive_is_low(target_lruvec, LRU_INACTIVE_ANON)))
> If you are really seeing the said behavior then why will this fix it.
> This is just about deactivating active anon LRU. I would rather look
> at get_scan_count() to check why swappiness = 0 is still letting the
> kernel to scan anon LRU. BTW in cgroup v1, the memcg can overwrite
> their swappiness which will be preferred over system vm_swappiness.
> Did you set system level swappiness or memcg one?

This fixes the issue because shrink_list() uses the may_deactivate field to determine if it should shrink the active list. This is not the only place that can cause the may_deactivate to deactivate anon, but it is the common path of kswapd/balance_pgdat. I can look into a get_scan_count() solution however this line is the ultimate cause of telling scan controller to go for anon so i figured this is the best spot ( stop the problem at the root, not all the way down in the call path). The get_scan_count balance can also be further modified after some shrinking occurs in shrink_lruvec. 

This is only the system level swappiness. As far as cgroups, I will also take a look into that to make sure we can generalize the solution for that as well. I dont think it should be too hard. 


Thanks for the review!

-- Nico


>>                         sc->may_deactivate |= DEACTIVATE_ANON;
>>                 else
>>                         sc->may_deactivate &= ~DEACTIVATE_ANON;
>> --
>> 2.31.1
>>

