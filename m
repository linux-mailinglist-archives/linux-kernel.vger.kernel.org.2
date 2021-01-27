Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7953065C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhA0VMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbhA0VML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:12:11 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C09C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:11:31 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id q66so864060vke.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssBFTUkK7k+tD6KQtHwBNNI+cb5wpFEnuxsGYeB8Knk=;
        b=elZyyFERceYpQiET3o7NGtPrxQUtJ8LJIJdHf1Dsi5l6C8ccyiUE/y5S/WfVt+y+0O
         IhI64tQ7QTrsflUz48lrmFhjDzq0FNHf0ZElYedzoALTScz7AxV+oLoVMOrcb0dsxU6j
         n0fFNr3nzvQ6E6lMb+h4u4wr7CaYyg7oM+tGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssBFTUkK7k+tD6KQtHwBNNI+cb5wpFEnuxsGYeB8Knk=;
        b=JXcYjS9Y5WeZ/M335lIw1cFO55iyY0lNW355UBwksONJsipWrMRNwsWsB6LR+5e8wH
         CSBRL/po8AmTmmCeCxzT9JggTInucm9raW8JF3fQgw2YDnZ9j+YFaGg+rCRD0mGiDDUT
         lP73XADh3vt0x/o2binQbKs1Tb292M5kuvvwZQ3Ayf8F+oVEG367ie9kSIMcsT7Xc21v
         PWh7D5cVCZwLl/6dy0hGOqA2q3XYh/QdLOJf/4Ix1IDXciSxMfRDs0mv4ObcQrZeu4/b
         0nybvUh+37xP8T3Wx3CT8968VjBzchOj82ZysAmZpCx2oF3WuS4jBwrEuLfO2c8Q0HGw
         bcHw==
X-Gm-Message-State: AOAM532rHTz7VichNRUceKp7dlUZdb0cq6N+AZQC6ECXlC8gzBRfKg63
        ZQFN1jVPADjAYdJaBkgxr8LPMQZ32mRaEA==
X-Google-Smtp-Source: ABdhPJwk5l/LIHXxTBFLRzPPTAqe/wJsyzTPuPviY8KArbLXKH9zEbR4/8kEH6vIelyd665BwNoItg==
X-Received: by 2002:a1f:9187:: with SMTP id t129mr9851227vkd.12.1611781890289;
        Wed, 27 Jan 2021 13:11:30 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id c123sm434446vke.22.2021.01.27.13.11.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 13:11:29 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id v19so1893937vsf.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:11:29 -0800 (PST)
X-Received: by 2002:a67:f997:: with SMTP id b23mr9145052vsq.34.1611781889026;
 Wed, 27 Jan 2021 13:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20210115224420.1635017-1-dianders@chromium.org>
 <20210115144345.v2.3.I6916959daa7c5c915e889442268d23338de17923@changeid> <161160651990.76967.1833069919954122114@swboyd.mtv.corp.google.com>
In-Reply-To: <161160651990.76967.1833069919954122114@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Jan 2021 13:11:17 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XEsZVfgoOzMAMtye+NB17cP5VO9s=_yVZ2Frp4y4Y6Ug@mail.gmail.com>
Message-ID: <CAD=FV=XEsZVfgoOzMAMtye+NB17cP5VO9s=_yVZ2Frp4y4Y6Ug@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm/panel-simple: Retry if we timeout waiting for HPD
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 25, 2021 at 12:28 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > +/*
> > + * Some panels simply don't always come up and need to be power cycled to
> > + * work properly.  We'll allow for a handful of retries.
> > + */
> > +#define MAX_PANEL_PREPARE_TRIES                5
>
> Is this define used anywhere else? Feels like it would be better to
> inline the constant and move the comment above the loop, but I guess
> this is OK too.

Hrm, usually I only add a #define like this when I need to use the
same number more than once, but I'm not doing that here.  Maybe I did
in an earlier version of the code and then didn't go back and remove
the #define when I reworked it?

Since this is a bit of a style issue, I will leave it to the
simple-panel maintainers to decide.  I'm happy to spin this and add
the comment before the loop and just hardcode "5" in the loop instead
of using MAX_PANEL_PREPARE_TRIES, so just let me know.

-Doug
