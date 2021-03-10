Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EDB3348B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCJUNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCJUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:13:03 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7768DC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:13:03 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id r24so10596914otq.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ParB71IxhiRrfBGpAi87T+sw94LRbdpcOA901A69TgA=;
        b=l9TN+s8G4fphqlAMXmxn0VTICbyOlt5MCFF/fUR/8oug0GoivqZ4PHhuFHh5SbZtyX
         0MN1f3BqjFJ9KZB0opLj49yl27RHF3KQAG9oX8nUsh2QbgHxIcMtkPbD2ki38nki9qbI
         ehc+6w1G3/oSnkOORqaQCC+f0XmGfuToDdeHPgM6/jWUURIHuOnl5ZA82W6/1eEhMfYG
         QMJyTjJ250M+Bqq/tB03enMaqc4eGMUzHPEPFgRhDYvYhwRnAdOsGqbEMkFCYbI+Hm0X
         TGkaIZ8L8rdMsJMJXYvQJ4qTVBEblp1XRzlaaVCDVGvPtuMM19ecJWAiDkml71Z9q44k
         2CHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ParB71IxhiRrfBGpAi87T+sw94LRbdpcOA901A69TgA=;
        b=sN/eATCkxW4pJnWlgvB4fzd6csv3lBEvV92GU4LGPenfSzZ39lPPt2hlC2tnyCPMR8
         A3tv4+bo0sgdzxlB7RvUPaworOS+uzbvSJu+VnaQVWpJbL3GNdicBBGd+gOR57u9OlrQ
         NGGQr3gqiqh6Ip8UC6QYlB7rkRhkSCL2Evk6JbSrx6zC2bnQsjQ2wpH2AhMWQLijXET4
         geWUtclj0wdHbeFkUrBtgnfd2DYvYnjagvZ7fQ53tdecI3m5/HUOydOczSytb/7V95Ww
         tcNbtjr49ZuNJvNNasA+6T1isQ7IJnPldUgipO3qJrxuQEQ0lVbc94M8no0HENOLoQ1/
         oGhA==
X-Gm-Message-State: AOAM533XjmMOhBNSqSfHmVcgyOtDe8ovJ+Ko9MTrRTq1rT2aOTSKAgnu
        rdmL88gLN9qfpv8xPctu/aJVNg==
X-Google-Smtp-Source: ABdhPJxG71p4NqMut9jm2BctnUtl0uE1+wVO4QiKMsPrTKbFBAfQ1ej1T/mHQqfW4Ul/TSOVfc/7Bg==
X-Received: by 2002:a05:6830:1da8:: with SMTP id z8mr3844420oti.11.1615407182801;
        Wed, 10 Mar 2021 12:13:02 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j19sm98919oie.6.2021.03.10.12.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 12:13:02 -0800 (PST)
Date:   Wed, 10 Mar 2021 14:13:00 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH RESEND 0/2] Common protected-clocks implementation
Message-ID: <YEkoTEJqzpRacByw@builder.lan>
References: <20200903040015.5627-1-samuel@sholland.org>
 <9363f63f-8584-2d84-71fd-baca13e16164@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9363f63f-8584-2d84-71fd-baca13e16164@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09 Mar 02:03 CST 2021, Rasmus Villemoes wrote:

> On 03/09/2020 06.00, Samuel Holland wrote:
> > Stephen, Maxime,
> > 
> > You previously asked me to implement the protected-clocks property in a
> > driver-independent way:
> > 
> > https://www.spinics.net/lists/arm-kernel/msg753832.html
> > 
> > I provided an implementation 6 months ago, which I am resending now:
> > 
> > https://patchwork.kernel.org/patch/11398629/
> > 
> > Do you have any comments on it?
> 
> I'm also interested [1] in getting something like this supported in a
> generic fashion - i.e., being able to mark a clock as
> protected/critical/whatnot by just adding an appropriate property in the
> clock provider's DT node, but without modifying the driver to opt-in to
> handling it.
> 
> Now, as to this implementation, the commit 48d7f160b1 which added the
> common protected-clocks binding says
> 
>   For example, on some Qualcomm firmwares reading or writing certain clk
>   registers causes the entire system to reboot,
> 
> so I'm not sure handling protected-clocks by translating it to
> CLK_CRITICAL and thus calling prepare/enable on it is the right thing to
> do - clks that behave like above are truly "hands off, kernel", so the
> current driver-specific implementation of simply not registering those
> clocks seems to be the right thing to do - or at least the clk framework
> would need to be taught to not actually call any methods on such
> protected clocks.
> 

I can confirm that this is the case. Marking the clocks as critical does
not prevent the kernel from touching these registers so the boards where
this is used doesn't boot with the two patches applied.

> For my use case, either "hands off kernel" or "make sure this clock is
> enabled" would work since the bootloader anyway enables the clock.
> 

Our use case is that depending on firmware these platform might handle
some specific clocks in firmware or in the kernel, and in the prior case
security permissions are set up such that these registers are off limit
for the kernel.

Regards,
Bjorn

> Rasmus
> 
> [1]
> https://lore.kernel.org/lkml/20210226141411.2517368-1-linux@rasmusvillemoes.dk/
> 
