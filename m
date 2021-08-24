Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735DF3F629E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhHXQXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhHXQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:23:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15156C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:22:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j12so24208340ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1p0o+1bDBZZcnsbLlc+PmnEMPXHkkQy0tdXGmQ6Xogw=;
        b=TcgS1rL1D8BQMVtkdScnlO21S3L66Y9bLv0UsZgVlbeY8aWmtB8Bc3KZihbGnZssfP
         fuyPam7MRSa8eyXR/2iWv+bt/frKdz5+YfNixZAdFT1iXCYI5PqqmfptmUY+GzG5/GR1
         BRkT3/V9mj9I+AsCCITn8bJ2cwS2EH4imPghs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1p0o+1bDBZZcnsbLlc+PmnEMPXHkkQy0tdXGmQ6Xogw=;
        b=ByAP0aHmKsw1fKTzVtSIazlLTNL9H/CmhrgKTZiStrLBuNFw9tVrAdR2qprT62k8Kd
         f7SoANwzRforthIGHdtm1qvp5cnmXNiE77ZeemKyeok8BJVcvWs1qsGrgnZ92xJbXlyi
         ZYYPWvChIP6lLHe3ytTE2YfDOZ16o8nXsLrqKM1qt4ZdaFt0kcwq+qjsyATGyC4l+WoZ
         AWPtxuvvCIt+dNjKBVmdfbTFmag7/wDeodT68+FeQmYPnVYXPXmi7h9lsefZs9Z9F1aq
         sh6dcHeOgIOOVJVLN5j8scqRVRP5113lfJWPggvZYf2GaDnCZ1EC9lzy6XDsC9ySwQbT
         7ilw==
X-Gm-Message-State: AOAM5302TPOSu+9nbE99iXhMyq8X6y3SgFwFG52v0122JOYNiMtHGKYf
        8Yp1HvVJ2sNmS1tfErMPhfoSwrLsFI7MrNyB
X-Google-Smtp-Source: ABdhPJzUimBD8v19jhcVovP4Udq/uxc6xqz2LNCMO675XJcTUIaUlfHbG42As1zUbAaVOjF+5s/nlw==
X-Received: by 2002:a2e:8001:: with SMTP id j1mr11322051ljg.9.1629822163094;
        Tue, 24 Aug 2021 09:22:43 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id r11sm1840381ljk.71.2021.08.24.09.22.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:22:41 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id i9so46679587lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:22:41 -0700 (PDT)
X-Received: by 2002:a19:500e:: with SMTP id e14mr28511435lfb.487.1629822161302;
 Tue, 24 Aug 2021 09:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210824151337.GC27667@xsang-OptiPlex-9020>
In-Reply-To: <20210824151337.GC27667@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 09:22:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEdeNW8bPNhwRCkMu6zLKjE2vQ=WL_6bQtc9YnaKt0bw@mail.gmail.com>
Message-ID: <CAHk-=wjEdeNW8bPNhwRCkMu6zLKjE2vQ=WL_6bQtc9YnaKt0bw@mail.gmail.com>
Subject: Re: [pipe] 3b844826b6: stress-ng.sigio.ops_per_sec -99.3% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Sandeep Patil <sspatil@android.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 7:56 AM kernel test robot <oliver.sang@intel.com> wrote:
>
> FYI, we noticed a -99.3% regression of stress-ng.sigio.ops_per_sec due to commit:

Well, that's bad.

> commit: 3b844826b6c6 ("pipe: avoid unnecessary EPOLLET wakeups under normal loads")

You fix one benchmark, you break another..

What's a bit odd is that this commit basically reverts commit
3a34b13a88ca ("pipe: make pipe writes always wake up readers") which
did *not* result in any kernel test robot report.

It's not a pure revert, because it adds that 'poll_usage' case (for
EPOLLET), but the stress-ng.sigio test doesn't even use select or poll
(ok, there's a select() call with an empty file descriptor set, which
seems to be just an odd way to spell "usleep()").

So it _looks_ to me like it's a 100% revert in practice for that test.
I strace'd the "stress-ng --sigio" case just to make sure I didn't
miss anything.

But I'm clearly missing something. Can anybody see what I'm missing,
and hit me over the head with the clue-bat?

                      Linus
