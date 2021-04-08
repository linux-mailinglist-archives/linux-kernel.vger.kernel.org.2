Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9481358C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhDHST4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231676AbhDHSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617905982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9R3LUNaapjZXbF7Q+/1FJfCvFZMoJkLxAm5tknjLmdc=;
        b=hD9uoLYfpr4W0u1VYhnViY3Asdya/JF8O1fH4zgHY/ksD2Ac8LDJZC8droKk74WCRyDMae
        fhyKrr8Z+IW3cVuYWZgiUSWFR2AdQNFQdHnTFFYUZtH6Ei18digGPWVwX8Jljmh3ZksAXn
        iar4lsiouGeuRUI2yaxtxL6jIJ3qVJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-tWNt4AkkN42UaNq7YJOckw-1; Thu, 08 Apr 2021 14:19:38 -0400
X-MC-Unique: tWNt4AkkN42UaNq7YJOckw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A726E801814;
        Thu,  8 Apr 2021 18:19:36 +0000 (UTC)
Received: from [10.36.113.26] (ovpn-113-26.ams2.redhat.com [10.36.113.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1255610013D7;
        Thu,  8 Apr 2021 18:19:33 +0000 (UTC)
Subject: Re: [PATCH v7 7/8] x86/Kconfig: Introduce
 ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
To:     Christoph Hellwig <hch@infradead.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210408121804.10440-1-osalvador@suse.de>
 <20210408121804.10440-8-osalvador@suse.de>
 <20210408133651.GA3875084@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f39d3121-1714-e8f2-2a33-808083f4848b@redhat.com>
Date:   Thu, 8 Apr 2021 20:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210408133651.GA3875084@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.21 15:36, Christoph Hellwig wrote:
> On Thu, Apr 08, 2021 at 02:18:03PM +0200, Oscar Salvador wrote:
>> Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.
>> +config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>> +	def_bool y
> 
> This needs to go into a common file, with the architectures just
> selecting the symbol.
> 

I'd like to point out that we have plenty of counter examples. Meaning: 
it's really hard to figure out what the correct way is. Unfortunately, 
the correct way also doesn't seem to be documented :(

-- 
Thanks,

David / dhildenb

