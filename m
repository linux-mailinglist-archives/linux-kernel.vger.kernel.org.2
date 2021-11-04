Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E69445919
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhKDR7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:59:48 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37746 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229850AbhKDR7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636048629; x=1667584629;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rDfcmeXr06UuyuIkrSpDVVQCX//kJb88o/BxKjLn2GQ=;
  b=vG+RYCi6skA19zO5fPmuxnlGJYUqQjX8xULJxw2iCbDMY4LImycB4fbt
   R6AcOs0PX3bh+IUUC9mioDLinEK4iHZ1AnXKzP4q8b5zNtB1C9mB4w8OB
   z8YuFo+sFbj/6ccwJFB35FDPaRKQfs/FfIQ+7K/04JuLqA8ZEyeJXzuel
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Nov 2021 10:57:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 10:57:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 4 Nov 2021 10:57:06 -0700
Received: from [10.110.50.149] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Thu, 4 Nov 2021
 10:57:04 -0700
Subject: Re: [PATCH] arm64: Track no early_pgtable_alloc() for kmemleak
To:     Mike Rapoport <rppt@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20211104155623.11158-1-quic_qiancai@quicinc.com>
 <YYQTKRrDIJbkcplr@kernel.org>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <9bb6fe11-c10a-a373-9288-d44a5ba976fa@quicinc.com>
Date:   Thu, 4 Nov 2021 13:57:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYQTKRrDIJbkcplr@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/21 1:06 PM, Mike Rapoport wrote:
> I think I'll be better to rename MEMBLOCK_ALLOC_KASAN to, say,
> MEMBLOCK_ALLOC_NOKMEMLEAK and use that for both KASAN and page table cases.

Okay, that would look a bit nicer.

> But more generally, we are going to hit this again and again.
> Couldn't we add a memblock allocation as a mean to get more memory to
> kmemleak::mem_pool_alloc()?

For the last 5 years, this is the second time I am ware of this kind of
issue just because of the 64KB->4KB switch on those servers, although I
agree it could happen again in the future due to some new debugging
features etc. I don't feel a strong need to rewrite it now though. Not
sure if Catalin saw things differently. Anyway, Mike, do you agree that
we could rewrite that separately in the future?
