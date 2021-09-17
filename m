Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5D340F234
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhIQGUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhIQGUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:20:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B368C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:18:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so11528827otq.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=hzp3W57grtENZ1UMp0tOsXr8ZoYgbq44MmPXCel3Oa4=;
        b=W6qfmBMKsTv98mLlYbwvasVyjfbNJpx35I87S9ODLKaOW8i/gNzfJE227YWEEgZ7wh
         HcABjt4NZynd7MI2AHz3zEcEuPDkRMfAYmQzf1NnC+Z4nm0YsbTjP3xFj0y7TvJOBz/K
         yBRt65DdAnOgAaUg6TeeXusYlDXyatoOmf07Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=hzp3W57grtENZ1UMp0tOsXr8ZoYgbq44MmPXCel3Oa4=;
        b=SC77TqDlVbiWE5eB5CtQRqpJRylX/vLmABIlJfRPLwg7NpQx3AllJwSP38qWjMSUIL
         thGbwgEWIRsXiDcYNR4SYDfP4jAQcLAjZRB1u9q3gXUTC9FB3kopLkT9cih+zlYgfu/H
         HHgqMplezHDHB1W5utAHavIfbQf4AMjAI+mteMYJ8ymBkf8qdj9Ez5ERtfbJrNLKC9d+
         oyxOIYhGhcYu4B58EfPNCsVyFGEJifrvZWMhlSFThj/TrLwNPZj7RwQPmCTZYfXHG9LI
         fcawteb+GkYyBXfv2nt5jac7LJkV8da/+aLFLETekI+VwnxmUCG3WLO3wNAvqMay5bLM
         VoGA==
X-Gm-Message-State: AOAM530EHZlQGHHJXx0LZJ8eVt7c9KRK4Bjm4i8jZqu7kpNvYoG1CaoL
        kuA4GvHV8+ARnthCRxICphmQq6GJUvSKAcvK1cHLWw==
X-Google-Smtp-Source: ABdhPJwnpapPZqGI9tLkWKhUef481j23KWl2vfNPI9pI3jrBmxG+IzpYd9/UGy7aQL1rw4TZIJqyFcky0nzdXD72gH4=
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr7931455ots.77.1631859527357;
 Thu, 16 Sep 2021 23:18:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Sep 2021 23:18:46 -0700
MIME-Version: 1.0
In-Reply-To: <53a38a24cca0b6f1c2a3120f14dfc865@codeaurora.org>
References: <20200730095350.13925-1-stanimir.varbanov@linaro.org>
 <20200730095350.13925-3-stanimir.varbanov@linaro.org> <159718256557.1360974.458611240360821676@swboyd.mtv.corp.google.com>
 <8c1fdf2d0807f07ec57b232497b405f1@codeaurora.org> <CAE-0n53T-RoOvR=s9nHiXAriMgKvBfDqfBfoGKX5Ju5YF3Tcqw@mail.gmail.com>
 <53a38a24cca0b6f1c2a3120f14dfc865@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 16 Sep 2021 23:18:46 -0700
Message-ID: <CAE-0n51Pxs7stTdJ5AO3i+Xm=q1R_EUcueR2+_-gFAa7iqUypg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] venus: Add a debugfs file for SSR trigger
To:     dikshita@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, jim.cromie@gmail.com,
        Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media-owner@vger.kernel.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting dikshita@codeaurora.org (2021-09-15 23:29:36)
> On 2021-09-16 01:09, Stephen Boyd wrote:
> > Quoting dikshita@codeaurora.org (2021-09-15 02:13:09)
> >>
> >> So, IMO, we will have to use custom debugfs only.
> >
> > Can you use DECLARE_FAULT_ATTR()? Or you need it to be active instead
> > of
> > passive, i.e. it shouldn't wait for should_fail() to return true, but
> > actively trigger something on the remoteproc?
> >
>
> yes, it doesn't need to wait for should_fail() to return true.
> the client/user should be able to trigger this subsystem restart(SSR) at
> any point of time
> when a session is running. It's totally client-driven.
>
> >>
> >> Please feel free to correct me in case my understanding of the
> >> framework
> >> is wrong.
> >>
> >
> > I presume the fault injection framework could get a new feature that
> > lets the fault be injected immediately upon writing the debugfs file.
> > My goal is to consolidate this sort of logic into one place and then
> > put
> > it behind some config option that distros can disable so the kernel
> > isn't bloated with debug features that end users will never care about.

So you can modify fault injection framework to support direct injection
instead of statistical failures?
