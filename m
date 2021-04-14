Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77E35EF49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349204AbhDNINX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348065AbhDNIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618387953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEQkyy9t1jzPVdahKRoV374H4BVFmTXZ/iYnGJBO3bY=;
        b=cbGhsH1Yt5r/hUoTc0guIW6zAX+Nus9wUnKhXMaGipnBPkgTNrnaisXiw2DEY6fIcLrYBV
        c16OJyFW1pD7Cm/GzrArW+mfP4SMyIrY220Fmup0Geg7K+YOlphkUP/5nITe/FYhfaQGN3
        oZOgl8LJmZPgSrlUdkJ7wAhUVF6JWt0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-6PUmSR5EN7SJDYEAInVlBQ-1; Wed, 14 Apr 2021 04:12:31 -0400
X-MC-Unique: 6PUmSR5EN7SJDYEAInVlBQ-1
Received: by mail-wr1-f71.google.com with SMTP id n4-20020a5d51c40000b02900f3fe975f03so706124wrv.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vEQkyy9t1jzPVdahKRoV374H4BVFmTXZ/iYnGJBO3bY=;
        b=aA1aqoXO9ujgDo88f757feplI+68ubzjtnJ5vwCliXJVKCjAorX+ThbVK9Yx9UThHA
         f/qT1cfe4s0OyCoM/W1dbQRi7nAUZQ6LnVMKIPqJmhS9l3k904Wua5FD5wc4IhWDGlRy
         K2EKWnhma6G4uSZre01DPc/7SFc21kEv7so4JHaY8LX6+Q0EXHc7SjIf7FP1C16bemLg
         N/l+vL2hm9zl8300NIDY2BwcDb/SBAp21AdJrh3/2Vuiyl0nwI58Km5/0h7JyohAmz8q
         12wAFtzMphlgKDOapQYvvVwYjIcgbQyJ7DjAYG17DQ2F06mTsXau7IwkyQbBiBly3fwr
         NE2A==
X-Gm-Message-State: AOAM533qQs2SuhfBsho+jNHUx8g1caGWMoOj9sRTZ6dqWtNxgcpvpHEn
        u7k6AtL9EyP8660CP0XsM2mYMtCroZDNFydGQwQ6xGF93421HrFmIThvIviQoDs4pkF7st1LNc4
        R0QN12k+NfAT7WLYdhB1XqpdN
X-Received: by 2002:a1c:1904:: with SMTP id 4mr1724577wmz.57.1618387950400;
        Wed, 14 Apr 2021 01:12:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGH12SrR2GWYO5cbmCBwPe1iLy20MAjZNmVNWKtirNi5r4Ie5TLXUWfLSqG6YHBes8LdheAA==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr1724556wmz.57.1618387950173;
        Wed, 14 Apr 2021 01:12:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id r5sm23063420wrx.87.2021.04.14.01.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 01:12:29 -0700 (PDT)
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration
 order
To:     Oscar Salvador <osalvador@suse.de>, Wei Xu <weixugc@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183219.DC1928FA@viggo.jf.intel.com>
 <CAAPL-u8Jk-i-9-iSnU7_nb-k2ZMqdRk5c88d-M6Bi1rfv4kSLQ@mail.gmail.com>
 <20210414080849.GA20886@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <926bd5f9-bf05-2e01-26da-da3f66439d3b@redhat.com>
Date:   Wed, 14 Apr 2021 10:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210414080849.GA20886@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.21 10:08, Oscar Salvador wrote:
> On Fri, Apr 09, 2021 at 08:07:08PM -0700, Wei Xu wrote:
>> On Thu, Apr 1, 2021 at 11:35 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>>> + * When Node 0 fills up, its memory should be migrated to
>>> + * Node 1.  When Node 1 fills up, it should be migrated to
>>> + * Node 2.  The migration path start on the nodes with the
>>> + * processors (since allocations default to this node) and
>>> + * fast memory, progress through medium and end with the
>>> + * slow memory:
>>> + *
>>> + *     0 -> 1 -> 2 -> stop
>>> + *     3 -> 4 -> 5 -> stop
>>> + *
>>> + * This is represented in the node_demotion[] like this:
>>> + *
>>> + *     {  1, // Node 0 migrates to 1
>>> + *        2, // Node 1 migrates to 2
>>> + *       -1, // Node 2 does not migrate
>>> + *        4, // Node 3 migrates to 4
>>> + *        5, // Node 4 migrates to 5
>>> + *       -1} // Node 5 does not migrate
>>> + */
>>
>> In this example, if we want to support multiple nodes as the demotion
>> target of a source node, we can group these nodes into three tiers
>> (classes):
>>
>> fast class:
>> 0 -> {1, 4}  // 1 is the preferred
>> 3 -> {4, 1}  // 4 is the preferred
>>
>> medium class:
>> 1 -> {2, 5}  // 2 is the preferred
>> 4 -> {5, 2}  // 5 is the preferred
>>
>> slow class:
>> 2 -> stop
>> 5 -> stop
> 
> Hi Wei Xu,
> 
> I have some questions about it
> 
> Fast class/memory are pictured as those nodes with CPUs, while Slow class/memory
> are PMEM, right?
> Then, what stands for medium class/memory?

My guest best is that fast class is something like HBM (High Bandwidth 
Memory), medium class is ordinary RAM, slow class is PMEM.

-- 
Thanks,

David / dhildenb

