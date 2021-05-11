Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA0D37A53D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhEKK6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhEKK6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:58:05 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2755C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:56:59 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id m17so9961578vsn.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzuUJNlN6zFe3lbQy9UWCFGOnXngAGzdHt+g+eYNfEo=;
        b=u28Bov95aO/sH7n+9EQNFrCombDhkYlL+ScFmgE0qxMG2vr06lxfeu5tGwxlE3Emvr
         M2oYauZPM9JWNQD7fFnQFEXId+eKQyyJ66jVLlRTiBzBmjC+kG2SjqvbdKCRSe3sk0dU
         RxQQOQ61m+MEpPs4GnsS/HQYIFcFM+Syj/jjBYS73gwpOh6/RtbWoYsZjg+jn9rPm02f
         QcTbCqwE9UaLsnOdrHlGIMIB/2SY5ZoI/9aQ0BK/Fs2e2V9zcnTxsCJuhBZ8MQWeKl6W
         5YxZtah2Wx6xPGr4YGu+UcMat/VylROKEdU5DpWSdzA0V6gbNZsuQUfW20yojjmGQWVr
         RGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzuUJNlN6zFe3lbQy9UWCFGOnXngAGzdHt+g+eYNfEo=;
        b=UaD3Xoxf9qQJLcWpkO1cbri+pwcZmru13jOVKcm9GNmtlFX3Cv2yFzlhPLQZAgpUKE
         c7IQfnwBAO6GIWIjCS2c26hZWj6movnsXST/BdNrpyZK6agSOU5PcTSWpOOhPDjxEi7O
         LRd80WFOJLaIdhTtu0hsuaLYgwzSbr1xPl9tNHUNKioalvij1+W6Wax2/ftAi9V4dzWq
         R+X+Muc0o9Y4HWZGIHzP3jKmtZ1Sa0i7+RWSHhjsFHq0KqFJKDPCFVmGXsNuZtmrifjI
         307q+dApazUWwMcGP7bUjRot+Yv141iKEWyHQfv421AqPsf5OURxgzPtuIatVoY4NRef
         r8Eg==
X-Gm-Message-State: AOAM530a5UMTcmVnEQyTMayrJpbbrSLKZe8PVRcnN7B4AoKJ8kTd9ziC
        VesTnrF4ZKwhpWi5PwIsEeeFbF3W3lpnnHqDg4HjRw==
X-Google-Smtp-Source: ABdhPJyFhD+Lh02XrPAb5mni64p9iAqg+QAwP4zu51SiNIsBwidKqvduXdsGY8kBo3hXgbz95FIw4Bdp2aA88IjPfD4=
X-Received: by 2002:a67:2c03:: with SMTP id s3mr24304488vss.42.1620730618960;
 Tue, 11 May 2021 03:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210424081652.GA16047@nyquist.nev> <20210426073251.7726-1-benchuanggli@gmail.com>
In-Reply-To: <20210426073251.7726-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:20 +0200
Message-ID: <CAPDyKFoCrFMyDEo8czEjAUPZMiUDcV3hKcYSAfdmujZPe7R58g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: increase 1.8V regulator wait
To:     Ben Chuang <benchuanggli@gmail.com>, dlbeer@gmail.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 at 09:30, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi Daniel,
>
> > Inserting an SD-card on an Intel NUC10i3FNK4 (which contains a GL9755)
> > results in the message:
> >
> >     mmc0: 1.8V regulator output did not become stable
> >
> > Following this message, some cards work (sometimes), but most cards fail
> > with EILSEQ. This behaviour is observed on Debian 10 running kernel
> > 4.19.188, but also with 5.8.18 and 5.11.15.
>
> Glad to receive your report. Thanks.
>
> >
> > The driver currently waits 5ms after switching on the 1.8V regulator for
> > it to become stable. Increasing this to 10ms gets rid of the warning
> > about stability, but most cards still fail. Increasing it to 20ms gets
> > some cards working (a 32GB Samsung micro SD works, a 128GB ADATA
> > doesn't). At 50ms, the ADATA works most of the time, and at 100ms both
> > cards work reliably.
>
> If it is convenient, can you provide the appearance pictures and product
> links of these two cards? We want to buy them.
>
> >
> > Signed-off-by: Daniel Beer <dlbeer@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index 592d79082f58..061618aa247f 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -627,8 +627,13 @@ static void sdhci_gli_voltage_switch(struct sdhci_host *host)
> >        *
> >        * Wait 5ms after set 1.8V signal enable in Host Control 2 register
> >        * to ensure 1.8V signal enable bit is set by GL9750/GL9755.
> > +      *
> > +      * ...however, the controller in the NUC10i3FNK4 (a 9755) requires
> > +      * slightly longer than 5ms before the control register reports that
> > +      * 1.8V is ready, and far longer still before the card will actually
> > +      * work reliably.
> >        */
> > -     usleep_range(5000, 5500);
> > +     usleep_range(100000, 110000);
>
> Looks good for me.

I consider this as an ack and will add you tag to the commit. Please
tell me if I should change.

[...]

Applied for fixes and by adding the below tags, thanks!

Acked-by: Ben Chuang <benchuanggli@gmail.com>
Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
Cc: stable@vger.kernel.org

Kind regards
Uffe
