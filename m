Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D143131D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhJRJTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:19:23 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52531 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231636AbhJRJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:19:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UsbOJts_1634548606;
Received: from C02XQCBJJG5H.local(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0UsbOJts_1634548606)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Oct 2021 17:16:47 +0800
Subject: Re: [PATCH V3 06/49] compiler_types.h: Add __noinstr_section() for
 noinstr
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
 <20211014033414.16321-1-jiangshanlai@gmail.com>
 <CAKwvOd=znqwGT_FmUPbWPodjrnFHf+FtHMaYCTfvUeukBCM3xw@mail.gmail.com>
 <CANiq72k7E2ahWoFQWSUo6CWNd7iWVh-5sdqtTQ=5JPTHN_tzyw@mail.gmail.com>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
Message-ID: <8d2f0a4f-80e0-36c1-9421-d2c1af282a12@linux.alibaba.com>
Date:   Mon, 18 Oct 2021 17:16:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CANiq72k7E2ahWoFQWSUo6CWNd7iWVh-5sdqtTQ=5JPTHN_tzyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/15 02:35, Miguel Ojeda wrote:
> On Thu, Oct 14, 2021 at 8:29 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> Can we use __section(section) here (from
>> include/linux/compiler_attributes.h)? I kind of can't stand seeing
>> attributes open coded.
> 
> Yes please! (though it can be an independent patch)
> 

I will use __section(section) in the updated patch.

I don't know whether it is worth for a new version for a relatively large patchset
with almost 50 patches since the feedback becomes less or I should wait for more
reviews from the x86 maintainers.  Especially the second half of the patchset which
is all about IST exceptions has no feedback since V2.

Thanks.
Lai
