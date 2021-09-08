Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38272403B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351947AbhIHObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349350AbhIHObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:31:16 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F43C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:30:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m28so5307797lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cd4KZy4x2pTlEHlDKbDrBtC/WiwsU7NBfk76zAgmO4I=;
        b=ca3M97tlnfgje41roeTfZsVBgciesfVX0uP5y414o4x4iaDSFqnkLcxgnzIvhHOAS+
         XMkRC9iiEX4jEx4dLN2oInyTVNHx+3J8lvTV54anV9jiYjREIpX5XVxAcrdE30fpVDf2
         jt2fTln0vgXY2qwYTnvhfnDbs9d1xXfH57hU9RDyhlMLqN7qO+plcIA5HBXupFjjnMon
         3Kw8aKZCWYzEn0AA30h63cywZnU5Ch8I1cQ/xlMSrvFourIaGFgwjk6vnUnuCsRVPL4o
         ejRyLrZQkUlYN4YDJoVVp9PJADk67K/b0TDDj3tBEsMFZmoKFBbzZ4eRf7ksJCURyqcn
         KQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cd4KZy4x2pTlEHlDKbDrBtC/WiwsU7NBfk76zAgmO4I=;
        b=vTqRGqW8WdHfnrc6r6JXPUZR88tpgyQVyE+mR9uedk0Zfs5IGWbVfx6vape2tRneji
         YPuIy9T1PRIuXcbkvpk1Uc+TdXd+mEGaJm8LL+2qgRzA4Atrbkp4HN8mbNmtJe8qacHD
         SEx0TYhoE8634eeR3efr9Wz2yjkyqfvl8fNwH4Z5AG/XXdWYzPIMHO1f/49CFjHUfZvx
         5MnPuUWrhpGz7oukVl9TSCKPpWTyS7IT6ZOjZWq5cI62bC+rVYcsHnL5SbPZ2yMiZmcw
         jVfZkr5uoj4JjVYT74n3g0yEwMlQGi6+Q7Yj6Mms4/vFTfFISDGquwkQF9JRcolF8djB
         +mhw==
X-Gm-Message-State: AOAM531Qud/NlTRO1EkugnRogxdryfawusjkYlH5pDmRgw1emWP3fOgp
        LeVy74jKRAHkLOgJGG/UHu7ETRNvvfG9yY5kXM9JSQ==
X-Google-Smtp-Source: ABdhPJx6YkEihkTPOHz7i0JiTJA+kgRrv4PLkRkl3EtqG3Iv3XHz1A4V31/GLbsPFfkomia+ZhmRQ562NZ483N9JshE=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr2816010lfu.291.1631111407072;
 Wed, 08 Sep 2021 07:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210908141606.136792-1-bert@biot.com>
In-Reply-To: <20210908141606.136792-1-bert@biot.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Sep 2021 16:29:56 +0200
Message-ID: <CACRpkdYo9KYVZKBvEuSbVa_pN__SQRAF0VTRcMFOVs=3CaQQhw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add support for Airoha EN7523 SoC
To:     Bert Vermeulen <bert@biot.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 4:16 PM Bert Vermeulen <bert@biot.com> wrote:

> This patchset adds support for the Airoha EN7523 SoC, intended primarily
> for xPON/xDSL routers.
>
> v3:
> - s/armv7/armv8 in commit message
> - Fixed dt-bindings vendor ordering
> - Removed CONFIG_COMMON_CLK_EN7523 reference for now

This v3 patch set looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
