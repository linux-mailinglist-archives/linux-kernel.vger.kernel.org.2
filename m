Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE7375B88
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhEFTPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235003AbhEFTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620328487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxJCtrJc+hn1vhOwMRBMiLEsVjLTk4AmYnUbr3bQtaE=;
        b=PLRvuvKSFI1DBA41oyQZfmh5KBtNY7jp9bfmvhGxSvQHtx0HkfmIdlhEHoaBBb18LF3AOM
        6lYi62N3cIRS2MC9cNkAYTtSyTqaEZyJ7/MvGXFS7pLcnBjmicQBouSbd0WuWOO8CFt0Dm
        U/iwtdnTNMQIyW096DYgRPjOV5+xK6M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-VgBj6KJuPVSnkc-sLZy7Zg-1; Thu, 06 May 2021 15:14:45 -0400
X-MC-Unique: VgBj6KJuPVSnkc-sLZy7Zg-1
Received: by mail-ej1-f69.google.com with SMTP id gt39-20020a1709072da7b02903a8f7736a08so999150ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 12:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LxJCtrJc+hn1vhOwMRBMiLEsVjLTk4AmYnUbr3bQtaE=;
        b=cDhU3CkitAT0nK6OZV/XTWzPf6LVfRio6MQnORatGJXe7/PYxdf4EnBD9YF4+i6alx
         QiA3Q+TYZylKc6dqnRif+xuIklohDSoyZgP2w8HGazEK1EovUFwBCDF4Y2jsUeoo7Vyw
         JZjNB5cLuQaHliIoeXmrCdqk/N3T/YuQySOGMaaEl2aQ1eS3BB4eEW7gs04jsevBvEFJ
         KO9u9tdxmgW9Dlq0xv5R0ab4HRqvW5+CydNTy14fvDIh+VIxncm7qsk0vBOQtnuJcdtG
         UhuPllwWjNMzpvZMaU5n9lF5oSYEH1pfd7k2yrz3yhsOb4X8fp5swVi2iCkDHsEidQQ4
         p8AA==
X-Gm-Message-State: AOAM533ostE4+OD9fwKbVN1m+6zXCBUpZ3GyTfn0Zq1Ey/e5SGH0+hlR
        5GkhdsruE8+sBG9x2ktavKEKGyJlaRQG3i5kBiZa3DTtw4Q6kaXvAXLnPQYkYKcvLbfLEmYLV1r
        +qzDdnf7Q0hVhi/jBygWJ6rWj
X-Received: by 2002:aa7:d843:: with SMTP id f3mr7130710eds.270.1620328484582;
        Thu, 06 May 2021 12:14:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMDfCDANHagwyvMGFrV1L6sL7t6UDHQRxiwpmWElp0FfWEi44uao+v+GyT+Pf6/v6QHjNNZw==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr7130678eds.270.1620328484331;
        Thu, 06 May 2021 12:14:44 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id x7sm1924071ejc.116.2021.05.06.12.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 12:14:44 -0700 (PDT)
To:     Zi Yan <ziy@nvidia.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
References: <20210506152623.178731-1-zi.yan@sent.com>
 <20210506152623.178731-2-zi.yan@sent.com>
 <06dfaf69-1173-462c-b85f-8715cb8d108c@redhat.com>
 <71EE13C0-9CF7-4F1F-9C17-64500A854BD8@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 1/7] mm: sparse: set/clear subsection bitmap when
 pages are onlined/offlined.
Message-ID: <146a1ec6-38b3-9724-b346-9bb6e7e24c72@redhat.com>
Date:   Thu, 6 May 2021 21:14:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <71EE13C0-9CF7-4F1F-9C17-64500A854BD8@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> But glimpsing at patch #2, I'd rather stop right away digging deeper into this series :)
> 
> What is the issue of patch 2, which makes pageblock_order a variable all the time? BTW, patch 2 fixes a bug by exporting pageblock_order, since when HUGETLB_PAGE_SIZE_VARIABLE is set, virtio-mem will not see pageblock_order as a variable, which could happen for PPC_BOOK2S_64 with virtio-men enabled, right? Or is this an invalid combination?

virtio_mem is x86_64 only. aarch64 and s390x prototypes are available.

If I understood "Make pageblock_order a variable and
set it to the max of HUGETLB_PAGE_ORDER, MAX_ORDER - 1" correctly, 
you're setting the pageblock_order on x86_64 to 4M. That mean's you're 
no longer grouping for THP but MAX_ORDER - 1, which is not what we want. 
We want to optimize for THP.

Also, that would affect virtio-balloon with free page reporting (report 
only 4 MiB chunks not 2 MiB chunks).

> 
>>
>> I think what would really help is drafting a design of how it all could look like and then first discussing the high-level design, investigating how it could play along with all existing users, existing workloads, and existing use cases. Proposing such changes without a clear picture in mind and a high-level overview might give you some unpleasant reactions from some of the developers around here ;)
> 
> Please see my other email for a high-level design. Also I sent the patchset as a RFC to gather information on users, workloads, use cases I did not know about and I learnt a lot from your replies. :) Feedback is always welcome, but I am not sure why it needs to make people unpleasant. ;)

Rather the replies might be unpleasant ;)

-- 
Thanks,

David / dhildenb

