Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79723E4E53
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhHIVT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 17:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhHIVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628543975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f5YVhdAcO6l+JL131v6pp68KDpwBPXY9dHoGr3Aj3qU=;
        b=aoQnqdOXoOnlMwy6uJZSCZ1zV2vm95tmUIh1/U6eyf+tPXJxLP8aRyZmYCR4yzoQ+1FB8P
        MVZGK6Da5CPSA7kfuqIrdkX1fnCXW2kuUOxmf4NpTs6JABlv/h2EKrnJiyBWokPmRk7A90
        qEpD6DJSW5AOLX7N6ReCY+EimSzgxo8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-4UyXUeKhN3-xETnZtCE5Eg-1; Mon, 09 Aug 2021 17:19:33 -0400
X-MC-Unique: 4UyXUeKhN3-xETnZtCE5Eg-1
Received: by mail-qk1-f197.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so1569475qki.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 14:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f5YVhdAcO6l+JL131v6pp68KDpwBPXY9dHoGr3Aj3qU=;
        b=Fjiqp2AfC9i6y3hOEaeE4LpIvSQvid9x7GtVwhGQNWLbh/3ReVYR1GbIT0lFlOWNii
         suTpseeKMdZPDQRQ6kyzYvToUk+W77uFdLnCqBUWFE0CPHktzwIRNY/Yh7VK8SSKzwOz
         StGNsYERZjUro2GXje7R9om06AbAiboCATolTUFJuX71ORsiDQ9/EEfFRUagIbJANM/K
         QhAmifU398jYi4gNpqviNBQwnjyyRSpK2PtsCx+x7QHWxzN0IHFhsW5Lpl+PmBRLNx/F
         5Yd6849BS7tlJd4rxZozIVgzoaaz8hUc//NMwle8ijejztRfFnu8J60/2kn+tIcpkMO4
         UtKw==
X-Gm-Message-State: AOAM533Wyz5A6xKzuOZCfCWepk2gPChX0fKl8JHZrHnpzCHOCn6sFMaW
        4nsjR9+/7MyWf/zCPPFVbTvT+NWboCE+w/4yiepMWnQclcjf1NHi7b2mhL70D7OVbR1DMqcotEm
        SF+Wv4HwZ+KCSAl6AEOY/GHKl
X-Received: by 2002:ac8:4743:: with SMTP id k3mr21805512qtp.124.1628543973576;
        Mon, 09 Aug 2021 14:19:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMv6D5mkTgs9VqqyMzS/viI7LG43ru1BwIUMuzxkPVULikVpRvSTJFN9CYAqWG9biHqErsLg==
X-Received: by 2002:ac8:4743:: with SMTP id k3mr21805502qtp.124.1628543973395;
        Mon, 09 Aug 2021 14:19:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:4180:af10::540e])
        by smtp.gmail.com with ESMTPSA id j2sm7245809qtn.46.2021.08.09.14.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 14:19:32 -0700 (PDT)
Subject: Re: [PATCH v2] vm_swappiness=0 should still try to avoid swapping
 anon memory
To:     Alexey Avramov <hakavlad@inbox.lv>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        aquini@redhat.com, shakeelb@google.com, llong@redhat.com,
        mhocko@suse.com
References: <20210807022129.8842-1-npache@redhat.com>
 <20210807151424.76b4ee3a@mail.inbox.lv>
From:   Nico Pache <npache@redhat.com>
Message-ID: <c8de174f-751e-0c2a-3fda-0896e42583e9@redhat.com>
Date:   Mon, 9 Aug 2021 17:19:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807151424.76b4ee3a@mail.inbox.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/21 2:14 AM, Alexey Avramov wrote:
>> vm_swappiness=0 should still try to avoid swapping anon memory
> Swapping with swappiness=0 depends on vm.watermark_scale_factor.
> Decrease vm.watermark_scale_factor to avoid swapping and get OOM,
> and increase vm.watermark_scale_factor to get successful swapping 
> even with swappiness=0.
>
> Maybe I misunderstood you and you are solving some new problem? 

The problem is new; however, the two workloads that are now running into this issue are not new (one is as old as RHEL5).

Sorry the issue was attributed to the wrong commit in my V1/V2 posting. This may have caused some confusion. The actual commit to blame is 170b04b7ae49 ("mm/workingset: prepare the workingset detection infrastructure for anon LRU"). I will be posting my V3 soon. It has a much better commit log and fixes a issue that was present in my V2.


This new change allows for challenging the anon memory at a much greater rate. I believe this is ok since it will cause less trashing; however, it may also be the case that the user wants to avoid paying the cost of writing the anon to swap, and would rather throttle the page reads (like has been the case since at least rhel5).


Hopefully my V3 clears up a lot of the questions asked, and my motivations for these changes is more clear.


Cheers!

-- Nico

