Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA5446069
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhKEIHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:07:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:22490 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhKEIHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:07:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="219057965"
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="scan'208";a="219057965"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 01:04:30 -0700
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; 
   d="scan'208";a="490253444"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.18]) ([10.254.213.18])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 01:04:28 -0700
Message-ID: <716e2940-a426-60d7-e4a7-9ff6187a6af8@linux.intel.com>
Date:   Fri, 5 Nov 2021 16:04:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <YYPrNkweZahTdAbA@8bytes.org>
 <CAHk-=whX_ygSHr02mhWXO38kddFE_t7ntBHf_sehz=asFfzFKA@mail.gmail.com>
 <YYTezKfKDCTiDcij@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [git pull] IOMMU Updates for Linux v5.16
In-Reply-To: <YYTezKfKDCTiDcij@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/5 15:35, Joerg Roedel wrote:
> On Thu, Nov 04, 2021 at 11:10:53AM -0700, Linus Torvalds wrote:
>> That too seems to be stale and unused since commit 9bfecd058339
>> ("x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove
>> update_pasid()")
>>
>> I left it alone because I didn't want to do any extra development in
>> the merge commit itself, but it looks to me like there's some room for
>> more cleanips. No?
> 
> Yes, looks like this define is unused now. I talk to Baolu whether this
> can be cleaned up too, Baolu?

Yes.

PASID_DISABLED is unused after

commit 9bfecd058339 ("x86/cpufeatures: Force disable X86_FEATURE_ENQCMD
and remove update_pasid()").

and

commit 00ecd5401349a ("iommu/vt-d: Clean up unused PASID updating
functions")

Best regards,
baolu
