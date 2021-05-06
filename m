Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63D13757BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhEFPlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235537AbhEFPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620315620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zt1CMVCYEfkxyd9UNysxUz4SpT8ZgoiU+x8AV2J3Qcc=;
        b=HmYgesH4zOZHiP2jS3YRke1g+9zU6IFtdcvgLDslYENOMT+6xwIgET0f2+dZUOJJ5rizYc
        i3NjoHH+BW2zMU8ACGngt3R2hbpF6KJxiRUcuVPoUPWcwOT4ocBtqNwoVGd0ArJreYnzT5
        Dwgj68IKLWH40WiaCkLf/iwJMFLchmY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-JHqmbhZIMduL2nwXfnqpjQ-1; Thu, 06 May 2021 11:40:18 -0400
X-MC-Unique: JHqmbhZIMduL2nwXfnqpjQ-1
Received: by mail-ed1-f69.google.com with SMTP id z12-20020aa7d40c0000b0290388179cc8bfso2835283edq.21
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zt1CMVCYEfkxyd9UNysxUz4SpT8ZgoiU+x8AV2J3Qcc=;
        b=HGIb6MJZuY9i5uz36FOLSj2eHfl7cmWr6hD6xcE37iustTs6/UfchbeAWMgEtDlH3B
         9YILyYOQsF8qI/XZTgjlanpbotnqnd4SBB2/N/Iv6MTR+YxqzFVw7iJsbULFVSP1HZr6
         CuJBq+hCxWpW8LnkQRMSZCJEx+zM4PJJoVvbBJzSwWqaPGrmPTAxD6zriuASXbTsXsq1
         CdPVfJc/sSZpeUwKNRJOIdRxJ+fIiOcpT2nEDINGxJfwliFrXKe/JVBKHdnGycle9p+p
         RPi2lz+R4X0eLJThD9Rkqtrz87dFdH5B4/C8uGbxGbkDujsOwinVF2/OWZUoef5OXKfi
         4AMQ==
X-Gm-Message-State: AOAM533F1RAcfqJ/zyJwLrM8+zAo087e/oHEPSYqxbr69og+os/ALA4n
        x/qqiiDA4s7rflY9+btb9SnOyx5XAuirZ1OvTkBhUKj4nw6WDoBUAZEg0TFX7/cyyykTAjD3lk2
        xwFYgblBjlJPCVOHQ2sv95D5f
X-Received: by 2002:a05:6402:4313:: with SMTP id m19mr5915836edc.263.1620315617609;
        Thu, 06 May 2021 08:40:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzk0LjFrMyClreAxpxpyn2/1+H3Xm8pkFKVU4ZpBXb5EXnGWXP797OFz3GwiryEOPHyCBR4Q==
X-Received: by 2002:a05:6402:4313:: with SMTP id m19mr5915815edc.263.1620315617456;
        Thu, 06 May 2021 08:40:17 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id k9sm1740567eje.102.2021.05.06.08.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 08:40:17 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Memory hotplug/hotremove at subsection size
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
 <fb60eabd-f8ef-2cb1-7338-7725efe3c286@redhat.com>
 <9D7FD316-988E-4B11-AC1C-64FF790BA79E@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3a51f564-f3d1-c21f-93b5-1b91639523ec@redhat.com>
Date:   Thu, 6 May 2021 17:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9D7FD316-988E-4B11-AC1C-64FF790BA79E@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> The last patch increases SECTION_SIZE_BITS to demonstrate the use of memory
>>> hotplug/hotremove subsection, but is not intended to be merged as is. It is
>>> there in case one wants to try this out and will be removed during the final
>>> submission.
>>>
>>> Feel free to give suggestions and comments. I am looking forward to your
>>> feedback.
>>
>> Please not like this.
> 
> Do you mind sharing more useful feedback instead of just saying a lot of No?

I remember reasoning about this already in another thread, no? Either 
you're ignoring my previous feedback or my mind is messing with me.

-- 
Thanks,

David / dhildenb

