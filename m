Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA7B3D9E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhG2HKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbhG2HKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:10:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998B2C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:10:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f18so9058873lfu.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoFw2S044+a87aIj+7FPIutyeW+kh1qZwjiCXtSKMLE=;
        b=e7KXs8ysXeshruLJUbQ2J+1tDH0JsuB/m95qY8LS9996gmbNKFNcX8L5dS9QsbTQQU
         ztxFZoyWEzTP6DkEQO3pcnbQqg17LB3CBuUMGWu+Hvwe6D7XdUJd0yiQvUuPXaCvYysW
         P9ciOF2WV1M7iuGUcUyzODsOKBoSHWv2ZeLgaoAd8BIx0cWgpS5ypwsWv44Cc6TrA17m
         wu9E+WHxwUCTRYc+23FQvvrL+zEWAANddxP3te427ncMlAF6S/H0oeDhBYUtn+E2Uu98
         SNU62XTt9CBYkQCxjWuUQyz0Ld5s2a0WZa2cLHkXlNWuHisB/lInD9JzIi5oQxdEfFcS
         l3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoFw2S044+a87aIj+7FPIutyeW+kh1qZwjiCXtSKMLE=;
        b=kk3rYLTNIWGGM8F7Vb/uShs1RrbHU0oH0WRUjEq/qD05E2FNP0YlctUc2B98U3vXq5
         VTkq5567v4vvz55yJmtipoeq9rS9AF2CQGey5qq1iLbaFRxS50Oe+OrOVzxVqeyYouw5
         KtUt/63Zsoic3P3uavdEyfveAsDOMD4dwINO7xzFks48IYYrXycgHJejEV0SCipI+avO
         jps6t0iUl7BFYZTXbQMCZZzsjqF7H1qBgA5Ia0lJAFg/oI5UolIo7/6A+i7KS3lCAMu1
         /g0ltd27hZPU93adgMOs9uLslzxJJNmN3amzK5dUZ7PJvRJGoQyvekGyKfumuPZwqO5x
         Os+A==
X-Gm-Message-State: AOAM531sD4SdF8wFeRKhM+F2pEEKXkjm5QqO6T25e9tP3HhGOLo2jdjp
        ma6PRN2s57nYL+LTAz6qwh45oriWfJRwbmF/zFLvHg==
X-Google-Smtp-Source: ABdhPJwUcHHIbN9tpoHWa1g8Yf70sfTpSypy31K0iy9ajc6mvUdEsW0U+ZvCHV6P/AYwdz502O+bj+QubUZYq+SzFrw=
X-Received: by 2002:a05:6512:511:: with SMTP id o17mr2695176lfb.396.1627542644007;
 Thu, 29 Jul 2021 00:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
 <20210722121757.1944658-3-jens.wiklander@linaro.org> <CAFA6WYOJ6At7p21UuWNp8k4=Qwcb_2VFuV78Z9hksyW76p-fKA@mail.gmail.com>
 <20210729064359.GA3316601@jade>
In-Reply-To: <20210729064359.GA3316601@jade>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 29 Jul 2021 12:40:32 +0530
Message-ID: <CAFA6WYNdkYGYiAMgkLRzc1-Ag=1Gd3kCSCwx=wT1RAxfYZtmgw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] optee: simplify optee_release()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 at 12:14, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Wed, Jul 28, 2021 at 02:15:47PM +0530, Sumit Garg wrote:
> > On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Simplifies optee_release() with a new helper function,
> > > optee_close_session_helper() which has been factored out from
> > > optee_close_session().
> > >
> >
> > Simplification looks good to me.
> >
> > > A separate optee_release_supp() is added for the supplicant device.
> > >
> >
> > On similar terms, can we have separate optee_open_supp() for better
> > understanding?
>
> I'm not so keen on that. It wouldn't be much of a simplification since
> we'd end up adding quite a few functions. optee_smc_open_supp(),
> optee_ffa_open_supp(), optee_open_common(), and finally
> optee_open_supp().
>

Fair enough, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> Thanks,
> Jens
