Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91966345B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCWJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230011AbhCWJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616492449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=088M8b3j5m89GVK9P+jIPgtOdQ+Cx6zwybuJwCbvRt4=;
        b=Dzjq25STuJxN6FJuVKJ6uqKmiNAR5VRung37rRSocO2UhlFlBdgwGsD3oRkpmpnvn8Fqbx
        rZ5ll+5vtRUDWL6p3MWaI6t6JujTLOeBZRHL+r08JIir9v7omgztQ6Ym3TA0mqJDhG7Jzr
        pUsevV9yBHcq03TT3avpIVn4vdtdDXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-zqiZPOvkMqiRdtrS1BNldA-1; Tue, 23 Mar 2021 05:40:45 -0400
X-MC-Unique: zqiZPOvkMqiRdtrS1BNldA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D818D83DD22;
        Tue, 23 Mar 2021 09:40:42 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C20152A335;
        Tue, 23 Mar 2021 09:40:34 +0000 (UTC)
Subject: Re: [PATCH v1 1/3] kernel/resource: make walk_system_ram_res() find
 all busy IORESOURCE_SYSTEM_RAM resources
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e4a088e3-fc26-cb59-8af8-a746932b108c@redhat.com>
Date:   Tue, 23 Mar 2021 10:40:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322160200.19633-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.21 17:01, David Hildenbrand wrote:
> It used to be true that we can have busy system RAM only on the first level
> in the resourc tree. However, this is no longer holds for driver-managed
> system RAM (i.e., added via dax/kmem and virtio-mem), which gets added on
> lower levels.
> 
> We have two users of walk_system_ram_res(), which currently only
> consideres the first level:
> a) kernel/kexec_file.c:kexec_walk_resources() -- We properly skip
>     IORESOURCE_SYSRAM_DRIVER_MANAGED resources via
>     locate_mem_hole_callback(), so even after this change, we won't be
>     placing kexec images onto dax/kmem and virtio-mem added memory. No
>     change.
> b) arch/x86/kernel/crash.c:fill_up_crash_elf_data() -- we're currently
>     not adding relevant ranges to the crash elf info, resulting in them
>     not getting dumped via kdump.
> 
> This change fixes loading a crashkernel via kexec_file_load() and including
> dax/kmem and virtio-mem added System RAM in the crashdump on x86-64. Note
> that e.g,, arm64 relies on memblock data and, therefore, always considers
> all added System RAM already.
> 
> Let's find all busy IORESOURCE_SYSTEM_RAM resources, making the function
> behave like walk_system_ram_range().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Signed-off-by: David Hildenbrand <david@redhat.com>

^ My copy-paste action when creating the cc list slipped in a duplicate 
  SO in all 3 patches. I can resend if desired.

-- 
Thanks,

David / dhildenb

