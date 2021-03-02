Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4B332A803
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579602AbhCBQ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351427AbhCBOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:24:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBE7C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:23:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id w7so2357826wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4Ux0jV9jTZg+jzngXb8yOeSpc8cRPS43A0idXjYxTM=;
        b=KReUW+8dHb0H8llHJeSCs24ub3qMFrTI70eyphhZIUkAVsypaJQUlDpPUxvZF6wLZ4
         Lq1AdUodLt1NuEDdokR5YC+efz2a0XUbT2sOQmUECJ5DnAeO5kPgL6l/Zxqpqn3GPSi5
         IAo7cuyfCnIvxHpVBykyQaxusc+9OnIxVEUZB1b+yW9hnqfv9sH/xq9YlXJTGP0jpiVT
         +4VdspJS5T+iGpjMzxZ2OXt/12TpKfGZoTWyhzodj90UVXcaMDTjaz63cN+Ew3rcxbFT
         oQPUd5OowHBrmPgVcxLUINQ5UzqUjv6g8CEZVmpDu+9rNGK5ulzbo/EGonW/BU9tpBb2
         BMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4Ux0jV9jTZg+jzngXb8yOeSpc8cRPS43A0idXjYxTM=;
        b=JiSnXkC4pQkfI6OfiAcnDe8s7O3eHwPD7bDmnS73KREmuC9rYYdcjxxN/Rs9O8BipM
         oUL3EamJqKMmz0DDTHR1VLwYV0GnU6SF8y+C+fSBHKav453sMzJbVPNzB7iPhxO8rPl4
         hgvcLCAatdy8wYfkuL8isL7OnjC+Zfd/bkRl3FDbgKTZULKGqpCrrpMAdCchM/c3x1TF
         B0fV/rRlPOJNJ83oR6kwbjf1RQR8PaV9Z9bim4XcT6W8Vh0yBsWuv2k2Kb7dO+w+a9ZL
         WB+kAd9vqeHV1DPX6PW5Djwu96vx9LueemlXpzqLBgRpeq/FBNj47FOtVKiVIiSLLlz6
         9ksA==
X-Gm-Message-State: AOAM533rkywcNcCZnBf/OrE1DmeosPiET1M+fQyHhZuR/SBl//BsuKCn
        xZkBcPii0rHRiU0tG1WGnaB33TR1GykShfEd78+18Q==
X-Google-Smtp-Source: ABdhPJwGU5BWmh08eb2nSi2S+WfLgwvQL61Puep5g+dxhEIogIfzY5iIWFTsuSVF6UlcgeHraldfDenhide6lLApKdM=
X-Received: by 2002:a7b:c776:: with SMTP id x22mr3586771wmk.98.1614695004780;
 Tue, 02 Mar 2021 06:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org> <YD41GUtuq8fVa4Q6@kernel.org>
In-Reply-To: <YD41GUtuq8fVa4Q6@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 2 Mar 2021 14:23:14 +0000
Message-ID: <CAJ9a7ViKLg8vjBnuA1eWh8b5-PN7RryefyOV1qoX9Zu362Eq8Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,


On Tue, 2 Mar 2021 at 12:52, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Feb 24, 2021 at 09:48:29AM -0700, Mathieu Poirier escreveu:
> > Good day Arnaldo,
> >
> > I noticed there is a couple of patchsets [1][2] that haven't made it
> > to your tree for the coming v5.12 cycle.  Do you think that can still
> > be done?
> >
> > I tallied the patches here to make it easier for you to pick up.
> >
> > Applies cleanly on perf/core (84b7725536d8)
> >
> > Thanks,
> > Mathieu
> >
> > [1]. https://lore.kernel.org/lkml/20210202214040.32349-1-mike.leach@linaro.org/
> > [2]. https://lore.kernel.org/lkml/20210213113220.292229-1-leo.yan@linaro.org/
>
> These are not applying right now, I've pushed what I have to
> tmp.perf/core, please take a look, I'll get back to this after
> processing fixes for v5.12 and what is outstanding for v5.13.
>
> - Arnaldo

I've tried [1] on both Linux-5.12-rc1 and your tmp.perf/core and it
applies cleanly on both.

Let me know if there is anything else I can try.

Thanks

Mike



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
