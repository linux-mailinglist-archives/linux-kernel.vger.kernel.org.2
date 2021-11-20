Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1113D4580FB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 00:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhKTXnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 18:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhKTXnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 18:43:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7156EC061574;
        Sat, 20 Nov 2021 15:40:09 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so59220372edb.8;
        Sat, 20 Nov 2021 15:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65MbiCirE9d1cqOS3f7OshdK8GTlWYGnLliUJ1JW4TI=;
        b=PeubQnk3Yfliv//Bdzq5DZVf8lnujLcLRhwLW4YrU04aspNKB8vxK0JhVry3TVWcLh
         LTJrgAyP9buv4LG+ijX8Oc8qVHhEh+1ogkviZodLZhZbOVVf7Et+1p2CrvuKEaniEVyJ
         SNt28yBZ0lCbHgWdd5/eFNPyH3LrjGxGPf76Dw+whk9IUb5Fz8zAgLzwgU0uev0eiePi
         G1CIR98OPctQI3DVtKs4dHSY/IS3NAOBYo4VTcJ3kP6bxg2JPeBDS1vEVPt+2URjxDcF
         CTIWBfX1oqfbyPLnE0nSXzdIfN+PU/pcO6d0Vc/BjLei3r0okEPDOyDcRMOCzk2SflDX
         aZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65MbiCirE9d1cqOS3f7OshdK8GTlWYGnLliUJ1JW4TI=;
        b=ADiozrf9CNwgOqxgogYGfMgCfAFLvVDr2iwefE0CTp4eTuPookL67NcIshORt93quG
         InBVc8CRh1AkuT8ZSIVWu0kMc4gHwN+bBv0F/y5ScnVI/UqgvtaDMr7JpBjREJgxjghQ
         TqgUGM4DbSOvP9PfPPR/z+2SqdlbABxPrbbZvh+KKzgc/VMmL6rUxvGonWk5uLv7UNMf
         W6GJ8+L/d4yXqhhZP0g6xY79aiegnVp4OXoXl5z34F72Z+nwZjYxJ642tdPY48Nl2Ep4
         PiYMc9SpAMPOJZvjpYbIpY3A8Wnq8xni5DfPuaF+R5JPg8Zn6TriuIxJUjiM+pMj+QTc
         tAmQ==
X-Gm-Message-State: AOAM531TK64kz0MmDuOAg7Cl8A6H4HyJWt0+eIX1O0nMHUEnDghuoVZw
        i5t6muw516xNk98UFy5U1EWqRQexEteGSHKUSJw=
X-Google-Smtp-Source: ABdhPJyuw2LGnZSgNbwuV6TKKfWCPeJ20W180C+o72+JnsmMFpFls0G1soAIz58Nf2hd7ZCeO9tiOHQuwjurfIHDNI8=
X-Received: by 2002:aa7:cb41:: with SMTP id w1mr44250205edt.327.1637451607740;
 Sat, 20 Nov 2021 15:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20211112162827.128319-1-aouledameur@baylibre.com> <20211112162827.128319-2-aouledameur@baylibre.com>
In-Reply-To: <20211112162827.128319-2-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 21 Nov 2021 00:39:57 +0100
Message-ID: <CAFBinCA4UHybSkKX=yRvEE3k7oSwFEzYADkZdsMxfMsp-Cmodg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset
 controller use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     khilman@baylibre.com, p.zabel@pengutronix.de, balbi@kernel.org,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 5:33 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Use reset_control_rearm() call if an error occurs in case
> phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
> phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
> and the reset line may be triggered again by other devices.
>
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework. Therefore, use of reset_control_reset() on shared reset line
> should be balanced with reset_control_rearm().
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
