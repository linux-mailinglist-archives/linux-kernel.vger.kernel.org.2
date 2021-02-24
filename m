Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C571F323BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 13:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhBXM23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 07:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBXM20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 07:28:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3884FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 04:27:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614169663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8D96xwlLlGmvQwFfBmCZIKGOORDeUvfAfzM5df4y+w=;
        b=stSPGXX1ETYl0eye8Ly/VEmrR0dTiT1HG7RNYu3/HGJWQuhsl5EssNBCnBzmJjE01BN0V7
        bZiItJ+QH3xg77oQ3jG+f0Y89n3/CxQto/zkZBOLw2HRfP6t4vzjqLRP8+DYIe4jCFbCzQ
        j7H24kuDV5FJAeNeHV1rahfumTBN1LJRZtx58ggvbk5uulgvAMJB+1ucanJ1BLeIErBiA1
        4s6VkI09Ej4GlObWNnowPzPLnUS+DY1yQ86CpOfQ6GZyJSkiunUXVnVFAoWapc1pN8FWMh
        elN2+BYyfCExtBw5Mowo4VAABYP7KvHXDEENvn9SGnrCQQiHUvtFmQcjAgpnEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614169663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d8D96xwlLlGmvQwFfBmCZIKGOORDeUvfAfzM5df4y+w=;
        b=L0cZoFhjG8cRqjLuLOLAi0QGcR1yDqoI0gs0jFNwZv5MgDCkcvbHO47hXnN6lzLMNHw3eD
        Z/JbwJdSFyvc2KDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: synchronization model: was: Re: [PATCH printk-rework 09/14] printk: introduce a kmsg_dump iterator
In-Reply-To: <YC/79JPVKcVaSEEH@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de> <20210218081817.28849-10-john.ogness@linutronix.de> <YC/79JPVKcVaSEEH@alley>
Date:   Wed, 24 Feb 2021 13:27:42 +0100
Message-ID: <87eeh51wht.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-19, Petr Mladek <pmladek@suse.com> wrote:
> This is likely beyond the scope of this patchset.

It would be beyond the scope of this patchset because it is not related
to logbuf_lock removal.

> I am still scratching my head about the synchronization if these dumpers.
>
> There is the "active" flag. It has been introduced by the commit
> e2ae715d66bf4becfb ("kmsg - kmsg_dump() use iterator to receive log
> buffer content"). I do not see any explanation there.
>
> It might prevent some misuse of the API. But the synchronization
> model is not much clear:
>
> 	+ cur_seq and next_seq might be manipulated by
> 	  kmsg_dump_rewind() even when the flag is not set.
>
> 	+ It is possible to use the same dumper more times in parallel.
> 	  The API will fill the provided buffer of all callers
> 	  as long as the active flag is set.
>
> 	+ The "active" flag does not synchronize other operations with
> 	  the provided buffer. The "dump" callback is responsible
> 	  to provide some synchronization on its own.
>
> In fact, it is not much clear how struct kmsg_dumper_iter, struct kmsg_dumper,
> and the used buffers are connected with each other and synchronized.

With this series applied, there is no connection between them. And
actually you have made me realize that the iterator should be named
"kmsg_dump_iter" instead. I will change that for v3.

> It might some sense to have the iterator in a separate structure.
> But the only safe scenario seems to be when all these three things
> (both structures and the buffer) are connected together and
> synchronized by the same lock. Also the "active" flag does not look
> much helpful and can be removed.

The @active flag is useless. It should be removed.

We have kmsg_dump_get_line(), kmsg_dump_get_buffer(), kmsg_dump_rewind()
as an in-kernel interface to allow retrieving the kernel buffer
contents. To use these interfaces, the caller only needs to have an
iterator that is initialized using kmsg_dump_rewind(). These functions
can be (and are) used, regardless if a dumper has been registered. And I
think that is OK.

The used buffers (like the iterator) are local to the caller. So there
is no need for the kmsg_dump_*() functions to be concerned about any
synchronization there.

Then we have kmsg_dump_register() and kmsg_dump_unregister() to allow
for registration of a dump() callback, to be called when the kernel does
panic/oops/emergency/shutdown. Presumably the registered callback would
use the kmsg_dump_*() functions to access the kernel buffer. Again, no
need for kmsg_dump_*() functions to be concerned about synchronization
because the buffers are provided by the callbacks.

> As I said, this is likely beyond this patchset. This patch does more
> or less just a refactoring and helps to understand the dependencies.

Aside from removing the useless @active flag, I am not sure what else
you would want to change. Perhaps just fixup the comments/documentation
to clarify these interfaces and what their purpose is.

John Ogness
