Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DBD39B609
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFDJfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:35:40 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:55033 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhFDJfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:35:38 -0400
Received: by mail-wm1-f53.google.com with SMTP id o127so4968878wmo.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sgf8szZUYWmNdrKI3gu3zwX9+OcqC8hdJRxUX8YspKE=;
        b=ZhHicDonPK793RF3tGNKrCQeIkcZFXNOLCRYXlX8yud0qwKlysDjeRjN7Qe+g1GDlJ
         IeyoYr+r/6M7FWCFe01ndehC7dwAiOsYfP9oI6w1Q7ZockOREvsRFO5pGmwqgAFzD0TF
         cdRUuFj4+69l0xCz6pn1wRbq7HcPhds2qEHu4VpCz0/EM8wcwNDwtfwJ1LYz8rpuWase
         /1eNtPyfxoXy5QpzxMDo4gQVY6yl5a43hPUoDGtJc74rL6esBZ2StdxfkNV8JyDFu0NV
         2PX1cSoX+yeqF03Q99nNzBScFc5dnCyBTylT+ToGB+Vkc2W3EUCl63lpYdWhSUGWF5kF
         ofbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sgf8szZUYWmNdrKI3gu3zwX9+OcqC8hdJRxUX8YspKE=;
        b=gKl+lNBBn4YGIlR6MRbax3AlxiFWgUWeNpE3/8k2h4diyIM/o32sFp9gTbZLazAwid
         1RMcFXaT1OlvxAvDawOIBzKJNS4QLXJ2ctcCYFx0vKHOcX7morLuqZos7apDNgNGTIDR
         bFoWHpAg4IW5mCkfTH4A/SKtZLZsYiKf4IOzAeHpC2aAdrF2QHDGOqlY7yN6cNn6CaH8
         cJ4a3tgjLwN14i3xFMZ3Slp107bKAOc4hjtF7WsInLYazs7KX/amKPT61rHiv8a0TVkO
         g7P/UPa/Ic8oIcHeDekap7FpwWR84BWKJTVLcHLegwFYyfCP+hjFehrhTtnNsBKUfm44
         jVLA==
X-Gm-Message-State: AOAM532ejSFDnRGWjetTU1ye7Fe1dEb73RzRspBqcrIaEbWU/zD/DRWj
        rxXatyVWH9f0DlpyAQlNQ6q+N62BHulwUQ==
X-Google-Smtp-Source: ABdhPJwrGUtb3zQRg7xmpqDvHIEgG86q9JUwoEBt74fFLO2diZMwKdaQTe5jb8kPLbqb6FCB7xE0VQ==
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr2706969wmg.58.1622799172164;
        Fri, 04 Jun 2021 02:32:52 -0700 (PDT)
Received: from dell ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id m65sm5244301wmm.19.2021.06.04.02.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:32:51 -0700 (PDT)
Date:   Fri, 4 Jun 2021 10:32:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/16] i2c: busses: i2c-mxs: Demote barely half complete
 kernel-doc header
Message-ID: <20210604093249.GJ2435141@dell>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
 <20210520190105.3772683-10-lee.jones@linaro.org>
 <YLk7qcWTZnQmLGkW@kunai>
 <20210604084710.GG2435141@dell>
 <YLntC+Sl8MaFFZw4@shikoro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLntC+Sl8MaFFZw4@shikoro>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jun 2021, Wolfram Sang wrote:

> 
> > IMHO, we wouldn't want to foster the impression that it's okay to
> > provide a non-determined effort, safe in the knowledge that someone
> > will come along later and finish the job for them at a later date.
> 
> Right.
> 
> The first lesson from that is that maintainers should require
> documentation of the fields when they get added. This was my oversight
> because it was back then not reported by checkers, probably. I am sorry.
> It annoys me, too.

Sure.

When I started this work, there were 18k+ W=1 warnings in the kernel.
Now there are more like 3k.  I don't think anyone is to blame per say,
it's just something that people haven't particularly cared about up
until this point.

One of my main aims is to clean-up W=1s to the point where enabling
them would become normal practice, rather than the situation we're in
presently where enabling them just dominates the build-log, making
them more trouble than they're worth.

> If I notice that someone updates a driver which doc-errors, then I ask
> if that could be fixed by this person, too. It usually works. Not for
> drivers without attention, of course. But this is why I don't mind
> doc-errors to stay.

I'd rather they didn't say.

This would void the main aim of this effort.

> If this is considered problematic, then I'd suggest to remove the kernel
> doc headers like you did, but add a comment like:
> 
>  * FIXME: add missing fields and reenable kernel-doc
> 
> To make sure, it is obvious even by glimpsing through the code that
> there is work needed.
> 
> Can we agree on that?

It's the first time this has been requested, but it's your train-set
and I will do whatever you ask.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
