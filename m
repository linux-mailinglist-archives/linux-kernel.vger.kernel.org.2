Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B583F79C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbhHYQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhHYQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:04:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F269C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:03:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n11so8543363edv.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EVMcSyzLWCJbPhaXzVam6/a6dBjGlpQ372IsbwtfVxk=;
        b=D06ZT5x477gq/rdgUndPpPpqolkunQ0Lm+fcM+BVH9xsClA537zE4gTkymgV9SOneE
         Z4wFUwKjmpg5WO4xHmlKEx8ZKBhIwhrI/xCO76zsFp6S+yskcz6PkbIpJbWCfJUVAdjf
         ydcPHRjPKF5RLELwCO25YvR57zMie8CdsZB0LNG1G4dztOSz3ZCalccB89E92CSLulGv
         2Lu6SvQCsk3+Q8nKSLtzb0AKw6IuLcp/Ce6ZP9Cq28l3MaS1f5ronpiO6DWvdxqImOnD
         g9q3mhRfVn2DTDFh5tCdORUzZR98nMkke7pzzxMpdDNDzb442XS8wLkn/6MQIuVf7VYy
         3Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVMcSyzLWCJbPhaXzVam6/a6dBjGlpQ372IsbwtfVxk=;
        b=LBTXnd27g7Ck3855yyr4gbtUC1Jyx+Phs8TcutQ8UIWHNH15Gg3hEw/xVZgXLtWXLb
         dURNOuHP5dLe8CA911AvuRUkK0GaX6CgULjNwRFhvQ8QiPRqc9zNe0dYMgnlOrxf4Jrr
         64ElP1DsYwyOQbwVTRFo3p2/9xGy6SNIFC1zU6900uUSUnJWS2XLKHJiNlP3oq8OFJr8
         nY45t2cTCj/rKHU3YmVIWd9a/vXbKBC0NB/12d8qVlReF3S0iIAGz4yiUwpm5Xn83y4c
         a3HI799ndY9LCcAVTtH/KcB27I6/UPlahJdKPL4znNGKlSllTrexcierl+jkvl776dNA
         pmuQ==
X-Gm-Message-State: AOAM532xXBUZ+jIUunjvw0YVjpuWMcJk7uVh6+I0PZ6ojofniqt7bQHD
        MS6mdqy/DdsDtz/pNmeSEIg=
X-Google-Smtp-Source: ABdhPJxjBiP2v0hTKy8/DUiXgQJbVJkToudVT4d+E34jU0Odh/FXoYM06T4tga3q953mxyBJ3nsS1A==
X-Received: by 2002:a05:6402:2751:: with SMTP id z17mr23305428edd.290.1629907415912;
        Wed, 25 Aug 2021 09:03:35 -0700 (PDT)
Received: from skbuf ([82.78.148.104])
        by smtp.gmail.com with ESMTPSA id f26sm254814edu.4.2021.08.25.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:03:35 -0700 (PDT)
Date:   Wed, 25 Aug 2021 19:03:34 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: "BUG: Invalid wait context" in ls_extirq_set_type
Message-ID: <20210825160334.zffm2ctcklo66qkx@skbuf>
References: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
 <20210825155427.GK5186@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825155427.GK5186@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 04:54:27PM +0100, Mark Brown wrote:
> > I did google for fixes for this kind of issues that were sent in the
> > past, but in my limited search I did not find any other driver which
> > uses regmap while under a raw spinlock.
> 
> No problem with adding raw spinlocks to regmap, I think it's just nobody
> needed them before.  I've not looked at the problem in sufficient detail
> to figure out if that's actually the best solution here but from an initial
> pass through it looks reasonableit looks reasonable

The question becomes how will syscon be told that one of its consumers
needs the regmap to use raw spinlock locking? The syscon regmap is
initialized before any of its consumers probe, AFAIU.
