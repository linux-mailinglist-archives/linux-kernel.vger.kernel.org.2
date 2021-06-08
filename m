Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A487B39EC65
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFHCzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:55:21 -0400
Received: from m32-153.88.com ([43.250.32.153]:64721 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230254AbhFHCzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=pLj4SGsK8n/jI46LQXbW+LeIjOWzSml3VLIw9
        mbSDtA=; b=QIalVcjGjJkkgfp3fULiqBo+7+K59FT8fSyJNSRWn5SaplEhxiP4g
        M0zFOhk7CIjNv3IlKbfkUHO4izxMefDREWhL0vOMMfokUWVa3m/tteczYFaj0/Ra
        tI0iW9HT46xon5feOpPpc4w/+pBPVXlfedwPkMaqnTuVtkzXceHlcU=
Received: from [0.0.0.0] (unknown [113.251.8.115])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCHXv2g275gJ80EAA--.14169S3;
        Tue, 08 Jun 2021 10:53:21 +0800 (CST)
Subject: Re: [PATCH v3] docs/zh_CN: create new translations for
 zh_CN/dev-tools/testing-overview
To:     "Wu X.C." <bobwxc@email.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, bernard@vivo.com,
        maskray@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210605120504.40246-1-src.res@email.cn>
 <20210608024439.GA3207@bobwxc.top>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <01cd7a95-8b91-ad2f-ad94-80b06c1fe5c0@email.cn>
Date:   Tue, 8 Jun 2021 10:53:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608024439.GA3207@bobwxc.top>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgCHXv2g275gJ80EAA--.14169S3
X-Coremail-Antispam: 1UD129KBjvJXoWrurW8Gr4kCw4rur1DZr4DXFb_yoW8Jr1xpr
        Wkuwn3CF4qgry7ArZ3C3W0qrnYk3sYqry8ta1ftFyUXryDZFnakr9rtrZrtw15uayxAF9Y
        ya17KFy7C348Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4UJr1UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv
        8VWxJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjaMKZUUUUU=
X-Originating-IP: [113.251.8.115]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/8 上午10:44, Wu X.C. 写道:
> On Sat, Jun 05, 2021 at 08:05:04PM +0800, Hu Haowen wrote:
>> Create new translations for dev-tools/testing-overview.rst and link it
>> to dev-tools/index.rst with TODOList modifications.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
>> ---
>>   .../translations/zh_CN/dev-tools/index.rst    |   5 +
>>   .../zh_CN/dev-tools/testing-overview.rst      | 110 ++++++++++++++++++
> [...]
>> +
>> +代码覆盖率工具
>> +==============
>> +
>> +支持两种不同代码之间的覆盖率测量工具。它们可以用来验证一项测试执行的
> Linux内核支持两种不同的代码覆盖率测试工具。


But you mentioned that this sentence should be 
"支持两种不同代码之间的覆盖率测量工具" in
the previous email. Should I take this version or the previous version?


Thx,

Hu Haowen


>
>> +确切函数或代码行。这有助于决定内核被测试了多少，或用来查找合适的测试
>> +中没有覆盖到的极端情况。
>> +
> OK, good job!
>
> Just need to fix a small problem, after that
>
> Reviewed-by: Wu XiangCheng <bobwxc@email.cn>
> Thanks,
> 	Wu X.C.

