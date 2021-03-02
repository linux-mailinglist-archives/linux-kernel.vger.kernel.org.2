Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7474232A97E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577136AbhCBSbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578957AbhCBPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:36:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE14C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:37:46 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614695690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwO6HcbI3LDgNldCfGMx8XixgE14ckJS96JYeXlrQLs=;
        b=ES9C0DAHmgHUsSLXNRu9I0WcODnlSz6vM0uctfwtkad9smFt6SYyCjRM5VRnSXBcY61Cr6
        JIVufJgn6p+UTokL9vH1xwZ2jRKkHhmqULRiGi9vlT4w4AHkeKQnc4pOSsJ6TUuzd6eNxO
        b+UXMWP6S1X2stTWf4fSQbBHdIdqICKNbXs5RqucZZ03bXTiNufMEAGoVThclClvcwgZjA
        0x9grjGZOhcBdWXHTm9IUB3yWqsFXugkh/ZKFT8pGo0kZLCh3KIIpnrBlPoZFe9+KsKcM3
        Bmga39ydAlPPsMVfZwBWgeVsv4x+zBzp02nF2PPbK8aNGuV89MeU5FCenJ4VNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614695690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RwO6HcbI3LDgNldCfGMx8XixgE14ckJS96JYeXlrQLs=;
        b=6oxk50DmutsZwnLKHenbHnn3Rj34E6czbdR2jfGaO6GtN81JH1mouA4sY8KnaPP9Rw2kW4
        HGZCH4NfTfOQs/AA==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next v3 07/15] printk: introduce CONSOLE_LOG_MAX for improved multi-line support
In-Reply-To: <CAMuHMdWCM4MLkwRZTZU2Sne3gEvjBT9gowLUKLJbTAYh5gb1wg@mail.gmail.com>
References: <20210225202438.28985-1-john.ogness@linutronix.de> <20210225202438.28985-8-john.ogness@linutronix.de> <CAMuHMdWDPjU1q6QnBJ2D7k4pt2XZyGMbKJuifTOb8SJB1uio7Q@mail.gmail.com> <CAMuHMdWCM4MLkwRZTZU2Sne3gEvjBT9gowLUKLJbTAYh5gb1wg@mail.gmail.com>
Date:   Tue, 02 Mar 2021 15:34:49 +0100
Message-ID: <87h7ltpqt2.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 2021-03-02, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Mar 2, 2021 at 2:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, Feb 25, 2021 at 9:30 PM John Ogness <john.ogness@linutronix.de> wrote:
>>> Instead of using "LOG_LINE_MAX + PREFIX_MAX" for temporary buffer
>>> sizes, introduce CONSOLE_LOG_MAX. This represents the maximum size
>>> that is allowed to be printed to the console for a single record.
>>>
>>> Rather than setting CONSOLE_LOG_MAX to "LOG_LINE_MAX + PREFIX_MAX"
>>> (1024), increase it to 4096. With a larger buffer size, multi-line
>>> records that are nearly LOG_LINE_MAX in length will have a better
>>> chance of being fully printed. (When formatting a record for the
>>> console, each line of a multi-line record is prepended with a copy
>>> of the prefix.)
>>>
>>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>>
>> Thanks for your patch!
>>
>> This increases kernel size by more than 3 KiB, which affects small
>> devices (e.g. SoCs with 10 MiB of SRAM inside).

Petr was concerned that this patch might raise issues for the small
devices.

>> Who is printing such long lines to the console?

Some printk users like to print large multi-line messages into a single
record. They can get pretty long. But since no one is complaining with
the current 1024, we can assume it is big enough.

For v4 I will return it back to 1024 bytes.

> BTW, printing a single line of 1024 characters to a serial console at
> 115200 bps takes almost 100 ms.

Yes. Although once we move to threaded printers, I don't think anyone
will care. Also, I think the netconsole will become quite attractive
when we move to threaded printers.

John Ogness
