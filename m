Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1033C338A59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhCLKh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhCLKhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:37:24 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1D7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:37:23 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id p24so12239034vsj.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3/Vc1Ah6eKHyLWI1pgidt8/nWh+3HJqZHQUqW0QsJY=;
        b=e/OV4wNhRA/Hs5pdnjxqlm48AcxIBgreDOOJNjy58xe/C+lYYaCP1LvYHtxw5nNMDd
         ALc5X7QtHJfqYjQJtkk29KbBS+sCEO+r861cukBYcKfIkwG7Ou4nlCW1n/UmnxXDl8UZ
         Z/fv7WEl9eLwGeyto13VUunS/sfPRI2c3QsnbpFtyEdc7Gfom8B6Uyb0CQaIhkyCgJpI
         Vsh00DPD7rj87XdaxRSYPfBsBAN7FvwewFG9kAbAybHO8w6BrDs7Q/oHkpYaTspxVr8g
         hG55hBJ9e6DnKN6cjQsuVlY7/n4MxMQTtSF3SukeI2+Zdfpe9OF7WCVtCu8zUxSY8ajX
         hHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3/Vc1Ah6eKHyLWI1pgidt8/nWh+3HJqZHQUqW0QsJY=;
        b=TVv8Xr8PzbdIiVT9lq1FnqymIfv7uAS7R4QD+5dVzqHoolkiBY2Bgr8QtfYArr9x4j
         6SJkZSSrFfOSeuJfkD32LG+isINmKfPpriuvTyFs3wcPHPHMy+J1oAHKm676NY/5tUat
         V6IdUjASfnq2CL7RP6k3jLQ/MRBslpqyI6dUeU7eiCvmISc30ycJ0Zhk1vi+uNBUSbGW
         JPajlCtHbRRsC3C1yYpEAJtjpVkCwRneM5ltzpz56C4Po2qKuxkQTwgz6vmPTg2zxn+8
         VIWwkLdMuaO1RpGcMUofPuxNs8+QKMe70J3mLmbP33JGVGZITk/taoCvHO1aRojQI6yd
         CLEA==
X-Gm-Message-State: AOAM533OXpcF8jAdSHXcJ+uvXrxBtoGju6Eu31GgcWPT0ISHNPc4lbQl
        RiQhzn3PB8vRHZ4XwKfwan/hzSaXci3xNeTjHO2oCg==
X-Google-Smtp-Source: ABdhPJyLTgXQd1zTmLlKpEGuucdoDu6MxM1Ifem4y53cs/Xb9ONexPA+wPxOnpJgqOBWr4/fpZSZO+YOQXGKhLX6tmk=
X-Received: by 2002:a67:6942:: with SMTP id e63mr8188302vsc.48.1615545442849;
 Fri, 12 Mar 2021 02:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20210311192105.14998-1-digetx@gmail.com> <20210311192105.14998-2-digetx@gmail.com>
 <20210312053312.zgke2mzjkqmwn67i@vireshk-i7>
In-Reply-To: <20210312053312.zgke2mzjkqmwn67i@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Mar 2021 11:36:46 +0100
Message-ID: <CAPDyKFqrUCjTfrNqZ4gFfQS6LpoQCevGc-tv4WVOwuGhx5iiBg@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] opp: Add devres wrapper for dev_pm_opp_set_clkname
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 at 06:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-03-21, 22:20, Dmitry Osipenko wrote:
> > +struct opp_table *devm_pm_opp_set_clkname(struct device *dev, const char *name)
> > +{
> > +     struct opp_table *opp_table;
> > +     int err;
> > +
> > +     opp_table = dev_pm_opp_set_clkname(dev, name);
> > +     if (IS_ERR(opp_table))
> > +             return opp_table;
> > +
> > +     err = devm_add_action_or_reset(dev, devm_pm_opp_clkname_release, opp_table);
> > +     if (err)
> > +             opp_table = ERR_PTR(err);
> > +
> > +     return opp_table;
> > +}
>
> I wonder if we still need to return opp_table from here, or a simple
> integer is fine.. The callers shouldn't be required to use the OPP
> table directly anymore I believe and so better simplify the return
> part of this and all other routines you are adding here..

Yes, please. I was thinking along the same lines, when I reviewed the
mmc patch (patch9).

>
> If there is a user which needs the opp_table, let it use the regular
> non-devm variant.

Kind regards
Uffe
