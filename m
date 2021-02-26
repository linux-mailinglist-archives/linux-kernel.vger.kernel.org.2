Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA84325F43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBZIka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:40:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhBZIhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:37:11 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614328582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wa9POXqMKGw+8kb3VAc3hSm+Y4vGF0EAtAN5/tcZUMU=;
        b=muUzaIMBpPxOCUKU+xBeJdilnkL/NyDY+RF8P8QPv8ytIrC130tc5k4ztDxXh4QCErNqRQ
        rNHNxl+io7jGyWAvKpri456Eox6HCL8OpxWjbM0EENMAN0i76/m03nJftGI3lLju0k4uWC
        vCiX9kaxzbYg2r9z0VTLrqemp94Q3wgaiUuPIhMf3gTjxpfS+YGmzri8j8C0aVA7MogXmZ
        6cpeecHvrNzE9Nh/XAInVBnBLCOM8Q+P6oWyqLJqY4Bp70Em3I7RUg3SN2bS+79dvGeNMu
        3j35vZnioT8qLM5UgHSXymkNE3DghxsnOSi1O3GTBkhzbKQijluz4LnWvmszYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614328582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wa9POXqMKGw+8kb3VAc3hSm+Y4vGF0EAtAN5/tcZUMU=;
        b=ZG4J3SIGHekCeoIDg0IEG47Ka/+4+vh5qujpC7tj+T6w/LHxcGaZhMICaKO8r2Zf98n3c+
        xDdPrAZ87zTdcXBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: synchronization model: was: Re: [PATCH printk-rework 09/14] printk: introduce a kmsg_dump iterator
In-Reply-To: <YDeZAA08NKCHa4s/@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de> <20210218081817.28849-10-john.ogness@linutronix.de> <YC/79JPVKcVaSEEH@alley> <87eeh51wht.fsf@jogness.linutronix.de> <YDeZAA08NKCHa4s/@alley>
Date:   Fri, 26 Feb 2021 09:36:21 +0100
Message-ID: <877dmvxm2i.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-25, Petr Mladek <pmladek@suse.com> wrote:
> IMHO, a better design would be:
>
> 1. dumper->dump() callback should have only one parameter @reason.
>    The callback should define its own iterator, buffer, and
>    do the dump.

Unfortunately this won't work because drivers/mtd/mtdoops.c is using the
dumper parameter for container_of().

So we will need 2 parameters: dumper and reason.

Can we agree to proceed with 2 parameters in the callback?

> 2. dumpe->dump() callback should synchronize the entire operation
>    using its own locks. Only the callback knows whether it is
>    safe to do more dumps in parallel. Only the callback knows
>    whether it is called only during panic() when no locks
>    are needed.

Agreed. I implemented this part for the v3 series.

John Ogness
