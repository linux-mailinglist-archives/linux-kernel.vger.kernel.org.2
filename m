Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD4D43A592
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhJYVOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhJYVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:14:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C61C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:12:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so14750289lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVX+3lzLvWhUn4tentelh/747tIk4zl+rRWtSWpc9Yk=;
        b=aQgz9Tv6mpoE3tF3MaUnqcoIZTzd9NM67EmB21HgN8ByNXIhPpJTwMQIdse+uBCvM/
         F0wjX2GSLWEyTKdsledeQGcf3ALxbdkQjFpv24RgLL5kI9ONayzSXg0GiAruZkeL4Mv5
         m+VLxE02J/Zxm8OQiM46Uvgda5b858wHUBZVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVX+3lzLvWhUn4tentelh/747tIk4zl+rRWtSWpc9Yk=;
        b=Rp9hh3Smj0a6BvqLChdxLiwgiXbNMT4TResGIguGeUrgYXehbFF+b9lcP8JCv+UXQo
         NC3YqUWETHlh3Z2U2MrPQ+8T5Y1xXlG2sa2jq48bDy6Y2eYYhzXnpMJ8yz0vqpDyDBPv
         AqqomgvMDLc05ZT7yovg1/L9wU++mxEoF8l2t7E+vhMNrVxhhRlZYHwkGCmOOOPdjoKP
         LldkCoxMjAVxGL6w/et7S2CJqFh1UIWNvGPS5oitD3Nqf2hYs1knmbTiys+IIJVUdURn
         48SceG9xdGv+pOcjJf8IqRMvipCE0YLqlQPZudeR7mhkhe8JOOEhEdtpQoo0EQDAyKaf
         yHsQ==
X-Gm-Message-State: AOAM531ITeipGV4X4h5evQg1dbDcXaRkwHgtFcxHe9egJyUWlFuCK2jx
        v/2ibQ9RVjzBpW9i79vkeGfB51N0z0dUKdyy
X-Google-Smtp-Source: ABdhPJxwv7l3T6e3YrgycgM1J+WmAMo9B9+URc/8FHYKXvDgOTai+jeap+CFY+hNCnMnG80PCkFOCw==
X-Received: by 2002:a05:6512:3501:: with SMTP id h1mr19080807lfs.446.1635196340697;
        Mon, 25 Oct 2021 14:12:20 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r3sm1748679lfc.131.2021.10.25.14.12.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 14:12:20 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id bp15so14750187lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:12:19 -0700 (PDT)
X-Received: by 2002:a05:6512:3983:: with SMTP id j3mr11474965lfu.402.1635196339690;
 Mon, 25 Oct 2021 14:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-10-ebiederm@xmission.com>
 <875ytkygfj.fsf_-_@disp2133>
In-Reply-To: <875ytkygfj.fsf_-_@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 14:12:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whS0PL0NZrz2d8a3V+8=4szSZ6jqkg5fkjeaEjMN_NX8Q@mail.gmail.com>
Message-ID: <CAHk-=whS0PL0NZrz2d8a3V+8=4szSZ6jqkg5fkjeaEjMN_NX8Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/32] signal/vm86_32: Properly send SIGSEGV when the
 vm86 state cannot be saved.
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 1:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Update save_v86_state to always complete all of it's work except
> possibly some of the copies to userspace even if save_v86_state takes
> a fault.  This ensures that the kernel is always in a sane state, even
> if userspace has done something silly.

Well, honestly, with this change, you might as well replace the
force_sigsegv() with just a plain "force_sig()", and make it something
the process can catch.

The only thing that "force_sigsgv()" does is to make SIGSEGV
uncatchable. In contrast, a plain "force_sig()" just means that it
can't be ignored - but it can be caught, and it is fatal only when not
caught.

And with the "always complete the non-vm86 state restore" part change,
there's really no reason for it to not be caught.

Of course, the other case (where we have no state information for the
"enter vm86 mode" case) is still fatal, and is a "this should never
happen". But the "cannot write to the vm86 save state" thing isn't
technically fatal.

It should even be possible to write a test for it: passing a read-only
pointer to the vm86() system call. The vm86 entry will work (because
it only reads the vm86 state from it), but then at vm86 exit, writing
the state back will fail.

Anybody?

                 Linus
