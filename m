Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6944033AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 07:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhIHFNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 01:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhIHFN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 01:13:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC4C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 22:12:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s12so1471690ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 22:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEg9j5PHH4GrveK8S9hlpJRiAHD5wKCWS95UHHv0q00=;
        b=N4InN9Bj8fK6jG56hBNBpJBevxf+zsjhr7g+bMTchVecF318z1bCZNQ7q8LjKHJ+rY
         FgI1xNRgaljSEjyEWdJkhHCYF7JA+S7v3h1Kmo8J0p5GjZuXB38rvOI1xcsBxJS0cNGf
         IEReRyPR8+eORygkamDmkpP366EyiO4cBCUPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEg9j5PHH4GrveK8S9hlpJRiAHD5wKCWS95UHHv0q00=;
        b=RuiP2RkyUn1JX2RpE+iXUwHfkM5Ou2kqATfxFeJc2xZ6BDnklbjvAWtcHvCIxDW4P0
         2RZNA/PqX+vR7cwaUA3dRyxz9l3PBG9zqHylWPC9Cl6UaE0RtW+33j/SR899gpmXjLje
         iz7r6hHdgEjAefEdDWngiM9sodwoazwR+wt3NMvWyxDXKYoSnJH0GrcOzPxCDL+okDn4
         42Rtje+qGTyNjtj2EYBULU2niHRWI2XKvOGJXy+reN5c/oDhvAxrwz4oGFNJHIFo2rwR
         VDoBOE4XRsQdaxUlqb3/uMfFfmYQf6f6p+SXWt1/cvn+FGBdPKnKxijAuAuMLXHRlrnW
         XoEg==
X-Gm-Message-State: AOAM530JH1OIOHTpsnOYQUuazA6oNRueQQhyHW+XpOGhDRaAaXRV+Iv7
        d+AcAdon5Xi9NuaGujhTzt7Bqb1PUKrXiQwaEBPqIQ==
X-Google-Smtp-Source: ABdhPJy1eiw/GhIkayI2GgkNyxQN+8Yh+FdEG4Rp52WWFbHlAo3RxV1qWk231DHeycdNYZPN6u8599LpZ1rHJ4OzvW8=
X-Received: by 2002:a2e:9a44:: with SMTP id k4mr1320396ljj.201.1631077940431;
 Tue, 07 Sep 2021 22:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210907094628.RESEND.1.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
 <20210907094628.RESEND.2.Ibc87b4785709543c998cc852c1edaeb7a08edf5c@changeid>
In-Reply-To: <20210907094628.RESEND.2.Ibc87b4785709543c998cc852c1edaeb7a08edf5c@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 8 Sep 2021 13:12:09 +0800
Message-ID: <CAGXv+5H9q7PZCBADk8ncTRYde7W_pgRT=+WNNUdg2jNSt0LtkQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] arm64: dts: rockchip: add Coresight debug
 range for RK3399
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 12:46 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Per Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt.
>
> This IP block can be used for sampling the PC of any given CPU, which is
> useful in certain panic scenarios where you can't get the CPU to stop
> cleanly (e.g., hard lockup).
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

The datasheet isn't clear on whether the debug subsystem has a separate
power domain or not, so that may bug us later. Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
