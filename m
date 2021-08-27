Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4448C3F9D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhH0RRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhH0RRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:17:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF7C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:16:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k5so15845588lfu.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a19KJLPA9Kw3mdNWbG0ze5xClxOMuIiH5wNzKQGXOAQ=;
        b=M2TmKG29RGiqOQNBpAzk/kUTH/AFcTJgygJI79NLgmECLhJdI5NaD/k9T/EZR3De52
         aaMjwMY0T5CbqDw/zxY8r22SxE+g2kU3b7s3f+vG5NDGKHc98kl2VjEr6R3qGg1lYsQK
         WcLITTAIUglaZfJSbVXNwUO074B2xgGqPh/GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a19KJLPA9Kw3mdNWbG0ze5xClxOMuIiH5wNzKQGXOAQ=;
        b=tsgH7afqnSfMWYJcvyKEhB144adgkeZUhmX5nccLPBHgi9/LvQxoldcPqRsF+/V0ie
         lP3DGbnD/+p1OraXEP6y/0YS7jJNwUIgVLcPbSCA9/Toi4lFyFXQiRkKFoIaSCVtZb0S
         tNah7KXJHzWmq9ByyDmC9fnNsoStuxmYQn+p4z+FLdEjeqX4QsQBXMSojQqIyypR5VU8
         IJ/O1a5RjzS0vyTSYVZQA/92q2ScuOjg7jqv0PKx7r8h/eKeOR60zriK3t+hwdRaH+9J
         r7XhQpGExVgLUbV9mHVDbgbMAyIwoCNXECaCK+AeIgeowY8VVOuEVQSROgM8hFpoC75x
         uwIQ==
X-Gm-Message-State: AOAM531WTqFec4JhAaHLGH0tIAvKp7AhiEehxKqCXa+Kw0ZUtmrQ1W1k
        pDxSCFmxZu6nGFiEHz2UHjAJPaRVgICSrEsb
X-Google-Smtp-Source: ABdhPJx8wos7Tj7qyYBdF3PCNlhoD6v/AXw7faCxHLYs9qZpIuVL8t608/FhMAHm4TGJ5yb4sPwoZw==
X-Received: by 2002:a05:6512:1144:: with SMTP id m4mr7507006lfg.267.1630084604511;
        Fri, 27 Aug 2021 10:16:44 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id x74sm648379lff.54.2021.08.27.10.16.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 10:16:43 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f2so12690680ljn.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:16:43 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr8541721ljq.507.1630084603229;
 Fri, 27 Aug 2021 10:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210826131747.GE26318@willie-the-truck> <CAHk-=wi8Wxazuq+E4_V0GG4eda0rNpZi76AYWQe7xfPZAAexAQ@mail.gmail.com>
 <20210827074041.GA24309@lst.de> <CAHk-=wjd28sN9khO=1j6zmBk+2n4_e+SY1URjW9hzsHSAZU+7Q@mail.gmail.com>
 <20210827171041.GA28149@lst.de>
In-Reply-To: <20210827171041.GA28149@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 10:16:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=+P1+HQXhrszxN_BgWtLc-=dWiT61KzogcJU3hnLrtQ@mail.gmail.com>
Message-ID: <CAHk-=wg=+P1+HQXhrszxN_BgWtLc-=dWiT61KzogcJU3hnLrtQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fix for 5.14
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:10 AM Christoph Hellwig <hch@lst.de> wrote:
>
> They CCed me on their earlier discussion, but I did not catch up on it
> until you responded to the pull request  If I understood it correct it
> was about a platform device mapping a MMIO region (like a PCI bar),
> but something about section alignment cause pfn_valid to mistrigger.

Yeah, so I can easily see the maxpfn numbers can easily end up being
rounded up to a whole memory section etc.

I think my suggested solution should JustWork(tm) - exactly because if
the area is then in that "this pfn is valid" area, it will
double-check the actual underlying page.

That said, I think x86 avoids the problem another way - by just making
sure max_pfn is exact. That works too, as long as there are no holes
in the RAM map that might be used for PCI BAR's.

So I think arm could fix it that way too, depending on their memory layout.

(x86 has that traditional hole at A0000-FFFFF, but it's special enough
that it presumably is never an issue).

                  Linus
