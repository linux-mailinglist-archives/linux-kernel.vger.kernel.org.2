Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA93FC128
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 05:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbhHaDG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 23:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbhHaDGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 23:06:25 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8FDC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:05:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id y23so15354104pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vzU1A7A9dM6sOFHUb4Dm16KSmTy2qTEVAOWldoDjUvI=;
        b=Y6GZTvHocXTL9Usa+zrNZpBvv/xgN/DAYog0Xg4Pbw42E+tQW6TeMBqEhqn/DF5HwJ
         PQTwLGjqDIbh3Z9xyjXhnXs4PYId/bvA2mXPTXjarlrHe/6OJplZymhbfghcJsaVmF9F
         qxgo4aDXcxoj7omQDuBQNZ9seX7r6UcefKyI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzU1A7A9dM6sOFHUb4Dm16KSmTy2qTEVAOWldoDjUvI=;
        b=tGIhace0HrdB9rXigKJQGtQIzgmpld21Bu//VfO0kafnUf0Tkt1kkWFwE9ygHPe/9E
         H5vGsW97s2RStjAQYXOuRK/Yntd0DLzrAdJCipnRNlSggS9JnCtLZT72KZAe6X351e10
         /w+c00PT96ImDVUArhvusyKFPhe7wGlYMP6IPCXR2XCqSygfZ2HC14jfl1Bn0Do8gXy6
         7Tl2g0npHMJZ3wKZI2WLwefWVw83iL7I0LDHbWCFEeP9IBTSs4zusM0OTSslHWkXppif
         sO7NVjRQ3U4hayma4dzqyGSB+9/Zoi9cuYJc0iJfdWWnOPGdRmxjWwC7y9n49Og30RfM
         G2fA==
X-Gm-Message-State: AOAM5321vioqGxlQg7I0K7JhNSV10fxsZbE77xnTYVvsE2lCVIZ8d1au
        MPOsJ/Xm9Aumr/OCnhbN1gCUZPMjdP7Dlg==
X-Google-Smtp-Source: ABdhPJyVx7iReecgVYnbxLfjCK6zDxvhIE6PHYXZA/eWqMIKvl7e0Clu16y+8i06rDwOgk5yXLVHzA==
X-Received: by 2002:a63:ce0f:: with SMTP id y15mr20646899pgf.249.1630379130477;
        Mon, 30 Aug 2021 20:05:30 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:6d52:87b8:b55b:8800])
        by smtp.gmail.com with ESMTPSA id u21sm18911863pgk.57.2021.08.30.20.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 20:05:30 -0700 (PDT)
Date:   Tue, 31 Aug 2021 12:05:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 06/10] printk: use seqcount_latch for
 console_seq
Message-ID: <YS2cdfN5/D1Jzelg@google.com>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-7-john.ogness@linutronix.de>
 <YQvWuzpAv1Tw/CoQ@alley>
 <87bl6bx68f.fsf@jogness.linutronix.de>
 <YQ1bsdh8PoLwBrnl@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ1bsdh8PoLwBrnl@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/08/06 17:56), Petr Mladek wrote:
> 
> A solution might be to implement a generic cycle that would use
> the right latched_seq and buffers. Something like:
> 
> enum console_mode {
> 	CONSOLE_MODE_NORMAL = 0,
> 	CONSOLE_MODE_ATOMIC,
> 	CONSOLE_MODE_ATOMIC_NMI,
> 	CONSOLE_MODE_REPLAY_ALL,
> 	CONSOLE_MODE_LAST
> };
> 
> struct console_mode_info
> {
> 	static char text[CONSOLE_LOG_MAX];
> 	static char ext_text[CONSOLE_EXT_LOG_MAX];
> 	static struct latched_seq seq;
> };

Seems to me like this wants to be part of struct console.

[..]

> Problems:
> 
>    a) The same line might be printed by more contexts.
>    b) per-console kthreads?
> 
> 
> Ad a) I am not sure if we could prevent duplicated lines when
>       the nested IRQ/NMI writes the same message that is just
>       being written by the outer context. But it should be
>       an acceptable corner case.
> 
> Ad b) Everything will get much more complicated with per-console
>       kthreads. We will need counters and buffers for each console
>       and each context.

Oh, yes, you are talking about per-console counters/buffers too.

> This is what I was able to come up before leaving for vacation. I am
> not sure if it is the best design/naming and it if it has a chance
> to work.
> 
> But it looks like a way how to re-use the same code in all modes.
> It might help to see what is the same and what is special about each
> mode.
> 
> 
> I would prefer to see something like this instead of the completely
> different code paths for atomic consoles that are proposed by 7th
> patch of this patchset.

I agree.
