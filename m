Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5843D43685D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhJUQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:54:21 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:58114 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634835124; x=1666371124;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=C2USpOaQOuMhe1S62pB1CHZMA8ULxI2Wj/wPcLVsRyQ=;
  b=IYxd004DHXCnwlRIXRg6iSDT3hOkVQPAPSp06/FkELim3faYgajAOiLX
   yEUz5LsVQ+QqsVt2izO2EMCJPEuUKHBgKzq2OoIsVuXTK21DZ04zbdyk5
   HTLwTDjdpMdjTXDYo8bkAqo0HGYxPcFhLc8SeVsD7zOfTL1iJCssWbV18
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 09:52:04 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 09:52:03 -0700
Received: from [10.110.35.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Thu, 21 Oct 2021
 09:52:02 -0700
Subject: Re: [PATCH v2 0/2] memblock: exclude MEMBLOCK_NOMAP regions from
 kmemleak
To:     Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20211021070929.23272-1-rppt@kernel.org>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <0599ae1a-e00b-b69c-6ad0-b741ddc291b2@quicinc.com>
Date:   Thu, 21 Oct 2021 12:52:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021070929.23272-1-rppt@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/21 3:09 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> This is take 2 to fix interaction between MEMBLOCK_NOMAP and kmemleak.
> 
> The previous version caused boot failures Qian Cai reported here:
> 
> https://lore.kernel.org/all/c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com
> 
> The failures happened because calling kmemleak_free_part_phys() (or any
> kmemleak phys APIs for that matter) too early means it cannot use __va() on
> arm64.
> 
> This late in the cycle I can only think of reverting kmemleak wavier from
> memblock_mark_nomap() and putting it in the only two callers that set
> MEMBLOCK_NOMAP to an allocated chunk rather than marking NOMAP "unusable"
> memory reported by firmware.
> 
> The first patch here is the revert of v1 and the second patch is actual v2
> implementation.
> 
> Vladimir and Qian, I'd appreciate if you could verify that v2 works for
> you.

FYI, this passed the regression tests here.


> 
> v2:
> * move kmemleak waiver from memblock_mark_nomap() to callers that need it
> * use kmemleak_ignore_phys() rather than kmemleak_free_part_phys() as
>   Catalin suggested.
> 
> v1: https://lore.kernel.org/all/20211013054756.12177-1-rppt@kernel.org
> 
> Mike Rapoport (2):
>   Revert "memblock: exclude NOMAP regions from kmemleak"
>   memblock: exclude MEMBLOCK_NOMAP regions from kmemleak
> 
>  drivers/acpi/tables.c        |  3 +++
>  drivers/of/of_reserved_mem.c |  2 ++
>  mm/memblock.c                | 10 ++++------
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> 
> base-commit: 519d81956ee277b4419c723adfb154603c2565ba
> 
