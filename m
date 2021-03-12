Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B957B33987B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhCLUhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbhCLUgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:36:44 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EE7C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:36:43 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 184so8923994ljf.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krkiARkGrz5/9qGpL9CUupwhbPQyuxxXG7KhD8Ld0V0=;
        b=d28X0+NBaLjAXHqkOYSSMHN/8sLCFP8PgwarytmPJXZdFuIGjVwDK4LHZfzbF4itoj
         77YQls5hoXtFvNAZg3NvRzkxd0vJ5oRlUT05ul+Do9mg7HFFt5B9V37YJC4eqwLwbtde
         jpSyCgoLGjYpgKVLv9gguH/8hyxPWZIZbDwbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krkiARkGrz5/9qGpL9CUupwhbPQyuxxXG7KhD8Ld0V0=;
        b=BrY2aIDGiVJbE4UNnbDwx/Ka3xMXZSGNxlcEo/oZwcF8qRTXzfh8gPB33kcGxxlalD
         FEZsLXdkdqJKicqI4axVdevSd1LiGcBiJ8v4+l+sgks/+yb0rMVT28C+b6i8onUGzPmP
         fDbCMfh8iSElUf5/VtoWGm6PBzvW6rlV5trwwhGWP3Mes/6LrsNAbCP3xakxclrCyA/s
         FISIHyQ3Y94FcirnST3FTTp7BRlGcKsbexrXGZnn5lvva0w5aFRSd0393i6iTfaKErl6
         /Q6uHl6Pp3qlQSAZfXKAgrvII1O/srkO/eg3hKpFNvW4EkBSeJz1cNHWWM9QGILdZ/79
         8s+g==
X-Gm-Message-State: AOAM5326PwRmShUMP9l4iRix6PIprIpmS0VS0lxBLy+3oaerWHJvPESt
        cZWrls04k2JXRWrcZffYxv6XiH99yX5ntg==
X-Google-Smtp-Source: ABdhPJwPwQHzpZ96WuUFF1DWkMB+STE5dai8hWIkELUdkCveRhsqy7NLU80A/pIdGPmYqB64UcqDDg==
X-Received: by 2002:a2e:7008:: with SMTP id l8mr3404488ljc.461.1615581401599;
        Fri, 12 Mar 2021 12:36:41 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id w8sm2077397ljh.131.2021.03.12.12.36.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 12:36:41 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id m22so47261358lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 12:36:40 -0800 (PST)
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr545496lfu.41.1615581400478;
 Fri, 12 Mar 2021 12:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org>
 <YEtZ63iAralvR9eC@hirez.programming.kicks-ass.net>
In-Reply-To: <YEtZ63iAralvR9eC@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 12 Mar 2021 12:36:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXUVwytv60Zst_--y=yGbRGUAn1AgRTyzjJfoOO5B+9w@mail.gmail.com>
Message-ID: <CAHk-=wiXUVwytv60Zst_--y=yGbRGUAn1AgRTyzjJfoOO5B+9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 4:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Note that this also made all NOPs single instructions and removed the
> special atomic nop.

Ack. Good riddance.

             Linus
