Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1D53F68B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239627AbhHXSFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbhHXSEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:04:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D83C061A28
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:01:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id j12so24684065ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCxb+VTz4cjVjB3faY8PYmPDiDFElSaMqsPr/FfkL6c=;
        b=TTbBK+uOHncqHzTPlHlqLNwRCow/uI7O1xrUhx5q6yORLlE6bHsr+dhSaSuXcvPC8W
         sSo9+Ef3wIF2fxdpq/IxupzammVvj/ottvH7stUJfbMNmbqddK9z1dT8S9X+kA7WeC7B
         pddO/dstyV3iOaE17BwK+pzEa2wK9BhJlKORo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCxb+VTz4cjVjB3faY8PYmPDiDFElSaMqsPr/FfkL6c=;
        b=ahBBuCfTuPkVXCLtI0jEs1bLZgcZEMQRTEKxiwvGzZjs2/5R/P2QOsM/cIy4WWZHqm
         B7QcOUlZ6fYxZTOknKGBC6NclUs3yBAYFvHR2ZtSiwvFhML9Hm9mjTgPBgUw2a6r2CKX
         P9iczz3STGLsAw13MfY4fdEr7btXdcn247cu7cObzkOESjdpK5boBEsyp24u6yu8magi
         EhYAJFkbUi/k/BR4o8NwmTAmYCZFUlE/rJ5x9p3blMABCV699Tn9kCBLVYD4nFYC8Xdu
         xuSFtyJ7W5W6LHCPySKaBUQTZe6EVAnmLjHdPhfJqS8KwzY23Ha8aMfZBpTD38eWRDvC
         2GXQ==
X-Gm-Message-State: AOAM531kyzxYZUbT+6T+boOf2cqvYBl+ffBfK+ZYHkHryMGtwI/N8zmw
        cvAE25ewcdWXwaLJr/8zFHQRPK0eck2HweQD
X-Google-Smtp-Source: ABdhPJykaoC93ajXXF6yJu0DxSgV8cmzVAq44qHo4gWErAH/XrP7m0sVaOUwKKcHa/wIzTMVwtCXeA==
X-Received: by 2002:a05:651c:1b3:: with SMTP id c19mr32732339ljn.16.1629828099937;
        Tue, 24 Aug 2021 11:01:39 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p7sm1810316lfa.258.2021.08.24.11.01.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 11:01:38 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id o10so47266520lfr.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:01:38 -0700 (PDT)
X-Received: by 2002:a19:500e:: with SMTP id e14mr28777692lfb.487.1629828098025;
 Tue, 24 Aug 2021 11:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210824165607.709387-1-sashal@kernel.org> <20210824165607.709387-74-sashal@kernel.org>
 <CAHk-=wiQhb689WEk__vLy-ET4rL69cjq39pGTmrKam=c_0LYGg@mail.gmail.com> <YSUt8NdA+5EPJIyD@sashalap>
In-Reply-To: <YSUt8NdA+5EPJIyD@sashalap>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 11:01:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgftHEoWsxidkWD3YodMVJKGuRz1JYG5=75-Rj6wbBwwg@mail.gmail.com>
Message-ID: <CAHk-=wgftHEoWsxidkWD3YodMVJKGuRz1JYG5=75-Rj6wbBwwg@mail.gmail.com>
Subject: Re: [PATCH 5.13 073/127] pipe: avoid unnecessary EPOLLET wakeups
 under normal loads
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:35 AM Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, Aug 24, 2021 at 10:00:33AM -0700, Linus Torvalds wrote:
> >
> >Honestly, I don't understand the performance regression, but that's
> >likely on me, not on the kernel test robot.
>
> I'll drop it for now.
>
> Ideally we wouldn't take it at all, but I don't think any of us wants to
> field "my tests have regressed!" questions for the next 5 years or so.

I have a theory about what is going on, and it's not a new problem,
but it would explain how that test might be so bimodal in performance
if you happen to hit the exact right timing. And the test robot just
might not have hit the right timing previously.

See

    https://lore.kernel.org/lkml/CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com/

with a test-patch in the next message in that thread.

So it looks like another case of an odd test, but it should be easy
enough to make that test happy too. Knock wood.

             Linus
