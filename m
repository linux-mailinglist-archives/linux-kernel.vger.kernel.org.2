Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2053638FABE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhEYGTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:19:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5695 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhEYGTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:19:06 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fq3hM1jM5z1BQrK;
        Tue, 25 May 2021 14:14:43 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 14:17:34 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 25 May 2021 14:17:33 +0800
Subject: Re: [PATCH -next] xen/pcpu: Use DEVICE_ATTR_RW macro
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
References: <20210523070214.34948-1-yuehaibing@huawei.com>
 <c27b37e3-7d4b-1ed1-2b8c-1fbde6e30c3b@oracle.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <e2f4309d-e53a-1511-a732-9cf5c5217d55@huawei.com>
Date:   Tue, 25 May 2021 14:17:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <c27b37e3-7d4b-1ed1-2b8c-1fbde6e30c3b@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/24 20:48, Boris Ostrovsky wrote:
> 
> On 5/23/21 3:02 AM, YueHaibing wrote:
>> Use DEVICE_ATTR_RW helper instead of plain DEVICE_ATTR,
>> which makes the code a bit shorter and easier to read.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> 
> Do you think you can also make similar change in drivers/xen/xen-balloon.c and drivers/xen/xenbus/xenbus_probe.c?
> 
Sure, will do that in v2.
> 
> 
> Thanks.
> 
> -boris
> 
> .
> 
