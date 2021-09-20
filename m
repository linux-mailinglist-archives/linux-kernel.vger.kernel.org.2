Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5C5411434
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbhITMV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232858AbhITMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632140397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSqcwcTmYi+4XAo3AQLXt1fScqtILQNXT0vec3kDxvM=;
        b=SEUZLv0OFj4aT0lZg+BH24C85ht5s+s54uZ9SqSNhmCYHKDzoE0pRXSzCckiIMrOH3QBxK
        8yA9hlqJo49e+/zDfosZl8xPwmd52HZIFn0ZJiNdkYj+Ake62qDTkNOxwbzihHBStjstjE
        No27LlUFn7JTYulWn1BSlkjazkL/vO0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-tgz0ty_bNXOmwjXU1DC3Yg-1; Mon, 20 Sep 2021 08:19:56 -0400
X-MC-Unique: tgz0ty_bNXOmwjXU1DC3Yg-1
Received: by mail-wr1-f72.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso5933538wrw.22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BSqcwcTmYi+4XAo3AQLXt1fScqtILQNXT0vec3kDxvM=;
        b=lzk/eLvfWIXXtv2tnjEoTeGj1Y8gN2VisSrjoCa+1ZJr0paedZ+nfnwHvdTBBhYo1c
         +Of60B61iu+Dawy5TCrdFTL1EYO0uVGytNPUMK+W/7FFeB0TfQg7RPfklFJnsMpMrnq0
         NTH9I0ESOMi8dCPvCh7UlvptvdBVl8irBG7Bg7wQJNJ6TSTcRopGjeGgA5FWL4Hg5YZp
         UvD9ma+SzK5Cdcm7WgYAfQo/HnMuqPqUBDbX5tdqaE2MjRbQAuGMLfBfMxwtOMMOFfHQ
         EFW11Kx6v+koxJWo9KlSRTFZUYRJVzkWdbupiPm65bA6PiSskU4sPxs7RBgbZn7POcyQ
         VWNg==
X-Gm-Message-State: AOAM533wDo0v0axFzgkda38s/sL2ARcG+v3Wgy7E1Jy7P99RtMBFq+Xj
        W+57hIvQwf/yK0wuw2ey3BwMG4Kdd7zhuCdi38uCQPUsbrGoCghjKDG/vNJq65FRuKyuVnpwH2j
        O/xGl/twNGxYx61Jri3wSSWN6
X-Received: by 2002:adf:e408:: with SMTP id g8mr28345009wrm.138.1632140395067;
        Mon, 20 Sep 2021 05:19:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt6J1u5jDB+ETfKXxtynJ5yNdt7v/raGEFZ8RHHrlmwTC8uNCF2suT6pHOVRaE0lORruR0UQ==
X-Received: by 2002:adf:e408:: with SMTP id g8mr28344998wrm.138.1632140394915;
        Mon, 20 Sep 2021 05:19:54 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e48.dip0.t-ipconnect.de. [79.242.62.72])
        by smtp.gmail.com with ESMTPSA id y197sm17923941wmc.18.2021.09.20.05.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:19:54 -0700 (PDT)
Subject: Re: [PATCH 4.19 STABLE] mm/memory_hotplug: use "unsigned long" for
 PFN in zone_for_pfn_range()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta@ionos.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
References: <163179697124554@kroah.com>
 <20210920113224.7478-1-david@redhat.com> <YUh6kI6f4Q9NgB7B@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <469a6a19-fef0-2e5f-1b61-34305eaf02bb@redhat.com>
Date:   Mon, 20 Sep 2021 14:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUh6kI6f4Q9NgB7B@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.21 14:12, Greg KH wrote:
> On Mon, Sep 20, 2021 at 01:32:24PM +0200, David Hildenbrand wrote:
>> commit 7cf209ba8a86410939a24cb1aeb279479a7e0ca6 upstream.
>>
> 
> We also need a 5.4.y version if we are going to be able to apply the
> 4.19.y and 4.14.y versions.

On it, still compiling :)


-- 
Thanks,

David / dhildenb

