Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1003C835D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbhGNLEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:04:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11304 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbhGNLEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:04:36 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GPvbG2vdmz8slH;
        Wed, 14 Jul 2021 18:57:14 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 19:01:43 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 14 Jul
 2021 19:01:42 +0800
Subject: Re: [PATCH] cacheinfo: clear cache_leaves(cpu) in
 free_cache_attributes()
To:     Sudeep Holla <sudeep.holla@arm.com>,
        James Morse <james.morse@arm.cm>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1626148058-55230-1-git-send-email-wangxiongfeng2@huawei.com>
 <20210713113315.thsvrvqvqptc7hje@bogus>
 <303cd2bf-7142-6ec9-548a-afe7f6e5ca8f@huawei.com>
 <20210713132612.gvx7xpdp3tjcmxxu@bogus>
 <ee4db21a-e1cc-5847-d1fb-1d7735cf2164@arm.com>
 <20210713174818.oipjwqldkf3jlzih@bogus>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <c84bc06b-b6c8-38b6-00a4-eb3e623b896e@huawei.com>
Date:   Wed, 14 Jul 2021 19:01:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20210713174818.oipjwqldkf3jlzih@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/14 1:48, Sudeep Holla wrote:
> On Tue, Jul 13, 2021 at 06:38:15PM +0100, James Morse wrote:
>> Hello,
>>
> 
> [...]
> 
>> If you like. If there is nothing broken its hard to care.
>> I guess this helps people doing backports.
>>
> 
> Thanks James, indeed I was trying to avoid unnecessary backport.
> 
> Xiongfeng,
> 
> Please don't add any fixes and post the patch with my Reviewed-by, we can

Sorry, I forgot to add your Reviewed-by tag in the new version.

> then ask Greg to pick. I am fine with the patch as is, it is nice to have
> as it ensures teardown is more complete but it doesn't fix anything
> in upstream or stable trees.
> 
> --
> Regards,
> Sudeep
> .
> 
