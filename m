Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B30632A012
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575240AbhCBDyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240762AbhCAWPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:15:46 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74C3C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:15:04 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id e25so116677vkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzeVUaCzJnhJfJfVrJQ1TF93szrlaAkr3ouNQpEiPGQ=;
        b=iV8VerKLHxfI3fxO3wdeHJyeAFeY6iYDcAkOh7S6Is4RQ0suh7ftzIGZTJJCYvJbIf
         +JtGhMUAT0Lq8oVU4eN97qEm4Y+DoDdypKdSR4tZjBwAwhK2Pwh4t3FdYBElKccMgKPt
         D3ZSrxxJ7c0MnVRn8Bz2lPvyg4O+x/eQfL+5JPfNoSwkqDPRKQ5JFQXHLsANfr2x8Jwu
         dt624E1hbjFwKeCnzXIKYmmkG5VX9NTtFH6WVf873MTToVmwsPLFRnHtq8UQreRNqGTp
         deXk+GQtQNmjFErjmcCaY9pceG1x/QVPNDBFFaSS4eSPfmeBtlHixAsm8A0ZlzKYgQ+v
         CX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzeVUaCzJnhJfJfVrJQ1TF93szrlaAkr3ouNQpEiPGQ=;
        b=fkOs+7qpF/rY7BG2/HqCc5dBFTuSXI2EIke+NPmv4pBtDXQ91XPe9Opk/INoSJrLfs
         xaJh489vcBVQw4GcHIuKT1rGxPQUYKcNHrl3d7/tGfM6zHE2w/gZbVCKUmlzybHQ2HWq
         ut+XWJ5mdGpx6Fq45TqUkheGEzJS7x+d63BL/MDecXVz2YhYyXlcGGstFPhJ8H5oApbo
         rjsYjZLd+eSWG8Mryuoph22Vx6gHjTeqA9B+1/QEJT+NZadfQ+OOn6PB3Bzk3nczRx9x
         LO9ofEH0hlpNexJmD1fkNV6+8m+GRmpVvF6FZenk6j/n6u/gr+TshCB6nkdK85BVso25
         xFIw==
X-Gm-Message-State: AOAM530DRP0pX4xELfzG4Kn4CEo7Sx6FWNCuD21Zp+V49zlFY3yLksMW
        KNlN1nl9BwGPRtZ5xODHup9HXrWYTEwxz+GwaI1D2brdU4TeuQ==
X-Google-Smtp-Source: ABdhPJxO8yLE94qvlCLptsBfnRA6LXGQt8YZbFLKfXCyW4qh9SiHQW1qOk2tTvfHpKdKTUgu7ipGow1NXr39T0UG9uU=
X-Received: by 2002:a1f:4f44:: with SMTP id d65mr371633vkb.3.1614636902593;
 Mon, 01 Mar 2021 14:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20210301074027.GD12822@xsang-OptiPlex-9020>
In-Reply-To: <20210301074027.GD12822@xsang-OptiPlex-9020>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 1 Mar 2021 14:14:51 -0800
Message-ID: <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
Subject: Re: [x86, build] 6dafca9780: WARNING:at_arch/x86/kernel/ftrace.c:#ftrace_verify_code
To:     kernel test robot <oliver.sang@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 11:25 PM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with clang-13):
>
> commit: 6dafca97803309c3cb5148d449bfa711e41ddef2 ("x86, build: use objtool mcount")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Thanks for the report, I'm able to reproduce the warning.

> [    4.764496] ------------[ ftrace bug ]------------
> [    4.764847] ftrace failed to modify
> [    4.764852] do_sys_open (kbuild/src/consumer/fs/open.c:1186)
> [    4.765483]  actual:   0f:1f:44:00:00
> [    4.765784] Setting ftrace call site to call ftrace function
> [    4.766193] ftrace record flags: 50000001
> [    4.766490]  (1) R
> [    4.766490]  expected tramp: ffffffff81037af0
> [    4.766959] ------------[ cut here ]------------

Basically, the problem is that ftrace_replace_code() expects to find
ideal_nops[NOP_ATOMIC5] here, which in this case is 66:66:66:66:90,
while objtool has replaced the __fentry__ call with 0f:1f:44:00:00.

As ideal_nops changes depending on kernel config and hardware, when
CC_USING_NOP_MCOUNT is defined we could either change
ftrace_nop_replace() to always use P6_NOP5, or skip
ftrace_verify_code() in ftrace_replace_code() for
FTRACE_UPDATE_MAKE_CALL.

Steven, Peter, any thoughts?

Sami
