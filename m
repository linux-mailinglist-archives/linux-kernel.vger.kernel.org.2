Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE1309761
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 18:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhA3Rni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 12:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhA3Rne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 12:43:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA58C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3aFRxX0fz2ePxoZOLeQ4qI/y3ZqjEwqLpDY+N2WR944=; b=Enjcl+HnCIQXEPaqA8N62o3me+
        /f9Fw8fcDvM66qqQ39P0x6EAMp4Lh9+7GcM0fRxmjFkgcg7p25JNy9pa6hF2DqvqQkXgpC/t2pRDC
        IC20snTmAKCL+ZUC5wR3knjWB3ksfD5snntOJwcunwu3CJ3773HjhOGR2zcWFR7McrmbI1bEg9LAV
        wiQB3/9BM07e0QsSdcL7JwG95qCIQYev6ugthkZ3qyPK7x8g6dXH7qZxPmQiiwrwL3VJkiENsfSAz
        hcAiF2YAxGTyqP1X2U2LoZaDt+yYKV7AJ2GzFRZ/g3SEH3+7EyDFYXowO19pfoeW63fpbFEfdqIgM
        HW8Cbo/A==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5uGm-00077M-Tf; Sat, 30 Jan 2021 17:42:49 +0000
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix compile error
 [-Werror=implicit-function-declaration]
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210130151907.3929148-1-baolu.lu@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <84803c36-c29c-09a2-8731-af85ffdf26aa@infradead.org>
Date:   Sat, 30 Jan 2021 09:42:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210130151907.3929148-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 7:19 AM, Lu Baolu wrote:
> trace_qi_submit() could be used when interrupt remapping is supported,
> but DMA remapping is not. In this case, the following compile error
> occurs.
> 
> ../drivers/iommu/intel/dmar.c: In function 'qi_submit_sync':
> ../drivers/iommu/intel/dmar.c:1311:3: error: implicit declaration of function 'trace_qi_submit';
>   did you mean 'ftrace_nmi_exit'? [-Werror=implicit-function-declaration]
>    trace_qi_submit(iommu, desc[i].qw0, desc[i].qw1,
>    ^~~~~~~~~~~~~~~
>    ftrace_nmi_exit
> 
> Fixes: f2dd871799ba5 ("iommu/vt-d: Add qi_submit trace event")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/Makefile       | 2 +-
>  drivers/iommu/intel/iommu.c        | 1 -
>  include/trace/events/intel_iommu.h | 2 --
>  3 files changed, 1 insertion(+), 4 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

-- 
~Randy

