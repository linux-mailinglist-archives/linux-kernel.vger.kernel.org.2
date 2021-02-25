Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E5325480
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhBYRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhBYRZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614273817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uQvQXiSXUcQBP00bQ8yjoMaRgmaZ9xX5MhFh8znqtjI=;
        b=MPWTzdfbhTfR1Y352qLjKwMaRxnAg4TFfLsgph+d6eQV0Pj/2rNn26hR/Tf0EUclxGcUBN
        YsFw/y/3sLxfcapgzZZJ1N4AdsXJw4S1JK6Q9vG1mmgvveAVPE451+R9UixNFzL73egVQt
        iBXOWoZ5sv59kJbWHQEsFK4s0GveZO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-q9qyAeirNUCTGppSnwk_eQ-1; Thu, 25 Feb 2021 12:23:32 -0500
X-MC-Unique: q9qyAeirNUCTGppSnwk_eQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C754179EC0;
        Thu, 25 Feb 2021 17:23:29 +0000 (UTC)
Received: from [10.36.114.58] (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79BED60BE5;
        Thu, 25 Feb 2021 17:23:25 +0000 (UTC)
To:     George Kennedy <george.kennedy@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>
References: <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
 <dcf821e8-768f-1992-e275-2f1ade405025@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
Message-ID: <24e43280-1442-3c4e-aa57-ac84b987aa58@redhat.com>
Date:   Thu, 25 Feb 2021 18:23:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <dcf821e8-768f-1992-e275-2f1ade405025@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.21 17:31, George Kennedy wrote:
> : rsdp_address=bfbfa014
> [    0.066612] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
> [    0.067759] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP
> 00000001      01000013)
> [    0.069470] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP
> 00000001 BXPC 00000001)
> [    0.071183] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT
> 00000001 BXPC 00000001)
> [    0.072876] ACPI: FACS 0x00000000BFBFD000 000040
> [    0.073806] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC
> 00000001 BXPC 00000001)
> [    0.075501] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET
> 00000001 BXPC 00000001)
> [    0.077194] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2
> 00000002      01000013)
> [    0.078880] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP
> 00000000      00000000)


Can you explore the relevant area using the page-flags tools (located in 
Linux src code located in tools/vm/page-flags.c)


./page-types -L -r -a 0xbe490,0xbe4a0

-- 
Thanks,

David / dhildenb

