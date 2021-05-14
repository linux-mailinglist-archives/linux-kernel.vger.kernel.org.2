Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1E938117A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhENUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhENUMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:12:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78928613BB;
        Fri, 14 May 2021 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621023067;
        bh=kd4z1PpTjZsgZwRwiDTwC1SuHlOAMi6865/opPSAzQo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CE+KCPG3/ZeDcN+E3ysyUYES6j/HqhVJ5ZOtSAkKPVTI7LLIQHag5W55rOGkGsf5J
         uMkjxqWsFmsUWa0cebXk5hRc9VndM5r69ck8nqS18RbfOm5nGuWY0vNlC7MLjCvKhc
         5Q5UxzUDONH9DzpfWptl2bpLHQMm0mh+GnwwTD6IB2W2n7z82IUGa+0hI3hjX18uS/
         NHPU+GPuh2zGpauqmJ7UOvDaClfY34zf+ZZLNtUAu/74KRe9tL2XwTbZ2sbx5E1Jyl
         1fG4lCW6VLsn6Tk3Kz90d0Zs6VT20MhVg136qmwShrsGhTXCxsjkc9JleRnQ1VCdPa
         W3LQumkDaCGow==
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
To:     paulmck@kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>, Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210514140015.2944744-1-arnd@kernel.org>
 <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
 <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <534d9b03-6fb2-627a-399d-36e7127e19ff@kernel.org>
Date:   Fri, 14 May 2021 13:11:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514193657.GM975577@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 5/14/2021 12:36 PM, Paul E. McKenney wrote:
> On Fri, May 14, 2021 at 11:29:18AM -0700, Nathan Chancellor wrote:
>> On 5/14/2021 7:00 AM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> clang points out that an initcall funciton should return an 'int':
>>>
>>> kernel/kcsan/debugfs.c:274:15: error: returning 'void' from a function with incompatible result type 'int'
>>> late_initcall(kcsan_debugfs_init);
>>> ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>>> include/linux/init.h:292:46: note: expanded from macro 'late_initcall'
>>>    #define late_initcall(fn)               __define_initcall(fn, 7)
>>>
>>> Fixes: e36299efe7d7 ("kcsan, debugfs: Move debugfs file creation out of early init")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> For the record, this requires CONFIG_LTO_CLANG to be visible.
>>
>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> Queued with the three Reviewed-by tags, thank you all!
> 
> Nathan, I lost the thread on exactly what it is that requires that
> CONFIG_LTO_CLANG be visible.  A naive reader might conclude that the
> compiler diagnostic does not appear unless CONFIG_LTO_CLANG=y, but
> that would be surprising (and yes, I have been surprised many times).
> If you are suggesting that the commit log be upgraded, could you please
> supply suggested wording?

You can see my response to Marco here:

https://lore.kernel.org/r/ad7fa126-f371-5a24-1d80-27fe8f655b05@kernel.org/

Maybe some improved wording might look like

clang with CONFIG_LTO_CLANG points out that an initcall function should 
return an 'int' due to the changes made to the initcall macros in commit 
3578ad11f3fb ("init: lto: fix PREL32 relocations"):

...

Arnd, do you have any objections?

Cheers,
Nathan
