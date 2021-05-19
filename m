Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4726B3893CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347515AbhESQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241726AbhESQdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:33:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:31:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b12so9127344ljp.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZLJNKKc9VMDuwm5nqmO6Jk46MY22hPJLYhiTwehgjY=;
        b=BNo+5FL4MivuGXFJyBkyugMfiR2R6b/DtPSISTGhZNn4jxyVfn/H1Bhhfies2dDfMC
         HS84WMm9VY40kL6qVL0Hio+ns0+CoOCx6ZliKWYhjgK7jiyiwDBzY5ZryuWAa/ES2tv2
         j8iTrJhzTO8SCATTMs8IBSRU33TSJL2dOxGLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZLJNKKc9VMDuwm5nqmO6Jk46MY22hPJLYhiTwehgjY=;
        b=ueDNQcXcMz1MdHMSGtIw9AfAroTFYBWRlLhixizYOah/ctj3eBZ4lNI65vt0OrwKMe
         0tV5eN++MbqvLhfcn1eVPaRkPhnPz7hOCLM957jB1x6QQPrbQNTZ/gyY9hIbGBsdU1n1
         FLFh1pbrLd4qyTe6yJfPaubdLqOkYUgjVj+TyJNXGnQ8+ISsZT1VEYhQQk9zPIBVd8CX
         FX9VNIx8FJMBk46tjcmQgLh9k5h/zRmq2e2FkynCZ1FFfkPnkQrTTBYZrJQljSvhkooW
         o//07cgTMP2BAHD3TCL3QkxDhg+eVRPHe88dpvYYfayBF3iHQzIJCWrhBKLGLejmmLA4
         /RFg==
X-Gm-Message-State: AOAM531b+RS2h/WVTsza8q7TqQVFf2VER8LV8V4utFn2rIPhAT5VQcmq
        KvzFD2XvzBY0S+ti48EhOXsjMatRnQc5YyWNGdk=
X-Google-Smtp-Source: ABdhPJz6vk9v6eiZX5WKd7hymnpY5oi4rudp+mVyg/jWA/zCtLKc5nhfGFYxZnNG+CouZEHox55inQ==
X-Received: by 2002:a05:651c:511:: with SMTP id o17mr113751ljp.14.1621441911076;
        Wed, 19 May 2021 09:31:51 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n8sm18480lfe.48.2021.05.19.09.31.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:31:49 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id a2so19985692lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:31:48 -0700 (PDT)
X-Received: by 2002:a05:6512:36c5:: with SMTP id e5mr244603lfs.41.1621441907825;
 Wed, 19 May 2021 09:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210519024322.GA29704@xsang-OptiPlex-9020> <CAHk-=whcr5M=4Mz2ydu4XtxTL_34WkXPnmFmA4f8r+ELXDC6hg@mail.gmail.com>
 <20210519133330.GA14452@lst.de> <87y2ca6a69.fsf@tynnyri.adurom.net> <CAHk-=wgYqF3bffW0EPmVTUFcoV0jXECu-A_dyWZ0ZwUwhCHi+A@mail.gmail.com>
In-Reply-To: <CAHk-=wgYqF3bffW0EPmVTUFcoV0jXECu-A_dyWZ0ZwUwhCHi+A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 May 2021 06:31:31 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgEZrsY9tsyC=+2sXVVuBDiZDTSMxt-X5LgwvSQqs_a6w@mail.gmail.com>
Message-ID: <CAHk-=wgEZrsY9tsyC=+2sXVVuBDiZDTSMxt-X5LgwvSQqs_a6w@mail.gmail.com>
Subject: Re: [i915] b12d691ea5: kernel_BUG_at_mm/memory.c
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 6:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, May 19, 2021 at 5:00 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> >
> > Christoph Hellwig <hch@lst.de> writes:
> >
> > > On Tue, May 18, 2021 at 04:58:31PM -1000, Linus Torvalds wrote:
> > >>
> > >> I'd be inclined to revert the commits as "not ready yet", but it would
> > >> be better if somebody can go "yeah, this should be done properly like
> > >> X".
> > >
> > > I think reverting just this commit for now is the best thing.
> >
> > Yes, please revert it if there's no quick fix. On my Dell XPS 13 9310
> > laptop (with Debian 10) X won't start until I revert commit
> > b12d691ea5e0, so this is a major issue.
>
> Reverted.

Oh, and Christoph - there were a couple of preparatory patches before
that one. They all looked syntactic to me, but it might be best to
check that reverting just this one commit is ok?

                   Linus
