Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447B03F207A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 21:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhHSTUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhHSTUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:20:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30156C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:20:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u22so15103905lfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/UMoQYNiM0OhlEK7+Wk6CZ5b5LK1w4Xd45bb87WFug=;
        b=HUADSkb/5Kmj4z9hojcnMEtS2q7Pi4EfxrfMv4Y/PY1hCqOj8CEdD5A1IN35liPA1O
         /2LcpsfCAakMpVLHTcuqOx9ju2jR15GagGNXMtyO4UZXQLqjOqh3xDYYix/GTxIGzqk/
         GTZRGCM2KWS+l8wuA3ln+flK6POwqX/vKbAwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/UMoQYNiM0OhlEK7+Wk6CZ5b5LK1w4Xd45bb87WFug=;
        b=Nip5r32p1ZGfDTOt+6nFunFSrLkuK+0cmVEIs9Zsagk/Rnq5tHbvQy6HlZWNJFnV1m
         8bkSYH9mfJ+P3d3EQ/WTFgszibWvCQ3nPpaQyCa9m1+gjnoTh0GdFWlZgNaihEsxvPWT
         LGSPjDuLuKT8t0K8/dEO8QaSbcrUWi5aaF1SsTtwuFLFZ0Rw5P6PrCMUm8wYkv14LQ+a
         00U64O3zOv22glNIsxGnLxhnSWN/7sim+uwmpU1CbI0d0ZFatocPUgb/kqruHuYkqlS3
         PDta1MOBkNjVYhiI+1ZFeZKBow2WyHFh0zyeZZwMImcqfqZelD2Ut7Zl7Q8DY0jvXRw6
         9hkg==
X-Gm-Message-State: AOAM533IEUcx8shGNyZwQKpIOSBRQwcajfGUicY/sYBWx9olxJDXVr8N
        /96Viop2glz1aCA10BTNv0w8eaKdbpl6WZoZZ+o=
X-Google-Smtp-Source: ABdhPJxj8J51ypQlgR9LNRd8/5BrvkNmf2EpLL0RZsSN6y4iAj8UjlMKbAJAqKIWLWt6whUtkT4HRw==
X-Received: by 2002:a05:6512:3d22:: with SMTP id d34mr11985267lfv.326.1629400798399;
        Thu, 19 Aug 2021 12:19:58 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t2sm340270ljk.125.2021.08.19.12.19.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 12:19:57 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id r9so15227089lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 12:19:57 -0700 (PDT)
X-Received: by 2002:ac2:5a1a:: with SMTP id q26mr11471879lfn.41.1629400797296;
 Thu, 19 Aug 2021 12:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210819040517.GA329693@embeddedor>
In-Reply-To: <20210819040517.GA329693@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Aug 2021 12:19:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXUJbqhjkRSjOQ2Tm5OmyKv3_JUTh8pxxvykGaC+fM0Q@mail.gmail.com>
Message-ID: <CAHk-=whXUJbqhjkRSjOQ2Tm5OmyKv3_JUTh8pxxvykGaC+fM0Q@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.14-rc7
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 9:02 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Enable -Wimplicit-fallthrough for Clang for 5.14-rc7

No. Much too late in the release, particularly knowing that we have
Clang pre-releases that claim to be 14.0.0 and get this wrong.

So no way does this happen like this.

That's doubly true since the clang support for this all adds exactly
_zero_ upside, only downside: we made the gcc checks be stricter, and
gcc ends up having (a) more wide coverage and (b) doesn't have the
bugs clang has.

Honestly, I think the clang "version 14 or more" check is simply
buggy. We *know* that check fails. Don't do it.

Make it "strictly more than 14.0.0" which hopefully doesn't fail, is
cheap and easy, and which will make clang work correctly in the not
too distant future.

In the meantime, we have the gcc checks,  and we'll have a release
without pointless warnings from garbage clang versions.

                Linus
