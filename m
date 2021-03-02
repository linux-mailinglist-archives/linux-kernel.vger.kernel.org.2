Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8844032A3B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382514AbhCBJ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:26:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378917AbhCBJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614675898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKR5m0U4Kyxf0YAKbBROA6h6lzGB5mUnbgoPuKmwmCE=;
        b=H77eztOwAPapHBfK9Nup6cmGWflYz0Xl9h+EFPdKh5ZP6Atls9kNgUbDXTRRL575somxfD
        yY6rYlEwhqR54ETGZF9AP9qKD0tfFhsAyUpOv5Y1zocVUE6sBBeGtNQOJilBp8m84W62Tm
        eKqwxo6zQHOQtJilPNEAhi2/Er1qD2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-DqEAEwDGNXOLgLHqx4u4gA-1; Tue, 02 Mar 2021 04:04:54 -0500
X-MC-Unique: DqEAEwDGNXOLgLHqx4u4gA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A22750743;
        Tue,  2 Mar 2021 09:04:52 +0000 (UTC)
Received: from [10.36.114.189] (ovpn-114-189.ams2.redhat.com [10.36.114.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF1D457;
        Tue,  2 Mar 2021 09:04:48 +0000 (UTC)
Subject: Re: [PATCH v1] microblaze: tag highmem_setup() with __meminit
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ira Weiny <ira.weiny@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210301114749.47914-1-david@redhat.com>
 <20210301221846.GA4744@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b38b353b-7138-373b-057a-a4fa4b4ab30e@redhat.com>
Date:   Tue, 2 Mar 2021 10:04:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210301221846.GA4744@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.21 23:18, Oscar Salvador wrote:
> On Mon, Mar 01, 2021 at 12:47:49PM +0100, David Hildenbrand wrote:
>> With commit a0cd7a7c4bc0 ("mm: simplify free_highmem_page() and
>> free_reserved_page()") the kernel test robot complains about a warning:
>>
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x23ac): Section mismatch in
>>    reference from the function highmem_setup() to the function
>>    .meminit.text:memblock_is_reserved()
>>
>> This has been broken ever since microblaze added highmem support,
>> because memblock_is_reserved() was already tagged with "__init" back then -
>> most probably the function always got inlined, so we never stumbled over
>> it.
> 
> It might be good to point out that we need __meminit instead of __init
> because microblaze platform does not define CONFIG_ARCH_KEEP_MEMBLOCK,
> and __init_memblock fallsback to that.
> 
> (I had to go and look as I was puzzled :-) )
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks!

Whoever feels like picking this up (@Andrew?) can you add

"We need __meminit because __init_memblock defaults to that without 
CONFIG_ARCH_KEEP_MEMBLOCK" and __init_memblock is not used outside 
memblock code.

-- 
Thanks,

David / dhildenb

