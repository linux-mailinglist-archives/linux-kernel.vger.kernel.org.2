Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF10B34775B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhCXL2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232545AbhCXL2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616585318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oEtMbE1m2IC72jJ8v6aeU/OBewRFspn2AuP8ScrD10I=;
        b=XDMPt2nHqz6XJwEcJMmMRgigRo6sHCeynSGi0RwIdu3UcQiM6z58BjyIFiww7IMn/iszbQ
        SSiI80s8pOZaF5w0weN2oNfN/OvBU2ytv1zPpJHDja/Uuer5koyOG1hsCZZfFy1u+dMM81
        6A44S2N9JwMCh0b6y4ScLkpvcuMSsGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-EBTSN4fnMNW2hktyP4UpDA-1; Wed, 24 Mar 2021 07:28:34 -0400
X-MC-Unique: EBTSN4fnMNW2hktyP4UpDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA8AF1005584;
        Wed, 24 Mar 2021 11:28:31 +0000 (UTC)
Received: from [10.36.115.66] (ovpn-115-66.ams2.redhat.com [10.36.115.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA4A15D9D0;
        Wed, 24 Mar 2021 11:28:22 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        kexec@lists.infradead.org
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-2-david@redhat.com> <20210324111835.GA18855@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v1 1/3] kernel/resource: make walk_system_ram_res() find
 all busy IORESOURCE_SYSTEM_RAM resources
Message-ID: <8aa6af09-6f8b-1f50-820f-90eab0993f1c@redhat.com>
Date:   Wed, 24 Mar 2021 12:28:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324111835.GA18855@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.21 12:18, Oscar Salvador wrote:
> On Mon, Mar 22, 2021 at 05:01:58PM +0100, David Hildenbrand wrote:
>> It used to be true that we can have busy system RAM only on the first level
>> in the resourc tree. However, this is no longer holds for driver-managed
>> system RAM (i.e., added via dax/kmem and virtio-mem), which gets added on
>> lower levels.
> 
> Let me ask some rookie questions:
> 
> What does "busy" term stand for here?

IORESOURCE_BUSY - here: actually added, not just some reserved range / container.


> Why resources coming from virtio-mem are added at a lower levels?

Some information can be had from ebf71552bb0e690cad523ad175e8c4c89a33c333

commit ebf71552bb0e690cad523ad175e8c4c89a33c333
Author: David Hildenbrand <david@redhat.com>
Date:   Thu May 7 16:01:35 2020 +0200

     virtio-mem: Add parent resource for all added "System RAM"
     
     Let's add a parent resource, named after the virtio device (inspired by
     drivers/dax/kmem.c). This allows user space to identify which memory
     belongs to which virtio-mem device.
     
     With this change and two virtio-mem devices:
             :/# cat /proc/iomem
             00000000-00000fff : Reserved
             00001000-0009fbff : System RAM
             [...]
             140000000-333ffffff : virtio0
               140000000-147ffffff : System RAM
               148000000-14fffffff : System RAM
               150000000-157ffffff : System RAM
             [...]
             334000000-3033ffffff : virtio1
               338000000-33fffffff : System RAM
               340000000-347ffffff : System RAM
               348000000-34fffffff : System RAM
             [...]



For dax/kmem it comes naturally due to the "Persistent Memory" and
device parent resources like:

             140000000-33fffffff : Persistent Memory
               140000000-1481fffff : namespace0.0
               150000000-33fffffff : dax0.0
                 150000000-33fffffff : System RAM (kmem)
             3280000000-32ffffffff : PCI Bus 0000:00


Thanks

-- 
Thanks,

David / dhildenb

