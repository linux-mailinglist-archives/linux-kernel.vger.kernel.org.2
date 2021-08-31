Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B863FC477
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhHaIsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhHaIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:48:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF0C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:47:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g184so15963331pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5N6ypMdRcr4ZgmRIVnEGSKQmlW/QleP7nwivKq0B2gk=;
        b=fEA1pgeXgY439k3DG6eXcE8Z9rwXk1TPaOdTXAHlbIMwnyGAzpwZawIlOAVoitzZaN
         5tlkFMf3m8bEc8lHKdExKgyK3HvTXD9t1Fp0SGAIwdtUCTgKsRd0paTEwEIRgJsjiu7B
         mR6NFvpHG6p9DjhUVhPye/9cZJSgmHWQGgXKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5N6ypMdRcr4ZgmRIVnEGSKQmlW/QleP7nwivKq0B2gk=;
        b=LWT6LuVbkILEC4iyhLKT3mnyrXxPCI9UMCyHP0211CJdvM7hd6v1fEcCFgEg2ccLpq
         m0WCxaX+4FQqSGGZFZo8RhAo98UMzIemRqf0Lotd4YCDQ3u39YAmJsOKuzHpCr0XNMKU
         IsA7HvuqcX9p/dmZww2pMf2OTp5h22eB6Ptt5Fq+nJG5yoiNU6DFXg8PHW5VXWYRX4vZ
         2zjgMi+pmM/oPg64F8A4JzxhQ3tXxSsu10kB/gba0ijWK+f2KkBf7yHfGJqVDy0yS2oH
         G0gQrQfriIRNPjsFPS/69TPtUH0A1FXuaLcTEXPlFqKqASIYjfvfPxKiVTADB0YDnVeP
         6y2Q==
X-Gm-Message-State: AOAM532hyi0UgdbfcncJBwb6I4cGYXmCFkILM2q+pD1BdiRRpC5yFt8j
        OlVIAvjlWMkdrIZIQ4D9Hf52PiPAQV/QuA==
X-Google-Smtp-Source: ABdhPJwtbcTktFUBY59ABWOAhu/WBgzK2HSIOUKiz8ksf77kBoG8kyv+acHQb20HS0DvTrTRAvSqFg==
X-Received: by 2002:a05:6a00:16d5:b0:3e0:f6ce:f2f7 with SMTP id l21-20020a056a0016d500b003e0f6cef2f7mr26917409pfc.78.1630399673474;
        Tue, 31 Aug 2021 01:47:53 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:6d52:87b8:b55b:8800])
        by smtp.gmail.com with ESMTPSA id x16sm19845382pgc.49.2021.08.31.01.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 01:47:53 -0700 (PDT)
Date:   Tue, 31 Aug 2021 17:47:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        James Wang <jnwang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel hang during reboot when cmdline include a non-exist
 console device
Message-ID: <YS3stL0cTn5ZQSNx@google.com>
References: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
 <YS2fZ1sknFYKtJFi@google.com>
 <YS3k5TRf5oLLEdKu@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YS3k5TRf5oLLEdKu@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/31 10:14), Petr Mladek wrote:
> On Tue 2021-08-31 12:17:59, Sergey Senozhatsky wrote:
> > On (21/08/30 19:53), Linus Torvalds wrote:
> > > 
> > > There's a bugzilla for this, but let's just move it to reguilar email,
> > > unless some of you want to track it that way.
> > > 
> > > The bugzilla entry says
> > > 
> > >   "When reboot， the capslock key of thinkpad x1 starts blinking"
> > > 
> > > which sounds like there's an oops that just isn't showing, quite
> > > possibly because the console has already been shut down.
> > > 
> > > I didn't test this out, and would sincerely hope that somebody else is
> > > willing to follow up on it since I'm in the busiest part of the merge
> > > window.
> > 
> > [..]
> > 
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=214201
> > 
> > I think normally wrong/empty console boot argument should not cause
> > problems. We have a huge number of devices that use console="", for
> > instance. But on some hardware this triggers panic(), very early on.
> > 
> > I have the same symptoms on my laptop, and so far haven't been able
> > to figure out how to track it down, but I need to re-start my investigation.
> 
> Sergey, I think that you talk about the crash where there is no registered
> console and console_on_rootfs() fails to create stdin, stdout, and
> stderr for the init process. As a result the kernel crashes
> during boot.

Oh, good point, this is during reboot... I somehow missed it. I saw that the
kernel oopses when invalid console driver is specified and that sounded
familiar.

So these cases still _can have_ same root cause, but not necessarily.

> But the bugreport says that the system booted. It crashed later during
> reboot. It will likely be in the shutdown phase. It still might be still
> be caused by the missing console. But we should rule out other
> problems.
> 
> James, do you see the problem:
> 
>   1. When there is a real console registered. When you remove the
>      wrong console= parameter.
> 
>   2. When using "reboot -f" so that the system reboots a dirty way
>      without trying to shut down services.

And may I ask, just in case, if James can revert a revert of Petr's commit:

       revert a91bd6223ecd46addc71ee6fcd432206d39365d2

boot with wrong console argument and see if the kernel reboots without
any problems.
