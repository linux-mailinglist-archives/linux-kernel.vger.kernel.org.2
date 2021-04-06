Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C61354F6A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbhDFJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhDFJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:07:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1C6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 02:06:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a6so7341318wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 02:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bHkJf1wV3bHTr0oAvFB6Eaq8Z3cFS9G7NgxWG90yTjU=;
        b=cDJZHb05TlH/4GQelllIxqMgNAG5MjUer9+I8+DYMTKKgU7bQYLVIe19nMAVplaBMe
         zw0Sza4awUJHqE3sEfPuAvqpIOJILDLZu1FEuSFcqpgCfS4N85ikBrFZyp64Ba3uPrUe
         WZDa7/giao7LZwDHV63PoT2o0Du1gPoTs0C6sNtIsEG3Q76qVfpNAnvMKrWEzqcMIcFR
         0cp48dqYVZjydPgjgxgh1YJE0czjOMv2apNHzMm15L/mVH6WZiHHGBU96mBtbQPz//9T
         /rUBy0o/x+Qsl+RZcbTMw50qnog/CYJFgHtvMqQsEd7GXAj5NxbUSA6wVltEs20iGt3D
         SpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bHkJf1wV3bHTr0oAvFB6Eaq8Z3cFS9G7NgxWG90yTjU=;
        b=p0OsSGjurY6fRqNzz2Pwcbf/19unq4CIveJrkwPFjTRIHIykahEHuApexLujkY0eaJ
         yGPPtpKPxuzJwSDoB8DuuAM80jOdU2orN1HmNiZIw8cWpq1oGLPgrR0E23N2w/JvRqmX
         HM23CtQC39hTxtP/BzUUGph3l/CvI4guMRUG+vyu4ZsZbU7rIDgdpQaUg3xu4yL+5a7z
         5yh3AMDcq/00L2ULAKuaP2e/rp5vcYKv9JLmQxt3nO8LtREaUl75dRdji+gKyU5L66YJ
         g0k1vDwF2iA0KyhXhJmUcH5HhkoCWlU+9nv3koBykybrYAR/stGcHf5wBgEcwHyqUSE1
         dD+w==
X-Gm-Message-State: AOAM533aHLHwHxqVzZbK6NZeavnuUUMiL8knNWyOUngVj8UOjMjAz/eu
        dDNwrL1LQcdu94rNnodFU6s=
X-Google-Smtp-Source: ABdhPJxSjsy5x3w43RYpce4XqhOc/74aveF/fICBZmjv095ODKkUdsAOmcn0PXWpTxRjoypUMrgLFA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr20320236wrp.104.1617700017248;
        Tue, 06 Apr 2021 02:06:57 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id p12sm30783705wrx.28.2021.04.06.02.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 02:06:56 -0700 (PDT)
Date:   Tue, 6 Apr 2021 11:06:55 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linus.walleij@linaro.org, ulli.kroll@googlemail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: gemini: sl3516: Mainlining of NS 2502
Message-ID: <YGwkr0qbYqR02Yyh@Red>
References: <YGtZeofmBv7hXK+a@Red>
 <YGt00DdrToMTskp8@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YGt00DdrToMTskp8@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Apr 05, 2021 at 10:36:32PM +0200, Andrew Lunn a écrit :
> On Mon, Apr 05, 2021 at 08:39:54PM +0200, Corentin Labbe wrote:
[ ... ]
> > libphy: Fixed MDIO Bus: probed
> > mdio-gpio ethernet-phy: failed to get alias id
> 
> That does not look too good. But it is just a warning.
> 
>         if (pdev->dev.of_node) {
>                 bus_id = of_alias_get_id(pdev->dev.of_node, "mdio-gpio");
>                 if (bus_id < 0) {
>                         dev_warn(&pdev->dev, "failed to get alias id\n");
>                         bus_id = 0;
>                 }
> 
> If you look at the example in the documentation, it has
> 
> aliases {
>         mdio-gpio0 = &mdio0;
> };
> 
> If you add that, i guess this will go away.
>   

Hello

Yes it go away with this

> > gemini-ethernet-port 6000c000.ethernet-port: probe 6000c000.ethernet-port ID 1
> > gemini-ethernet-port 6000c000.ethernet-port: using a random ethernet address
> > gemini-ethernet-port 6000c000.ethernet-port (unnamed net_device) (uninitialized): PHY init failed
> 
> And now it seems to of all gone horribly wrong :-(
> 
> This is the second Ethernet interface, the one you have commented as 
> 
> /* Not used in this platform */
> 
> I _think_ you just need to delete the entry, otherwise it tried to
> probe it. And then that probe fails, it looks like it also fails the
> working interface :-(

Deleting the entry did no change. It still try to probe it.
I will try to delete second interface in gemini.dtsi just in case...


> > # udhcpc -i eth0
> > udhcpc: started, v1.33.0
> > udhcpc: socket: Address family not supported by protocol
> 
> That suggests the kernel you have build does not have PF_PACKET.
> Enable CONFIG_PACKET_DIAG.

Yes adding it fixed this error message.

Thanks
