Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E35315CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhBJCNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhBJA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:58:05 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75ECC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:57:24 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y128so317575ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 16:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCCDjzP34Ivl3lsXM9x/SwTdAdkeCOcYrLzlWFPV+tM=;
        b=ex5ZWphpx1C8Ig4A82Vb5/qVMtJPVzW90lX+ay6ZhdHBl2wb+K4qpQ3MtpMqK130vn
         zt47/aS7FgI7S4x/0mPyiezsLnNR+PCEmPoeYHmR67tHKS12czECs4z5pS3IV7pv4TTb
         faVT5sVd1O5JvWkFjO15nZ+hB/RIldjZ3LhY/47D+/1rutICuNtmbCsF+/WYh15C7pcb
         McTsc7OVSREU3bsydDFPdoE/ZM75JKiAIWeANdH6bl95PQQ5GymWxyva7nzCug8e6EjU
         mZoAKG3BBOlRdUnm5p5675cMFoD5W0AoILySGAsRBZVFEtqv8hc3xTuGSikVvOkkfVgr
         eKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCCDjzP34Ivl3lsXM9x/SwTdAdkeCOcYrLzlWFPV+tM=;
        b=nuRLa7Hvasl9Pumn7iPen5OOAY0OZKq8lBbyFDIqEfuEt9ZMO6sRkdjzr8HPVFmZZZ
         Zk6HSQwK58E4OuTj+5BqhNLFxKpFVMitxCZVeB5ZvXioLr4G5t7v3UfuS7rDt3O7e+sc
         9wv3dF7yrBUe7s1MVbmaQ4njobY9RCo/L+odkyNS7wiP8SmNpFj/tUnIG9bSSoxfUizg
         GoeJg561oLcI3Ir/LWV/KKw78abCtZj51AXTEenO2gP3XEQZWhdXjpuD7X9v9GPPhAJS
         77wIIY+CS33ntEwlZImW7vhi3Rkxf2IpYb3ZG2LzcllLQRjkpNvC7muPesg3AqGDHNkj
         24ZA==
X-Gm-Message-State: AOAM5335iPSjVQqa5StTTlRFZ1BiQd9tCm0ZpNQ0A4NZSVy/hqzQMdbK
        a5RsjYSjUK+Y4dx4sAJNFMvC4lu06vYbHhnh/n/65g==
X-Google-Smtp-Source: ABdhPJxehbw/5RJ+QRtKe+9zFRw3hl9x6b5uKwu1xvC+jjUVpzOAGXZopUVCCD0/vkx9XTYnqC+B2cLCn09LrqKdKmI=
X-Received: by 2002:a25:cc89:: with SMTP id l131mr759286ybf.346.1612918643917;
 Tue, 09 Feb 2021 16:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20210203154332.470587-1-tudor.ambarus@microchip.com>
 <5bc4f5b7-5370-bdd5-143e-429c83447ce1@microchip.com> <161291845517.418021.17378265940034341908@swboyd.mtv.corp.google.com>
In-Reply-To: <161291845517.418021.17378265940034341908@swboyd.mtv.corp.google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 9 Feb 2021 16:56:47 -0800
Message-ID: <CAGETcx9fjRhNmEMF2QoerrzGctC6MMTy+_znVTgPEm1w-+ehqA@mail.gmail.com>
Subject: Re: [PATCH] clk: at91: Fix the declaration of the clocks
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Nicolas.Ferre@microchip.com,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        mirq-linux@rere.qmqm.pl,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        a.fatoum@pengutronix.de, Krzysztof Kozlowski <krzk@kernel.org>,
        Codrin.Ciubotariu@microchip.com,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 4:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tudor.Ambarus@microchip.com (2021-02-08 01:49:45)
> > Hi, Michael, Stephen,
> >
> > Do you plan to take this patch for v5.12?
> > If fw_devlink will remain set to ON for v5.12, some of our boards will
> > no longer boot without this patch.
>
> Is fw_devlink defaulted to on for v5.12?

Yes.

-Saravana
