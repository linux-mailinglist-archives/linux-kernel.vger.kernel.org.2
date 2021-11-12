Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D968544EE84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhKLV03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbhKLV02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:26:28 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22235C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:23:37 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t18so23455988edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlmzwGFA4fDlxdznEeqdTaCKPH1HhGcx4T9b9UE3wT0=;
        b=TR0JF1xqWQNnVJgjHkpEeGZQS7s/t2K2iAUV/M5BITryofsnC2nBJAEeD93mztRcDh
         4XHpddduh39keAcpxpXdklSUgSJOaYSHCquSplv+WY99UjS56D8uX56ssfgke1cBfkQZ
         1ECpoP11aDxGLVpb9SQACE+cR71d0MuBmQ23Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlmzwGFA4fDlxdznEeqdTaCKPH1HhGcx4T9b9UE3wT0=;
        b=Asv+92T2ft0bGrLFU4Uasy7XZD0jt9St3377ebrtvIn5tWPUvbKAdiy80zFpkADOyi
         Bsi/STLI+gY0EqLV1nw6h88RbhJqx+V2TfnSHCmQkF77LuBRLGGKvq+GybqijpHMkghv
         IOCRBXHZo/zihfd0l6w6q2DZ0rrLOQ9iPiudigkDVlAR4lrhuzjM+LZ6vBNRlBlzlLQq
         UWi9l6+z+QlBIcFjNmDY/NY5pF6AinijVgnpiBZ153g05ssmuNqOVyz+EEwJnrJEDhSx
         ixeP0a1MvAnpJnOSUMVgWbv2Nnj5kCH3PUVm64ZyFg5lS6J18PEIJoL0tRkzA3pmswg7
         ra8g==
X-Gm-Message-State: AOAM532zq2D5YNn5G9sBPhL9FfMu2/LKp3qbKab80TEneTPDMfgR/dh0
        gT5pOydMWQMk9+s9TNOjYr80VgMgfi3ZldGGoN4=
X-Google-Smtp-Source: ABdhPJyvvT0vnmAS3AWyZsG5C3nSX8h38nf7itSKy2+RG5CIDFa8SKb0r5GIPiVtiU9A6EEl/8G2fA==
X-Received: by 2002:a17:907:d94:: with SMTP id go20mr23133765ejc.78.1636752215027;
        Fri, 12 Nov 2021 13:23:35 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id e12sm2965100ejs.86.2021.11.12.13.23.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 13:23:33 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id i5so17842060wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 13:23:33 -0800 (PST)
X-Received: by 2002:adf:cf05:: with SMTP id o5mr22951337wrj.325.1636752212641;
 Fri, 12 Nov 2021 13:23:32 -0800 (PST)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-9-ebiederm@xmission.com>
 <874k8htmb2.fsf@email.froward.int.ebiederm.org> <CAMzpN2jkK5sAv-Kg_kVnCEyVySiqeTdUORcC=AdG1gV6r8nUew@mail.gmail.com>
 <87ilwxrvu9.fsf@email.froward.int.ebiederm.org> <CAHk-=widK1vko2EN9PtV3jTo02u-expXxozui-fsK-0uKrcGHg@mail.gmail.com>
 <87ee7lqe6k.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ee7lqe6k.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 13:23:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whf-nR4xDSEDtXeowFn4QQKY3s_MXoM8Ha-dPiOzFzUxQ@mail.gmail.com>
Message-ID: <CAHk-=whf-nR4xDSEDtXeowFn4QQKY3s_MXoM8Ha-dPiOzFzUxQ@mail.gmail.com>
Subject: Re: [PATCH 09/20] signal/vm86_32: Replace open coded BUG_ON with an
 actual BUG_ON
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 1:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Still if we are going to check for userspace being silly that it should
> be in do_sys_vm86.

Sore, something like

        if (!user_vm86)
                return -EINVAL;

in do_sys_vm86() sounds fine to me.

It could in theory break some odd test-case, but I can't see anybody
putting the vm86 save area at 0 in a real situation.

But I could see some quick test hack doing it - the IVT at boot is
actually not at zero, but at fffxxxxx. 8086 is magic.

              Linus
