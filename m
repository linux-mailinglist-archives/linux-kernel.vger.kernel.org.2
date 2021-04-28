Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229BE36D06F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 04:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbhD1CGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 22:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbhD1CGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 22:06:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 19:05:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q2so10715294pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 19:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K+/8ltcSzj4pSeYeJlp5W8nRAMi5XqdxM0qLV1h4WPc=;
        b=cHr7TQZuhTt9nEbf4BGsvSxM9oRZVh4iXC1Hg7xHRZu0NscWQN4Frnenp7jQNl/63x
         j+7aaXvpZntmVwR1xNnuxtkJjsgsKIMQ8s/Qzxxe439zNf9VxIermbBj9GYjmp088LDZ
         rChKWyFpSrmY+yNa3JzjnqkRWUXF5k78BHy0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K+/8ltcSzj4pSeYeJlp5W8nRAMi5XqdxM0qLV1h4WPc=;
        b=uZTvsIMoDiuaV9eb10kUGvYr0uCQIUZ6tOtU4cnIXPRmgKjRNX2ZyFaRNedolToGfz
         abLrDsaY6BjxaJjvUxglXhNVrcGMRsVpiakEVyixMKc8Wig9dhh7bbd8LSBRIt/WT+8Q
         4wn3m/X6fYcE/K5o+yT1RgrxDqYwZ94E8gY7sDfSX5fBMT0IXjzOPM2TTqhgfzu8ViEa
         ZORrNoMBae86GdxWhVglmthAF8bOxUSUKv8buZVBMWrEJ9YpWgEUoFsioakQSdekHJ/n
         TA+Fr0iwEui9VVVv1RbG0x5auh/Jx26gn+Qa8t2Y2KYOMoky12ybRXetfaBGcWHj5K6G
         BCCA==
X-Gm-Message-State: AOAM531h5/Na2+5aZadFZpEnTjxiqfFor1By1xCBxaTZqyDogpGPaLNB
        35dr0oXMP9Bfy+o5PLqix0u4bg==
X-Google-Smtp-Source: ABdhPJxD6SFnl44B7eINZhXvRs8ByPxI7vG2WLeCDAOd0OqN/YzmUI/zPHEC9PodbtaWQsaqucQjwg==
X-Received: by 2002:a05:6a00:1742:b029:27a:218b:5a85 with SMTP id j2-20020a056a001742b029027a218b5a85mr7128173pfc.64.1619575558452;
        Tue, 27 Apr 2021 19:05:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f3sm855747pgg.70.2021.04.27.19.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 19:05:57 -0700 (PDT)
Date:   Tue, 27 Apr 2021 19:05:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Will Drewry <wad@chromium.org>
Subject: Re: pt_regs->ax == -ENOSYS
Message-ID: <202104271857.4708C9A25@keescook>
References: <202104271619.0DBE456@keescook>
 <78327AF2-575F-415E-98D4-6ECDFE311D0F@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78327AF2-575F-415E-98D4-6ECDFE311D0F@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 04:51:06PM -0700, Andy Lutomirski wrote:
> Fortunately there is not, and never will be, a syscall -1.  But I
> agree that calling max syscall + 1 should behave identically to calling
> a nonexistent syscall in the middle of the table.

If that happens, we have to separate the meaning of -1L from ptrace,
seccomp, etc. (i.e. we can't just add an "else { result = -ENOSYS; }" to
the syscall table dispatching code, since that'll overwrite any written
return value when the syscall is meant to be skipped with a specific
return value set by ptrace/seccomp.

syscall_trace_enter() will currently return either -1 or the
syscall. Which means someone making a "syscall -1" will get the skip
semantics currently (though the preloaded -ENOSYS results in the
"expected" outcome).

arm64 recently had to untangle this too:

15956689a0e6 arm64: compat: Ensure upper 32 bits of x0 are zero on syscall return
59ee987ea47c arm64: ptrace: Add a comment describing our syscall entry/exit trap ABI
139dbe5d8ed3 arm64: syscall: Expand the comment about ptrace and syscall(-1)
d83ee6e3e75d arm64: ptrace: Use NO_SYSCALL instead of -1 in syscall_trace_enter()

-- 
Kees Cook
