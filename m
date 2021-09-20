Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E91541182B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbhITP3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhITP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:29:00 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5632BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:27:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e15so30702870lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkYY5lcGFh2USQXT1hiHpvyqlBdZwGnV7QY6uFjV4/Q=;
        b=JP/I4sNUuNpAgFWRVxvQiM1sNdFOCT4pTbqUzUoZphqHWUn8mHK4Tno+WnUirVncE2
         b99bNRpkKfoGmgpCLAXtR+OsEduwXUm5XhTtX0N98IJPyLQrrFKY6WWUVeBYrMEF5GJP
         +bHpBWbQWS2C/OnZOm+ZSpVfWzHlfFSGzaLp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkYY5lcGFh2USQXT1hiHpvyqlBdZwGnV7QY6uFjV4/Q=;
        b=07ibsgwdoGB8985ax6b6W+XLUq+GJaE/5uZhvt/DRHy4Y74R1KWub3VaX1VrYjk0P5
         c6yOPEUO2DR/IC6F2fdQCdAXpqV7Xpy/vdgRy/7+s7zpsxliMdKpMIqhOjkIPgc042At
         TXQWd2Ov6oXKGL7pWKESAy9rwjPcGuhN0mjnLaFxoZhhZgNP4ZUwLwODFQPPmEVy/ll6
         7E8c8i6vwT2wuRe8l6LPhLQ9ehIAlRZvVCRXF7gZhDlkvVvF6I0zjwpctU5MWmhpF27n
         lGjtunbwMOhjKkBW/TO7vt6LXunLedr+hKfIWZvPbUrxA/03hpaio623hpCqWYdvHCO4
         mvIw==
X-Gm-Message-State: AOAM532VRo8AHe8hc3n7QY+1tesF+1zWe+8Wn6atXICn6nD0Mv35YqyG
        9ZM/x5CqHWjmggMBF/2iDccfQ2d9FbhATIQS
X-Google-Smtp-Source: ABdhPJyt79LxyyUiQ46vcGFDsyrn4nu91bpv0d5YeKBZbGGxxQce1uFXW5yFid66HW07ln+Enwy/iQ==
X-Received: by 2002:a2e:801a:: with SMTP id j26mr2522096ljg.175.1632151530654;
        Mon, 20 Sep 2021 08:25:30 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r13sm1402155lff.10.2021.09.20.08.25.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 08:25:30 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id i25so69946526lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:25:29 -0700 (PDT)
X-Received: by 2002:a2e:5815:: with SMTP id m21mr15553407ljb.95.1632151441140;
 Mon, 20 Sep 2021 08:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <163207602242.947088.16824174748243890514.tglx@xen13>
 <CAHk-=wiFY6Ys0bOrUUsocp_1YHt_9aEBi9CtPt4N0bRUTY8+5Q@mail.gmail.com> <YUhwHsx8n0KJWgQP@hirez.programming.kicks-ass.net>
In-Reply-To: <YUhwHsx8n0KJWgQP@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 08:23:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrw6C-skHMLOR5PNfOtLm1Wyng3Z_eobJBz9BY+Q1ag@mail.gmail.com>
Message-ID: <CAHk-=wgPrw6C-skHMLOR5PNfOtLm1Wyng3Z_eobJBz9BY+Q1ag@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for v5.15-rc2
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 4:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Is that XADD really more expensive? I don't think I've ever seen that.

Hmm. Looking at newer tables from Agner Fog, it doesn't seem to be the
big difference it used to be, so maybe not a big deal. It shows up as
many more ups, but the lock synchronization ends up dominating.

I just remember from when xadd weas new, and it was noticeably slower.

                 Linus
