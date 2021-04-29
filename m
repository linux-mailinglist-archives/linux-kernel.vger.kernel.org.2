Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD88D36EE41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhD2Qhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhD2Qhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:37:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA09C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 09:36:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 4so45908764lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jy1gsfA2QLvOvx7TBvVpUXXLbyGvmt6zTTbfyCza5Q=;
        b=e4nJJe8AlWJAidgWI6OhihjcNqgwz0DPI5Rl5bu5T1BqIhh4NlFmQJRL449TeVMK5y
         ChHE9s6lfcj3/LCDVQtcCqr9Wmb1XcpRoGlvPNWK/jjagajCseaN2xGpyJacHDtsZaYY
         4xMHvg4nD4E30NOL+TVcLYCkKH7UYRgfAT6Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jy1gsfA2QLvOvx7TBvVpUXXLbyGvmt6zTTbfyCza5Q=;
        b=KhIkUkccQegq+J+MtaK/5utiN23+fB6LZqi8O3a3pz95KFQPhsMe1KzUa1oYWNa5wH
         0QTBUNT+WiPUpegJnWhu+0DPaJvU67JDo9LbsKs8vfxadd4JhR1OtV7/00EdRUSqadNQ
         t1jbmpN4YbGYqpWfqLU/l3M0DUuRSM6sMLH5JujfTzsPOa2+/pHaY1Hvyql4R0rI4hhz
         9ObDqpZMIuQhr7wKMt2Try2a2lTnYSPqdC73vnn11x1sEHIqgPO3OIPPCwrMdGqy4MIJ
         4L/DjsDolS2YyfmHkIRxuv/72S7vaL6ytVPcqYxvGNtuSjQ9y7gGEtBn9QvahTjOpZKx
         acWA==
X-Gm-Message-State: AOAM532RX6Rsun/pOLnlyVJDv7AN9+II1b8dgalJ2tlrwOgHMifL3sF5
        VMQiWRexvyOyj9mcxFKxU2wpZQDaHC1/VJ9h
X-Google-Smtp-Source: ABdhPJzry45nGa+wW9p8SWl12s0zTtPrlY9XS4zQSoDdElUjns3RXjRkrz6SYxi1luq5CJoxDrjjWA==
X-Received: by 2002:a05:6512:3f93:: with SMTP id x19mr315041lfa.182.1619714201104;
        Thu, 29 Apr 2021 09:36:41 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f11sm25716lfu.109.2021.04.29.09.36.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 09:36:39 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 124so24787458lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 09:36:39 -0700 (PDT)
X-Received: by 2002:a19:7504:: with SMTP id y4mr273122lfe.41.1619714198332;
 Thu, 29 Apr 2021 09:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wibrw+PnBiQbkGy+5p4GpkPwmmodw-beODikL-tiz0dFQ@mail.gmail.com>
 <20210429100508.18502-1-arek_koz@o2.pl>
In-Reply-To: <20210429100508.18502-1-arek_koz@o2.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Apr 2021 09:36:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYiKOYTtU6DifULbj0tmFLJf2Va5ScZW0dCgWi8=-c1A@mail.gmail.com>
Message-ID: <CAHk-=wgYiKOYTtU6DifULbj0tmFLJf2Va5ScZW0dCgWi8=-c1A@mail.gmail.com>
Subject: Re: [PATCH v2] proc: Use seq_read_iter for /proc/*/maps
To:     "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 3:04 AM Arkadiusz Kozdra (Arusekk)
<arek_koz@o2.pl> wrote:
>
> Since seq_read_iter looks mature enough to be used for /proc/<pid>/maps,
> re-allow applications to perform zero-copy data forwarding from it.

I'd really like to hear what the programs are, and what the
performance difference is.

Because I'm surprised that the advantages of splice would really be
noticeable. I don't _dispute_ it, but I really would like this to be
actually _documented_, not just "Some executable-inspecting tools".

What tools (so that if it causes issues later, we have that
knowledge), and what are the performance numbers?

             Linus
