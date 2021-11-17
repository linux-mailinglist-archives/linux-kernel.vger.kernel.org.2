Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B2454D64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbhKQSua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbhKQSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:50:29 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66170C061767
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:47:30 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r11so15383836edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2GQP2tRGysNgPEKNCjI+dwty2vanWOhkRb6VoLXLY6c=;
        b=cwihSbWXg/XvJyyox4hBavRvB43vlOFqjx0Ds7R7QUBkVvFBWqFdGsRVpbdaqduTXV
         lWY/xgnS2OvmtgH0WOAYFCikajlVm8p7uWcpv/7XvH7YVsRymkbcLTFNZhoMH0OkFNib
         x61xgU0vbY/zNqkzXCo3Wcdgl/mo2Dc+R/xPntSCtRJmojF9TQ/2taROZZJBYzLvHDlG
         Ua4m3kTdCLHG4QSdfXIk/EfcdIYLaEpoQkQdYKY4GPayfIKKDcMzsPtUmVfgsoZJc0Jy
         f5Pwr4cJV70tcrnPJXyRXfmym7oh/x1Ug7FP2E5gm1tDNXuGrayTDOMDF7tcZ5secqag
         Q6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2GQP2tRGysNgPEKNCjI+dwty2vanWOhkRb6VoLXLY6c=;
        b=YPWrGoEej7bMPYJm+TxpMkHMOFhULKxcNm/JVE7xPruBuzY5zJxtaDmZ1s4Iu4L32D
         Xaoa+qymhEpSkWbYCkot84mFn2qknGaz+D9la72lgYJFhueyvs2MgRd17Q6Py+hudsza
         ONLS961+fqZWf+hzLKnzDGyAn3J1wDON6vkLbGDauVo1ib3pzTn+HCPYZRGwR8Vx5LtK
         YRp7R+1duV18pfHC1jpsy+1XNBU4/C++SSqj86863/Eai7r0ZsoqY+yy4U8qshLpPy0x
         Z+yvDFnqtk/m/XD+xcly+Vl3ah7zXjBO20JsF9lOg2sLHWWm6rYNV7S7SYO+yXLAn52t
         VkKw==
X-Gm-Message-State: AOAM5306P2Ya/51TuiJ8WYm+pKI/6XugUm8EI9iuovLVMGeY6rvay4QS
        vOAALDWTiBFwDuGAozRGOgzQlTzLYTjZMum2ZsoKXA==
X-Google-Smtp-Source: ABdhPJzzVIVN1wyydH6f4f7OlGu6N3bX8zKWGU3H6C2rPo0t+oyEeAHFI/swWYHkGFU26QqJA7D3qJ52L+jOiMsxclQ=
X-Received: by 2002:a17:906:140b:: with SMTP id p11mr24492849ejc.116.1637174848825;
 Wed, 17 Nov 2021 10:47:28 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 17 Nov 2021 10:47:13 -0800
Message-ID: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
Subject: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rr, a userspace record and replay debugger[0], is completely broken on
5.16rc1. I bisected this to 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7.

That patch makes two changes, it blocks sigaction from changing signal
handlers once the kernel has decided to force the program to take a
signal and it also stops notifying ptracers of the signal in the same
circumstances. The latter behavior is just wrong. There's no reason
that ptrace should not be able to observe and even change
(non-SIGKILL) forced signals.  It should be reverted.

This behavior change is also observable in gdb. If you take a program
that sets SIGSYS to SIG_IGN and then raises a SIGSYS via
SECCOMP_RET_TRAP and run it under gdb on a good kernel gdb will stop
when the SIGSYS is raised, let you inspect program state, etc. After
the SA_IMMUTABLE change gdb won't stop until the program has already
died of SIGSYS.

- Kyle

[0] https://rr-project.org/
