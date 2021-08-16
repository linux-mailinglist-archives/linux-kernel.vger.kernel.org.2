Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1774A3EE031
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 01:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhHPXFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 19:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhHPXFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 19:05:32 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:05:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c12so16736123ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lj2dLqJ9pyYOjsECo/lSTtBJ835kttkCZJ43TYZ23RQ=;
        b=QZ0ArbXT9/B+Kg7FSkdPaBvXoC1IXNemdZn9zn5hHGl8DBDLJiJeKzGqjnMHcq31kU
         amRu+f2bG50wNYadysjF9juYcloVrnTx23n7jEpNqX79hDf1hrFb2pzMZfVmD7Ee/iJ8
         o9S5EhBOL0qHFgU+EOi/dw81a7+WhfZ2ZIJP1gdSTcP3PdbHPqNpHFJmH1VP03xNRJg4
         bdo3sctrvoPWc8pCiu2dqFPwEDJmRCPbjVXIrqDO+zz1Ke3/hx3Z31L1vWVR8C13gPNP
         JfIpw8k3EPNTTBQHLBw8xSFARDTNfzlnZx+vsrzXv2k2ZbZFN/Z7RIUvcDlrBC1mhz9/
         hDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj2dLqJ9pyYOjsECo/lSTtBJ835kttkCZJ43TYZ23RQ=;
        b=dhhJfj86N2ZBa6hcaWo0fQ+DPAuQqEWM1HILn+kRFU3Cdlyd5p1DIb0p4eFI84hI2V
         lMBSeLi76OcH1EO0cy156SE5y9GsGDcZ1dqLPcu1lAOmok0tIrHBZls3GO1pmnxmH1yo
         8ScuKIXWJnXixUHtdoCCbiU/hJAkgM5lISNa4GPOUYGDCl5r/DOVr9xauH5QbAb8/s9H
         e0pplqvEYHHZjewdU9cZVsLDqp1vCHhctgLlwLiwcfNZB4DwKyckpYluMnycFnvC9+jS
         b8x2Pbxwrg53vF1R3clhLXJVqWrZ4AEwL2JXli36Nahd2r/QE3YY3V3WavSff2uxKIVz
         cOvQ==
X-Gm-Message-State: AOAM532Hj8MPkk+wmuX2NqoARBqnVu0r+m0bmryayvO0LOzHHGErvGfG
        a7TmzyXASvBoD+9rppUwUPmSBiideY9gxy+VF5p4gLI5JOl5/Q==
X-Google-Smtp-Source: ABdhPJxpngVDILQkYsQuzskdLl1PgOfY9XcdWYa9WAFWHXbDYqBy4QG/NrpOSQl08X4uPllHJTi0bYwlx4bzggm47vk=
X-Received: by 2002:a2e:88ce:: with SMTP id a14mr465713ljk.467.1629155098850;
 Mon, 16 Aug 2021 16:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210816011948.1118959-1-jay.xu@rock-chips.com>
In-Reply-To: <20210816011948.1118959-1-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Aug 2021 01:04:47 +0200
Message-ID: <CACRpkdaVJn9UosC5VwkQ5fTdrymtHpajc1h8HMomVS-R6vggbw@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] gpio-rockchip driver
To:     Jianqun Xu <jay.xu@rock-chips.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 3:19 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> Separate gpio driver from pinctrl driver, and support gpio v2 controller.

I merged this into an immutable branch here:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-rockchip

Then I merged that into my devel branch for v5.15.

Bartosz: pull this into the GPIO tree if you need it, e.g. if you want
to fix stuff on top.

Yours,
Linus Walleij
