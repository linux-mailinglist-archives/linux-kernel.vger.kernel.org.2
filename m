Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8039B3F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhFDHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:34:58 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46014 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhFDHe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:34:57 -0400
Received: by mail-lj1-f171.google.com with SMTP id m3so10329577lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxKLe4sZ1K8JPJ2QdvPjxW9bu30Q1qHWxTs6jtOn7w4=;
        b=lnlCxzbNDn3bNsybUku+dXbbNMewlzXuXZ6ZqlsFOgdvG5M/4ZkoqrtAgYeh8zo5YR
         tADhKkUCVTwLEaXmvNbILhEJNE1x8wd/CO6NAc5E7jJib2mjzJvXHpMZslvNQ/6wTSvO
         8C1GjaQRS4l/ExdTWoQPGbN5dVyzFzz695NeT5qKbCBw45RUVVjj6/8OVGM6QOG5Z+l5
         fPFEBSXnoZ0jmVH+Y9RMIsWkzaKAwejCCdJzZosgYrj8m6tAC3v7n0qLFqVbaDffmIxP
         QKL1+GVcPTuLn6kBleXG1m1Y2EsyBh0f5cmxK1vypcRrL/fbJIC6cp9gTNNf9Zob3+Bl
         sPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxKLe4sZ1K8JPJ2QdvPjxW9bu30Q1qHWxTs6jtOn7w4=;
        b=MUffQ4eRp+wG2rhr7PQJcrS2FkQHtrHwo+byoSNKWd8LDkQtJN8v0EBDg4WA8QdrA2
         raumqn7t4xmqF6Wc5zEqx87l0QaHAdVwflkAc4PRM0g8Puv8w9/yI97T2ymg9bcOrbzu
         qG5p5oIIg5U+FGf9458YmZJr0UAemTVQuA8HJDT7FPVhzez/I9NWW4EkcJDjgxzAZrFY
         Zgny8bEK/pKPt0Xpxm66U4wM+X69VsVvch5o8q2SUB+qdO2ufXytpv5C2p3R1qT7AKOL
         hc9qcttTpFdfTs4mNTEIDsBKGsNAsSpmnd7ZuwU5yln+9tl0gF4FLlF5XnAnRqaGDJy4
         ymzg==
X-Gm-Message-State: AOAM532N3q4Zbb4/OQX0iDIY6jnFV/mmokLZlNn8b2ZF1Rwwa06DWC8L
        7VxIKx/1ZG55nRGaubHMEhof8NAg50MHAygHExiOYw==
X-Google-Smtp-Source: ABdhPJyPFI87XIWla6LvyUr8sk3VNsW6SKxfYSfodk2fzO/PZom/0csd9fJAcoNs4ZmcXBI2NG0twc3vJwXv4t6xSMo=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr2494985ljt.200.1622791917583;
 Fri, 04 Jun 2021 00:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210603043726.3793876-1-dmitry.torokhov@gmail.com> <20210603043726.3793876-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20210603043726.3793876-3-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 09:31:46 +0200
Message-ID: <CACRpkdYGrhrronv0nXwcYiik7=r_6D-rf9dPZLx=FpghcBRn2g@mail.gmail.com>
Subject: Re: [PATCH 3/7] Input: cy8ctmg110_ts - do not hardcode as wakeup source
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 6:37 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Let platform specify whether the controller should be a wakeup source
> by registering as I2C_CLIENT_WAKE.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
