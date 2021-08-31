Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F4E3FC3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbhHaHfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 03:35:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57188 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhHaHfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 03:35:42 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630395286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLJY6xcbvW6C1KJTFx9luEOAgHOknJdl/gDSN5JHA78=;
        b=3REJvLaUATeZ4zNNO4ubJTgJ9k8VgcJSw+Oqb7IyX2WC9vgO1xnUBkKSbaB0+ZVrWig2fs
        1HiFvBsYOi0Ggv8d6DtY/yehGD1HyhzPXM150BNp4HUwNgR7u5p26u0uUtVbuIfbL9xIcO
        5a5VgFJZDjIhKy4rSGGMjK9qA5lzNjGwOcwFfT0I9bS9EzRMAsrN9g9KkaWNSb52skMfsx
        bBEcDLWuJhJdO3ESjwJG/TK2ECCYNGGLZeVxADOzLJYD2c27DKWVhBfn8EjPqmfVvvANsj
        DF+ZgZ3NYl1tiyirjZB/uIuWWDeta1B/A4jAOGnyppIxw0+2vluulT/JOomXdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630395286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLJY6xcbvW6C1KJTFx9luEOAgHOknJdl/gDSN5JHA78=;
        b=deHyDpyhfNUYedf43wjWDOY9ANOSscmnAXCpz6RD0SSrAmnZYV9U1JkowlYHEE6XwQ3RT5
        2qBq277L5NNBfeDg==
To:     James Wang <jnwang@linux.alibaba.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel hang during reboot when cmdline include a non-exist console device
In-Reply-To: <YS2fZ1sknFYKtJFi@google.com>
References: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com> <YS2fZ1sknFYKtJFi@google.com>
Date:   Tue, 31 Aug 2021 09:40:45 +0206
Message-ID: <87pmtudq3u.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the reporter to the discussion...

On 2021-08-31, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> There's a bugzilla for this, but let's just move it to reguilar email,
>> unless some of you want to track it that way.
>>=20
>> The bugzilla entry says
>>=20
>>   "When reboot=EF=BC=8C the capslock key of thinkpad x1 starts blinking"
>>=20
>> which sounds like there's an oops that just isn't showing, quite
>> possibly because the console has already been shut down.

There is no console registered.

>> I didn't test this out, and would sincerely hope that somebody else is
>> willing to follow up on it since I'm in the busiest part of the merge
>> window.
>
> [..]
>
>> > https://bugzilla.kernel.org/show_bug.cgi?id=3D214201
>
> I think normally wrong/empty console boot argument should not cause
> problems. We have a huge number of devices that use console=3D"", for
> instance. But on some hardware this triggers panic(), very early on.

@James: Is it possible that you can set up a crash kernel to capture the
dump?

If a crash kernel is not possible, another option would be to enable
kgdb+kdb for a serial port. This would allow you to dump the kernel log.

> I have the same symptoms on my laptop, and so far haven't been able to
> figure out how to track it down, but I need to re-start my
> investigation.

A crash kernel or kgdb/kdb on a serial port is the easiest way to debug
this.

John Ogness
