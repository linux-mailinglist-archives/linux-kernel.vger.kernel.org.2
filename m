Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ACC42F1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbhJONKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236523AbhJONKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:10:23 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64313C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:08:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id x1so7614386iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKgbBbllKYLOnYYBWfUPT+0UJFGXr6hxe1bIf87m+Wo=;
        b=SoNpANbU5l3QtOW/vGGOLfrraUHtPPFJHwbst3D088WlVHAwDQjXeAQOCBNympFuKB
         9gBQ8xWQQrbimJRhzJUQ3Ch0P7Om/vBIS/Pu+CCde7f2dawgpCWb4VH1c8gvnbW7TUz1
         uB5XbS1uNj5KY4pLVxEdSiqywlTSNwgUv4GVJTVE2/4tzVbks8fw/bUPspU4fPRs64zA
         FejgjqEYfiTblKpKTRDNuStXNG1FMjHGo7bIIPIM5CQ0Jl9NCqmihcjL/taeZnl8Ls+9
         XohSn/zfQK1/REUxttESjLCYspoGymF3dxq00NZ0w53mj28RB8opkG+Ct3TVrR71ffei
         vE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKgbBbllKYLOnYYBWfUPT+0UJFGXr6hxe1bIf87m+Wo=;
        b=YgJaijUKjfxmcEaSu0GmK7X2Xgh58L3QNo52zDbLEZvmlY9Ct69ITNKRbjZEclELTM
         mu0x145ezwpHNHwoqxNSggGlx3IzBuZinOwUFzrT3kBiE4noFFSwzqSXFLu9aHnQc7tE
         IUhjVpY4175ejEtvlR1ZyhMsP1gdjFtXkKOzx2Uv6e4adPweoD25IXC2sfQNgcHLyA4k
         FjdPww5QIS7I380vKdMqsd75Cvfw2hnoepoQJ3NI1ThJPu1xCASsYnOfSjzZIfrFGDD+
         0FIH9FkClC636Z+mniKJWGuex+BfHHHOC2Ag26+bX5x+0M7sRP6F7FXbk1rHzJh+h1s5
         g/9A==
X-Gm-Message-State: AOAM531SqDwmlhJcdN5VC3frLvma2rOG/Bna7ODaB4A9lqUH7oG2H60L
        8IDwk0xXuUNR5WVRuS+gDROC1lTF82CITPsKAWg=
X-Google-Smtp-Source: ABdhPJwEmywvJIgAYSX/r8WesMxLQwdryjCg5hg6VeZMshC9h06xocgocnLZSxPO3Zi3lh4y5mOek8ju9Tia6SX7A7Y=
X-Received: by 2002:a5d:9d56:: with SMTP id k22mr3555793iok.177.1634303296843;
 Fri, 15 Oct 2021 06:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211015090530.2774079-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20211015090530.2774079-1-linux@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 15 Oct 2021 15:08:05 +0200
Message-ID: <CANiq72mG2dX++A9S9+ycS-67rbkhFgF7B9wgEEpOoBKYpgPAkg@mail.gmail.com>
Subject: Re: [PATCH] linux/container_of.h: switch to static_assert
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 11:05 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> _Static_assert() is evaluated already in the compiler's frontend, and
> gives a somehat more to-the-point error, compared to the BUILD_BUG_ON
> macro, which only fires after the optimizer has had a chance to
> eliminate calls to functions marked with
> __attribute__((error)). In theory, this might make builds a tiny bit
> faster.

Thanks for this! Very much in favor!

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Perhaps Andrew may want to add a link to the related discussion
thread: https://lore.kernel.org/lkml/20211014132331.GA4811@kernel.org/T/

Cheers,
Miguel
