Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBEB36F14C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhD2Uu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhD2Uux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:50:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B653C06138B;
        Thu, 29 Apr 2021 13:50:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so40068976edb.2;
        Thu, 29 Apr 2021 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYep7DOlIrBwf9rsY4DQWIcoFlibsgvSZY3B/DcJdfg=;
        b=I25T9hixgQAsDaNe83dVEDp50wP1nN6G63BPhGqPcFsE2D5fUk/NTom7hVS70E4DRA
         VhvrxRR9YtQ02ExDrIkFXqjDFp7mnrpJjQA5Ra+hqaL3IgOFJelW95+rYKQ8OsL9Ft44
         flHVH0IVmclqSFS4asalpYPc6lQO4ZKkbEzXzh//j2DVZOjxObUaLKKltYPxXMydK9W2
         1bVV6+GIol/5a1eM/UxaYzBucIDBoDQPP58MneazC6EflvUABOhm8q2qXH3XI17dt+vt
         GhyWVd3H6XsBoQCZjSpfoMkwt6PfobGaiV/j5dc1Npb4cgLIE67REI/XQ4rJogA9YNFc
         Nkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYep7DOlIrBwf9rsY4DQWIcoFlibsgvSZY3B/DcJdfg=;
        b=sXPGUL6tEGudHvQWNIBxn1jIkmtBw3CnsqQPi15yOklg9xQ327AyLABF8GxZKL0xYi
         /IttLG46pJVnQuRChzYcB207VPHhl8aMcb1+4PTvn5Wq8ULsyUIdzGgdd/CjSIQsp/8w
         BzGKMsAwqtTGr6tYimvS+hSq8kaSBn3gqnZYLvbCBC+mImnr18QpLJab8P0hjSKM1y42
         qJT5csnfHvMV/hpbdYudwwjruGtMaQaKwvGZJk3hgW+pAQSO4NcX28G8jt4245qLizoB
         MlBBoPbvoZLYHQQj3u47SQcMO/o0/RvqUpJNyASL+sBQGzZn3/JSkEPUunesT3llZqnK
         +39Q==
X-Gm-Message-State: AOAM531bY0JKP9vzC3V7gnuazukAOXSvzUF7T4Cwpss8EvFFB3KYoDeR
        wZrH9nvMiNltS//QqiVydU0eX3xVx6qG25FwaeQ=
X-Google-Smtp-Source: ABdhPJz8oW/YGEAMbGIiBMqPkwePjgTRbJCwGYkAtXYds2j96mVj2F2/CsZH1CG9WOp4AOfV5vP0fYnhzUgu+uuDVEU=
X-Received: by 2002:a05:6402:3109:: with SMTP id dc9mr1833460edb.13.1619729404817;
 Thu, 29 Apr 2021 13:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210429090516.61085-1-jbrunet@baylibre.com>
In-Reply-To: <20210429090516.61085-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 29 Apr 2021 22:49:54 +0200
Message-ID: <CAFBinCCcKHqd7Mh3bV9NyyWzi=96pCWxzSZBOjg5Puy9wOuihQ@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: axg-audio: do not print error on defer
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Thu, Apr 29, 2021 at 11:06 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 7c8d02164443..5e501eff0840 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -1811,7 +1811,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>
>         ret = device_reset(dev);
>         if (ret) {
> -               dev_err(dev, "failed to reset device\n");
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to reset device\n");
many drivers are switching to dev_err_probe nowadays
According to it's documentation:
  In case of -EPROBE_DEFER it sets also defer probe reason, which can be
  checked later by reading devices_deferred debugfs attribute.

so I think it makes sense to use dev_err_probe here as well


Best regards,
Martin
