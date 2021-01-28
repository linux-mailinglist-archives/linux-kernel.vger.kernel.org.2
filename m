Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF3306B40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhA1Cuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:50:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12037 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhA1Cuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:50:50 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DR4fV0jsKzMR49;
        Thu, 28 Jan 2021 10:48:34 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 28 Jan
 2021 10:50:05 +0800
Subject: Re: [f2fs-dev] [PATCH v3 1/5] f2fs: compress: add compress_inode to
 cache compressed blocks
From:   Chao Yu <yuchao0@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <X/0DxG+AcX54730W@google.com>
 <160f2cf9-73ca-18cd-6ad0-2498821b8db6@huawei.com>
 <X/4kYf11oyoMY8P+@google.com>
 <abc09f9f-561d-df8a-b835-6b5d7a15232c@huawei.com>
 <X/8UtJU9Dy30kC7I@google.com>
 <37ba41db-2589-e155-c416-d0c8832026cb@huawei.com>
 <X//DPI10+ZXvHkYH@google.com>
 <8e88b1e2-0176-9487-b925-9c7a31a7e5cd@huawei.com>
 <YAGt0i244dWXym4H@google.com>
 <20a1dbd3-808e-e62a-53f3-7f1e2a316b3c@kernel.org>
 <YAdSTzYF8Hvxdcqy@google.com>
 <068da0d3-18c9-53f7-0f24-63b07e1af272@huawei.com>
Message-ID: <9b982458-57e1-a04d-c5d4-f5ca775af1e7@huawei.com>
Date:   Thu, 28 Jan 2021 10:50:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <068da0d3-18c9-53f7-0f24-63b07e1af272@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/22 10:17, Chao Yu wrote:
>> No, it seems this is not the case.
> Oops, could you please help to remove all below codes and do the test again
> to check whether they are the buggy codes? as I doubt there is use-after-free
> bug.

Any test result? :)

Thanks,
