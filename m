Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECB4309EDC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhAaUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbhAaUWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 15:22:46 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 12:22:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id AF0D61F44865
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yuxuan Shui <yshuiv7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Kyle Huey <me@kylehuey.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
Organization: Collabora
References: <CAP045ApxLJ7vXOVp5Cwx7WEyDr6v01D9YD3xGFDv3WAp6czaMQ@mail.gmail.com>
        <87v9bdc4yc.fsf@m5Zedd9JOGzJrf0>
        <CAHk-=wixO7LJKwtD+CQJTQHgJFQjr=sSi_pQEGqcYdczTphncg@mail.gmail.com>
Date:   Sun, 31 Jan 2021 15:20:16 -0500
In-Reply-To: <CAHk-=wixO7LJKwtD+CQJTQHgJFQjr=sSi_pQEGqcYdczTphncg@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 31 Jan 2021 12:10:48 -0800")
Message-ID: <87mtwozwn3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Jan 31, 2021 at 10:54 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
>>
>> But renaming the definition in x86 is not enough, as TIF_SINGLESTEP is
>> set in current_thread_info()->flags, and the same commit has removed the
>> code that checks those flags. We have to also migrate TIF_SINGLESTEP from
>> thread info flags to syscall work flags, to make the whole thing work again.
>
> Ok, so I now have the first fix merged, but what's the next step here?
>
> As you say, the x86 ARCH_SYSCALL_EXIT_WORK is now entirely unused.
>
> It's called ARCH_SYSCALL_WORK_EXIT these days, but that's for the
> SYSCALL_WORK_SYSCALL_xyz flags, not for the TIF_xyz ones.
>
> Revert? Or does somebody have a fix patch?

I think we should migrate TIF_SINGLESTEP to a SYSCALL_WORK flag as that
is just a simple refactor. I can get a patch to you and Thomas during
the first part of the week, for the next -rc. I will also review the x86
version of ARCH_SYSCALL_EXIT WORK to make sure i didn't miss anything
else.

Reverting would be slightly be annoying as it requires reverting syscall
user dispatch as well.

-- 
Gabriel Krisman Bertazi
