Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464730D501
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhBCIPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:15:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12386 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhBCIPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:15:45 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DVvZw47QYz7gWf;
        Wed,  3 Feb 2021 16:13:44 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 3 Feb 2021
 16:15:00 +0800
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: rename checkpoint=merge mount option
 to checkpoint_merge
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20210202133829.2671108-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <710cdfc9-74cb-b6b1-2b47-b2a4c34210d3@huawei.com>
Date:   Wed, 3 Feb 2021 16:15:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210202133829.2671108-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/2 21:38, Daeho Jeong wrote:
> From: Daeho Jeong<daehojeong@google.com>
> 
> As checkpoint=merge comes in, mount option setting related to checkpoint
> had been mixed up and it became hard to understand. So, I separated
> this option from "checkpoint=" and made another mount option
> "checkpoint_merge" for this.
> 
> Signed-off-by: Daeho Jeong<daehojeong@google.com>

Looks good to me, IMO, this patch should be merged into original patch.

Thanks,
