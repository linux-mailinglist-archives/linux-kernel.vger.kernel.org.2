Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6E1345CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCWL1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230165AbhCWL0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616498804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CO7ddAXo7AW4IVD6z1X02gzoos7uqwcpTrAx3rTQHIE=;
        b=epEGqrD0PF+latJWr2eb/YLYO92AXpYuQe7JrelI30uRRiQ4nTY7OJQBQ5HJDU297Nw/9s
        sXg9R1m542AUbdE83u6S9kIKdbvzBfa0FgLYXSwpWtGi62PqOTp/9XTHnyFKJJqeYYrq8Q
        EEiA8OXldWoukTZxzxTALZL6rLD/sfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-bLs84uwNPVaNMEF3YIU1AQ-1; Tue, 23 Mar 2021 07:26:40 -0400
X-MC-Unique: bLs84uwNPVaNMEF3YIU1AQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EC6110082E0;
        Tue, 23 Mar 2021 11:26:37 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD45F19744;
        Tue, 23 Mar 2021 11:26:28 +0000 (UTC)
Subject: Re: [PATCH v1 2/3] kernel/resource: make walk_mem_res() find all busy
 IORESOURCE_MEM resources
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
 <20210322160200.19633-3-david@redhat.com>
 <YFnMOK6VuIBsoKWr@smile.fi.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <16bfac8e-cee1-c8ce-14f1-70e697e4f2f1@redhat.com>
Date:   Tue, 23 Mar 2021 12:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFnMOK6VuIBsoKWr@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.21 12:08, Andy Shevchenko wrote:
> On Mon, Mar 22, 2021 at 05:01:59PM +0100, David Hildenbrand wrote:
>> It used to be true that we can have system RAM only on the first level
>> in the resourc tree. However, this is no longer holds for driver-managed
>> system RAM (i.e., dax/kmem and virtio-mem).
>>
>> The function walk_mem_res() only consideres the first level and is
>> used in arch/x86/mm/ioremap.c:__ioremap_check_mem() only. We currently
>> fail to identify System RAM added by dax/kmem and virtio-mem as
>> "IORES_MAP_SYSTEM_RAM", for example, allowing for remapping of such
>> "normal RAM" in __ioremap_caller().
> 
> Here I dunno, but consider to add Fixes tag if it fixes known bad behaviour.

Haven't observed it in the wild. We can add the same fixes tags as to 
patch #1.

-- 
Thanks,

David / dhildenb

