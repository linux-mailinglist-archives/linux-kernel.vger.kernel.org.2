Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D8034C551
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhC2Hwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:52:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15369 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhC2Hw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:52:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F84W06CXMz9sJc;
        Mon, 29 Mar 2021 15:50:20 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 29 Mar
 2021 15:52:24 +0800
Subject: Re: [PATCH v2 4/4] erofs: add on-disk compression configurations
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20210329012308.28743-1-hsiangkao@aol.com>
 <20210329012308.28743-5-hsiangkao@aol.com>
 <f24bd7dc-54c3-1c19-a461-97ddca778c06@huawei.com>
 <20210329063625.GA3293200@xiangao.remote.csb>
 <3c0bf7e5-0924-3d85-56db-35a2d39dbb8d@huawei.com>
 <20210329065549.GB3281654@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <338b72e9-d4d0-21ab-3643-19d472f3afb4@huawei.com>
Date:   Mon, 29 Mar 2021 15:52:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210329065549.GB3281654@xiangao.remote.csb>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/29 14:55, Gao Xiang wrote:
> I found a reference here,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v5.11#n99
> also vaguely remembered some threads from Linus, but hard to find now :-(

Sure, we can follow this rule for erofs code style. :)

Thanks,
