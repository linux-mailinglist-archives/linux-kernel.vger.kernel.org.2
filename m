Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4DE346EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhCXBY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:24:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14132 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbhCXBYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:24:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4r7n5sxxz19HqG;
        Wed, 24 Mar 2021 09:22:29 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 24 Mar
 2021 09:24:21 +0800
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: fix wrong comment of nat_tree_lock
To:     qiulaibin <qiulaibin@huawei.com>, <jaegeuk@kernel.org>
CC:     <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20210323114130.2288596-1-qiulaibin@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a73ac76e-330b-f062-942a-ee7aa8d63ad4@huawei.com>
Date:   Wed, 24 Mar 2021 09:24:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210323114130.2288596-1-qiulaibin@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/23 19:41, qiulaibin wrote:
> Do trivial comment fix of nat_tree_lock.
> 
> Signed-off-by: qiulaibin <qiulaibin@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
