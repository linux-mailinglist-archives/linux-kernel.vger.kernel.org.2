Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57835FC44
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 22:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347764AbhDNUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 16:05:04 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.216]:45015 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233425AbhDNUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 16:04:58 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 091F2D738BB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 15:04:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id WlkJl9FAGL7DmWlkJlM7Ba; Wed, 14 Apr 2021 15:04:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I55bdEFQX4moo7BAVIRls7hGJWpEXoU8cYRMSjJc/ns=; b=SpJOcVLYwguf8IF31YAypIuX5M
        zt7P8mqVXdcqQ7CdS4VxwIPQIdU1El+WOZH/z4clqIC0tra3ff7o1vX9915F8qeX4CphNwuzJOAxl
        CCYzMEEaQnxbZhYvimw8ZGh4O9MQ9xDRdM2DzkIRNSnAwX3dOV1akmqN9ITjTk56o2VlgwQt0A6KX
        f/6qimDjq+bQ5JmmJmW4ztGacvkxNy0vnsmc658IIncahYUXeV+XabjEJD0DaKUeeatjdJQ8dP2UW
        MeR+MIQDyHp0pb5fR4ucU1WVKhnuE2g5Eop6sp7cYV2ex6Q+hSVo9UCGcK3R7ywECgPqh+DcjtWZ1
        zF8JXocw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:60882 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lWlkG-000GGN-IV; Wed, 14 Apr 2021 15:04:16 -0500
Subject: Re: [PATCH][next] iommu/vt-d: Fix out-bounds-warning in
 intel_svm_page_response()
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210413195409.GA322376@embeddedor>
 <61b37f83-eb9e-cf81-c5e6-ca322f76f490@linux.intel.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <4ffdd120-d46d-f44e-ba66-000e95fc9b1a@embeddedor.com>
Date:   Wed, 14 Apr 2021 15:04:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <61b37f83-eb9e-cf81-c5e6-ca322f76f490@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lWlkG-000GGN-IV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:60882
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balou,

On 4/14/21 00:24, Lu Baolu wrote:
> Hi Gustavo,
> 
> On 4/14/21 3:54 AM, Gustavo A. R. Silva wrote:
>> Replace call to memcpy() with just a couple of simple assignments in
>> order to fix the following out-of-bounds warning:
>>
>> drivers/iommu/intel/svm.c:1198:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type
>> 'long long unsigned int' at offset 16 [-Warray-bounds]
>>
>> The problem is that the original code is trying to copy data into a
>> couple of struct members adjacent to each other in a single call to
>> memcpy(). This causes a legitimate compiler warning because memcpy()
>> overruns the length of &desc.qw2.
>>
>> This helps with the ongoing efforts to globally enable -Warray-bounds
>> and get us closer to being able to tighten the FORTIFY_SOURCE routines
>> on memcpy().
>>
>> Link: https://github.com/KSPP/linux/issues/109
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/iommu/intel/svm.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index 5165cea90421..65909f504c50 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -1194,9 +1194,10 @@ int intel_svm_page_response(struct device *dev,
>>           desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
>>           desc.qw2 = 0;
>>           desc.qw3 = 0;
>> -        if (private_present)
>> -            memcpy(&desc.qw2, prm->private_data,
>> -                   sizeof(prm->private_data));
> 
> The same memcpy() is used in multiple places in this file. Did they
> compile the same warnings? Or there are multiple patches to fix them
> one by one?

I just see one more instance of this same case:

1023                         if (req->priv_data_present)
1024                                 memcpy(&resp.qw2, req->priv_data,
1025                                        sizeof(req->priv_data));

I missed it and I'll address it in v2. Do you see another one?

Thanks for the feedback!
--
Gustavo

