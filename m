Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A6379DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEKDcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:32:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2767 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhEKDcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:32:05 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfNf12fRMzmg6f;
        Tue, 11 May 2021 11:27:37 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 11 May
 2021 11:30:52 +0800
Subject: Re: [PATCH 2/2] erofs: update documentation about data compression
To:     Gao Xiang <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>
References: <20210510162506.28637-1-xiang@kernel.org>
 <20210510162506.28637-2-xiang@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <460ee99a-2e1c-df90-c0e9-6a58764bd49f@huawei.com>
Date:   Tue, 11 May 2021 11:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210510162506.28637-2-xiang@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/11 0:25, Gao Xiang wrote:
> Add more description about (NON)HEAD lclusters, and the new big
> pcluster feature.
> 
> Signed-off-by: Gao Xiang <xiang@kernel.org>

Good job!

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
