Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A531D3321DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCIJWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:22:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13890 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCIJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:22:27 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DvqSp2rtgzkWPM;
        Tue,  9 Mar 2021 17:20:58 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 9 Mar 2021
 17:22:19 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs nodes to get accumulated
 compression info
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20210305022402.2721974-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2f2abc41-24d5-6795-44fe-b770ed8514df@huawei.com>
Date:   Tue, 9 Mar 2021 17:22:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210305022402.2721974-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/5 10:24, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added acc_compr_inodes to show accumulated compressed inode count and
> acc_compr_blocks to show accumulated secured block count with

I noticed that these stat numbers are recorded in extra reserved area in
hot node curseg journal, the journal will be persisted only for umount
or fastboot checkpoint, so the numbers are not so accurate... does this
satisfy your requirement?

> compression in sysfs. These can be re-initialized to "0" by writing "0"
> value in one of both.

Why do we allow reset the stat numbers?

Why not covering all code with macro CONFIG_F2FS_FS_COMPRESSION, since these
numbers are only be updated when we enable compression.

Thanks,
