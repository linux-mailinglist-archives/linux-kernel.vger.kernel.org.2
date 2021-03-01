Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF5F3278D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhCAIBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:01:45 -0500
Received: from foss.arm.com ([217.140.110.172]:52324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232620AbhCAIBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:01:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1E031063;
        Mon,  1 Mar 2021 00:00:36 -0800 (PST)
Received: from [10.163.67.14] (unknown [10.163.67.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17F0A3F70D;
        Mon,  1 Mar 2021 00:00:33 -0800 (PST)
Subject: Re: [PATCH] mm: Generalize HUGETLB_PAGE_SIZE_VARIABLE
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mm@kvack.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <1614577853-7452-1-git-send-email-anshuman.khandual@arm.com>
 <20210301062358.GA25761@lst.de>
 <89f2d77c-f4bc-8f7b-a6b0-1c04e422fb77@arm.com>
 <20210301075352.GA27659@lst.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d5fc741d-0c24-5b0f-c9b3-3a2be796ad79@arm.com>
Date:   Mon, 1 Mar 2021 13:31:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301075352.GA27659@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/21 1:23 PM, Christoph Hellwig wrote:
> On Mon, Mar 01, 2021 at 01:13:41PM +0530, Anshuman Khandual wrote:
>>> doesn't this need a 'if HUGETLB_PAGE'
>>
>> While making HUGETLB_PAGE_SIZE_VARIABLE a generic option, also made it
>> dependent on HUGETLB_PAGE. Should not that gate HUGETLB_PAGE_SIZE_VARIABLE
>> when HUGETLB_PAGE is not available irrespective of the select statement on
>> the platforms ?
> 
> depends doesn't properly work for variables that are selected.
> 

Alright, will move the HUGETLB_PAGE dependency to platforms while selecting
the variable HUGETLB_PAGE_SIZE_VARIABLE.
