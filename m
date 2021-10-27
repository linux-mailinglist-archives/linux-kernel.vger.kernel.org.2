Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC4743CB93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbhJ0OK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242408AbhJ0OK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:10:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21542C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:08:03 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so3787666ott.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dqUuQlH4DnXRPcRZFyC/rf6NwywVKvTGkeOXqaPUVW4=;
        b=hft5zQ9WiyF+SuVBhIXBL+D88PaNa8tafAqttZ+3UoKqrswtDootJcCltsM2NIu49z
         UCKZx3kid/GlJGdATO98C6QgCW37J3Tq9+/WYutzivX4ENw8os69ekVJX2GEnGvIHTU1
         vWnoCrhrzbbfOBss3jgJ2GwIqELxO+ViyUX6CTN9ztxkYOI/ny1aViAZAJ3Rc1RkEWXc
         unqCEwFFQ6ZNo2hJwy9e/73dhzOObzqbmwb5fjQn6gEjGpj8io7KVNC/CdkxoEpnGx0M
         gauFpVi2aU1DgKG8XRV8Z+ZI193YUMjAkuBQ1LPxya1uQ4iYt0BBrPCqMS+vqwE/6zdl
         +I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dqUuQlH4DnXRPcRZFyC/rf6NwywVKvTGkeOXqaPUVW4=;
        b=p970njMeMOW2ReYvcrldqqq2daAKbJlhy8NBGGAJo6pkh4+VibejyCmNmx6fJmcdtZ
         CCZ6q+ILJ0ctqSqdxvAYdWQCFUbPhPaWJEmoIBRn7XX2aC1XcWIbp0aTQPoF/EYiJTuT
         FfY+vQslmqWavFb5yDLKQMTBaGAyhVsYA4OWdiUTkykjapLtdmUxdrGC1Y4ehhm+5jCk
         HfOVgyQA2C+NiOLLYi+xu3RhW99SlstgO+EYU7WhMUcblVvl7ZRgUIxx4M+okpgaGAf7
         qAjz+zn9Fn31M5FDo44r7eVSt0e1TppAopykRLBrAogK/gMNZfKKkyq/3BIPWQ28jfEB
         rvPg==
X-Gm-Message-State: AOAM533elvfa0g2fBXLw7KgvsXnln6TOEhgRux8m+uQwruD9DwK6dErU
        xPV8TyL30KrKnkQ0cX92AO8Hww==
X-Google-Smtp-Source: ABdhPJw1mWzgD6QE89wYJ8HWGsD1ilb9e/Cg2rV3cNaRk8EuSYUuFr3KlPKt93OVWCDA79gA41Ft+g==
X-Received: by 2002:a05:6830:2a8a:: with SMTP id s10mr26073246otu.17.1635343679907;
        Wed, 27 Oct 2021 07:07:59 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id a71sm40887ooc.10.2021.10.27.07.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:07:59 -0700 (PDT)
Date:   Wed, 27 Oct 2021 07:09:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     SoC Team <soc@kernel.org>, Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: qcom: scm: fix non-SMP build
Message-ID: <YXldsEH+oqN9a2vi@ripper>
References: <20211027072427.2730827-1-arnd@kernel.org>
 <CAK8P3a1CjfRmJsc0p2P2ja1DB6QFsuwnkBdXk1CfdzGjGpK-3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1CjfRmJsc0p2P2ja1DB6QFsuwnkBdXk1CfdzGjGpK-3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27 Oct 01:49 PDT 2021, Arnd Bergmann wrote:

> On Wed, Oct 27, 2021 at 9:24 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > A check was added for non-arm platforms, but the same code
> > is still broken on Arm non-SMP:
> >
> > ERROR: modpost: "__cpu_logical_map" [drivers/firmware/qcom-scm.ko] undefined!
> >
> > Fixes: c50031f03dfe ("firmware: qcom: scm: Don't break compile test on non-ARM platforms")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Nevermind, this is not sufficient, as the symbol is not actually
> exported, so this still
> fails on SMP configurations, both 32 and 64 bit.
> 

Damn, it seems I only compile tested it on the three platforms with
configurations where it ended up =y in the end.

> Any ideas for a better fix, or should I revert 55845f46df03
> ("firmware: qcom: scm:
> Add support for MC boot address API") for the merge window?
> 

Let's revert the patch (and the fix) for v5.16 and try to figure this
one out for next round.

Regards,
Bjorn
