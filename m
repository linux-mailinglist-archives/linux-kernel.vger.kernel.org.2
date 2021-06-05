Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC56E39C736
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFEJ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 05:59:31 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:42585 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFEJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 05:59:31 -0400
Received: by mail-ed1-f53.google.com with SMTP id i13so13991782edb.9;
        Sat, 05 Jun 2021 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yR3o22V6B0YXuWlVxnHv20sYJqOuoilM3F9ooehFaN8=;
        b=EYM0+9+EVxjeZI77wQ3QZeqEL3vpuxoA7Kmxpdduc8F15lOc2egU5DruViDoQhX9Q0
         Msx8YfbAJbyN8Wr+XFF17O7NI1VGHVmJNaEDTlqkNimbvNUeN3arSXR/ScDGd0Fdcj6E
         LydkZyD4e57n5PVw47rQiEYl6rvmkVZg6q6lZx4r9gSZG3HZA1A/IqQk3xhwbrAdlLHf
         28UdImJw9FU8OLXvROGH9X6PEY/n/W8Fu2kPSb/zzJ1phR0CRKSSIKhTn+uMXsvAy9Jm
         wfDztuXz5fFTCFVnr4VinUBiV3kXw4gI7bm3aUnVquCeznzBVR9JDqOvDVfapV0DjyrW
         138A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yR3o22V6B0YXuWlVxnHv20sYJqOuoilM3F9ooehFaN8=;
        b=ZzkUVWIiijFJg0QWSzft4Qgpm3UAnV0OMWE8/Z00edzYe/q7aPl46Wh4xgHJp2vXtG
         lul8UqzcZFvM714GRR8tQDyAfD6HukfSm94i8auHUEL6SqOvnWQZ+ehEwY154DeET7+2
         Y4vLL1mK1bPz7xQ5GBTRl2Gul7KB3BYB8FG9nqUVJT8tjDVnVwYRaxC3gFO8eM5I/CEl
         28uDxg6F0dpQgHgaKimMPcaRGfD0H76K+umkKypFnBSvfKN8dfwlkuWz1J3Vg2LnYup4
         XQzVhNX1EMa2WREYNAD61nqkD3V2qE//UiSmgXXeY8cRGI39wjgL9t3ayBARvyZuB9Uw
         7EDA==
X-Gm-Message-State: AOAM530UN6VNOGZ9m0/rSc/IaGg1Ie3Po1z49nL0Y7r2SLmcBTmIdJWN
        n4kqKQ6EsDJm7vg4cgDZjZmu2EJI7awA5YDpOLU=
X-Google-Smtp-Source: ABdhPJzEOzc3gAXmpYvwyNJL0PnwFKClIXK7fupCEPfpbH3SEgvLCg0oYWO6q/WonnS3sKiStvCiL7rWuQRaJeiAsfM=
X-Received: by 2002:aa7:dd14:: with SMTP id i20mr9658485edv.110.1622886988140;
 Sat, 05 Jun 2021 02:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210605062313.418343-1-xieqinick@gmail.com> <20210605062313.418343-5-xieqinick@gmail.com>
In-Reply-To: <20210605062313.418343-5-xieqinick@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Jun 2021 11:56:17 +0200
Message-ID: <CAFBinCC=3=tQJo9jSLo-edjgZ5tuNEkjXA=xpiZXi6eXi4YfZA@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: meson: vim3: add i2c aliases
To:     xieqinick@gmail.com
Cc:     robh+dt@kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, jbrunet@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        nick@khadas.com, artem@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

thank you for this patch!

On Sat, Jun 5, 2021 at 8:24 AM <xieqinick@gmail.com> wrote:
>
> From: Nick Xie <nick@khadas.com>
>
> Add i2c aliases for Khadas VIM3/3L.
commit ab547c4fb39fe1 ("arm64: dts: amlogic: Assign a fixed index to
mmc devices") added the aliases for the MMC controllers to the
soc.dtsi
I would like to hear your opinion as well as the opinions from other
Amlogic reviewers whether the same makes sense for the I2C controllers
as well


Best regards,
Martin
