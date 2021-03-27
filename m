Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE9734B5AD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhC0Jdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 05:33:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14166 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhC0JdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 05:33:08 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6tqX0x1DznZZF;
        Sat, 27 Mar 2021 17:30:32 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sat, 27 Mar
 2021 17:33:01 +0800
Subject: Re: [PATCH 1/4] erofs: introduce erofs_sb_has_xxx() helpers
To:     Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
References: <20210327034936.12537-1-hsiangkao@aol.com>
 <20210327034936.12537-2-hsiangkao@aol.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2f92af1c-9a7c-3870-2b15-c275cfe948ba@huawei.com>
Date:   Sat, 27 Mar 2021 17:33:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210327034936.12537-2-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/27 11:49, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> Introduce erofs_sb_has_xxx() to make long checks short, especially
> for later big pcluster & LZMA features.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
