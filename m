Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ADE456825
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 03:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhKSCg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 21:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhKSCgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 21:36:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB01C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 18:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=b6FrkTAxRK+qLx2xZ5nzzRM1/+AwCFIgwe1ZBMf+k/U=; b=UXlRrNIG6xpu1yZ0YX8Wmp9F9e
        yHlvqMLEJUqP8WppnzBvUGNV/2ERkOG8b8syQr6YROAuYBXFrmT1ExmWVIo/JyM5TNmj3JKFq72yH
        HJBXMa4+TsxNb592IHgLI9dIXJQUbS7ZjEDCjGonv/2yuN1tc3vx13g4a+KPbqIZm3/5fTouEy+yN
        cCXGBuHmWnAo43KKhtBjTfwjdbXzJ7N7qvdaN4H1NlmBWn1ZbE+sms9sjts7XDLsvoeSm8U5Nn1dS
        biP8Edt+RXKOdTcQqkULU+AUUwaug0XjyUDQnivHOyiTcihYpp/8jPlnqDat2warVaXgH3HAWz918
        Xmub3ZKw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnti6-009GwF-UP; Fri, 19 Nov 2021 02:33:07 +0000
Subject: Re: [PATCH] sound/oss/dmasound: fix build when some drivers are =m
 and others are =y
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20211118062146.11850-1-rdunlap@infradead.org>
 <CAK8P3a1s_toN_J=M8gxcVrtEazZ+Mu9UYbKMVkG3MzDLSCEOfQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <588b3e9e-df03-8bd6-b36e-b88212e01e3f@infradead.org>
Date:   Thu, 18 Nov 2021 18:33:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1s_toN_J=M8gxcVrtEazZ+Mu9UYbKMVkG3MzDLSCEOfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/21 10:50 PM, Arnd Bergmann wrote:
> On Thu, Nov 18, 2021 at 7:21 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> When CONFIG_DMASOUND_ATARI=y and CONFIG_DMASOUND_Q40=m,
>> dmasound_atari.o is built first (listed first in the Makefile),
>> so dmasound_core.o is built as builtin, not for use by loadable
>> modules. Then dmasound_q40.o is built and linked with the
>> already-built dmasound_core.o, but the latter does not support
>> use by loadable modules. This causes the missing symbol to be
>> undefined.
>>
>> Fixes this build error:
>> ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_q40.ko] undefined!
> 
> I suspect your patch now breaks the case where multiple drivers are
> built-in, because that puts the same global symbols into vmlinux more
> than once.

True dat.

>> -EXPORT_SYMBOL(dmasound);
>> -EXPORT_SYMBOL(dmasound_init);
>> -#ifdef MODULE
>> -EXPORT_SYMBOL(dmasound_deinit);
>> -#endif
> 
>  From a very brief look, I would think that removing this #ifdef and
> unconditionally defining dmasound_deinit is the correct solution
> here, to solve the case of the core driver being built-in but called
> from a loadable module, the Makefile logic is otherwise correct.

OK, thanks for the info.
I'm not going to spend any more time on it...

-- 
~Randy
