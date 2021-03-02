Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8220A32A25C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376725AbhCBHvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:51:01 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:21661 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1836807AbhCBHVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:21:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DqStN5Y6wz9ty3x;
        Tue,  2 Mar 2021 08:09:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZDu3KoTvWhhv; Tue,  2 Mar 2021 08:09:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DqStN44CRz9ty3w;
        Tue,  2 Mar 2021 08:09:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7576B8B7AC;
        Tue,  2 Mar 2021 08:09:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id V6-wUwb-6uGj; Tue,  2 Mar 2021 08:09:33 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BFF088B75F;
        Tue,  2 Mar 2021 08:09:32 +0100 (CET)
Subject: Re: [PATCH V2] mm: Generalize HUGETLB_PAGE_SIZE_VARIABLE
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
References: <1614661987-23881-1-git-send-email-anshuman.khandual@arm.com>
 <a3772544-1e84-1969-b71c-ea2a3d013471@csgroup.eu>
 <c33fe839-82c6-d0cd-32d6-b386d143ac51@arm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4452b859-9e72-974c-95b3-9c70c54472d1@csgroup.eu>
Date:   Tue, 2 Mar 2021 08:09:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <c33fe839-82c6-d0cd-32d6-b386d143ac51@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/03/2021 à 07:37, Anshuman Khandual a écrit :
> 
> 
> On 3/2/21 11:13 AM, Christophe Leroy wrote:
>>
>>
>> Le 02/03/2021 à 06:13, Anshuman Khandual a écrit :
>>> HUGETLB_PAGE_SIZE_VARIABLE need not be defined for each individual
>>> platform subscribing it. Instead just make it generic.
>>>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: linux-ia64@vger.kernel.org
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Suggested-by: Christoph Hellwig <hch@lst.de>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This change was originally suggested in an earilier discussion. This
>>> applies on v5.12-rc1 and has been build tested on all applicable
>>> platforms i.e ia64 and powerpc.
>>>
>>> https://patchwork.kernel.org/project/linux-mm/patch/1613024531-19040-3-git-send-email-anshuman.khandual@arm.com/
>>>
>>> Changes in V2:
>>>
>>> - Added a description for HUGETLB_PAGE_SIZE_VARIABLE
>>
>> You are doing more than adding a description: you are making it user selectable. Is that what you want ?
> 
> No, this was unintended. Will drop that description.
> 

The description in the help section is OK.

It is only the text after the "bool" that makes it selectable.

	bool "Allows dynamic pageblock_order"

