Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B6C419540
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhI0Nmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232185AbhI0Nmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:42:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E2C060230;
        Mon, 27 Sep 2021 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750060;
        bh=ImMT0WL2AytIKMoXvqRDsxJTl0zeXAJpCA6dndQsQ5U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nt+Lbz7zcy1PzhgbxQGKI3JLwKxO4+YMLmYBDx7PvV7WSfn3dw8xwuAaYu3M6SRyC
         pUKZNLLDBqceYJ/2jRtUtFFARE4uljBEn8AT3/QoO19fmhSkCKFZysy2sV4UwD77Sn
         aIyPulxmrdGmpMNtspOPVVWYw1aVJKJjiRcyJqucL+mO8cvnhbRVxIxf6XoqFAgcay
         +5DgVUr9hA6PeLhvj9VHtZzTDnSsKagipo5leW8G1TCfY6shk3nTrH8f0K0wjUjk8i
         TPUNZQ0fL5oXQ56YXBxPJhl06YGvxQy250x5vq4l7E4DjMwqfo+BhKtPEwT0i+TKO7
         osd3yJ/xlBwWw==
Subject: Re: [PATCH] NIOS2: setup.c: drop unused variable 'dram_start'
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Andreas Oetken <andreas.oetken@siemens.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210924210525.7053-1-rdunlap@infradead.org>
 <YVAFRdc/DWN0scc7@linux.ibm.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <3b71b1b4-fe58-6e55-2b1e-172dc391e9db@kernel.org>
Date:   Mon, 27 Sep 2021 08:40:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVAFRdc/DWN0scc7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/21 12:29 AM, Mike Rapoport wrote:
> On Fri, Sep 24, 2021 at 02:05:25PM -0700, Randy Dunlap wrote:
>> This is a nuisance when CONFIG_WERROR is set, so drop the variable
>> declaration since the code that used it was removed.
>>
>> ../arch/nios2/kernel/setup.c: In function 'setup_arch':
>> ../arch/nios2/kernel/setup.c:152:13: warning: unused variable 'dram_start' [-Wunused-variable]
>>    152 |         int dram_start;
>>
>> Fixes: 7f7bc20bc41a ("nios2: Don't use _end for calculating min_low_pfn")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>> Cc: Andreas Oetken <andreas.oetken@siemens.com>
>> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 

Applied!

Thanks,
Dinh
