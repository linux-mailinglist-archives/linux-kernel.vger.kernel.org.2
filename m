Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3097A422AD5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhJEOUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:20:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51548 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbhJEOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:20:41 -0400
Date:   Tue, 5 Oct 2021 16:18:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+hsztr/umJzTDpJmHDTmgfYbMGoKmREVcSnZcNhevQ=;
        b=VGiKN/QRm7H5oG4sR3emZufNoZwvRmDEv7QfPbR9x4oXoWseoa769Hok1o7OZH1X5eLzeR
        UMlrAKAlcAnxqgGJOJwzH2bYEGz4JOnQoD6J4fwSeA5siLIh745tcToDvJp+cP91nmPOCP
        UoDRD+Mq2eW2jtO7MvxgeBanL4zfiIDbnb8+bqbDoqMyF0RI87jZrTJ6lybbKhun1cZaa7
        zCZcMSu4/i73pMwYMhT7gu/2FFOnaZOSMBh6RM7hFkHZgxBrG7CuwQk6TohhnalCAcMDod
        Vqq//nwVj1oS9xvJqetXwWqIqnJK2jzNu2neu2CuNg7qj/tXaxT+OvJ4Pf0NAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+hsztr/umJzTDpJmHDTmgfYbMGoKmREVcSnZcNhevQ=;
        b=Sh3lWfIOR+kHVdD7hPIFQYl9xMUoI4BCOrajvlzEv3Fazd++aaOKMAAqSt2P1p0x22ox9a
        HLkpGi69Mr9NRQBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefani Seibold <stefani@seibold.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] samples/kfifo: Rename read_lock/write_lock
Message-ID: <20211005141848.cefuqo4eq5d27e6y@linutronix.de>
References: <20210923172918.o22iwgvn3w7ilh44@linutronix.de>
 <5cb013d281fc064a7e928eb16bdfa9d5d77987e1.camel@seibold.net>
 <YVxV8sKyc1Y62X7r@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVxV8sKyc1Y62X7r@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-05 15:41:06 [+0200], Greg Kroah-Hartman wrote:
> On Tue, Oct 05, 2021 at 11:42:57AM +0200, Stefani Seibold wrote:
> > Acked by Stefani Seibold <stefani@seibold.net>
> 
> WHo is supposed to take these?
> 
> Want me to take them through my char/misc tree?

Yes, please (if it is up to me).

> thanks,
> 
> greg k-h

Sebastian
