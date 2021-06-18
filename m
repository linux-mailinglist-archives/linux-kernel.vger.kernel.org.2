Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D5A3ABFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 02:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhFRAJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 20:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhFRAJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 20:09:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD04D6100B;
        Fri, 18 Jun 2021 00:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623974825;
        bh=fT8ghO62wb94wjF8ctHeOg9HOsl4L7WzRtohgUOi5/8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=u+2cCEeGOslzcT3MOai11g8eYsZQVyTkmi68V1F4C5mLvcjJw4ykuETJ2VmcyJ8d0
         b7jT+VUWxMUzYERgR8cODWpemiItXCVso0PP6LPVDo8m3YhiSdv4MPgAAdvcIEG2T+
         GzCdnxyxKIusqCNObPKwZAnArvzamYczQJacYb7KRXAX9ANr9b15PxzV1cxVTo2iIs
         I9R9hcjCKd84To6FaRfWBdkQC5rbt15yPu8IBQ/Ah32IrU4rNTm8QWkXfB01CtBk/9
         xaQr+jrgu6ve5GIylpygghBCTHUGMXtbMj3jhCPlIRG8pVytXSpe5sk8iyDNIJC+ND
         cF2DLkzSkiSYg==
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <f6674f8a-85ef-7a97-b8d8-575a57e47718@kernel.org>
Date:   Thu, 17 Jun 2021 17:07:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 8:21 PM, Andy Lutomirski wrote:
> On arm32, the only way to safely flush icache from usermode is to call
> cacheflush(2).  This also handles any required pipeline flushes, so
> membarrier's SYNC_CORE feature is useless on arm.  Remove it.

After all the discussion, I'm dropping this patch.
