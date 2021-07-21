Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C13D078F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 06:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhGUDjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 23:39:36 -0400
Received: from foss.arm.com ([217.140.110.172]:44576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbhGUDjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 23:39:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFE24D6E;
        Tue, 20 Jul 2021 21:19:50 -0700 (PDT)
Received: from [10.163.64.235] (unknown [10.163.64.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87A023F66F;
        Tue, 20 Jul 2021 21:19:48 -0700 (PDT)
Subject: Re: [PATCH 01/12] mm/debug_vm_pgtable: Introduce struct
 vm_pgtable_debug
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com,
        chuhu@redhat.com
References: <20210706061748.161258-1-gshan@redhat.com>
 <20210706061748.161258-2-gshan@redhat.com>
 <a74549ac-6794-25a0-7238-2591745e6810@arm.com>
 <65dbdc03-dd34-570c-6beb-7497855b5c8e@redhat.com>
 <1e39cb49-21d8-7114-4ffa-237c6fa19de9@arm.com>
 <fc9eaaf0-cf3d-b4d4-70de-57e14f42f0bd@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e1fea90d-ba81-c5a1-43cd-c4438046c28e@arm.com>
Date:   Wed, 21 Jul 2021 09:50:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fc9eaaf0-cf3d-b4d4-70de-57e14f42f0bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/21 4:37 AM, Gavin Shan wrote:
> Hi Anshuman,
> 
> On 7/20/21 5:02 PM, Anshuman Khandual wrote:
>> On 7/19/21 11:09 AM, Gavin Shan wrote:
>>> On 7/14/21 4:24 PM, Anshuman Khandual wrote:
>>>> On 7/6/21 11:47 AM, Gavin Shan wrote:
>>>
>>> Thanks for your review. I will take all your suggestion if it's applicable.
>>> Otherwise, I will explain as below. All changes will be included in v2,
>>> which will be posted pretty soon.
>>
>> You revised the series couple of times before I could even respond
>> here :) Anyways, I will jump to V3 directly and continue reviewing
>> from there.
>>
> 
> Yep. Sorry for the noises. Please review v3 directly. By the way,
> It seems Andrew start to integrate (v3) series. I personally still

That helps in getting it tested on many other platforms.

> hope v3 (or perhaps v4) is going to be merged in 5.14 cycle :)
> 
> Thanks,
> Gavin
> 
