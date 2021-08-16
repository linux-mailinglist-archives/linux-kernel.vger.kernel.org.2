Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790A43ED3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhHPMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhHPMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629117040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MwGXGUpgYHeCATQRI2S6hh9gbtFR662dOrFWy5V9MCA=;
        b=ai9tZ3WSvLXQp8fBVuIZW24s48vq46H7uyiBoCmPOflkz2zFRjA6b46ogeOQ/xyJdHqBsk
        +YpCn53onfjASJcM6mBdNsnzf19H9OSUicTCO18KdW2zceLlK1CWPgIxTN/+leeNOWsZLd
        ZazCPoDT6KdnWk4WNpiXKFsm7C5p888=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-DCNj5gkaNB26gWrQ7kK5wA-1; Mon, 16 Aug 2021 08:30:39 -0400
X-MC-Unique: DCNj5gkaNB26gWrQ7kK5wA-1
Received: by mail-wr1-f72.google.com with SMTP id a5-20020adffac5000000b00156c5929fadso660601wrs.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MwGXGUpgYHeCATQRI2S6hh9gbtFR662dOrFWy5V9MCA=;
        b=mhAGFRDBAJj8xT74R2+D6S8RcTh9LM0/tjhZfWqeTKHs9wzPA4iqsDLEAJqmjCypii
         12N7s83mpk8eLih9PjAdUPyQH+imRBPphAM7Eh08H8ij31TI3t3M2Kmy4A+ta5ToEVYj
         iirCzwv17yeXj/kXjmKY/RCc0cXZJqVCRtyK8rtop8sLgnCBDrXCI4UGtDp9F63lotSy
         Wj3m6D1VU9S0DI85G3ZkcSwiK8A5+qE4mxP/Kd1xx/8ASLJeqaqzpBVs2zs5D6v4l2z9
         YV19h50B1FahaXVKlGg5BcO3YXG/BfqrILBXUi7HHdXJ6/qli9fPE3bHSH9uAnZUqREc
         673w==
X-Gm-Message-State: AOAM533AHdeLHOSAY0NsaUoLUbTFcYII6smctf9nXlxgRYkdqQjq1VR1
        D4EzmIT/sihKGFlTBSZ9WFSbSzVw1KXX2yN+CMIsWuSGQs/QFw7tJr0wr5ZuFawS8uBKZ1n2xHg
        biQmVtahOXiODNTuRE+qoRXNH
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr15191868wma.9.1629117038446;
        Mon, 16 Aug 2021 05:30:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7JlO5k2O4tSoxxjXOPUiUg0ML1X1AtWmhiVEkYC3HAT22ctUgmMnk3JAB1e2foA6HWALHIg==
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr15191853wma.9.1629117038287;
        Mon, 16 Aug 2021 05:30:38 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id y1sm10781543wmq.43.2021.08.16.05.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 05:30:37 -0700 (PDT)
Subject: Re: [private] Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
From:   David Hildenbrand <david@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
 <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
 <YOubKmDwxMIvdAed@casper.infradead.org>
 <a94973ab83ce48bd85c91397f82d7915@huawei.com>
 <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
 <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
 <YRpVHnr55LpQQvTb@casper.infradead.org>
 <86ebdfe4-22ee-9a9a-9d06-8305290d9bc9@redhat.com>
Organization: Red Hat
Message-ID: <fbaf0a30-b0d0-1922-92ca-9dca632a0892@redhat.com>
Date:   Mon, 16 Aug 2021 14:30:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <86ebdfe4-22ee-9a9a-9d06-8305290d9bc9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 14:27, David Hildenbrand wrote:
> On 16.08.21 14:07, Matthew Wilcox wrote:
>> On Mon, Aug 16, 2021 at 10:02:22AM +0200, David Hildenbrand wrote:
>>>> Mappings within this address range behave as if they were shared
>>>> between threads, so a write to a MAP_PRIVATE mapping will create a
>>>> page which is shared between all the sharers. The first process that
>>>> declares an address range mshare'd can continue to map objects in the
>>>> shared area. All other processes that want mshare'd access to this
>>>> memory area can do so by calling mshare(). After this call, the
>>>> address range given by mshare becomes a shared range in its address
>>>> space. Anonymous mappings will be shared and not COWed.
>>>
>>> Did I understand correctly that you want to share actual page tables between
>>> processes and consequently different MMs? That sounds like a very bad idea.
>>
>> That is the entire point.  Consider a machine with 10,000 instances
>> of an application running (process model, not thread model).  If each
>> application wants to map 1TB of RAM using 2MB pages, that's 4MB of page
>> tables per process or 40GB of RAM for the whole machine.
> 
> Note that I am working on asynchronous reclaim of page tables, whereby I
> would even reclaim !anonymous page tables under memory pressure.
> 
> Assuming your processes don't touch all memory all the time of course
> ... of course, it's a research project and will still require quite some
> work because devil is in the detail (locking).
> 

Well, that comment did turn out not-so-private, so it's certainly a good 
discussion-starter.

-- 
Thanks,

David / dhildenb

