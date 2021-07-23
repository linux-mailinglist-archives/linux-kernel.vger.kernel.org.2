Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B815A3D3CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhGWPHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhGWPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:07:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D632C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:47:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y34so2781236lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfaVccn2yUG8jAakkQEcB71eHXs5I/bh68jZ/8jluNg=;
        b=Nhx2MkSRS2kizVwD8IW5xLiT5Dp4EN7ZX62X9d1tK9hq5M0pJnS9vlG+xY1LLWtjln
         PkXX+EOXgFr3Fbyvvde5qMhycVBjEMl/Fd3mGgZ3pu7nN3sLH6eWlEQOu/+WjisMUOx0
         CjLmBptaAHg6Nbn5oiKXIDHp5hvG6lzvpGvknUmLVtYTtMQdYdCmDsKq6w+lvoMXctnC
         k+SBnKtTC6FFC6X49GsdGH/k3fYX4+VZZZEBlTVh+HoxeQp4SpTGdmzSHVzqPyTBjkyA
         OHS2TFIg9lZHbrs46w00dNwI3yRsZUczAHkcPQAFQyyuUql8APmdTf5mcd2/7RaCevFb
         L3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfaVccn2yUG8jAakkQEcB71eHXs5I/bh68jZ/8jluNg=;
        b=H/aG522B3s8QSMK49Gk17h+B4qa6YUQ+YOIQCBk1WG45NvXSy39CAL1VtQULEy0mDI
         9YDzQLaFaht8PQkD4OBjH1QMSWUEktskjoS87y6b9DNSLry6Zv4/1NamTiqSCBT163si
         BbfgCDJmVeBX14M3gyJ9aXaKAU1vJ8Hr1YSWx049efugeeu8HDEMIXZmwUx8rmUtApSV
         xcIr+Jf1yWL/+OpvG6/FGNsHGVTURSb8zb/CRfzcFugBesqGdaritFMhHcHXC3ukapVw
         pyWmt0Kf6xaKQbr2IJN/wD6pqiaflfoZ16iu8BBF8J/4t5V7osM/tF83oaz/SbPPDd4Q
         nKBQ==
X-Gm-Message-State: AOAM533q8SKZ7B5bpLjTv1hAJ46oAz8vxt9DzEkWSJyJl6Oo2D8acvKo
        sMGC9nK9I+KTSkrS1ibFgHlmG/VzbJxfY6F5SRykcA==
X-Google-Smtp-Source: ABdhPJy9aCBd3SRx8tnm/82WwlHUhxYgRe2uHT4Krpm7X5eJKpAR7GP1nhUGc2PzUTyfXut4k8tOdzt+Yw5Ih0qwF/c=
X-Received: by 2002:a05:6512:3f1f:: with SMTP id y31mr3557468lfa.29.1627055252479;
 Fri, 23 Jul 2021 08:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210624064913.41788-1-wangborong@cdjrlc.com>
In-Reply-To: <20210624064913.41788-1-wangborong@cdjrlc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 17:47:21 +0200
Message-ID: <CACRpkdZm7LQOLnFY29UDtbSfAKTmeDG17C2M7M23J3UWX_GM9A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm2835: Replace BUG with BUG_ON
To:     wangborong@cdjrlc.com
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Phil Elwell <phil@raspberrypi.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 8:50 AM Jason Wang <wangborong@cdjrlc.com> wrote:

> The if condition followed by BUG can be replaced to BUG_ON which is
> more compact and formal in linux source.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Patch applied.

Yours,
Linus Walleij
