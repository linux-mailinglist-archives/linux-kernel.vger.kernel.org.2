Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D666C3E3775
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 00:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhHGWuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 18:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhHGWuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 18:50:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E508BC061760
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 15:49:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h9so17721411ljq.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o3qubOv31EtfKaNfHjdn82lhl+sbwGCg3V0u0FRk8QU=;
        b=Y5j9Tu28amnZUpN7zY3veiU+uMmDpe7mXmuIxCaWmknHVC9q/wX1UIEStgoXdiliru
         sCB9DqfQoYAh5RKWrnXgvRcICfc/f0fcV42tLxdpKas7JSPMdVhHDM6yrLRFNFDkNuuD
         VohfMEWE745XxofOXaDtB+auVIkcBbPrH7KR5pbVcbyorTCxcXj4UEBM/gHIIAPDoveI
         LVzyqtK+Ac7BuSOw0eBATVVbSSg8p24ja7WNFNtBYAsaSzBvltwlFx4dXEHczCxozscK
         hbyiYi5E5KXBh0dYZ5Sr1ItPhOyil7Vs8jSU/nUaD2Bzav7+bc2FnzrYGG32Pb69w9jT
         6TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o3qubOv31EtfKaNfHjdn82lhl+sbwGCg3V0u0FRk8QU=;
        b=i2+8saDRgUxlsJPBgl15uYwk9r90giDbZVnxDcqi2G/7cBPgV7DBQKreBzcCQYdi94
         OWmO0exOvlCIzz/FtbucmxvfHXWW2Ht0J8nCtwFE5jFil2mbO+3ywEvqVFi28e03wyIp
         UO7wcNewfuETn58eFenXMBfv2nSPrnHRyXvHYs8LMEg+A7rxJBJgO0gYIhTy6o69N+J9
         IuQZluJm6SAsiJprRzKkYNd0lO9KBtpcDDyNy+SL6fZAYqXE42xBDwb0UyvSQhL4GS9T
         e5amkhYRLF5/S/8zvEdWwOSIPVgzHhanHuprbXh8KB/nS0ljUXXaoSgCKO2dmTK4TXKS
         mDow==
X-Gm-Message-State: AOAM531qtqMHqAlDX47fzRcjvlNYvj0koWhbzQsN5fXAPVYzIJuIcenu
        Z3RcKb38NydrXvXFUCM7nm4oVkQsVLSEFStTzt7puA==
X-Google-Smtp-Source: ABdhPJy37zMjQasEWY5yuOKqQeAD/LtnA/iupXOAzZdWOxAY1eLppLhmy87rbgJCog2CdlEf1M473Rw22pP5qV2Xf4A=
X-Received: by 2002:a2e:b819:: with SMTP id u25mr10702122ljo.438.1628376595192;
 Sat, 07 Aug 2021 15:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210806150000.GA15586@kili>
In-Reply-To: <20210806150000.GA15586@kili>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Aug 2021 00:49:44 +0200
Message-ID: <CACRpkdZgSUyL99166Hoz_8_Gw0ApQOhFbUwBUecMb8XJVn4X_Q@mail.gmail.com>
Subject: Re: [PATCH] bus: ixp4xx: return on error in ixp4xx_exp_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 5:00 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This code was intended to return an error code if regmap_read() fails
> but the return statement was missing.
>
> Fixes: 1c953bda90ca ("bus: ixp4xx: Add a driver for IXP4xx expansion bus")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ooops that's a bug.

Patch applied, I will relay this to the ARM SoC tree.

Yours,
Linus Walleij
