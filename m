Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A715436E39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhJUXXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhJUXW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:22:59 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B25EC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 16:20:43 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r134so3034460iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jNypcQ3g46vmyczh20V/ouVF+9k+n33GgxhxhlzFVM=;
        b=gvLhpdKxPC6iwHPEJovrdC25s1Xkr0T/NWrCWtB8EbloRE/Xb0iJkimz4y4Ed/z0hj
         3LhCG4I6uXVJzLJTln3ti71Tbw+PNSdu4L9dGmaAOUTWjDXDBAfkx4L8puGiHGNrga5q
         Hlg/R6yZLsbBh3+1Kav06LiS+f8LZRBZeLqJZiCMgYVVOHr/wXqvWSrs646YKocjJKyg
         0iegnF86bYAZkqWeoFghejBf/bMZsKi8sm/2asXu6OTpzsLZe/wwRyXIEinekexp46iV
         nSds7P1E2lpX2vRLee9FpPlgQn+oRJBJ8DwMFCa3aS4Hge2ttzP2uJs/7JoRswbq1yXP
         H56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jNypcQ3g46vmyczh20V/ouVF+9k+n33GgxhxhlzFVM=;
        b=fYz/UJ5LrmtimftSooj21MiSM0/2FkEOiiLKCx+dfZOESUlNqXkEQtGS1INyN6HtKJ
         SbNKZxkSMvUTxhWZ/lu0cRY7cO/uhJojuUXA8dRJWTz+uDdVPrVQwQvStTTgRMCOs2Tc
         0HUvM7Tvk5mT46nsr9ZtEZBPKy4cu433TUyD6G84O5N2gMH9A7eCpmRutchSWGU+WQFi
         tuYISgMk+bvQtLLhbXxEHBVqmuLHzHH95NFgMsZfEnJChSK8NfUGj13hvoi6eE+FS4ni
         PsYFob4wfAsCmz1qgfAWJ6UFmAX8RcOHZc6emK/sy7fj8G6Dev+Jq1r5TezC5oN1DglM
         AhJg==
X-Gm-Message-State: AOAM530QbmQREw4bfniMNgeZqVVmeGTib10eCDJBS04ajcJekyOFjmEo
        5Ju+WINNsOQaaJxeeuCAX7qioXK+osR9Ww2ghzI=
X-Google-Smtp-Source: ABdhPJxR0AL0rRRUd73R0Y//e7pMjn6qgr02pg7gORQBCRpaAMGu2LYd5ukL9iH/j/Iz+QYHtvEF2O1tOzF2kffAyKw=
X-Received: by 2002:a05:6602:2d4e:: with SMTP id d14mr6276236iow.172.1634858442817;
 Thu, 21 Oct 2021 16:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211014132331.GA4811@kernel.org>
In-Reply-To: <20211014132331.GA4811@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Oct 2021 01:20:31 +0200
Message-ID: <CANiq72kJQ9JBifggdMad6yLyc9YFuqZnQ2Yahp3ieh=qZncq1g@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as __noreturn
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 3:25 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> `__compiletime_assert` declares a fake `extern` function
> which appears (to the compiler) to be called when the test fails.

Queuing this one through my tree.

Cheers,
Miguel
