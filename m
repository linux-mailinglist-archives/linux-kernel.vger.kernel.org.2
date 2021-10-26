Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7586543AC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhJZGMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhJZGMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:12:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FB9560FD7;
        Tue, 26 Oct 2021 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635228626;
        bh=jlo0wSpQEg3b4uT94kNaKHxLqywsLkSxtk+euI6cbGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zcyqYjur+Wxxc9kte4zvlS6ZJNMFVyYmwoGNA2tWWuQPm5Rpral6BUuiR6gYJHb7x
         OhHAfDCqRUe6AC7xKNdI+ZPUTuQ7tYDP+IRQ1PAf70hWggTtmk/8aeAkeqECxqoymn
         AonoQuErZfse6VT2SXBMLjSlaWlq0IKHZZ9zVyZ0=
Date:   Tue, 26 Oct 2021 08:10:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YXebzdZz8oN6w+T0@kroah.com>
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
 <20211015024658.1353987-3-xianting.tian@linux.alibaba.com>
 <208f7a41-a9fa-630c-cb44-c37c503f3a72@kernel.org>
 <cd195483-93c7-23be-8f4c-9cf7f25a3065@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd195483-93c7-23be-8f4c-9cf7f25a3065@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 02:02:21PM +0800, Xianting Tian wrote:
> 在 2021/10/26 下午1:10, Jiri Slaby 写道:
> > On 15. 10. 21, 4:46, Xianting Tian wrote:
> > > @@ -151,9 +142,11 @@ static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
> > >   static void hvc_console_print(struct console *co, const char *b,
> > >                     unsigned count)
> > >   {
> > > -    char c[N_OUTBUF] __ALIGNED__;
> > > +    char *c;
> > >       unsigned i = 0, n = 0;
> > >       int r, donecr = 0, index = co->index;
> > > +    unsigned long flags;
> > > +    struct hvc_struct *hp;
> > >         /* Console access attempt outside of acceptable console
> > > range. */
> > >       if (index >= MAX_NR_HVC_CONSOLES)
> > > @@ -163,6 +156,13 @@ static void hvc_console_print(struct console
> > > *co, const char *b,
> > >       if (vtermnos[index] == -1)
> > >           return;
> > >   +    hp = cons_hvcs[index];
> > > +    if (!hp)
> > > +        return;
> > 
> > You effectively make the console unusable until someone calls
> > hvc_alloc() for this device, correct? This doesn't look right. Neither
> > you describe this change of behaviour in the commit log.
> 
> I mentioned such info in the commit log:
> 'Introduce another array(cons_hvcs[]) for hvc pointers next to the
> cons_ops[] and vtermnos[] arrays. With the array, we can easily find
> hvc's cons_outbuf and its lock.'
> 
> After you pointed it out, I just found what you said make sense, I checked the code hvc_console_print() can support print before hvc_alloc() is called when someone use hvc_instantiate() for an early console discovery method.
> I send a patch to fix the issue?  or these serial pathches reverted fisrtly then I resend new version patches? thanks

Let me revert these now and you can send an updated version.

thanks,

greg k-h
