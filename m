Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783AB3D0E88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbhGULXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234059AbhGULTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626868769;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8YXS+13F1KNUgpwdBeKvcGRJTj7T9ba6km6u1OzRRA0=;
        b=BAhKX6FooCA+MKxQP1qLtB4uC82aJ8MGNOARVj+cQb88BBO9Bnk3iDFyFdKbm2gZY+svE+
        HyXQRO4+KN+JduOzsitMN83PoBXtyRsVR+5aFDiIYNnSN3HgUtbyxxqc4ntuThrLXsHD/X
        Qek1ofC26RcAjShAtfeWi8emy7jjm3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-MYgXijhtNWSsHeKOifwtdA-1; Wed, 21 Jul 2021 07:59:28 -0400
X-MC-Unique: MYgXijhtNWSsHeKOifwtdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5172C1074671;
        Wed, 21 Jul 2021 11:59:26 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9C755D9FC;
        Wed, 21 Jul 2021 11:59:21 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Qian Cai <cai@lca.pw>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-2-gshan@redhat.com>
 <ab0f9daa-0c49-e74c-e073-6e03a3cabb07@arm.com>
 <280a5740-b5dc-4b78-3a38-67e5adbb0afd@redhat.com>
 <e579e969-e344-8678-ca56-f933000fa7c1@arm.com>
 <23bb5363-fd36-5161-0ba2-da1efc3e3018@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <8f2cac0a-caac-9a0b-3eff-83f120882e48@redhat.com>
Date:   Wed, 21 Jul 2021 21:59:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <23bb5363-fd36-5161-0ba2-da1efc3e3018@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 8:59 PM, Anshuman Khandual wrote:
> On 7/21/21 4:09 PM, Anshuman Khandual wrote:
>> On 7/21/21 3:50 PM, Gavin Shan wrote:
>>> On 7/21/21 3:44 PM, Anshuman Khandual wrote:
>>>> On 7/19/21 6:36 PM, Gavin Shan wrote:
>>>>> In debug_vm_pgtable(), there are many local variables introduced to
>>>>> track the needed information and they are passed to the functions for
>>>>> various test cases. It'd better to introduce a struct as place holder
>>>>> for these information. With it, what the functions for various test
>>>>> cases need is the struct, to simplify the code. It also makes code
>>>>> easier to be maintained.
>>>>>
>>>>> Besides, set_xxx_at() could access the data on the corresponding pages
>>>>> in the page table modifying tests. So the accessed pages in the tests
>>>>> should have been allocated from buddy. Otherwise, we're accessing pages
>>>>> that aren't owned by us. This causes issues like page flag corruption.
>>>>>
>>>>> This introduces "struct pgtable_debug_args". The struct is initialized
>>>>> and destroyed, but the information in the struct isn't used yet. They
>>>>> will be used in subsequent patches.
>>>>>
>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>> ---
>>>>>    mm/debug_vm_pgtable.c | 197 +++++++++++++++++++++++++++++++++++++++++-
>>>>>    1 file changed, 196 insertions(+), 1 deletion(-)
>>>>>
>>> I saw you've finished the review on PATCH[v3 01/12] and PATCH[v3 02/12].
>>> I will wait to integrate your comments to v4 until you finish the review
>>> on all patches in v3 series
>> Yes, please do wait for the complete review and test before going for V4.
>> Also please add the following emails on copy next time, so that we might
>> have some more reviews here. Thank you.
>>
>> + Christophe Leroy <christophe.leroy@csgroup.eu>
>> + Gerald Schaefer <gerald.schaefer@de.ibm.com>
> 
> This one instead.
> 
> Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> 

Sure, It's always nice to have more reviews from the experts. I will
include them when I post v4. Thanks again for your time to review :)

Thanks,
Gavin

