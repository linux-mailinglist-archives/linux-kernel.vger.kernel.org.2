Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF3434340
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 04:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJTCCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 22:02:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24362 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTCCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 22:02:45 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HYtxS5kL3zbhF2;
        Wed, 20 Oct 2021 09:55:56 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 10:00:29 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 10:00:29 +0800
Subject: Re: [QUESTION] Performance deterioration caused by commit
 85f726a35e504418
To:     "Zanussi, Tom" <tom.zanussi@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
References: <992d3b1c-70db-5cc7-8400-39caa5d502d5@huawei.com>
 <20211018093731.2dd5917f@gandalf.local.home>
 <19e4222c-c9ac-5c1a-0c3a-b8bfd3524ab7@huawei.com>
 <20211018225112.3f6bda99@gandalf.local.home>
 <a138a0db-94a0-f77e-9b2d-bcffcba6862b@linux.intel.com>
 <20211019141002.386e7b6a@gandalf.local.home>
 <ea059f74-95d8-3e33-fbeb-02ef1ac567b0@linux.intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <9d0844e4-271e-41f7-3883-3dd1e572a8c8@huawei.com>
Date:   Wed, 20 Oct 2021 10:00:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ea059f74-95d8-3e33-fbeb-02ef1ac567b0@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steve and Tom

On 2021/10/20 2:38, Zanussi, Tom wrote:
> On 10/19/2021 1:10 PM, Steven Rostedt wrote:
>> On Tue, 19 Oct 2021 12:30:28 -0500
>> "Zanussi, Tom" <tom.zanussi@linux.intel.com> wrote:
>>
>>> So anyway, as far as the histograms go, I think optimizing the two
>>> changes in 85f726a35e504418 while ignoring trailing garbage can be done
>>> without affecting the histogram correctness.
>>
>> So, none of that is exported to user space?
> 
> I meant just that any optimization of those two things that ignored the
> trailing garbage wouldn't affect the histogram keys.
> 
> But yeah I think you're correct that ignoring it in the case of
> saved_cmdlines wouldn't be a problem either but it would be in the case of
> max_buffer since that's exported by the ring buffer.

OK. Thanks very much for your patience. :)

Kind regards,
Jihong
> 
> Tom
> 
>>
>> -- Steve
>>
> .
