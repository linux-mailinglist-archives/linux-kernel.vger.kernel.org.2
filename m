Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9D438BFF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhJXVGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhJXVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:06:34 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E54C061767
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:04:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j9so4832206lfu.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXZiinBB1P7wOrPBY5EXOLhRiRUn4EMUQJBC+p4xV6E=;
        b=wqk0FsTc33l1K46sT2Xr6J8RUxVJh/uxskfmCXujnPnsqk00yE0NSXmAbm/sI7ezoQ
         Sv9PPACt1sGIa2itP3H0vpq0T/XUB8iU9lbCfkvX672BUxotkQmISbTr5EEOE+eTBLXZ
         BiZvlrGw0vfunNxOZGTvhRhFjDn6kYhClJd6VX+ZyGvj0gwO6AFgZ/2FeSje7WXeI35r
         6b6blrGBXF7oSBFZLFOYFAXZFcEQhUx2kcLW/uvB6v5CEFrnUr/ZknJfuaI9mBuWuKQ2
         p5H6rH45jT9U+V9hKA9jjV5V9Pkh/ufWHg4B+PXlCSIpsh3//IYZR+BKE2+QBZDXG1G4
         k/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXZiinBB1P7wOrPBY5EXOLhRiRUn4EMUQJBC+p4xV6E=;
        b=N/0pl9ngBZeMGw6g0mj/kJwzoGGHnoo0s+XqaIS7HdUSKbwBjBNdLnFzs4XO03XqXO
         pSOiR5aj51e4ptFtTMhtiorRKCmmrqcuue18fQ5gemMEMMPVZz2wTMt1SWtVEVf0MSgH
         nMpKP6xI3x476NrGY0BCt0ZtXyVd+5bNlr1OE5mSqE19BpKCm3y3NaI1f9AdZ4Ym1fso
         8Npy8UW5RlVOrDV2tWDnUVdkyyV1bFziM8gnOl6U4cCa2etP9tu7xm4N0YquTyquYQuB
         /QWE466UlWHPF0rKxgeMHGpzS9Q3+q4OZMn0foccMzZfvTXlDHl6xGDODblPSybPiAqt
         ks5Q==
X-Gm-Message-State: AOAM533Ld76BYM2YsNDj7hMfWw5k7cWUK3+iej8FpQa5k5JCttsyHP4Z
        XQFlFuE58CM247ebc7Jf9l7snk0+lqlYxoUZOYWM3w==
X-Google-Smtp-Source: ABdhPJxNr92QTY2HNT8gRchRvSIpTrojxUxrxZ0hp9tos7pfpHyh5Hyi1phko/4SIzDFMiFX1QLAQUIl+4FTuACoszg=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr13034115lfd.584.1635109450097;
 Sun, 24 Oct 2021 14:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211018085754.1066056-1-horatiu.vultur@microchip.com>
In-Reply-To: <20211018085754.1066056-1-horatiu.vultur@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Oct 2021 23:03:59 +0200
Message-ID: <CACRpkdbyY9LPf5una95YE4OW4do9aLp_Vr-ge23RTSu6-7iKjw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] pinctrl: pinctrl-microchip-sgpio: Extend to call
 reset driver
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:56 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

> v5->v6:
>  - fix warnings reported by 'make dtbs_check'
>  - add back the name of the reset line

Patch set v6 applied, thanks for working this out!

Yours,
Linus Walleij
