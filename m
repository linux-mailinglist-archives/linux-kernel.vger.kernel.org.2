Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6085345CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhCWL0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231134AbhCWLZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616498745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4th3W1WuDCglHfKhIGbTRrg+iSR4HR4i9tFQs60ItI=;
        b=RKLVriP3MGRTjVCDLz/X+qPXNSPftgjgMfQeHtG3We1JDOZmtchLZjMV4S4VoSiiGUcdBA
        VcD72TUcg/RLBp2JaIQskl+uqOWbWrwdJAWsdz84CLc/JD0Km+mF3VIGLAEzaw+WQ/3SWC
        Wkuv4ZVPctYUZQvCpCDJ0dmoYR8oJkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-U3Yo1Md9M7GloIpZ9fJkiQ-1; Tue, 23 Mar 2021 07:25:41 -0400
X-MC-Unique: U3Yo1Md9M7GloIpZ9fJkiQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB20880006E;
        Tue, 23 Mar 2021 11:25:38 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63509179B3;
        Tue, 23 Mar 2021 11:25:28 +0000 (UTC)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        kexec@lists.infradead.org
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-2-david@redhat.com>
 <YFnLyJF4u5HVXcc2@smile.fi.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v1 1/3] kernel/resource: make walk_system_ram_res() find
 all busy IORESOURCE_SYSTEM_RAM resources
Message-ID: <73a96145-848d-66ea-4d45-fb759003d1de@redhat.com>
Date:   Tue, 23 Mar 2021 12:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFnLyJF4u5HVXcc2@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.21 12:06, Andy Shevchenko wrote:
> On Mon, Mar 22, 2021 at 05:01:58PM +0100, David Hildenbrand wrote:
>> It used to be true that we can have busy system RAM only on the first level
>> in the resourc tree. However, this is no longer holds for driver-managed
>> system RAM (i.e., added via dax/kmem and virtio-mem), which gets added on
>> lower levels.
>>
>> We have two users of walk_system_ram_res(), which currently only
>> consideres the first level:
>> a) kernel/kexec_file.c:kexec_walk_resources() -- We properly skip
>>     IORESOURCE_SYSRAM_DRIVER_MANAGED resources via
>>     locate_mem_hole_callback(), so even after this change, we won't be
>>     placing kexec images onto dax/kmem and virtio-mem added memory. No
>>     change.
>> b) arch/x86/kernel/crash.c:fill_up_crash_elf_data() -- we're currently
>>     not adding relevant ranges to the crash elf info, resulting in them
>>     not getting dumped via kdump.
>>
>> This change fixes loading a crashkernel via kexec_file_load() and including
> 
> "...fixes..." effectively means to me that Fixes tag should be provided.

We can certainly add, although it doesn't really affect the running 
kernel, but only crashdumps taken in the kdump kernel:

Fixes: ebf71552bb0e ("virtio-mem: Add parent resource for all added 
"System RAM"")
Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use 
like normal RAM")

Thanks

-- 
Thanks,

David / dhildenb

