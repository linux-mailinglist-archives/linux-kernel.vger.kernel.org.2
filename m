Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D1319C76
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhBLKPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:15:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229650AbhBLKPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613124866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2fAtOqtlFprVzhOykuVJGPyK43JZHoiCBMHURJCN5g=;
        b=CaASkZ/ojp+3i0YWC9XfAAavVke80341Oizlx9LXeN1oNIyguxYXQlf4DTcRksMACrGDqJ
        WFtSBw+DhGj2kqWvnC2wHHRI8mZNIk6TFpuWyNX02SdSdjNEG8UBMykoLeTSvCOW0byYy9
        d6At460FoWZn/4ss2uFN4fdC6csIwSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-UgtpkCbdO5-rEgbxQBzfTA-1; Fri, 12 Feb 2021 05:14:23 -0500
X-MC-Unique: UgtpkCbdO5-rEgbxQBzfTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E6141005501;
        Fri, 12 Feb 2021 10:14:22 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A633A100239F;
        Fri, 12 Feb 2021 10:14:20 +0000 (UTC)
To:     Adithya Chandrakasan <adithya.chandrakasan@gmail.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20210211072918.376837-1-adithya.chandrakasan@gmail.com>
 <bce53689-4a6e-c3c3-a09c-6e946a577f61@redhat.com>
 <3512c272-dbec-2c0a-4476-203315341fe2@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: This reply comments on the patch to fixes the missing a blank
 line warning
Message-ID: <35cbe08d-6c29-c904-1402-de18b787c5b0@redhat.com>
Date:   Fri, 12 Feb 2021 11:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <3512c272-dbec-2c0a-4476-203315341fe2@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.21 19:20, Adithya Chandrakasan wrote:
> On 2/11/21 2:36 AM, David Hildenbrand wrote:
>> ^
>>
>> Please create proper patch subjects. Nobody has a glue what you are doing when looking at the subject.
>>
>> "mm/util: fix ??? warning"
>>
>> Which raises the question, what is ???
>>
>> Compiler? static code checker? ... ?
>>



>>
>> Thanks
>>
>> On 11.02.21 08:29, Adithya Chandrakasan wrote:
>>> FILE: mm/util.c:930: WARNING: Missing a blank line after declarations
>>>
>>> Signed-off-by: Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
>>> ---
>>>     mm/util.c | 1 +
>>>     1 file changed, 1 insertion(+)
>>>
>>> diff --git a/mm/util.c b/mm/util.c
>>> index 8c9b7d1e7c49..60286876636d 100644
>>> --- a/mm/util.c
>>> +++ b/mm/util.c
>>> @@ -927,6 +927,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>>>         unsigned int len;
>>>         struct mm_struct *mm = get_task_mm(task);
>>>         unsigned long arg_start, arg_end, env_start, env_end;
>>> +
>>>         if (!mm)
>>>             goto out;
>>>         if (!mm->arg_end)
>>>
>>
>>
> Hi David,
> 
> Thanks for feedback. I have fixed the issues in the patch thread with
> change in subject and also log message.

Hi,

Please always send patches via proper mails and versioned.

E.g.,

rm *.patch
git format-patch -1 -v2
git send-email --to ... *.patch


The introducing patch is from 2014. So I wonder how you even get a 
checkpatch warning?

a90902531a06a ("proc read mm's {arg,env}_{start,end} with mmap semaphore 
taken.")

Anyhow, maybe just call this patch "mm: util.c: minor coding style fix", 
that makes it clearer that this is really minor and has been in the code 
for a while.

Thanks!

-- 
Thanks,

David / dhildenb

