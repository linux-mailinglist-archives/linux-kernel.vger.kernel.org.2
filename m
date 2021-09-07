Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56699402E11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbhIGR7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345260AbhIGR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:59:33 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD26C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:58:26 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l10so10959504ilh.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8pLJ1FpaVzh5FC1pX+Q5BEfmgO/vOO3RyE4cZ7z6Q8=;
        b=VPu7rS4YBeF7IlroZ7du8K/p1skwdho8pDjKL0Td2afcUesHnTuOM4LNVGIgGDOzwv
         RF9MnzKjq1wxndB6t0dvlo3/GLpNAbGq6B8gEKIuiFR8+yqReSl0H1w9Dzq1gsGsT3RB
         7NizSSM77IuqImGQvtk6zuvfv497MYy3UfgMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8pLJ1FpaVzh5FC1pX+Q5BEfmgO/vOO3RyE4cZ7z6Q8=;
        b=FLIftt1x1BnaknWp7QoNPx3PK8FE7J6GDIR89Q1R89Y+9RXg67/ujOcPz1AwAq+kY0
         OaxAigxTU7ysD8qnv1OxfG35UuEdPPUXZvH/QQ1rh8w6HMRcHc019V9K0cWkDOlUWuL7
         luxdCZZ3YsMglBCedYSxC6WvrpmPEfe34oWxsQqrqzYsefAgZpGLQrxBcPt84a9ok6Yq
         k4NAjKQIpTL9m0DTMlm11azJ62QgFdA96x2YC+Eve4Q0vryuRuqSS1fgwEjbUECaxHKz
         BBmgZ8qxCAdkg+dDzP1RyxV7OA/0mvhCAXJ9BG2rNhTIhZYfEzJoDE+aQNDWc0D5Qp5f
         WCqg==
X-Gm-Message-State: AOAM531IR3nUh+PGiySJkadFXxJZ/vs+QdtApMtwEhGiJOeZDgmw+Cvq
        HpXT5Ekqp7cVjRLWaLx1bAmveewFHpHdLw==
X-Google-Smtp-Source: ABdhPJyGzW4zEJ55jih0BgWI7Nx0oJsA+QgQTnJmzT0W56MdVCaASKfjtM0jZ7mE4Y+iXhA5fXfuiA==
X-Received: by 2002:a05:6e02:1a0a:: with SMTP id s10mr12350488ild.46.1631037506296;
        Tue, 07 Sep 2021 10:58:26 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id m13sm6300371ilh.43.2021.09.07.10.58.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 10:58:26 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id u7so10999713ilk.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:58:26 -0700 (PDT)
X-Received: by 2002:a92:cb52:: with SMTP id f18mr12692305ilq.120.1631037124093;
 Tue, 07 Sep 2021 10:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210830172820.2840433-1-jiancai@google.com> <20210906150625.GA1228692@p14s>
In-Reply-To: <20210906150625.GA1228692@p14s>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Sep 2021 10:51:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ukx_PRpfnLXEBajtts78ays=6+nGb+CRVn76xjyNkn5A@mail.gmail.com>
Message-ID: <CAD=FV=Ukx_PRpfnLXEBajtts78ays=6+nGb+CRVn76xjyNkn5A@mail.gmail.com>
Subject: Re: [PATCH v2] coresight: syscfg: fix compiler warnings
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Jian Cai <jiancai@google.com>, Mike Leach <mike.leach@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>, coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 6, 2021 at 8:06 AM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Mon, Aug 30, 2021 at 10:28:19AM -0700, Jian Cai wrote:
> > This fixes warnings with -Wimplicit-function-declaration, e.g.
> >
> > drivers/hwtracing/coresight/coresight-syscfg.c:455:15: error:
> > implicit declaration of function 'kzalloc' [-Werror,
> > -Wimplicit-function-declaration]
> >         csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev),
> >                              GFP_KERNEL);
> >
> > Fixes: 85e2414c518a ("coresight: syscfg: Initial coresight system configuration")
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Jian Cai <jiancai@google.com>
> > ---
> >
> > Changes v1 -> v2:
> >   Format the commit message and add Fixes and Reviewed-by tag.
> >
> >  drivers/hwtracing/coresight/coresight-syscfg.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> I have applied this patch to my local tree.  I will push it to the coresight-next
> branch when 5.15-rc1 is published next week.

Out of curiosity, does the fact that it'll be in coresight-next mean
that this will target v5.15 or v5.16? I usually think of "-next"
branches as targeting one major version later, so I'd assume v5.16?
...but it would be nice if this warning could get fixed somewhere in
v5.15.

Thanks and sorry if this was obvious and I just didn't know.

-Doug
