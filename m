Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B3E3545F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbhDERVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhDERVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:21:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE2C061788
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 10:21:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w28so18410381lfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/WjUWRXo+IDe/y+mKCTfQrTSTm3mkNsX9WTYOWOW3s=;
        b=lcPVlijF9oCVJyDvCuZq2rr1utg018XwqSJXnD12WyGEjGeNuCf+6oMoDHXEpTgD4H
         wAdg8ybhnDFNe1swhnJdMsptZJCkD2UV3EhTkB+h394vDWlOwQC4DOYWtRglgen0rWwl
         TtwOXYwnl6w2k8Hsmh4K0ltIVSeyruJ5EaerIAid40B1jeZoAiZ+jCGz/tnAVAG85XPq
         UdErIE9XJVhq133xdygBPh5h8+MxmjQk5Li+I/K2gdhGofjfD/T23mK3ND2onc5PEjOl
         JqHwWmaVzl5bD8iw5boeASm2un5suAh8wyXK7fEtYdDx4YKfknRfRJe6hSDJjvpd1fTC
         qRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/WjUWRXo+IDe/y+mKCTfQrTSTm3mkNsX9WTYOWOW3s=;
        b=ajbeP3uf2Vm229l1VQ8VU0LkHUMdMCBeIjvR6wbibo606BtZDhlYAXx6EuXfAHgUqV
         Za+xPL6u16GfGmI9HSTB5W/5ZSzMSyP/Y/n/UD6ASEkvWm29PilXzrNFYsYlG/oRvSoX
         C/Z2PMXy9TPKD6dUnis1uVfuQqOd64uo2U5cHtEYtg4AVFkeIUlFt8SBWidwFSv75PtC
         nD4Tbrz6NuB3eeQdd46KDmBBvodbDOhzDvvl7Mm0eS+zD3BvDS6rCd9dkieWSFSgB9Ks
         eMCPU+LM842wn6krdLmeOBK2sXln/bcx5PIM3+C79Bc1jX5m4WfII0aY974/wix0AVsv
         wcwA==
X-Gm-Message-State: AOAM531FxrkQbddcesqNd+3sbZ5aN3m8xDHt8H3vaskrxXCET72WiJXd
        E0JSBDKLTkPxjlZ8MQyNkHo3+lH0XqtBzdcBwOAEsvdKV4o=
X-Google-Smtp-Source: ABdhPJzpa/Qv4TAxznqUz7EKeGVdks1XIH+m58fd/U23qQHvjXNXxBChZn6kXkZNUfGgqeNN7Kpp3vt6qoVGRuJAIRM=
X-Received: by 2002:ac2:549c:: with SMTP id t28mr17791532lfk.7.1617643270361;
 Mon, 05 Apr 2021 10:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210330013408.2532048-1-john.stultz@linaro.org>
In-Reply-To: <20210330013408.2532048-1-john.stultz@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 5 Apr 2021 10:21:01 -0700
Message-ID: <CALAqxLXBjTO4b01BJnboVKWZVyqLM1pXRv3M-rOYq6tMXaHozA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix removal of valid error case when checking speed_bin
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 6:34 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Commit 7bf168c8fe8c  ("drm/msm: Fix speed-bin support not to
> access outside valid memory"), reworked the nvmem reading of
> "speed_bin", but in doing so dropped handling of the -ENOENT
> case which was previously documented as "fine".
>
> That change resulted in the db845c board display to fail to
> start, with the following error:
>
> adreno 5000000.gpu: [drm:a6xx_gpu_init] *ERROR* failed to read speed-bin (-2). Some OPPs may not be supported by hardware
>
> Thus, this patch simply re-adds the ENOENT handling so the lack
> of the speed_bin entry isn't fatal for display, and gets things
> working on db845c.

Hey Folks,
  Just wanted to re-ping you on this, as it resolves a regression
introduced in 5.12-rc5 and I'm not yet seeing this in -next. Would be
nice to have this in place before 5.12 final.

thanks
-john
