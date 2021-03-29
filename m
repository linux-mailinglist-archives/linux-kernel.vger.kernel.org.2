Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8181334D27F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhC2Oik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC2Oi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:38:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:38:26 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id c17so11401856ilj.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gMUDl2DT4mlMGjvIHFxLikScjKSbv5yrWXCd8WwiRWk=;
        b=G+axpC4H72KmvBBZ1KT7WGzKqwO8IPTuICBGBYDm5QSPcV/M6rs1YFzReciloGayGH
         +gTm23FEfthOf99Shx5pK3+i4m1YwO1zAfP/fMHCt7cjK1P4K6eVgyNZGGBoMNThpv7g
         s/Tim3BSI1de9ak4aFjv1R0v8U9EbALQKjPiauvLFX83I1ygUuccH8XHdPEZVVLi/ou9
         +V+ZPIphEZ8KKmUUQ4Fk+oDxxHMPKboFDWAc52K9lTepKE3UZDUsmS0pXjtmQiBeg126
         As4ruEnIMNi+yy8ffAmFtMk7LAVl59CFfk4V+isfHT163ihZ4EiKs1EEDEERh6HpbF8c
         7/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gMUDl2DT4mlMGjvIHFxLikScjKSbv5yrWXCd8WwiRWk=;
        b=AywbPj5f+m7y8qDLfp6lSxffAT35z52QXFCbj48kit9sgl8ace0UHC5wotRusQg2Tn
         fsRowGRSHlw210tYCKmcIHlTBhJvfwKZqP86kq8Qo1X37HgLISvXblUrhAzTDHpceErj
         hB9LqtdvnNDOcY4WuB8EUXC400vHE2A0BDprmdGvtpMgd/b/OcsWeRizVA7NqFVd10oL
         AxPzTcCOo9Hx5n7yvs2+a78HLCaBFVx6sMaYRhZqoOSzjcuoYBxgBNy4LE9FDi8WqoJ5
         IqJsY9q3Dpwdvld0cG8p/xg7aCvz9YKxuOGDe5Rzc0ILL9lwOogWEiMT2kwB8bOGFhTi
         MCTA==
X-Gm-Message-State: AOAM53323H4zUgT+xHouXHHTRqEnoIiBjDQN7129+NS4yUbxuRbDhl8u
        iP0bh10oamGqRmvDR3UGlYcVtuwygBd9sS/94IQgAg==
X-Google-Smtp-Source: ABdhPJyTUTcTfybs3ErxaQD7yrQGnJw6qndKFVu3+QTtGQKYl6J+4amSJdGH89c2/o1AJXS1MfnSw2WDTP7FxKGpRsc=
X-Received: by 2002:a05:6e02:149:: with SMTP id j9mr12703235ilr.57.1617028706009;
 Mon, 29 Mar 2021 07:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210326142244.17504-1-unixbhaskar@gmail.com> <20210326153213.GA2009902@xps15>
 <YF47p68yNRgIpuQU@Gentoo>
In-Reply-To: <YF47p68yNRgIpuQU@Gentoo>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 29 Mar 2021 08:38:15 -0600
Message-ID: <CANLsYkw+7tpMPna1tskRip3ceBaYqJJcAwVBoNJqAy+=QUzPHQ@mail.gmail.com>
Subject: Re: [PATCH] coresight-pmu.h: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 at 13:53, Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> On 09:32 Fri 26 Mar 2021, Mathieu Poirier wrote:
> >Hi Bhaskar,
> >
> >On Fri, Mar 26, 2021 at 07:52:44PM +0530, Bhaskar Chowdhury wrote:
> >>
> >> s/orignally/originally/
> >
> >Even if the change is trivial this changelog is insufficient.  Moreover, if you
> >found the problem with an automated tool, please add the name of the tool to the
> >changelog.
> >
> Oh Hi!
>
> I think the changelog is sufficient enough to conveying the triviality of this
> change.What's the point of writing unnecessary history , when a simple
> statement can do the work.
>

All I'm asking for is a one line description, nothing more.  Otherwise
this patch will not get applied.

> These are hand picked ...there is no point mentioning the tool in the
> changelog..it is all age old UNIX/Linux tool , nothing special.
>
> >Thanks,
> >Mathieu
> >
> >>
> >> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> >> ---
> >>  include/linux/coresight-pmu.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> >> index 4ac5c081af93..2d5c29e3cb8a 100644
> >> --- a/include/linux/coresight-pmu.h
> >> +++ b/include/linux/coresight-pmu.h
> >> @@ -14,7 +14,7 @@
> >>   * Below are the definition of bit offsets for perf option, and works as
> >>   * arbitrary values for all ETM versions.
> >>   *
> >> - * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
> >> + * Most of them are originally from ETMv3.5/PTM's ETMCR config, therefore,
> >>   * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
> >>   * directly use below macros as config bits.
> >>   */
> >> --
> >> 2.26.2
> >>
