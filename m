Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27E8396D33
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhFAGSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:18:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3484 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFAGSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:18:23 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvMLF3YnPzYqWr;
        Tue,  1 Jun 2021 14:13:57 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:16:41 +0800
Received: from [10.174.176.189] (10.174.176.189) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:16:40 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
Subject: Re: [PATCH -next] x86/kprobes: functions should not be declared
 extern
To:     Borislav Petkov <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20210531031009.21737-1-linqiheng@huawei.com>
 <YLS8+gMRp62s4WEY@zn.tnic>
Message-ID: <b0a08543-1ec6-f559-a6d8-fb2d49fadb5d@huawei.com>
Date:   Tue, 1 Jun 2021 14:16:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YLS8+gMRp62s4WEY@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.189]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/5/31 18:39, Borislav Petkov 写道:
>> Subject: Re: [PATCH -next] x86/kprobes: functions should not be declared extern
> 
> The condensed patch description in the subject line should start with a
> uppercase letter and should be written in imperative tone.
> 
> Also, the subject is wrong. Hint: "declaration" vs "definition".
> 
> On Mon, May 31, 2021 at 11:10:09AM +0800, Qiheng Lin wrote:
>> The function declaration in kprobes.h is already marked extern, thus its
>> definition should not have the keyword.
>>
>> This quiets the following sparse warning:
>>   function 'arch_unoptimize_kprobes' with external linkage has definition
> 
> This sounds like you're fixing something just because some tool
> complains and not because there's a real problem you're fixing.
> 
> Please rewrite your commit messages to state what the problem is and
> why you're fixing that problem. The tool output can be used to say
> something along the lines of "this problem was caught by this tool" but
> not as "see, tool X complains and creates a warning and I must fix that
> warning immediately."

Thank you for the review. I will send the v2.
