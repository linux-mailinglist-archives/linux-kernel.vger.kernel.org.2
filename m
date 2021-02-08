Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAF231407B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbhBHU3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:29:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38496 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbhBHTIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:08:18 -0500
Date:   Mon, 8 Feb 2021 20:07:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612811256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcnE5fU9oLeWJ17yg77X1c9xX8rV4+ATb0VQ5SgRAyI=;
        b=o9XbqQhuHw45cDq197w3U3RU8RqTZaCf67KVPEMT5nE/C/siH5LzSfOfFjgKeBK43n+Jbz
        bxYuB39jShaYsrgYc31pZERBZY6TfxDhi7SICHcIwOScxUPuIZmrDSEdw79p2am982i0BQ
        Ren6FRWU5lTzfGZTmS2mjrZ8wQOQgK3i1F+PD3tx1kh8vdrwCGsMNXBsgcs89XWbGrqTKa
        qmMLHAJCqfeMkbkeR2lW0QcYJRtJZ4txj/saUMBYSNoAHItfczZKooGvrxol4teW8tDe55
        EHgFNs8n76tNyrXKdbE53K5zXflP60Llv70zIvHtZ2JKGyz52vAaKcq8ccKUsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612811256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcnE5fU9oLeWJ17yg77X1c9xX8rV4+ATb0VQ5SgRAyI=;
        b=rEQlHrTHUY20slfXicHeywY3npcJ04Vf+9hVU+KXj6k/Nvnls064lh4jvPa2l8pjY2vsNv
        55YEsNEFb9Tyy4DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] auxdisplay: Remove in_interrupt() usage.
Message-ID: <20210208190735.ibq44r5pc4cwzt7j@linutronix.de>
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-08 19:38:10 [+0100], Miguel Ojeda wrote:
> Hi Sebastian,
Hi,

> > Therefore there is no need to use `in_interrupt()' to figure out if it
> > is save to sleep because it always is.
> 
> save -> safe
> 
> Does it hurt to have `in_interrupt()`? Future patches could make it so
Yes.

> that it is no longer a preemptible context. Should it be moved to e.g.
> a `WARN_ON()` instead?

No. If you know the context, pass it along like this is done for
kmalloc() for instance. The long term plan is not make it available to
divers (i.e. core code only where the context can not be known).

> Thanks for the patch!

I'm going to resend it with your corrections.

> Cheers,
> Miguel

Sebastian
