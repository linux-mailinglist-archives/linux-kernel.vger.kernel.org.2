Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33D64011CC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhIEV0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 17:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbhIEV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 17:26:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0299C0613C1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 14:24:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q26so5864563wrc.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIKy04n4SEct/kBbtr4jBMWbMzYLLzxmc9yw++ulVoU=;
        b=N86W1IJOKcV1SWTuhSmRlI5f79Nw7JC6F4ceQ/Ln9kz/BYw523ugT825Kz8NTbj2VJ
         Crzbo9kRW3fOSx1/YJX2cbCVDP4qSKRNNLFiyGa0qgRYfsyREy+GeviXzVaLD4syt5dd
         q1fAf1/Ffo1HEv9VynbKrlvhVsweqb9DgkyZS+4fAXSk7fStMFVWVueqUaVr9d/BILri
         zuqIcBp1psUJ7MxYrltDKT0tuuazHRi1UF7xbvtZKa823O68Hn24UfQFP2/gWiDOylV3
         eMhkR1BdSmnNy1TEOMm17gH08mSMmmqMiOcR3fJWFegqGP7D73PE3ZhOff43L2tq8nDU
         tZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIKy04n4SEct/kBbtr4jBMWbMzYLLzxmc9yw++ulVoU=;
        b=Rn3CavU3CjX8fbB55GjhAnDtr8QwK8UHJVr8nTLL43KQ91ZLmMdmOLPC4bM4kc7+z1
         yL+dr1wpN5yovyCcRueTCF0XKVzdFn4xFepCKL/f3E1sz1z6tpBINH5oLJ/N/fXS7EPs
         zmcAjrJNcTF0kMLonf/ZzS7wwpmsndxDAVnDi6znS4h1qKragsceb8PTaGdc6gKmkDVV
         smiVy2mqKHdG4aRjjpaWfAFlGED07AdZ9OMxsAlDVQxz34T/f5snbuu4+hjKVHJ/wyBg
         VZgv/+DnLYjcVJOLHLm+Mqxm3Tq163HXyi4TQvpLMQYpRDRj1jHBNLRi3MOui/R2+ehq
         h/iQ==
X-Gm-Message-State: AOAM5337+juHAk2MjZrW2ktOTjcE3+r9Kiu5e+RMXJMECiJAxW7FZZOY
        px84cfIS1dZiukL9ku+Mit4XM9lCazVfhQh0IYg+TQ==
X-Google-Smtp-Source: ABdhPJyHhGbGj5/aBMqLo8ftUlD+qEetFvZ8k0dh0n4d01mLIXJijTpRitU0QwB/MbTek9ZpkSOtY9r9e3sc4Yvxwko=
X-Received: by 2002:a5d:4a08:: with SMTP id m8mr9717729wrq.263.1630877097634;
 Sun, 05 Sep 2021 14:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-10-james.clark@arm.com>
 <20210824083615.GF204566@leoy-ThinkPad-X240s> <YS+iOrcPTzQfmbqU@kernel.org>
 <20210902174851.GB1078000@p14s> <YTEVwVCWoS8cgqql@kernel.org> <CANLsYkxhj1RkJ+BYLGBZ=c=VHT6ayfHvP_T68xGxcnsKQXEVxA@mail.gmail.com>
In-Reply-To: <CANLsYkxhj1RkJ+BYLGBZ=c=VHT6ayfHvP_T68xGxcnsKQXEVxA@mail.gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:47 +0100
Message-ID: <CAJ9a7Vh48zXnh8Wq8FDAik2GbX6JCnoq=h7B6wokkht0KRb7WA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic number
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Thu, 2 Sept 2021 at 20:22, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Thu, 2 Sept 2021 at 12:19, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Thu, Sep 02, 2021 at 11:48:51AM -0600, Mathieu Poirier escreveu:
> > > Hi Arnaldo,
> > >
> > > On Wed, Sep 01, 2021 at 12:54:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Aug 24, 2021 at 04:36:15PM +0800, Leo Yan escreveu:
> > > > > On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> > > > > > Currently perf reports "Cannot allocate memory" which isn't very helpful
> > > > > > for a potentially user facing issue. If we add a new magic number in
> > > > > > the future, perf will be able to report unrecognised magic numbers.
> > > > > >
> > > > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > > >
> > > > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > >
> > > > Applies cleanly to my tree, test building it now, holler if there is
> > > > something that prevents it from being merged.
> > >
> > > Have you already merged this?
> > >
> > > If so than let it be.  Otherwise please hold off as I'd like to take a look,
> > > something I intend on doing next week.
> >
> > Ok, I can remove them from my local branch, but this may make this miss
> > the v5.15 merge window, please advise.
> >
>
> Nah, leave it in your branch and proceed for this merge window.
>
> > - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
