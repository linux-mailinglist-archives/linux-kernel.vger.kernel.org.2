Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2485C3ECFDF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhHPIDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234476AbhHPIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629100948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VoHWbWOZZ5Gc380Xsm1HHUKCGfyh24JQPgPz3EJgIA=;
        b=SNkSxgcZhffdWVS7jize3j3f/CPt6d4SQhvi3p3FZtp2UFtjjwyfF7b2gnSBkxfmhfLzw1
        dJOBOpdqbaRwP+IluRFDgHS6F59KIe2aQu8ooZ1rykbXYbksxm3NMwu6qGS6Gi9CW/qLS7
        iDULCMi8Jps3HUK45IjX7/4nrgjtAfQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-PSAPKEwOOp-P7q1Kfn1g_Q-1; Mon, 16 Aug 2021 04:02:24 -0400
X-MC-Unique: PSAPKEwOOp-P7q1Kfn1g_Q-1
Received: by mail-wr1-f70.google.com with SMTP id y12-20020adfee0c0000b0290154e82fef34so5214378wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 01:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/VoHWbWOZZ5Gc380Xsm1HHUKCGfyh24JQPgPz3EJgIA=;
        b=OeR5NcuYIEgMJSSEbhym7xyn4DZ2EektksVQ73jL29SWK8j7v9kKzxRtRRC45YMVIn
         tBE+eUf42FFcwfpFHjKcn4gjgQ6iWMvfO5lKWoTGdIlINhO/131S7qYMVi3L5JckyJEc
         Mlu6SOQ9TyqDWNpg+HM/VTNly9hJM5nwxwEoP+zVgbCO97IJ9s0f8DIo+d1+KTlg83sZ
         Kn9A+jNKSwy1mee9CxKuAkeWFYHxmr+KtuT3sgD46/9BW7dqgmyxUVr3qoW77lskcE70
         50JM6I8Uti87FTP4BEvIpj5FjEjhsNqJgudLpIcSN2t1SoXfs5pKkd9P+sG0kQhCs11h
         KELg==
X-Gm-Message-State: AOAM5320zO8BAtENW+lrlyV9zqdTC3HXFnpWWzBl0UINqU96KiOWCoZQ
        0gDIeVaoANZsPwCMPPfgPkVnLV0/WCef8UhSIV8ggAe+Tma6g8bcMe0yUaXEenAyqT5iXSZ7WrQ
        qSFULPwbYwViMeSkYYxpHIWD1
X-Received: by 2002:a5d:4bc6:: with SMTP id l6mr17306737wrt.210.1629100943543;
        Mon, 16 Aug 2021 01:02:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOrPHrkJJ7EJbiWot1B5Zb3Htst+14frqtFk9dAp7/v+KmNHAUYoj4HkECEYZF0IDdDyFLzQ==
X-Received: by 2002:a5d:4bc6:: with SMTP id l6mr17306711wrt.210.1629100943372;
        Mon, 16 Aug 2021 01:02:23 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id e11sm10754872wrm.80.2021.08.16.01.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 01:02:22 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Khalid Aziz <khalid.aziz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <db2b7337-4c6b-4e4b-71d3-dc4940353498@redhat.com>
Date:   Mon, 16 Aug 2021 10:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <55720e1b39cff0a0f882d8610e7906dc80ea0a01.camel@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.21 21:49, Khalid Aziz wrote:
> On Tue, 2021-07-13 at 00:57 +0000, Longpeng (Mike, Cloud Infrastructure
> Service Product Dept.) wrote:
>> Hi Matthew,
>>
>>> -----Original Message-----
>>> From: Matthew Wilcox [mailto:willy@infradead.org]
>>> Sent: Monday, July 12, 2021 9:30 AM
>>> To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
>>> <longpeng2@huawei.com>
>>> Cc: Steven Sistare <steven.sistare@oracle.com>; Anthony Yznaga
>>> <anthony.yznaga@oracle.com>; linux-kernel@vger.kernel.org;
>>> linux-mm@kvack.org; Gonglei (Arei) <arei.gonglei@huawei.com>
>>> Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
>>>
>>> On Mon, Jul 12, 2021 at 09:05:45AM +0800, Longpeng (Mike, Cloud
>>> Infrastructure Service Product Dept.) wrote:
>>>> Let me describe my use case more clearly (just ignore if you're not
>>>> interested in it):
>>>>
>>>> 1. Prog A mmap() 4GB memory (anon or file-mapping), suppose the
>>>> allocated VA range is [0x40000000,0x140000000)
>>>>
>>>> 2. Prog A specifies [0x48000000,0x50000000) and
>>>> [0x80000000,0x100000000) will be shared by its child.
>>>>
>>>> 3. Prog A fork() Prog B and then Prog B exec() a new ELF binary.
>>>>
>>>> 4. Prog B notice the shared ranges (e.g. by input parameters or
>>>> ...)
>>>> and remap them to a continuous VA range.
>>>
>>> This is dangerous.  There must be an active step for Prog B to accept
>>> Prog A's
>>> ranges into its address space.  Otherwise Prog A could almost
>>> completely fill
>>> Prog B's address space and so control where Prog B places its
>>> mappings.  It
>>> could also provoke a latent bug in Prog B if it doesn't handle
>>> address space
>>> exhaustion gracefully.
>>>
>>> I had a proposal to handle this.  Would it meet your requirements?
>>> https://lore.kernel.org/lkml/20200730152250.GG23808@casper.infradead.org/
>>
>> I noticed your proposal of project Sileby and I think it can meet
>> Steven's requirement, but I not sure whether it's suitable for mine
>> because there's no sample code yet, is it in progress ?
> 
> Hi Mike,
> 
> I am working on refining the ideas from project Sileby. I am also
> working on designing the implementation. Since the original concept,
> the mshare API has evolved further. Here is what it loks like:
> 
> The mshare API consists of two system calls - mshare() and
> mshare_unlink()
> 
> mshare
> ======
> 
> int mshare(char *name,void *addr, size_t length, int oflags, mode_t
> mode)
> 
> mshare() creates and opens a new, or opens an existing shared memory
> area that will be shared at PTE level. name refers to shared object
> name that exists under /dev/mshare (this is subject to change. There
> might be better ways to manage the names for mshare'd areas). addr is
> the starting address of this shared memory area and length is the size
> of this area. oflags can be one of:
> 
>      O_RDONLY opens shared memory area for read only access by everyone
>      O_RDWR opens shared memory area for read and write access
>      O_CREAT creates the named shared memory area if it does not exist
>      O_EXCL If O_CREAT was also specified, and a shared memory area
>          exists with that name, return an error.
> 
> mode represents the creation mode for the shared object under
> /dev/mshare.
> 
> Return Value
> ------------
> 
> mshare() returns a file descriptor. A read from this file descriptor
> returns two long values - (1) starting address, and (2) size of the
> shared memory area.
> 
> Notes
> -----
> 
> PTEs are shared at pgdir level and hence it imposes following
> requirements on the address and size given to the mshare():
> 
>      - Starting address must be aligned to pgdir size (512GB on x86_64)
>      - Size must be a multiple of pgdir size
>      - Any mappings created in this address range at any time become
>      shared automatically
>      - Shared address range can have unmapped addresses in it. Any
>      access to unmapped address will result in SIGBUS
> 
> Mappings within this address range behave as if they were shared
> between threads, so a write to a MAP_PRIVATE mapping will create a
> page which is shared between all the sharers. The first process that
> declares an address range mshare'd can continue to map objects in the
> shared area. All other processes that want mshare'd access to this
> memory area can do so by calling mshare(). After this call, the
> address range given by mshare becomes a shared range in its address
> space. Anonymous mappings will be shared and not COWed.

Did I understand correctly that you want to share actual page tables 
between processes and consequently different MMs? That sounds like a 
very bad idea.


-- 
Thanks,

David / dhildenb

