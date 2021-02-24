Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2F3238B5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhBXIfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbhBXIeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:34:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C583264EC9;
        Wed, 24 Feb 2021 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614155613;
        bh=6hpKIts730HVSFW7NEWv++ddBcaF0jNziyKYSQQCVVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gntEwUaQtIH8fgq1omigfuVpROV+KjDjjgviQ8xMENu4F2X2xT/eRoUNezX1bBbEf
         yklpbiyER+fMtRtA/LifuX/Nz4IZIl66O4pK1epLMI5yaryLvh4bpdfVr1xyKKc9RI
         wTltEKr1hrOr1pfPfw2y2bfh1L+T5a8oUiB4hi15qK9PkC3thtUxKoLmMRVDHge3zp
         H5AahjoBPILfDn8HPup9FfL1DXfKhYv0oIGhDx7BsF+emicxdQHcTk9mCqfRAJQmnD
         fAg+BzUKV+yT5wea6PRE4pSpfnnFOql3QiI8T1+rdMem12FYx556+1IxIeB1pblvfp
         WgrPSas+34DaA==
Date:   Wed, 24 Feb 2021 09:33:28 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?77+8TWlyb3NsYXY=?= Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [GIT PULL] Modules updates for v5.12
Message-ID: <YDYPWAtoDpyD9D4Z@gunter>
References: <YDUibKAt5tpA1Hxs@gunter>
 <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de>
 <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
X-OS:   Linux gunter 5.11.0-rc4-1-default+ x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Linus Torvalds [23/02/21 12:03 -0800]:
>On Tue, Feb 23, 2021 at 12:01 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> Does your build now enable TRIM_UNUSED_KSYMS but previously didn't by
>> chance?
>
>Crossed emails.
>
>This is plain "make allmodconfig", so yes, now it will enable TRIM_UNUSED_KSYMS.
>
>This is unacceptably slow. If that symbol trimming takes 30% of the
>whole kernel build time, it needs to be fixed or removed.

[ Adding Masahiro to CC ]

It looks like CONFIG_TRIM_UNUSED_KSYMS had been hiding behind
CONFIG_UNUSED_SYMBOLS all this time, and once the EXPORT_UNUSED_SYMBOL
stuff was removed, it exposed that option to be selected by
allyesconfig. That option had previously caused build issues on
powerpc on linux-next, so I had temporarily marked that as BROKEN on
powerpc until Masahiro's fix landed in linux-next. I was not aware of
the additional build slowdown issue :/ In any case, Christoph's
suggestion to invert the option sounds reasonable, since the mips
defconfig selects it, it does not seem totally unused.
