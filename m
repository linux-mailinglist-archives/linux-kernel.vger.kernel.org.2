Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63318394ABF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 08:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhE2GXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 02:23:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2087 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2GXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 02:23:05 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsWXy2tp8zWnyy;
        Sat, 29 May 2021 14:16:50 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 14:21:27 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 14:21:27 +0800
Subject: Re: [PATCH -next] module: fix build error when CONFIG_SMP is disabled
To:     "Sunnanyong (Nanyong Sun, Intelligent Computing Solution Development
        Dep)" <sunnanyong@huawei.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <vincent.chen@sifive.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210529020328.36863-1-cuibixuan@huawei.com>
 <4798a93f-f0a5-60f6-5b02-7d507fe60d4f@huawei.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <f3011e4e-9d7c-39c0-e159-31c6df137875@huawei.com>
Date:   Sat, 29 May 2021 14:21:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4798a93f-f0a5-60f6-5b02-7d507fe60d4f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/29 12:43, Sunnanyong (Nanyong Sun, Intelligent Computing Solution Development Dep) wrote:
> Move the prototype of flush_pmd_tlb_range from pgtable.h to tlbflush.h
> 
> can also fix this problem, and it seems that declare flush_pmd_tlb_range in tlbflush.h
> 
> is better.
> 
> We could
Agree with you.

Thanks
Bixuan Cui
