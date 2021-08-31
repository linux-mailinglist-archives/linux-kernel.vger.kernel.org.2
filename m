Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552C83FC176
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbhHaDTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 23:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhHaDS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 23:18:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D699AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:18:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e7so15393985pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MHOGIKnTugS13OtVhVAw/dgLV35w9vlE4iezk8tgDSo=;
        b=LHioZtFps30H7Whej1ENLJTaN2XoBiRa5+P5hiWslhRsZ8P+bxzJUOmoncWBc1X0sX
         wTs5InF9aLDd8m/0TrE2r8ys2kDo765nZI6pTZJaUPAxMoJ0Ib+ZODJXh8TTdRoaefPQ
         jddMhevO16/P2aZVb4nO2Yja1HV2rHBLt8cBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MHOGIKnTugS13OtVhVAw/dgLV35w9vlE4iezk8tgDSo=;
        b=YSybddw++XE8dgFF0lUZqQA+0SJcfABJ4zwayI6Xzf+YSGCm+Nhn7m0+HHx5i1K9WJ
         lZdEwbvG3AfHSYcStbPPDvsJ5+n56QCddGCh4ya9CKQ/LCQLjQFnLb9iHGUabyuGgx4L
         rwtyGtw8JQc17XcD1IILx0okaa4o8hsEV4H1pexEBBqc6phJedB9iePz2JOCweBN2/Fd
         wGhoxsTeAUBOxhXwxmtDZwnprEk72EdldVtlxgQvqmdSRowNZqOXab+DFbHGcL0Bx6Ha
         cJ1FiZEoJuVeWVNVBjykz1UTU20TqycEnV3dIAJNktSKTvDcmK2qKxvtunHEs/uGGdyA
         Jarg==
X-Gm-Message-State: AOAM530FUHe64OJGihqLxf/GvWHOH0xU4blHBfHD5kMALCTgTeRNDgS5
        IBmWAQr7BAtVbaJGEErb+TPVxg==
X-Google-Smtp-Source: ABdhPJzsYEZTu67g6hoFHaQ2rw6OtW+6QLC5AKuqY27yUnJARsyEw0b0gx1bIxwhM/exByfH4SPYmg==
X-Received: by 2002:a65:44c6:: with SMTP id g6mr24556398pgs.442.1630379884279;
        Mon, 30 Aug 2021 20:18:04 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:6d52:87b8:b55b:8800])
        by smtp.gmail.com with ESMTPSA id u6sm17979862pgr.3.2021.08.30.20.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 20:18:03 -0700 (PDT)
Date:   Tue, 31 Aug 2021 12:17:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel hang during reboot when cmdline include a non-exist
 console device
Message-ID: <YS2fZ1sknFYKtJFi@google.com>
References: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/30 19:53), Linus Torvalds wrote:
> 
> There's a bugzilla for this, but let's just move it to reguilar email,
> unless some of you want to track it that way.
> 
> The bugzilla entry says
> 
>   "When reboot， the capslock key of thinkpad x1 starts blinking"
> 
> which sounds like there's an oops that just isn't showing, quite
> possibly because the console has already been shut down.
> 
> I didn't test this out, and would sincerely hope that somebody else is
> willing to follow up on it since I'm in the busiest part of the merge
> window.

[..]

> > https://bugzilla.kernel.org/show_bug.cgi?id=214201

I think normally wrong/empty console boot argument should not cause
problems. We have a huge number of devices that use console="", for
instance. But on some hardware this triggers panic(), very early on.

I have the same symptoms on my laptop, and so far haven't been able
to figure out how to track it down, but I need to re-start my investigation.

In the meantime, we had a series [0] but ended up reverting it.
I think we need to revisit it, namely the part that starts with [1].

[0] https://lore.kernel.org/lkml/20201111135450.11214-1-pmladek@suse.com/
[1] https://lore.kernel.org/lkml/X%2FfWGjYI5LapMdGW@jagdpanzerIV.localdomain/
