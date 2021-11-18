Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200DF45626D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhKRSe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhKRSe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:34:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528B0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:31:28 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso6547637pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JahmURoXBpdrG/zZ4YqYsqdrEmWXbGGp7MXl+Rf1lRk=;
        b=GWITrKiU3TYnu2v4rPJE357hkIE53WNulBCQ8zIwxiO261sPBAq435OHfJk0u2Ex8o
         kMQxaBomq0ftBcEI+hgv4xd3AgZ+vTmWO34gfeBzgfxb+QfStlFXOsORK3PVBJ6sKAbj
         XwcqC8sX434SdQPM9dpiI3eR7q5xsJprLAZaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JahmURoXBpdrG/zZ4YqYsqdrEmWXbGGp7MXl+Rf1lRk=;
        b=39i4UFDQtfi4qqDWlhuHfpWELOhbEkoKfRP2SxL2G9SwG4AlOVsSSM56PW7hzdxM3n
         LqLlZekm/tFHg0gmV30NqFHbQ74hnhVqzhwlHqM6oFc29xf+tzQ/X99RXB9PAD9DvuzH
         o/kDibdw4WhK6lLAbP12iVG3QF5R6imd6V+zTZ0w07RcGGd5fbLWrIJ7VatjweQDiAJP
         t4/3agkL9puqEIuHxJOnhiQQO8dSI+OQ4gVX4hYyBiqBRKXt2z9nzHMri/MLIgWpIjPj
         Sjo8L11AR/gSg/5zfzAi742y1hPDh33sIBo3JRFJrzwz+gNt9ObQFqXx3SkC3tcWcA2H
         0kPg==
X-Gm-Message-State: AOAM530vlavaqmJQgChebpFub7TXAfQNXR8Yg9DBNg2CENLQyv5QEdth
        hSNxs8yv7qV28nQnuiln9r83Iw==
X-Google-Smtp-Source: ABdhPJyavBQ6FX9lX/05f4CtIha1xk8B/dWinGz1YTjcV8ygxuXB+1gD7F11HUgZPGRG/NGvUwUbfQ==
X-Received: by 2002:a17:90a:cc01:: with SMTP id b1mr12707388pju.226.1637260287209;
        Thu, 18 Nov 2021 10:31:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm254810pgo.88.2021.11.18.10.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:31:26 -0800 (PST)
Date:   Thu, 18 Nov 2021 10:31:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Tony Luck <tony.luck@intel.com>, Colin Cross <ccross@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pstore/ftrace: add a kernel parameter to start pstore
 recording
Message-ID: <202111181030.A6A1469@keescook>
References: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
 <163725891549.1179817.6546871118396864090.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163725891549.1179817.6546871118396864090.b4-ty@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:08:38AM -0800, Kees Cook wrote:
> On Thu, 10 Jun 2021 10:21:34 +0200, Uwe Kleine-König wrote:
> > With this knob you can enable pstore recording early enough to debug
> > hangs happening during the boot process before userspace is up enough to
> > enable it via sysfs.
> > 
> > 
> 
> I refactored this patch a fair bit so it would use a common enable/disable
> routine, but otherwise the original intent remains. :)
> 
> Applied to for-next/pstore, thanks!
> 
> [1/1] pstore/ftrace: add a kernel parameter to start pstore recording
>       https://git.kernel.org/kees/c/8d74118c9441

Hrm, sha shenanigans. This is actually:

	https://git.kernel.org/kees/c/a5d05b07961a

-- 
Kees Cook
