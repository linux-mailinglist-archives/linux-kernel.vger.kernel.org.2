Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799943206D5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBTTOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 14:14:12 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38318 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhBTTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:14:08 -0500
Received: by mail-wm1-f46.google.com with SMTP id m25so1268746wmi.3;
        Sat, 20 Feb 2021 11:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VF3s9s8dD+8FgMnQzEnFyHG1q1prhIJgjdP8jQ0Kb/E=;
        b=UfHKLMARmIa6ApDFpt8RQj3yF7my2W8MSWSXMWNAu3+ibB4l/IQsqrrmNuBJ6kM/7c
         otg8+GxDQp/BQ2qqkU3Kt5ix6Aq2luJ6MXhxMHgiHg5mch0cw/xWIEbk5qmxeq8rTeDj
         IVSWxc4qWTMQ/3bVjjK+LlLLzFywiAy4Ck98klJD2QSWswAT00jz1PRekCXVPZPddRW+
         7cZYSXxGzgsDQEcoQXI+ymJ86dif1BSBzoAFvBkneWEINNS1x/VBwWAMRyh+ZdsEt4G6
         ZTOygK3JQn7Qc3+tqJ2f5nCKkbanYakofcNWJoLwvS14fvIwwfyPQtY8mYZH+Xr/w++d
         Es0w==
X-Gm-Message-State: AOAM532A5r6rAde+UV6l1uJIAMNLHwBw3IwrvymVBjuOn/DmQwJ/xYxt
        Xd+Zhc1FgRcnmFaLj7bRM1w=
X-Google-Smtp-Source: ABdhPJw9s3IjvIxVsPN1AfNRpwIaxtgvmFES1CWbXCIdbkt8xArpUI6D3W0a2jIIJOy8C9bd/VV77g==
X-Received: by 2002:a1c:d7:: with SMTP id 206mr13505454wma.68.1613848406537;
        Sat, 20 Feb 2021 11:13:26 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x18sm10044772wrr.10.2021.02.20.11.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:13:25 -0800 (PST)
Date:   Sat, 20 Feb 2021 20:13:23 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/25] tty: serial: samsung_tty: Use
 devm_ioremap_resource
Message-ID: <20210220191323.ugmzrtkvcxyqqolj@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-21-marcan@marcan.st>
 <20210215185135.onivzktfscv5myh2@kozik-lap>
 <20274436-7275-9734-5a07-d6da46b45c5f@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20274436-7275-9734-5a07-d6da46b45c5f@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 11:01:21PM +0900, Hector Martin wrote:
> On 16/02/2021 03.51, Krzysztof Kozlowski wrote:
> > > Also fix a bug checking the return value, which should use IS_ERR().
> > 
> > No, no, no. We never, never combine fixing bugs with some rework.
> > However devm_ioremap() returns NULL so where is the error?
> 
> Sorry, this was a commit message mistake. The code is correct and so is the
> patch: just the NULL check is correct for the previous variant and IS_ERR is
> correct for devm_ioremap_resource. I confused myself while writing the
> commit message after the fact.
> 
> > Did you test your patches on existing platforms? If not, please mark all
> > of them as RFT on next submission, so Greg does not pick them too fast.
> 
> I unfortunately don't have any Exynos devices where I could test the code (I
> have a couple but no serial connections, and I have no idea if mailine would
> run on them). I'll mark v3 as RFT.

If you have one of Odroid boards with Exynos, then you can nicely test
Exynos. Others - depends, on board.
Anyway I can test them for you. I just want to be sure that Greg waits
for this testing.

Best regards,
Krzysztof

