Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF7E3F0025
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhHRJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhHRJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:14:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E741C0617AD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:14:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so1922063pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tDuCq4cpa/FhfVLg3d4eOXI0t92SH+lRUdr1ZBj+304=;
        b=quAhTr+R/08xh/ignvyvF/El1dD/NQftWfiNTcAu87cJhuBhgI+As0zoEiydqeW6PP
         Ex/zHp4EDoA27CiqypV1XRJjyjppnIr9cuHPeEqT4Jz0u4Gd7rGoODV0vOYF2r+fXVrC
         O9YNeAY5lMNde/fcVIInzFs4EQNgUzhxxcNX6YMHjHSIPhU1rXEQOl9Aq3E25JLQ/9fv
         VxP/TlWw72/n6skEH8miH2qbrmh27V7jR6dmqc1oF+jbwQP/bhXkGIrzGuJgVHwfQUpg
         jLxJj1fuqBdXtzbuG0/ZFv6pjltmBS+1GsQZASCe+7q/ocD5Ye+29smqIZ7DN+BRR4O7
         VT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tDuCq4cpa/FhfVLg3d4eOXI0t92SH+lRUdr1ZBj+304=;
        b=G+O2vlsPq1PEzshyJAOBKiBPpsfG27CnWPr6XM+hBofUCGq9iJkMBBadXkDp76eUUj
         JMrKPLcF6kpCIiE8tQwFYVg8dfWyzW5bZira0F6hblDcZ913U3+/c3z8cFWiJwHKoxXO
         QcZWPsltnfYMyjfiAOUto9zjvFEIyUP3DtK3pKX+M6o2SjtBVqMeladDyz0y9nlS3A9S
         /MfJfOtAKidOVS/k9qk5+/UKR3X3SdP2j7/g/x+ev234uEjY3FDLoeS/OOJYzqzAhSQh
         lg8ZJ4OWU9QAjX+6YlHjOm7rDodOyX8D8m1kBnpBeJvIokbdMsvZ8dt7yoM5ECfake0I
         z9eA==
X-Gm-Message-State: AOAM530Nxr1wLkFRbOwbAJYuED+e9558OsL6gpMcyb5WSaGtQX8S7959
        MTE43QEnBrLfyB8KA7OKEwR9ZQ==
X-Google-Smtp-Source: ABdhPJz4yEie/eMLpBAmymSzx5jt3Od7muuoKSX0aK0QfqCy9SYA7S2Wvgljmd2wM1mkIsijUEW0lQ==
X-Received: by 2002:a17:90a:d791:: with SMTP id z17mr8231461pju.203.1629278059957;
        Wed, 18 Aug 2021 02:14:19 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id a8sm1540816pfo.79.2021.08.18.02.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 02:14:19 -0700 (PDT)
Date:   Wed, 18 Aug 2021 14:44:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
Message-ID: <20210818091417.dvlnsxlgybdsn76x@vireshk-i7>
References: <20210818035533.ieqkexltfvvf2p4n@vireshk-i7>
 <5b2a80c1-9743-e633-6257-ede94c8a274c@gmail.com>
 <20210818043131.7klajx6drvvkftoc@vireshk-i7>
 <a2a3c41f-c5e4-ee7e-7d48-03af8bac8863@gmail.com>
 <20210818045307.4brb6cafkh3adjth@vireshk-i7>
 <080469b3-612b-3a34-86e5-7037a64de2fe@gmail.com>
 <20210818055849.ybfajzu75ecpdrbn@vireshk-i7>
 <f1c76f23-086d-ef36-54ea-0511b0ebe0e1@gmail.com>
 <20210818062723.dqamssfkf7lf7cf7@vireshk-i7>
 <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-21, 10:29, Ulf Hansson wrote:
> Me and Dmitry discussed adding a new genpd callback for this. I agreed
> that it seems like a reasonable thing to add, if he insists.
> 
> The intent was to invoke the new callback from __genpd_dev_pm_attach()
> when the device has been attached to its genpd. This allows the
> callback, to invoke clk_get_rate() and then dev_pm_opp_set_rate(), to
> update the vote according to the current state of the HW.

I wouldn't call dev_pm_opp_set_rate() from there, since it means
configure and enable (both) for different resources, clk, regulator,
genpd, etc..

What we need here is just configure. So something like this then:

- genpd->get_performance_state()
  -> dev_pm_opp_get_current_opp() //New API
  -> dev_pm_genpd_set_performance_state(dev, current_opp->pstate);

This can be done just once from probe() then.

> I am not sure if/why that approach seemed insufficient?
> 
> Another option to solve the problem, I think, is simply to patch
> drivers to let them call dev_pm_opp_set_rate() during ->probe(), this
> should synchronize the HW state too.

Dmitry already mentioned that this will make the device start
consuming power, and he doesn't want that, else we need an explicit
disble call as well.

-- 
viresh
