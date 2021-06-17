Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14FE3ABDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 22:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhFQUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 16:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231241AbhFQUxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 16:53:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBBDD610A1;
        Thu, 17 Jun 2021 20:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623963087;
        bh=0KQKeh6bgDXKLLGwLRbNVUBv4sRzxd+Azd43XYpTEYM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IaZG7YAL+8RHGZTi0zuz/Zmlj3ZP7YPWLhB5WK9WQBV9LW0iC+Dx3ciTxt/GMjqET
         iOvOakqmrtE3K+f5M9V/yp2TQJ2TzcksLWz6Kr6rovbEFSeaQUmMvrBVdw7feYyCcY
         VCZSSQ5SBcSJGvRfOUOZolrSCllyUKTPRno2SMM7zJGM1WDh0h1yYpbpQcsLut3FOu
         cp5ewr9cvYdV4PtQ22wWvTGmPgjNj9rG5EK04Za8zi97zGGu+uiJP9wH8ljxSb6OtU
         /RS9GDyZ7z/loLPdLbN7/6Ve2ebKbXu51paKHQDjz6Xfs7OHYlKi4lupESpw9WMuwb
         07gUt04PDRpMg==
Subject: Re: [PATCH] iommu/vt-d: Fix W=1 clang warning in intel/perf.c
To:     Joerg Roedel <jroedel@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        kernel test robot <lkp@intel.com>
References: <20210617145339.2692-1-joro@8bytes.org>
 <CAKwvOd=8jUsRFKg6+sqq2-DakbRBGR6Z6mR_smuxp+cMEmCHLw@mail.gmail.com>
 <YMuw+LtM/B1QTTJI@suse.de>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <32f14288-315a-b75d-913b-2fc6a16cd748@kernel.org>
Date:   Thu, 17 Jun 2021 13:51:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMuw+LtM/B1QTTJI@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/2021 1:30 PM, Joerg Roedel wrote:
> On Thu, Jun 17, 2021 at 10:16:50AM -0700, Nick Desaulniers wrote:
>> On Thu, Jun 17, 2021 at 7:54 AM Joerg Roedel <joro@8bytes.org> wrote:
>>>
>>> From: Joerg Roedel <jroedel@suse.de>
>>>
>>> Fix this warning when compiled with clang and W=1:
>>>
>>>          drivers/iommu/intel/perf.c:16: warning: Function parameter or member 'latency_lock' not described in 'DEFINE_SPINLOCK'
>>>          drivers/iommu/intel/perf.c:16: warning: expecting prototype for perf.c(). Prototype was for DEFINE_SPINLOCK() instead
>>
>> I think these warnings are actually produced by kernel-doc? (not clang)
> 
> Will kernel-doc check automatically when COMPILER=clang is set and W=1?
> Because I did not explicitly enable any kernel-doc checks.
> 
> Regards,
> 
> 	Joerg
> 

kernel-doc is run automatically with W=1, regardless of gcc versus clang.

Cheers,
Nathan
