Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A119D394074
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhE1J6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbhE1J62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:58:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3EC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:56:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso4210263wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rLcRko7vTBkfD6ClMWD+JGFtnLvq9byhRpGvRT6Rq+w=;
        b=kruQNAjVubk9/aUgFi76/NLAojKcKZ/shIV3CLQKM6y+J61pSioemXQLOpovxkZi4L
         9eawNQPdEag6gfq/gzOLcrYHqGon4j9NWh9cGSL7HcW93pcMPoFyMnaTUte3/RJzUppv
         dN1LmcGscVktw2Ym2dz9IYy5TwVJPZkqEiwwWe/9TaeWF93SzeKvmYVMJAAVXTEMe8Um
         DuV65cAlnxlhuR+IayubUqsFnzcTLeAmtO26F5svOGRBGen2zsyj7IGIzH2wiH+wEzqw
         Hm6idHQsC+BVpfWKRrREBKUQC1gJoVwz/9NeOGvNEjFKFcO32Qv2gyPWNw5ahwkoyvqf
         vlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rLcRko7vTBkfD6ClMWD+JGFtnLvq9byhRpGvRT6Rq+w=;
        b=jOQIVeVO9PpdDJiQcMOm86wNRfO27FUl3Lo950X5eLrc/wR7G1oIc32BR6AkjE7ruW
         PjQgDWwWF4lRpdNpOCQ/U73uZZh257Hra82YETtu5yjgIs9hNjtkC/5BbaRSfwSn36N1
         DGUOLTD5vxgBgS7yquhGe9HNNs8vmuqkdXKzAoc2AkRHkTCVxTvYRbCwEQZYZEh3pGhN
         laO/3EwAr1hkRMCZR8pD1NltEk7xAw8A3vPdEaOoc+gOctTDg3jgGTwrxIcDCSwqLAh+
         hNpyFP4M4mdIue+B3X2XBXl6HaVUrzJSOui5n/W5kGFA11Es17y3uVoQV5mchJhJMku9
         fyEQ==
X-Gm-Message-State: AOAM5332MP6UdcZNtYvzfhexmqMAWu1QMSq71dN/9UchjuKS27KnhTJp
        Dqc1anCYBZKWhupnV83ugiC+TA==
X-Google-Smtp-Source: ABdhPJwSHeI8Oo/6vEqcqbmcNvvZPcF4bh+WP8RS5TIU8HG3/zLYhvuIpY9IHV3+jm0/TblgHavqwQ==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr7498380wmq.38.1622195809277;
        Fri, 28 May 2021 02:56:49 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id x11sm6368061wru.87.2021.05.28.02.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:56:48 -0700 (PDT)
Date:   Fri, 28 May 2021 10:56:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 14/15] leds: leds-lm3692x: Demote non-complete kernel-doc
Message-ID: <20210528095647.GQ543307@dell>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
 <20210528090629.1800173-15-lee.jones@linaro.org>
 <20210528093921.GA2209@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528093921.GA2209@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021, Pavel Machek wrote:

> Hi!
> 
> > Needs updating by the author to re-promote.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'boost_ctrl' not described in 'lm3692x_led'
> >  drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'brightness_ctrl' not described in 'lm3692x_led'
> >  drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'enabled' not described in 'lm3692x_led'
> >
> 
> I'm not taking this one.

You didn't say why.

> I wanted to take the rest, but "leds:
> tlc591xx: fix return value check in tlc591xx_probe()" did not apply.

I will rebase on today's -next and resubmit.

> I took the rest.

Thank you.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
