Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14754305BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbhA0MpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:45:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237427AbhA0Ml5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611751228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUziTB7yjFCtXkFHnLPvHhuspDqt9BvMkArF+T1jL44=;
        b=c6+OHF3eaPYH7lGGo8ZDJn622l3vmB8jLsNIDQCotczYF/jHVQi3ZDuLwUSLwUB4uwgKmj
        MlH6xwDNbofn4ad6BrVT8xvj3QS39IGQWSOZYD0WzgdhtARtkOdHJ+SGvP/3j+jkO079HX
        8rlcqCFSD/aQGNeL85B26vnoJ76Bho4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-UGS5im4NOrG_BesyskW9OA-1; Wed, 27 Jan 2021 07:40:26 -0500
X-MC-Unique: UGS5im4NOrG_BesyskW9OA-1
Received: by mail-ed1-f69.google.com with SMTP id x13so1284369edi.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QUziTB7yjFCtXkFHnLPvHhuspDqt9BvMkArF+T1jL44=;
        b=GvcJqClYLMRiZJWcEv61SFhykwXbYTvmU15DKm/0dkcuL74rDjpYaynbLPii04bxmL
         cqQjD1TZrRygMTkAl8xxsko0t+Xnte7FaUMusYJ9xM0B46kOX7+T/icxjtItA++NnvH9
         /ANqOiYOh4ayuTDOyHn+1fbdSvLFmpYs5NzGm4R4xNRTQvlRW0Aj7hgY5PYIJCtcGGKb
         U8iM4KVBKLGTgdyUs92hbaKzs0Bxs/wFYltvrO5II+ZJ8O6FQ/1WE1yfrVJgdF9lc7J8
         QKGnI+C76XZ4salVFQUj52ib9Wf74PkRIYsV9uhSrGHGC/mSyh+v7WzqPkVyQWJ0vv+Q
         k6dg==
X-Gm-Message-State: AOAM531rJ39vCwNoHPAATtqwBLT0lbO3wwIxo9embfzq0rXzgbb2mF9l
        BQcwekgbqvOCcTBKBYfR+6+UhjE9pjVXC1/Y2PYFeuZjCxC31W0JFvUR0FGCOW9xvMuexzJ5UXU
        1BQi3mnhti2yDZCMsy/wc7FI/
X-Received: by 2002:a17:907:20aa:: with SMTP id pw10mr6561876ejb.314.1611751225514;
        Wed, 27 Jan 2021 04:40:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuit+bGcgdhTrzCjhYmAEkv/7WLRGt5ic9fu4MFMY/cWcP+ETzolxbU4HANZFGkHEb8dAalQ==
X-Received: by 2002:a17:907:20aa:: with SMTP id pw10mr6561858ejb.314.1611751225382;
        Wed, 27 Jan 2021 04:40:25 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w18sm767764ejq.59.2021.01.27.04.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 04:40:24 -0800 (PST)
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-20-bgardon@google.com> <YAnUhCocizx97FWL@google.com>
 <YAnzB3Uwn3AVTXGN@google.com>
 <335d27f7-0849-de37-f380-a5018c5c5535@redhat.com>
 <YBCRcalZJwAlkO9F@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 19/24] kvm: x86/mmu: Protect tdp_mmu_pages with a lock
Message-ID: <bb1fcf44-09ca-73b1-5bbc-49f8bc51c8c1@redhat.com>
Date:   Wed, 27 Jan 2021 13:40:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBCRcalZJwAlkO9F@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/21 23:02, Sean Christopherson wrote:
>> You can do the deferred freeing with a short write-side critical section to
>> ensure all readers have terminated.
>
> Hmm, the most obvious downside I see is that the zap_collapsible_sptes() case
> will not scale as well as the RCU approach.  E.g. the lock may be heavily
> contested when refaulting all of guest memory to (re)install huge pages after a
> failed migration.

The simplest solution is to use a write_trylock on the read_unlock() 
path; if it fails, schedule a delayed work item 1 second in the future 
so that it's possible to do some batching.

(The work item would also have to re-check the llist after each iteration.)

Paolo

