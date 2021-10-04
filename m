Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC288421898
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhJDUot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhJDUos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:44:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5D1C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 13:42:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so76358321lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=me0z+ME7EPFb6ZEEoqdQdGy5VTWw4ckYvRJPBouWGig=;
        b=FY8tIni/Znx8Ji/q6Z7oei+cFOnMvUl/8NwIUDj9x6Qnxm3se6ToBRMhAi43rG2HT+
         UlorbUBm1R/P68pVUnnOpcvS6TMthydily2pUvupAQJd4T+zHQOXsVO7y/XV4p935qmN
         vVN7Vlqb0weZ0XqofDIYp4sENj4Hez4EMgeZnrdctdv9YF/SY7NbgQ0b2AtKIuKxhD/R
         R1SOL+qRSZjFHgTRcl6GZTAXTJQ2fsuhBSCZzDFNFq0ZOmZf0oDXjFyLOqVHwSRsRg3m
         7Nu5Y+bVJA/7UZTtWJvBE0Zy/KBQS+7CGHdsaJJgd4SM6gg9141nLa9orSoiw3uD6Fs6
         4liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=me0z+ME7EPFb6ZEEoqdQdGy5VTWw4ckYvRJPBouWGig=;
        b=C+xY98e2923zSSaGFpNXNncGLCjz+iZp6CnhqbdcT0ZyS9oAy/1w9a40iEopYtinIm
         CCLkz171vwYfq6wp6MRO0y6eyLVYT9sH5nKd21/BzbQ1mBdch0pJBJq+qPZXly8GYA5W
         5RaV1XD2By6k/zktXxuizpYKnG10k9Gp7WEboeZMMtWBnFKwFZlW3nTn4UatVfYWooYk
         BjVNKlcM4rTEgR2ij3uNaThEu3W/9+2kVHj3y0xT/40W1vKt2KCq2aPajWr93dljyhl+
         lLZIErq5ae2rCSs8Zp192fOimXEFsh85r1kiFn7rnl+UOZLwOYguSWgynGIcD2cQliuf
         suww==
X-Gm-Message-State: AOAM533wpHjD+kSWvOhWpp0IK1YgZSx30Q9MZQxV3sjHtEqGGCdVtlba
        7hw7T8nFqml2ODuwtUBTdec772pp7wZRHX4Kpg+Ojw==
X-Google-Smtp-Source: ABdhPJwoN+NxJ/fGV7inPNKtUbAVhVuzzxdipfKm/E4oc24DxLBb4XL4OQmZ5Rmgzij431nwk23QZOChQjMyVuUGSCM=
X-Received: by 2002:a05:6512:10cc:: with SMTP id k12mr17303158lfg.72.1633380176925;
 Mon, 04 Oct 2021 13:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210929163847.2807812-1-maz@kernel.org> <20211004083845.GA22336@lpieralisi>
 <CAL_Jsq+4FF9QYy87aYhJ-AS78qyHp0NkLrL492+WmdyWj-NKaw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+4FF9QYy87aYhJ-AS78qyHp0NkLrL492+WmdyWj-NKaw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Oct 2021 22:42:45 +0200
Message-ID: <CACRpkdaL=YEfqSmAogLcP0Gn2gUqSaEXZQrJD1GR5QU+DyuyDQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] PCI: Add support for Apple M1
To:     Rob Herring <robh+dt@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        opensuse-ppc@opensuse.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 9:52 PM Rob Herring <robh+dt@kernel.org> wrote:

> FYI, I pushed patches 1-3 to kernelCI and didn't see any regressions.
> I am a bit worried about changes to the DT interrupt parsing and
> ancient platforms (such as PowerMacs). Most likely there wouldn't be
> any report until -rc1 or months later on those old systems.

Lets page the PPC lists to see if someone can test on some powermac.

Linus Walleij
