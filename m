Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFDC430559
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 00:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244696AbhJPWUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 18:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbhJPWUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 18:20:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C7BC0613DF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 15:18:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p16so57772362lfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hTZmsVraLnoyoiajwq2kp7kDJD/UBIvDGojNlZOjYA=;
        b=MlO9EhDO0R+F6a5IFnTIPbpmq5BWUpNHbM6qRx1Se8vfzBsGJpgsGiIfisAVmCOyo8
         lTiW0jaVH1nUXT0F0YXJntoy6WAyo07Tyh36UXjKY9JKKvpY+pfD0X7zs0DozQ9DQXP6
         karq1mJ2Le0t4/YNCerJCdx+i1q+nbSTF9hakC6Xo16kJejquw5aMr9bdtYSfioHkoCO
         70BEy+4R6MmLmofcuDIv2wWHzULVW6hq5ZmyX8PhgEgrkEFcn6x7XKEMCCoMXR5gUhsw
         G+861Cw4nKW4ccwd0KS42UXE5caVkz3VajZVIPE6ghQLY+1a5QKi4c9DVcbODx/pm7FQ
         jrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hTZmsVraLnoyoiajwq2kp7kDJD/UBIvDGojNlZOjYA=;
        b=F/XOUEAIgXZd5QGP2Gm5cdYScrKahl4ytahgzEVtZ4xP3M93Pp3YfeoMw6EHcWhZtm
         /ls5kRfB1M2xC9qiwjQXMOyzePpKL5iz83DxkEvc/IFKCUw47Y1iLeVlsrh8ytxdpSY7
         sRCoBpKthC2SzPyLyZn+oK0GOqIhw/afoG2ksDF7IRyPk/565XTubLEvoJU2FQFh4Edl
         sivP6P8Qk49NAWE9/hjfr2bhkWI5KXlSlSShfZoOUgJDX/rRTnuAUNpbvFlknC5U6nkM
         gq4ONlwbsGJMmyhxspp9GFIVpvnP0ksd6gQPdx5r4IRtO6zqVkSCWid4yZ9vZ6i3Zh4v
         QwMg==
X-Gm-Message-State: AOAM531yLa9d+eDc3ydzmhZhXA6CCmr65297jm/TnJszn/6j0EQI68fj
        pt3kjknaY6bmMVIovOrcPSwpn/18zH/yssaz+OuAww==
X-Google-Smtp-Source: ABdhPJy7PQL7FlWahwMf8zqvRh3tgaf9x3NU3N/Jf4Z/TBpgv3e+zIyq80gCL0b/Z+0DKPZ9HVLLg6VScA1ErGJ2s9s=
X-Received: by 2002:a19:c10a:: with SMTP id r10mr19208289lff.95.1634422703906;
 Sat, 16 Oct 2021 15:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <655523d7bf9658eb0b8e49a06c8b79a04052e5d5.1634286595.git.michal.simek@xilinx.com>
In-Reply-To: <655523d7bf9658eb0b8e49a06c8b79a04052e5d5.1634286595.git.michal.simek@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 17 Oct 2021 00:18:13 +0200
Message-ID: <CACRpkdY4pQXGB0e+HY1UYrbNpSb9tZzcnMh9zETCpSxxQ-HoKg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: zynq: Add power-domains
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:29 AM Michal Simek <michal.simek@xilinx.com> wrote:

> Describe optional power-domain property to fix dts_check warnings.
> The similar change was done by commit 8c0aa567146b ("dt-bindings: gpio:
> fsl-imx-gpio: Add power-domains").
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
