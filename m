Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5640937ED94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387733AbhELUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386794AbhELUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:22:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2476EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 13:14:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v12so24848144wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ess5L+xOXRmxYaXPi1OkUKTPgDo0tGEKtcX8Gli1a7M=;
        b=bMD1xxDCoYykjIBBe999brSCSiuN3hK3+40TGP10CnhnqZUH4avumUHhe0jPHhpYsK
         nzJWpPjs5Yc+lHVUKa1cV3kJHdHdK+3d+b9lFiQOzT3gdp/2GIdZQfCUj7F5gBx4h+Eb
         50NembGNIrUec+KQYTUi8CLaSiLmMpj1HHj2tHk6Bxu1LHrCj8Usgr6b23cvEP4jkgAH
         j31VSyiAChSkhpNxliI9cALLQgU0wc2cBLkSuIe+B8XkhjX5TMVcrTDlzIzQyPd/5pdM
         bTlrFFbdbaHev1D9WC8y8XSoUfJWjWjj4yUnkx1hEfieCDzHPfyunCQOJvBlt4ORGbVN
         fQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ess5L+xOXRmxYaXPi1OkUKTPgDo0tGEKtcX8Gli1a7M=;
        b=ESpBsJ5+dlfhynmEtbe9QvMsnug1oJZA/v5+8py37T5QzXuUl0zGaZ1aPGnXU4Wzg1
         hre+gK0LJqe0QE5tGhhO6NfWERlZ00SNizEXvUCg3LNVC3TpeXW4/FTjbyubqql6DcRs
         NMMPjuP/jK07E1rAECh1jFAYwllIFLsrUkHmLIrVJlYkHWG9O3q45Pmcj9Z2sdBwNM3j
         DvbuMyO8K/Kwxv0oPn3sZyKpIAtF5jBLgenZOHLEJAhMJSFbHmFMVUk154XcLK/57S59
         RwHeeIqesl07Qt7oyd6CD9/0sNB0pFeSi1zVu4LvgooD13yKJKbgtwoaqEbx1lfGiY78
         6DuQ==
X-Gm-Message-State: AOAM533t/JYYRkOq/5wlJq1YpSJdaIeHdcq4rNyZ3Vl2Xg9DUZmtfBMc
        rpJzXXjeFnwZNQByu3eeOwI=
X-Google-Smtp-Source: ABdhPJybbYUER9CG6kcFQ36dzqEBntNnGBm+HBlS1sPcUtT0FUIPh559g+wBe0RJQP55zzq6iErIHQ==
X-Received: by 2002:adf:e611:: with SMTP id p17mr48475507wrm.161.1620850497911;
        Wed, 12 May 2021 13:14:57 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id z18sm678676wrh.16.2021.05.12.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:14:56 -0700 (PDT)
Date:   Wed, 12 May 2021 22:14:54 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gemini: sl3516: Mainlining of NS 2502
Message-ID: <YJw3PrZqz2q5OYbI@Red>
References: <YGtZeofmBv7hXK+a@Red>
 <CACRpkdZ_barDrLvD2UBKo+GA-F+g72uMQx8CfRK2YLRodpeyUA@mail.gmail.com>
 <YGxOf8pKN8Ip/kCl@Red>
 <CACRpkdYRUXJY_tXamS0vc+RNPDxR2oxdRLbBUk0fmQLp+eYAOA@mail.gmail.com>
 <YJLxTgVflotKs5Oe@Red>
 <CACRpkdaGAiK57LE8vkEBjCGwb+HRWBzWS_C86xdNa8N51G+1PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaGAiK57LE8vkEBjCGwb+HRWBzWS_C86xdNa8N51G+1PA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, May 06, 2021 at 01:56:28AM +0200, Linus Walleij a écrit :
> Hi Corentin,
> 
> I will check the patches you posted too, sorry for being a bit busy
> with some merge window and stuff.
> 
> On Wed, May 5, 2021 at 9:26 PM Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> 
> > It seems that USB is still a bit buggy, device are detected only if plugged before boot.
> 
> Yeah :/ I don't know that driver very well, only that others use it too
> so there might be some people who can help. I haven't mainlined
> that patch because there is something that seems wrong about it
> but I'm not a USB guy.
> 
> > I hit a problem on the NS2502, sata drives does not work well:
> (...)
> > It seems a problem soon after driver probe (qc timeout and HPA error).
> > Any idea ?
> >
> > The SATA works well on my other board (SSI1328)
> > having one or two disk does not change the behavour.
> 
> Could be the SATA muxing, this thing in your device tree:
> 
> sata: sata@46000000 {
>     cortina,gemini-ata-muxmode = <0>;
>     cortina,gemini-enable-sata-bridge;
>     status = "okay";
> };
> 
> cortina,gemini-ata-muxmode should be 3 for two harddisks
> I think.
> 

I used 0, and only the second slot was working.
Using 3 fixed both slots.

Thanks
