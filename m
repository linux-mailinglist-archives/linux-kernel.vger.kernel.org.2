Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA81A3DDE33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhHBRHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHBRH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:07:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECFAC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 10:07:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h9so24782857ljq.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILiPem6rQEtCvqEZt+Nmb4/YTU5td2KVc3h1l4OeuvA=;
        b=Jvm/NakPCNY29sPFDp+J2ZNO9jlolOSC2VFZd7wt0hSzXG1Vw//AWBKhccc4gYjXj7
         SAKq4Vw4oqlr/4tvUL4OvyPC0oGS4f1ofMxPFWZiDx+A6wkTEkvtkQDqjbU+E7Dj0E7u
         B3pKf/otBit3YvJFmUj6+wGPJOgLLRzfXCKKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILiPem6rQEtCvqEZt+Nmb4/YTU5td2KVc3h1l4OeuvA=;
        b=bGymPUM1eWLYsh/MV+yS/YpLOeM4eCzgctMfEYOkY99wyeyYWRFhif8o0ZgnHoMB+E
         gkLFrxsGUWi195WsVTthZ4GG0MwV2uQo7LlArJceMze1rtDfmfdxtNQ7MJIpMBwi4Mq6
         fSO027aRW4WPeZ+DnQJ4DzsAP8oG7g/YqhLqs+UPlqKJa0Km8qQo+nYSd7/1aS/vk3PV
         eCV0UV59Z0lGxS9VTZn0BBWioo4QRdINNowm8rLoqU47bt+2i8amBPKL6fq0ebBc2x//
         8ygnHY6lHsOPQUfxzoThlDL3UPy5lkN/AgctgdvS4MBMSPUg6ftoZJJbsgiT7gXFGT4G
         UMfQ==
X-Gm-Message-State: AOAM533fxzHCYjFjc3fjW1LoBPchkVOCrPQsmbKeT1AhcW6YMdm4CchE
        pmHiZcx3FCAXzn0qcJAH6cwOfXYImHHHQgfX
X-Google-Smtp-Source: ABdhPJzJWIyXTI3CZiwiYrFA0iIanj6vlmznWg+du+B+uqYlTISJtb3T+8Qhzy3iDRhtSP6W6PhFVA==
X-Received: by 2002:a05:651c:157:: with SMTP id c23mr11823368ljd.225.1627924036527;
        Mon, 02 Aug 2021 10:07:16 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f6sm1011471lfu.273.2021.08.02.10.07.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 10:07:15 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id u3so34945000lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:07:15 -0700 (PDT)
X-Received: by 2002:a05:6512:2347:: with SMTP id p7mr13403567lfu.253.1627924035317;
 Mon, 02 Aug 2021 10:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210802024945.GA8372@xsang-OptiPlex-9020>
In-Reply-To: <20210802024945.GA8372@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Aug 2021 10:06:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whr-zgf41B0BPsWnL-WWqhdk71rKffhV0fzdCuem3=SCQ@mail.gmail.com>
Message-ID: <CAHk-=whr-zgf41B0BPsWnL-WWqhdk71rKffhV0fzdCuem3=SCQ@mail.gmail.com>
Subject: Re: [pipe] 3a34b13a88: hackbench.throughput -12.6% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Sandeep Patil <sspatil@android.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 1, 2021 at 7:31 PM kernel test robot <oliver.sang@intel.com> wrote:
>
> FYI, we noticed a -12.6% regression of hackbench.throughput due to commit:

I had already forgotten how sensitive hackbench is to pipe wakeups.

I think it's all good for stable, and we can live with this -
particularly since I'm not sure how much hackbench really matters.

But it might be one of those things where it is a good idea to make
the crazy epoll case explicitly special.

Sandeep, does something like the attached patch (written to be on top
of the existing one) work for you?

It's not a great patch - I'd like to catch _just_ the broken EPOLLET
case, but this patch triggers on any select/poll usage - but it might
be a good idea to do it this way simply because it now separates out
the "ok, now we need to do stupid things" logic, so that we *could*
make that "stupid things" test tighter some day.

And I think it's actually better to make sure that the unnecessary
extra wakeup be the _last_ one a write() system call does, not the
first one. So this may be the way to go for that reason too.

This all probably doesn't matter one whit, but hey, I love how the
kernel test robot gives us heads-up about performance anomalies, so I
try to take them seriously when they aren't totally strange (which
happens sometimes: some of the benchmarks end up having subtle cache
placement effects)

                 Linus
