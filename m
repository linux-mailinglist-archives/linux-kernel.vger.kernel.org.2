Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2483131E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBHMLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:11:37 -0500
Received: from mail.netline.ch ([148.251.143.178]:51254 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhBHLuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:50:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 1EB102A6046;
        Mon,  8 Feb 2021 12:49:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OJzn5Nd4XMaf; Mon,  8 Feb 2021 12:49:30 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch [85.2.99.24])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 641222A6042;
        Mon,  8 Feb 2021 12:49:30 +0100 (CET)
Received: from [::1]
        by thor with esmtp (Exim 4.94)
        (envelope-from <michel@daenzer.net>)
        id 1l952n-001pI0-CW; Mon, 08 Feb 2021 12:49:29 +0100
To:     Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>,
        "airlied@gmail.com" <airlied@gmail.com>
Cc:     Will Drewry <wad@chromium.org>, Jann Horn <jannh@google.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
References: <20210205163752.11932-1-chris@chris-wilson.co.uk>
 <202102051030.1AF01772D@keescook>
 <CAKMK7uHnOA9CuRxcKkcqG8duOw_3dZobkThcV7Q_swMXVoLCkQ@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] kernel: Expose SYS_kcmp by default
Message-ID: <5a940e13-8996-e9e5-251e-a9af294a39ff@daenzer.net>
Date:   Mon, 8 Feb 2021 12:49:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHnOA9CuRxcKkcqG8duOw_3dZobkThcV7Q_swMXVoLCkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-05 9:53 p.m., Daniel Vetter wrote:
> On Fri, Feb 5, 2021 at 7:37 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Fri, Feb 05, 2021 at 04:37:52PM +0000, Chris Wilson wrote:
>>> Userspace has discovered the functionality offered by SYS_kcmp and has
>>> started to depend upon it. In particular, Mesa uses SYS_kcmp for
>>> os_same_file_description() in order to identify when two fd (e.g. device
>>> or dmabuf) point to the same struct file. Since they depend on it for
>>> core functionality, lift SYS_kcmp out of the non-default
>>> CONFIG_CHECKPOINT_RESTORE into the selectable syscall category.
>>>
>>> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>> Cc: Will Drewry <wad@chromium.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Dave Airlie <airlied@gmail.com>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>> ---
>>>   init/Kconfig                                  | 11 +++++++++++
>>>   kernel/Makefile                               |  2 +-
>>>   tools/testing/selftests/seccomp/seccomp_bpf.c |  2 +-
>>>   3 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/init/Kconfig b/init/Kconfig
>>> index b77c60f8b963..f62fca13ac5b 100644
>>> --- a/init/Kconfig
>>> +++ b/init/Kconfig
>>> @@ -1194,6 +1194,7 @@ endif # NAMESPACES
>>>   config CHECKPOINT_RESTORE
>>>        bool "Checkpoint/restore support"
>>>        select PROC_CHILDREN
>>> +     select KCMP
>>>        default n
>>>        help
>>>          Enables additional kernel features in a sake of checkpoint/restore.
>>> @@ -1737,6 +1738,16 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
>>>   config ARCH_HAS_MEMBARRIER_SYNC_CORE
>>>        bool
>>>
>>> +config KCMP
>>> +     bool "Enable kcmp() system call" if EXPERT
>>> +     default y
>>
>> I would expect this to be not default-y, especially if
>> CHECKPOINT_RESTORE does a "select" on it.
>>
>> This is a really powerful syscall, but it is bounded by ptrace access
>> controls, and uses pointer address obfuscation, so it may be okay to
>> expose this. As it is, at least Ubuntu already has
>> CONFIG_CHECKPOINT_RESTORE, so really, there's probably not much
>> difference on exposure.
>>
>> So, if you drop the "default y", I'm fine with this.
> 
> It was maybe stupid, but our userspace started relying on fd
> comaprison through sys_kcomp. So for better or worse, if you want to
> run the mesa3d gl/vk stacks, you need this.

That's overstating things somewhat. The vast majority of applications 
will work fine regardless (as they did before Mesa started using this 
functionality). Only some special ones will run into issues, because the 
user-space drivers incorrectly assume two file descriptors reference 
different descriptions.


> Was maybe not the brighest ideas, but since enough distros had this
> enabled by defaults,

Right, that (and the above) is why I considered it fair game to use. 
What should I have done instead? (TBH I was surprised that this 
functionality isn't generally available)

> it wasn't really discovered, and now we're
> shipping this everywhere.

You're making it sound like this snuck in secretly somehow, which is not 
true of course.


> Ofc we can leave the default n, but the select if CONFIG_DRM is
> unfortunately needed I think.

Per above, not sure this is really true.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
