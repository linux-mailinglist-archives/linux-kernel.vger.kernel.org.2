Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC9E3B4A04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFYVOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFYVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:14:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20593C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cX8/o+P5AkCq6YYmwi3wTfr9Bdl8j0K72iZJT1PzvrE=; b=bRfXAGOwOMopMG6okwC5t92X8P
        0X8MYe6XllCE6SgkRWGa42dA+iqYGMv0Evo9ysIHd9lkGibOwGh2vOpwuREfpEcoDo2Yxf3/BjYAB
        0Svd6/NyFFVglzXGPSYKPlFMAheefG009SoEWEUH8bPbNSoDPBYo0M4NVpDgbTBJQuzlKeceacx5B
        +Sds/zcAb/mUye6Q8goysriekKDF0OKD2Qrdd7mmzDay3JMtq+voO45D2P4d0pLwJjoJ67GxIOWvg
        FU90+TvPwW0UASNYUjXRdPV+MmS+BG47ugsO4UloAVq2idCIQvAydzgM+5FDISkKpVt2g3tx9QgZM
        IsGUZugA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwt6y-002rYH-9a; Fri, 25 Jun 2021 21:11:40 +0000
Subject: Re: [PATCH] ELF: add and use SUPRESS_WARN_UNUSED_RESULT
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
References: <YNYz+hVeqsQmiEqN@localhost.localdomain>
 <CANiq72=qtAcsyReu85AVT-cSf3dcvbnTpQYEF1JhxCRP0WgHUw@mail.gmail.com>
 <YNZGNvGn/pkMhsx+@localhost.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1de70b4e-722e-3c42-1c1d-06d6d1334206@infradead.org>
Date:   Fri, 25 Jun 2021 14:11:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNZGNvGn/pkMhsx+@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/21 2:10 PM, Alexey Dobriyan wrote:
> On Fri, Jun 25, 2021 at 10:34:29PM +0200, Miguel Ojeda wrote:
>> On Fri, Jun 25, 2021 at 9:52 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>>>
>>> +/*
>>> + * "(void)" is enough for clang but not for gcc.
>>> + */
>>> +#define SUPRESS_WARN_UNUSED_RESULT     (void)!
>>
>> While it is related to the attribute, this macro is not an attribute,
>> so please add it somewhere else.
> 
> This is natural place. If you're supressing WUR, then the WUR macro
> itself is defined implying that the header has been included.
> 
>> By the way, the name has a typo.
> 
> Ha!
> 

as in Aha!?

s/SUPRESS/SUPPRESS/

