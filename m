Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480C53F28AF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhHTIwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:52:01 -0400
Received: from foss.arm.com ([217.140.110.172]:56676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhHTIv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:51:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B911E1042;
        Fri, 20 Aug 2021 01:51:16 -0700 (PDT)
Received: from [10.163.69.60] (unknown [10.163.69.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 479D03F40C;
        Fri, 20 Aug 2021 01:51:15 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Drop page-def.h
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
References: <1629441331-19530-1-git-send-email-anshuman.khandual@arm.com>
 <20210820083131.GB16784@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4043e66c-c70b-00f8-4c0f-78b62b21a023@arm.com>
Date:   Fri, 20 Aug 2021 14:22:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210820083131.GB16784@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/21 2:01 PM, Will Deacon wrote:
> On Fri, Aug 20, 2021 at 12:05:31PM +0530, Anshuman Khandual wrote:
>> PAGE_SHIFT (PAGE_SIZE and PAGE_MASK) which is derived from ARM64_PAGE_SHIFT
>> should be moved into pgtable-hwdef.h instead, and subsequently page-def.h
>> can be just dropped off completely.
> 
> According to who?
> 
> Every other architecture defines PAGE_SHIFT in page.h, so if you're moving
> things around then that sounds like a better choice.

Sure, will change. That is why I had asked the question :)

> 
> Will
> 
