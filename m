Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6B3A6B83
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhFNQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:20:49 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36764 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhFNQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:20:47 -0400
Received: by mail-ot1-f53.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so11353111otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3QwEcalkIS8ReAls0/w7Nq1e4RuGQTqstXEHc+vsOnw=;
        b=S/yAuDYd0JJppmMTVABmtYQaTxnWKGrE2YRVqTjzJ98NhyUvuZFMuZIfgEOKz+ZWke
         Tp0dQGkuFuu43P0a2iUud4BhxePaAFurc6Igt2Kqx4nSxxSMRJ1CFclCo3Vzku7H2sEA
         dd6bJCD3wZMp8kfBHn1d9kUnv1STq417xUX1nc8ZlvzwISY3yEc9gGqOF1dzhj4D/ZWk
         xWUqBVEA1FkVeMYIcfsgL/MZBm73Uor4DRE2Ip6eaY3+ofk2IGboaTxGcUIVGnz6CYae
         WCkISe17fvoNKygeSwblRq/9M4krUbJe7jw3l/PrRNfxFnXGeqji2XJWOKVFQ84jC6LY
         r9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3QwEcalkIS8ReAls0/w7Nq1e4RuGQTqstXEHc+vsOnw=;
        b=Kk9lrg43KGvY5YPO6Y1VHo4gQTLXSN3zDyFSMHpp7eJ3TnuFyjrfBfGXXZTm29HRxP
         65VUc7hTNu3HzLgEQ1uAxmamPF7BBXuOTNxmhf1YjL4wT7lYtbB1xA9DBKkigGvhVe1V
         Mh9ON8M0cm3Vhgb15FgNcSyTwJsP2gZt5Q2BVwzAg2S5Igzkqytnma74CqBkj2lr6WzV
         qCXC3ihI8YleTbY7Fms3OpRd+oSyWF4kHh3ti3BQF0KRGCorhchaCUegn+6xW2GHjty6
         WWuKoxSvk5H4wEQLPHsP+KBwfrKoSmgjy9rWhGo+/B/yfK03m6Lk8TGMO/6YHxbSkJOo
         6uVQ==
X-Gm-Message-State: AOAM532Gi2+uC74kkIafU2BUsL5r5OjJFsg2y11eqqSzKXyRMcX3O/sT
        JSghKwhZRvA0QmY5v2AI0AAJdQ==
X-Google-Smtp-Source: ABdhPJzGtoAEDMq3D7uKFxq3zKowTgSYfT12PYxCOFGS+q5zFs8XY0M33mXlcr7v7ZVoLEVwiH9K4g==
X-Received: by 2002:a9d:7254:: with SMTP id a20mr13823489otk.142.1623687464039;
        Mon, 14 Jun 2021 09:17:44 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x31sm3327351ota.24.2021.06.14.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 09:17:43 -0700 (PDT)
Date:   Mon, 14 Jun 2021 11:17:41 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        bhupesh.linux@gmail.com
Subject: Re: [PATCH 4/8] regulator: qcom-rpmh: Add new regulator types found
 on SA8155p adp board
Message-ID: <YMeBJRujxoxj9no4@yoga>
References: <20210607113840.15435-1-bhupesh.sharma@linaro.org>
 <20210607113840.15435-5-bhupesh.sharma@linaro.org>
 <CAHp75Vd7z6ivOxHikqP5j+yPtV7C8GBogwVUAziLznSatH+8EA@mail.gmail.com>
 <CAH=2NtxtzRhOzekHxn+V4DSYmwncX1wSRbKOe=PNkcTsQ3jqiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2NtxtzRhOzekHxn+V4DSYmwncX1wSRbKOe=PNkcTsQ3jqiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Jun 07:30 CDT 2021, Bhupesh Sharma wrote:

> On Mon, 7 Jun 2021 at 17:39, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Jun 7, 2021 at 2:41 PM Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> > >
> > > SA8155p-adp board has two new regulator types - pmm8155au_1 and
> > > pmm8155au_2.
> > >
> > > The output power management circuits in these regulators include:
> > > - FTS510 smps,
> > > - HFS510 smps, and
> > > - LDO510 linear regulators
> >
> > ...
> >
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Andy Gross <agross@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-gpio@vger.kernel.org
> > > Cc: bhupesh.linux@gmail.com
> >
> > Use --cc or similar option when run `git send-email`, no need to
> > pollute the commit message with these.
> 
> It's just a matter of preference IMO. I prefer to use a Cc list
> here.
> 

The Cc list in the commit message will be committed to the git history
and there it carries the information that you specifically made sure
that these people saw the patch. So please limit the use to that
purpose.

> > > +static const struct rpmh_vreg_init_data pmm8155au_1_vreg_data[] = {
> >
> >
> > > +       {},
> >
> > Comma is not needed in the terminator line.
> 
> Hmm.. it's similar to the syntax already used at several places in this file.
> See ' struct rpmh_vreg_init_data pm8150l_vreg_data[] ' for example.
> 
> Unless there is an obvious issue with it, let's use the same to keep
> things similar from a syntax p-o-v.
> 

Those other places shouldn't use the ',' either, so please help set a
better precedence.

Thanks,
Bjorn

> Thanks,
> Bhupesh
> 
> >
> > > +};
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
