Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406954430B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhKBOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhKBOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635864296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jic1F9UNvooEC2d+xw/+5aCM+bj4ORtETpFt0PPjtmo=;
        b=L4xhvObeDbLRlLIATzHYUkyX6GEygyPJcfSyL7+nlciRgPPhc3hjgWD5eVfk8SlQgNXWyZ
        3GRNWIsjHVcTTS37bNQOKn4mxn9QOw7lQK61gIsTu3UknzzNlJii3FLyni4NjxXyXODcLS
        pS01OHn60p0JfAYArF40hYPV6cLgySg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-DBtO7zm2O6iwaLSIe9-dew-1; Tue, 02 Nov 2021 10:44:55 -0400
X-MC-Unique: DBtO7zm2O6iwaLSIe9-dew-1
Received: by mail-wr1-f70.google.com with SMTP id y10-20020adffa4a000000b0017eea6cb05dso3648032wrr.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jic1F9UNvooEC2d+xw/+5aCM+bj4ORtETpFt0PPjtmo=;
        b=aPKRQ+ZHJsfrmoroZ31eg7G0frbXUfLYyThYI7fqeQbQUBye9PTfcsyuKj1pl4fHwm
         SwOCFHrxJGjIt30sq1JUp8aA2E8slD9Q858MhV9YEkEr9Z0jBoYfe9ZoCd7BmmeSXLbz
         E4nDF+hs4iXVCqn0ezbOci0Cls3j5FIS8C1S+NCj/84QmlPoM+YT9sdovuO9I5Ao9G87
         R4X0xK16dvbhbavq88gpezuqJEdp1FTE5p8WX4NfJOqD/HXqgrx1Np01FJXek4dJ+c7+
         JqZgr5cTaK5T6ww8Zu+PVpZ2mUt9J5SzZjOGW3S8Ebjqc3MMnnyaM72m6V2JPWI7KW6U
         Z6Ag==
X-Gm-Message-State: AOAM531WOr7KvCVCiMsdAQTCdgPu+kjl6hwRektadpzRsLPn/yrocqWb
        1PZqM89Io5bIUkPFeupN/7kRizFKAA3Wq74ZBbQSuFKQiz/BO+p3ONwQM0d/NEA6xjs/xk17SmI
        dHKR45pxkM1NV4k8lphSYA4S1
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr7823252wml.20.1635864294654;
        Tue, 02 Nov 2021 07:44:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBBOUAAgvnqsjRVZ4bzRv1lCqYgkkyX3fHbS5Y5cY5MU4aoQfmzPcf1WlQqb1AxIh7YDXh9w==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr7823225wml.20.1635864294488;
        Tue, 02 Nov 2021 07:44:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6810.dip0.t-ipconnect.de. [91.12.104.16])
        by smtp.gmail.com with ESMTPSA id c11sm3176123wmq.27.2021.11.02.07.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 07:44:53 -0700 (PDT)
Message-ID: <c927ef49-ae10-ba1b-bc34-0c44bba2e864@redhat.com>
Date:   Tue, 2 Nov 2021 15:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm: fix panic in __alloc_pages
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Oscar Salvador <OSalvador@suse.com>
References: <YYD/FkpAk5IvmOux@dhcp22.suse.cz>
 <b2e4a611-45a6-732a-a6d3-6042afd2af6e@redhat.com>
 <E34422F0-A44A-48FD-AE3B-816744359169@vmware.com>
 <b3908fce-6b07-8390-b691-56dd2f85c05f@redhat.com>
 <YYEkqH8l0ASWv/JT@dhcp22.suse.cz>
 <42abfba6-b27e-ca8b-8cdf-883a9398b506@redhat.com>
 <YYEun6s/mF9bE+rQ@dhcp22.suse.cz>
 <e7aed7c0-b7b1-4a94-f323-0bcde2f879d2@redhat.com>
 <YYE8L4gs8/+HH6bf@dhcp22.suse.cz>
 <ccf05348-e1b6-58a7-2626-701e60b662e6@redhat.com>
 <YYFHPGq/E9F11F7o@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YYFHPGq/E9F11F7o@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.21 15:12, Michal Hocko wrote:
> On Tue 02-11-21 14:41:25, David Hildenbrand wrote:
>> On 02.11.21 14:25, Michal Hocko wrote:
> [...]
>>> Btw. do you plan to send a patch for pcp allocator to use cpu_to_mem?
>>
>> You mean s/cpu_to_node/cpu_to_mem/ or also handling offline nids?
> 
> just cpu_to_mem
> 
>> cpu_to_mem() corresponds to cpu_to_node() unless on ia64+ppc IIUC, so it
>> won't help for this very report.
> 
> Weird, x86 allows memory less nodes as well. But you are right
> there is nothing selecting HAVE_MEMORYLESS_NODES neither do I see any
> arch specific implementation. I have to say that I have forgot all those
> nasty details... Sigh
> 

I assume HAVE_MEMORYLESS_NODES is just an optimization to set a
preferred memory node for memoryless nodes. It doesn't imply that we
cannot have memoryless nodes otherwise.

I suspect just as so often, the config option name doesn't express what
it really does.

-- 
Thanks,

David / dhildenb

