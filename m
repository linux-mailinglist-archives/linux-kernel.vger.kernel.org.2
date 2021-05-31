Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE7395437
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 05:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhEaDgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 23:36:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2796 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaDgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 23:36:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ftgl9125KzWq6W;
        Mon, 31 May 2021 11:29:41 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 11:34:21 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 11:34:20 +0800
Subject: Re: [PATCH -next] mm/mmap_lock: fix warning when CONFIG_TRACING is
 not defined
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210531015527.49785-1-cuibixuan@huawei.com>
 <YLRDtBCPAYajOSqa@casper.infradead.org>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <ae21b203-0f31-7535-ef1b-9c5edd06fbc8@huawei.com>
Date:   Mon, 31 May 2021 11:34:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YLRDtBCPAYajOSqa@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/31 10:02, Matthew Wilcox wrote:
>> Fix the warning: [-Wunused-function]
>> mm/mmap_lock.c:157:20: warning: ‘get_mm_memcg_path’ defined but not used
>>  static const char *get_mm_memcg_path(struct mm_struct *mm)
>>                     ^~~~~~~~~~~~~~~~~
> That seems like the wrong way to fix the warning.  Why not put it
> under an appropriate ifdef?
It's better than me, I will send a new patch.

Thanks
Bixuan Cui

> 
