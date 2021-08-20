Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597453F2D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbhHTNms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhHTNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:42:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E2C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 06:42:09 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f2so17446506ljn.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DhOH14/6lzie5JE/kLqdu0LS3u763/qjtgmVKcWngA=;
        b=zabsO4jEjrqC54MNbZPJHDq4ijAV1KPbEh6BP8i2kEs0sPVk075P9lSvJpRxoXuY5D
         mZ0vxdr/mAdAKNoFpqACJXcxddk/v/L6svqpliziyehv7hgF4APRnmcyeY2I1Dlx01vA
         +ZEX6oGgoGHrTEWC0wnCGzH/lJCtBPT3t0nJNKrleREeWl4j5XLoE/SXmQrXvg0fSq0H
         VB5LPOwP6K4k1bR1c2ksBBYauoE9+mh3xnhdKmjTVIVeGLJBYf4iTzJXcDarEUdA7Q7I
         nc+TZletAllWT/9raEvaeKiw81q+vifHItZHVSnC/zQ6hYaAbPA6wX03Us6rgVEtnJjk
         WfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DhOH14/6lzie5JE/kLqdu0LS3u763/qjtgmVKcWngA=;
        b=tkkyi1ttnYODNrtekNhT78Uu7Lh165+phf8FSkXML9M3ev7zkqF5SD8o3xhEd1TJ9f
         4lzAonU+/sBBtOc/SU+oQZ1fikvkdYbnTTMQ6vS30U1bnDeBdr1eZ3r1swTqkxyUNSbV
         Cue9rNLozlLvome3PCmTqt/2fJXTH0CmG4wFPjsA4QuG6Cc5CD9h8xm16p300nztV7/O
         hWIgx2ut9qdQlhlZD9N4pTfRailZuKkf/3NT2MltaRQOo8biJpfnJf9WMYFZ4k59jIbA
         H6pTWgv3HmdwizL6+iCIijenTIhBVqBpW5zJBgIZ/P6qqs5U/BK6yUdHcpei+ckiuJT1
         5SjA==
X-Gm-Message-State: AOAM531u+kWB2rmDBf3CThVHbrZCal7mXgyD/bMD1BeTOLxPMNJur2qd
        O1DV0FIhfoTrXx8EbndjN97NDwvtc91y5SaiBfU2PQ==
X-Google-Smtp-Source: ABdhPJxy7I2ZoIN04yH4cApSk/hCQ1gO2a2bE2macF6+9WF0KIXIBaWfG7BeNnu0GwGNz/NVXmNNvg5vCoUYKMWT4D8=
X-Received: by 2002:a2e:3807:: with SMTP id f7mr16160137lja.200.1629466928042;
 Fri, 20 Aug 2021 06:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210819235111.25357-1-digetx@gmail.com>
In-Reply-To: <20210819235111.25357-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Aug 2021 15:41:56 +0200
Message-ID: <CACRpkda=hcw5dN8TfV01egb4_fzSi3kNOCz1UguYcKyQKDW9mA@mail.gmail.com>
Subject: Re: [PATCH v1] power: supply: core: Fix parsing of battery chemistry/technology
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 1:51 AM Dmitry Osipenko <digetx@gmail.com> wrote:

> The power_supply_get_battery_info() fails if device-chemistry property
> is missing in a device-tree because error variable is propagated to the
> final return of the function, fix it.
>
> Fixes: 4eef766b7d4d ("power: supply: core: Parse battery chemistry/technology")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Oops,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
