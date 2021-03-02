Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E718E32A22D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836745AbhCBHUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:20:35 -0500
Received: from foss.arm.com ([217.140.110.172]:45276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245093AbhCBGj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:39:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC47531B;
        Mon,  1 Mar 2021 22:37:16 -0800 (PST)
Received: from [10.163.67.84] (unknown [10.163.67.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 173343F73B;
        Mon,  1 Mar 2021 22:37:13 -0800 (PST)
Subject: Re: [PATCH V2] mm: Generalize HUGETLB_PAGE_SIZE_VARIABLE
To:     Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
References: <1614661987-23881-1-git-send-email-anshuman.khandual@arm.com>
 <a3772544-1e84-1969-b71c-ea2a3d013471@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c33fe839-82c6-d0cd-32d6-b386d143ac51@arm.com>
Date:   Tue, 2 Mar 2021 12:07:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a3772544-1e84-1969-b71c-ea2a3d013471@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/21 11:13 AM, Christophe Leroy wrote:
> 
> 
> Le 02/03/2021 à 06:13, Anshuman Khandual a écrit :
>> HUGETLB_PAGE_SIZE_VARIABLE need not be defined for each individual
>> platform subscribing it. Instead just make it generic.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: linux-ia64@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This change was originally suggested in an earilier discussion. This
>> applies on v5.12-rc1 and has been build tested on all applicable
>> platforms i.e ia64 and powerpc.
>>
>> https://patchwork.kernel.org/project/linux-mm/patch/1613024531-19040-3-git-send-email-anshuman.khandual@arm.com/
>>
>> Changes in V2:
>>
>> - Added a description for HUGETLB_PAGE_SIZE_VARIABLE
> 
> You are doing more than adding a description: you are making it user selectable. Is that what you want ?

No, this was unintended. Will drop that description.
