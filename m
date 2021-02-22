Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2DC3221E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhBVWAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBVWAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:00:07 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF84C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:59:26 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id o16so56153572ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJIv4Ygz9AuGt+quvqZA7NYt+2bmBkRDf9RDuFtCa74=;
        b=KLqsR+th49j951zmhVFHwF/NJMWPUj6QfyIdTBekD2cnJUZXpMiZRZWkXdfZ4P4/OU
         ROU3htWTExfOB0tYutUPXaAOf499c4qThcjvx620df6tZ65xkSboKzk5IU5PPvC8z5Gg
         FoZOoZx11F23YvlYI+qBmm4m7/+nwWTaHok5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJIv4Ygz9AuGt+quvqZA7NYt+2bmBkRDf9RDuFtCa74=;
        b=Ld71Kd+D765eh7r66DrHWky6SK6uRqui3TaZGdJB3NrcJvJVjds0VY8pSE71ZQhebD
         9UpJAGIwvmoLHiKZhxnSUrp/WmkyujPkLAvsf2Kl3tVyy450hipr72nI6Yvil6TJ5Spa
         Sx08jn1AFj7neZvb6pZc8n/tN+h7OxevuCtiyjRAdWDrOHGj/k7EIX6GOhdHtPOlTPPS
         K7kFj7ufYc/XWJx5xp8BCZP7SmF/rDDB4YbM0sheblLzNju1A3rp889FQ2rgDZI9Xt2p
         /I1bk2C08+QFEnvc5OOBQFCE2491p2OEmc7Q1N5slNLU0FbIxqLatGOkhQAlyL2qs5s6
         d4Nw==
X-Gm-Message-State: AOAM532whFz5bnZ6XdGH+Jo+NUrUImo09Vopl19+pVW/IYT6J4CAq7t+
        ndYYvfXV+Xr6qtdu+Tn266hpiqWnL8uODQ==
X-Google-Smtp-Source: ABdhPJxTHlpKjERqQoK3qzD88V8xhy2F9T+ZWx+OwqlNJ+v/AcSe6sbi+awjHN5vT/dh5PkJ02kAMQ==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr7107815lji.200.1614031164588;
        Mon, 22 Feb 2021 13:59:24 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r18sm2190616lff.270.2021.02.22.13.59.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 13:59:22 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id h125so8181862lfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:59:22 -0800 (PST)
X-Received: by 2002:a19:7f44:: with SMTP id a65mr14379914lfd.41.1614031161978;
 Mon, 22 Feb 2021 13:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20210216224751.7367-1-alobakin@pm.me> <202102171006.DD2F341@keescook>
In-Reply-To: <202102171006.DD2F341@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 13:59:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvSLSKsa5ZbBCTqszv3XXdvQNRTQk8adFApA7MbK5+ng@mail.gmail.com>
Message-ID: <CAHk-=wjvSLSKsa5ZbBCTqszv3XXdvQNRTQk8adFApA7MbK5+ng@mail.gmail.com>
Subject: Re: [GIT PULL] clang-lto for v5.12-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 10:08 AM Kees Cook <keescook@chromium.org> wrote:
>
> Ah yes, sorry for overlooking that. I can send a follow-up PR. AIUI,
> it's usually better for Linus's workflow for me to build on sent PRs
> instead of resending. (But given the merge window disruption, we'll see
> what happens!)

Since I'm only now getting around to looking at the stuff that wasn't
obvious, can you just add the fix and send a new pull request for the
fixed version?

Power seems fine, I got internet back on today too (I was working by
tethering off my phone over the weekend), so I should be all back to
normal.

              Linus
