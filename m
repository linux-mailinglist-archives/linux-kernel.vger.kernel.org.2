Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4801539D222
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFFXHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhFFXHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:07:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1BB361429;
        Sun,  6 Jun 2021 23:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623020731;
        bh=MP7FMA1pcXyauRBVKjd7g0X57/FdlVAQjI8PnSp5+IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPiDv2JP5SxK70TgvNXX1iEPgEIwTpgUXA8fVQoEnkUFqrMnDwUftADWfxiwRJ6ys
         Dpwy/xKEPiW88GjfqAU1rFfJKERpnoBAZNTL/wTuxS4Fg/RS9q/mTCfdhkeje7mwSx
         SeFSBqSLWqq24R4wEzYc2Xb/KyxkbLFt27DJ0WfjX1palvgW5u7I8TTpNmCzn59vC8
         2QhJyDoyVcRphjlpSQaeDkwqx4vm9P29ngjFn4l+in2SN7f+xLWMexjJ0mM9t4DWgT
         PUiD8XefxZU9nmWTQzDI3R1I8nHuoCtZkV0PaoFiL99Tq4YfyV3cPNoM7gm4TZ1+0W
         Vkc5HfjZlcIuQ==
Date:   Sun, 6 Jun 2021 19:05:29 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, James.Morris@microsoft.com
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
Message-ID: <YL1UucKH0GfXddZo@sashalap>
References: <YLx/iA8xeRzwhXJn@zn.tnic>
 <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com>
 <YL029aQZb09G3ShY@linux.ibm.com>
 <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com>
 <YL1HLdmh55uGAIs/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YL1HLdmh55uGAIs/@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 12:07:58AM +0200, Borislav Petkov wrote:
>On Sun, Jun 06, 2021 at 02:23:21PM -0700, Linus Torvalds wrote:
>> On Sun, Jun 6, 2021 at 1:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>> >
>> > A while ago hpa said:
>> >
>> >         As far as I know, Windows 7 actually reserves all memory below
>> >         1 MiB to avoid BIOS bugs.
>> >
>> > (https://bugzilla.kernel.org/show_bug.cgi?id=16661#c2)
>>
>> It would be good to have that checked somehow.
>>
>> I don't think this matters on any machine with gigs of RAM, but I do
>> wonder about the people who want to do small configurations. Maybe
>> they've given up on x86?
>>
>> It also eats into that somewhat precious legacy DMA resource and eats
>> up a fair chunk of that. Again, not an issue on modern hardware, but
>> ..
>>
>> > I believe that reserving everything below 1M after the real mode trampoline
>> > is allocated reduces amount of hidden dependencies and makes things simpler
>> > overall.
>>
>> Simpler, perhaps, and _I_ personally don't care about about 512kB of
>> memory any more on any machines I have, but ..
>
>Let's see if Sasha can dig out something... CCed.
>
>@Sasha, can you figure out who we can talk to whether Windoze reserves
>the first megabyte of memory unconditionally?

That's a great question, but I can't help there anymore :)

Adding James Morris...

-- 
Thanks,
Sasha
