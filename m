Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C64F33B33E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCONEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhCONET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615813459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfGku487SX3Ych9EefKjkZZfjXH2b15z69xTIvPbz1g=;
        b=ZX8EXTyXB3Zq+ZTCsZ8EInxRLAUEWg589HuPahyhw3cXuRG+Xw5Av2EUk8elfwT5McWwFx
        LJJA5xP0UYTuiTU5uoGQ8A/Ax2c9rI8PXT+mCzEZtyAakUNcKR3AM9sgm/Gh5zD9N5RR9I
        QsJ7YpZL7CLoEPQfDFAcFhWPZ6h2dwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-q6uXcxu_O0y-PY3Q78CgKA-1; Mon, 15 Mar 2021 09:04:15 -0400
X-MC-Unique: q6uXcxu_O0y-PY3Q78CgKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40D191084D95;
        Mon, 15 Mar 2021 13:04:13 +0000 (UTC)
Received: from [10.36.112.200] (ovpn-112-200.ams2.redhat.com [10.36.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A93219701;
        Mon, 15 Mar 2021 13:04:10 +0000 (UTC)
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Liang, Liang (Leo)" <Liang.Liang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        linux-kernel@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
 <YEzCm/Uwvw7kKpd7@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
Date:   Mon, 15 Mar 2021 14:04:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEzCm/Uwvw7kKpd7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.21 14:48, Mike Rapoport wrote:
> Hi,
> 
> On Sat, Mar 13, 2021 at 10:05:23AM +0100, David Hildenbrand wrote:
>>> Am 13.03.2021 um 05:04 schrieb Liang, Liang (Leo) <Liang.Liang@amd.com>:
>>>
>>> Hi David,
>>>
>>> Which benchmark tool you prefer? Memtest86+ or else?
>>
>> Hi Leo,
>>
>> I think you want something that runs under Linux natively.
>>
>> I‘m planning on coding up a kernel module to walk all 4MB pages in the
>> freelists and perform a stream benchmark individually. Then we might be
>> able to identify the problematic range - if there is a problematic range :)
> 
> My wild guess would be that the pages that are now at the head of free
> lists have wrong caching enabled. Might be worth checking in your test
> module.

I hacked something up real quick:

https://github.com/davidhildenbrand/kstream

Only briefly tested inside a VM. The output looks something like

[...]
[ 8396.432225] [0x0000000045800000 - 0x0000000045bfffff] 25322 MB/s / 
38948 MB/s
[ 8396.448749] [0x0000000045c00000 - 0x0000000045ffffff] 24481 MB/s / 
38946 MB/s
[ 8396.465197] [0x0000000046000000 - 0x00000000463fffff] 24892 MB/s / 
39170 MB/s
[ 8396.481552] [0x0000000046400000 - 0x00000000467fffff] 25222 MB/s / 
39156 MB/s
[ 8396.498012] [0x0000000046800000 - 0x0000000046bfffff] 24416 MB/s / 
39159 MB/s
[ 8396.514397] [0x0000000046c00000 - 0x0000000046ffffff] 25469 MB/s / 
38940 MB/s
[ 8396.530849] [0x0000000047000000 - 0x00000000473fffff] 24885 MB/s / 
38734 MB/s
[ 8396.547195] [0x0000000047400000 - 0x00000000477fffff] 25458 MB/s / 
38941 MB/s
[...]

The benchmark allocates one 4 MiB chunk at a time and runs a simplified 
STREAM benchmark a) without flushing caches b) flushing caches before 
every memory access.

It would be great if you could run that with the *old behavior* kernel 
(IOW, without 7fef431be9c9), so we might still be lucky to catch the 
problematic area in the freelist.

Let's see if that will indicate anything.

-- 
Thanks,

David / dhildenb

