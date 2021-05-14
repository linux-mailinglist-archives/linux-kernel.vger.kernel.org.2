Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74D8380FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhENSlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232058AbhENSlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:41:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5158361444;
        Fri, 14 May 2021 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621017623;
        bh=GxUwphmY7hFft3BJBfw+uogxcdC/z94IPCczLhDhI2c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gYbkQcl9daqMYvVinvn73xv7lxZZ2PRmTSwJb3sWks7SQ+7FUFI84qc8ONQOxiToR
         Xmwxe34/mixTsUIUGcT7JuTFjMESwUWzxHDNeahQMJvV2UnJKUrSmHsbXxjFIV4Nnz
         GWAvQ4f9hVA6J8k7RFVVQJJKPQpFGs5KPxId/ewbMG4RSZrlnudOWfGVg4NBu+Xnnl
         emzBlxmnsLpOeRydjnFdvkHCAaM39YXuhzN1us6N57qR9jcgnSjKm1nTkKozEai4ti
         lgrwLMm8yUn8/3nwYUMEmpkUrVYxwHdyB+izuZwEpwjLW1BPeO9zLU1ANqJ0LWrh6d
         Mcy23LyeU4KsQ==
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
To:     Marco Elver <elver@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210514140015.2944744-1-arnd@kernel.org>
 <YJ6E1scEoTATEJav@kroah.com>
 <CANpmjNMgiVwNovVDASz1jrUFXOCaUY9SvC7hzbv2ix_CaaSvJA@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <ad7fa126-f371-5a24-1d80-27fe8f655b05@kernel.org>
Date:   Fri, 14 May 2021 11:40:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNMgiVwNovVDASz1jrUFXOCaUY9SvC7hzbv2ix_CaaSvJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2021 7:45 AM, Marco Elver wrote:
> On Fri, 14 May 2021 at 16:10, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Fri, May 14, 2021 at 04:00:08PM +0200, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> clang points out that an initcall funciton should return an 'int':
>>>
>>> kernel/kcsan/debugfs.c:274:15: error: returning 'void' from a function with incompatible result type 'int'
>>> late_initcall(kcsan_debugfs_init);
>>> ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>>> include/linux/init.h:292:46: note: expanded from macro 'late_initcall'
>>>   #define late_initcall(fn)               __define_initcall(fn, 7)
>>>
>>> Fixes: e36299efe7d7 ("kcsan, debugfs: Move debugfs file creation out of early init")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [...]
>>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Thanks for catching this -- it boggles my mind why gcc nor clang
> wouldn't warn about this by default...
> Is this a new clang?

KCSAN appears to only support x86_64, which also selects 
HAVE_ARCH_PREL32_RELOCATIONS, meaning that the initcalls never have 
their types validated because there is no assignment:

https://elixir.bootlin.com/linux/v5.12.4/source/include/linux/init.h#L240

In the case of CONFIG_LTO_CLANG, the initcall function is called in the 
stub function, resulting in the error that we see here.

Hopefully that makes sense :)

Cheers,
Nathan
