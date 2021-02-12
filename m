Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7602D319C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhBLJpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:45:15 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42515 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:45:12 -0500
Received: by mail-lj1-f179.google.com with SMTP id v6so6163153ljh.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=qEeOVeGWUjbAKd3cc616gfNSqKL4F62UR20tHIDa83s=;
        b=H5keGv5kmJzVopY+IYkM5X+YnHL4CVzZwE8DRPRlDplo2eyK6fSUysrOGYsCuA1vz3
         5uE7itu+254SetGHUTC1ZOy9Iy9e1Px1MxKFbPXxP4vTAAn7imWwA5IkhBftu8TxrGqi
         Uv9U/U4KDjKQBQKyGDgGRlmQnPStqgaf8Azi1/gaoMA+qHbvpNDbzltTYPkUSyGFUPvM
         cUiorZD0+Wc5KkvhrTCkSfzWW17AoiwQosi+ZzwR0OPHdITImrZ58s0agnmKScF370K1
         ZgsoSlE5lPaovnsdOWHfcDv326lWig3sNvjb2KWVK7aBAwyL589AJewbnS7/+XKeBB5j
         URXw==
X-Gm-Message-State: AOAM5309utujgRSD4VSTh4lhFZM4El9JnBeXmoaYY2CiUy9bbB8fk8qL
        1EhucqZepb6vd3J+RC3cW70=
X-Google-Smtp-Source: ABdhPJyukF6o9pPKdx8454gWasWj/ENUYADOj1/Q16fjMrBjtQRXov+kosLT1DpOpatiKqOWKvDw0g==
X-Received: by 2002:a2e:9a1a:: with SMTP id o26mr1227066lji.231.1613123069863;
        Fri, 12 Feb 2021 01:44:29 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id i13sm920648lfo.203.2021.02.12.01.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 01:44:29 -0800 (PST)
Message-ID: <5d23f943cea65096eb40fec45f54114fd879905f.camel@fi.rohmeurope.com>
Subject: Re: [PATCH RESEND] regulator: bd718x7, bd71828, Fix dvs voltage
 levels
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210212091608.GE4572@dell>
References: <20210212080023.GA880728@localhost.localdomain>
         <20210212091608.GE4572@dell>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Fri, 12 Feb 2021 11:44:25 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

On Fri, 2021-02-12 at 09:16 +0000, Lee Jones wrote:
> On Fri, 12 Feb 2021, Matti Vaittinen wrote:
> 
> > The ROHM BD718x7 and BD71828 drivers support setting HW state
> > specific voltages from device-tree. This is used also by various
> > in-tree DTS files.
> > 
> > These drivers do incorrectly try to compose bit-map using enum
> > values. By a chance this works for first two valid levels having
> > values 1 and 2 - but setting values for the rest of the levels
> > do indicate capability of setting values for first levels as
> > well. Luckily the regulators which support setting values for
> > SUSPEND/LPSR do usually also support setting values for RUN
> > and IDLE too - thus this has not been such a fatal issue.
> > 
> > Fix this by defining the old enum values as bits and fixing the
> > parsing code. This allows keeping existing IC specific drivers
> > intact and only slightly changing the rohm-regulator.c
> > 
> > Fixes: 21b72156ede8b ("regulator: bd718x7: Split driver to common
> > and bd718x7 specific parts")
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> > 
> > I just noticed this fix never made it in-tree. So this is a resend
> > of a
> > resend :)
> 
> Not sure what you mean.  Isn't this patch part of:
> 
>   [PATCH v2 00/17] Support ROHM BD71815 PMIC
> 
> ... which has just been reviewed and is awaiting rework?

Sorry for the confusion Lee.
It was originally part of the series but I did intend to submit it
separately. That's because it is a bugfix for existing drivers - and
because the  series "[PATCH v2 00/17] Support ROHM BD71815 PMIC"
is expected to take some time as it needs to wait the dependency
patches to get merged in relevant sub-systems. (The parent-data removal
patches to gpio, regulator and clk).

So my thinking was that that fix could've been merged in as it's own
patch to get existing things fixed in next release. I could then rebase
the "PATCH v2 00/17] Support ROHM BD71815 PMIC" - series on top of this
when it is in-tree.

I think I should have communicated this better. Sorry.

Please let me know what works for you guys the best.

Best Regards
    Matti Vaittinen

