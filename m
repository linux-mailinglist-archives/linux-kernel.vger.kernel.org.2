Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08F232744B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 21:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhB1UBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 15:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhB1UBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 15:01:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8CEC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 12:00:41 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d3so22019321lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 12:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fcxmznsEmcLxGBbW8cWc2lbwaA1/eqUxRmZQ/MkhaM=;
        b=dVTI/0oFaQfcowiF91H3OWQLFKuOaYt1Tpw+fVNyC32xb4OSnfyiVjTkCYepoi56j1
         KiISP1eU7G1330E0O6ENAV+rXwb0oLRA6iLLDOT0H+YiXIXtKvXQ9XCeJGItJRZuXnO3
         KMaNsZ1chmXi+ZDhNQ4hQczbnVsN+s1iCb7dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fcxmznsEmcLxGBbW8cWc2lbwaA1/eqUxRmZQ/MkhaM=;
        b=a4F78XRmldOOeQ9S0zLIMMbRSuWiRPOhzDyYyedSsEj9hIITEm5btFOQHn2TRjxRGA
         m6r7hIEaGEdtFhtmb70sYGo01Ms1ZzMw4S2jDvjjFIIp7BJyiXFfJvIfnKiBZzfw0TK9
         JB5m+vHrud5Y+bN9dXYs/xtTL7YkDpUNJH/932tRf6y2Gpk+yNyY7g+b3XCrIyIlC8SU
         /E0HZlrRKLuP2XAxepqWa4uTlSEwU4rRTDvIAkxviVMZPNTA+xurbzSUoUCCc52Zow6W
         pUjvaHFV05DsSZWWZIyEn/elUPIV3DXh+bIOoeZwxaxGz2hngfgjbx+Y734WKGrrKRAh
         ozfg==
X-Gm-Message-State: AOAM531t4bmpMYtkIhQPzgR9m7q5Syn8DoArCbRHuCeQYGjAIl2aHSMD
        sZ+cN4N8E1CQPM5v88WXij+V4Q3yYpnuwg==
X-Google-Smtp-Source: ABdhPJzGoGc/JStFI0dAiyL9+IK+1y9PYelFkyL6UJPRbLq+qkI9yJAFHUHiQN+F6A9UQnY/Ji4f0w==
X-Received: by 2002:ac2:544f:: with SMTP id d15mr7191251lfn.177.1614542439750;
        Sun, 28 Feb 2021 12:00:39 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b11sm2064006lfi.174.2021.02.28.12.00.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 12:00:38 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id z11so22008765lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 12:00:38 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr7223200lfu.40.1614542437955;
 Sun, 28 Feb 2021 12:00:37 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain>
In-Reply-To: <YDvwVlG/fqVxVYlQ@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Feb 2021 12:00:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
Message-ID: <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 11:34 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> >
> > End result: #pragma is fundamentally less reliable than the
> > traditional #ifdef guard. The #ifdef guard works fine even if you
> > re-read the file for whatever reason, while #pragma relies on some
> > kind of magical behavior.

You continue to not even answer this very fundamental question.

"#pragma once" doesn't seem to have a _single_ actual real advantage.

Everybody already does the optimization of not even opening - much
less reading and re-parsing - headers that have the traditional #ifdef
guard.

And even if you _don't_ do that optimization, the #ifdef guard
fundmentally semantically guarantyees the right behavior.

So the #ifdef guard is
 (a) standard
 (b) simple
 (c) reliable
 (d) traditional

and you have yet to explain a _single_ advantage of "#pragma once".

Why add this incredible churn that has no upside?

So no. We're not using #pragma once unless y9ou can come up with some
very strong argument for it

And no, having to come up with a name for the #ifdef guard is not a
strong argument. It's simply not that complicated.

               Linus
