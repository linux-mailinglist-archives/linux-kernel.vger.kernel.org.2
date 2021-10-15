Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F002142FDE0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbhJOWKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbhJOWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:10:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9962C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:08:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g10so43478712edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ev7DTwrp6MZ4T8F+BiqYB8hT2a7fhd3qu/orSoJYRRk=;
        b=NDGXVXGgETY6w1uHUkxl0aOQgqOaHpy6s2tvAueulF9tqhRGEMU1NjQYegLI3Jmbo3
         hMp16bm5CVYOdrpZ3ZqND4DwL/pVY3YuoPzlRl6zFe1Wda7MkRmH2m4B3RmVw22Yk8fP
         znu01dYMmUoPyb0ZB36/pdRAmsw+NNX7CbKye0vNLXiSLmALyEzHlqsfsPdlLN0444LI
         uofuLyjYZwg+g2tceQcGFhQ2BLhzZWW3ktU5XA7yMwiavU0c4s3yTNsZQIZapXVSiKvg
         AI+Rn/GlRx1vtP3/VGe43e0VPyE+06dcXnwiL1S4y9AUG8Qpn7UQ5/2HUECgBdAOz2as
         kYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ev7DTwrp6MZ4T8F+BiqYB8hT2a7fhd3qu/orSoJYRRk=;
        b=XsiaPC28BahnrjVWFGPV4GceFbeRpH+Fpk7t4/wKpUYJGozp1WDdyVOuWzgX/PPorE
         2lPh79Fnt16a+N260n/DHTYoJ2b74rz5ryokQD/n0nkMWvm3NttB7dSR3J3it9rIfz43
         yHqEMgeMpmA7KqjQI5gp4LmCV4iC8kz2XSKSG5FEmVbzKhm0ITQ1xOonzfsUvdnGJryv
         G3SApqPGhttT2c+rSlgzRDFI6BUXa1vw9EPkkbGiA9V+15O4lsIGLhLL5fMPmwjiRKAb
         iyeGaOJu8uvy+qmCx+WkfHS0H6EgEjBvVTCAa1GF3vtgeSrHCe0+sKuOsqVMGvSPaJcu
         a34Q==
X-Gm-Message-State: AOAM532phGNPqXT4UEiLHi7bNl/P60KpQ0fB6YK8bWdhRomFME94X9lr
        uKMgQr72Ngdf/HLV074GJbnA2dV3HmbjBzbubEI=
X-Google-Smtp-Source: ABdhPJwuty6qNhbPHzOorY72ZZmKmtfUjljYFLAIkJ8cKHfYxsoqmg7A1X3fEyIG7As6fntwRInrBrRk7Ui5lNkexi4=
X-Received: by 2002:a17:906:49d5:: with SMTP id w21mr9997649ejv.30.1634335680467;
 Fri, 15 Oct 2021 15:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211015141107.2430800-1-narmstrong@baylibre.com> <20211015141107.2430800-7-narmstrong@baylibre.com>
In-Reply-To: <20211015141107.2430800-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Oct 2021 00:07:49 +0200
Message-ID: <CAFBinCAdgokOt6HSkX=FmYN064nV=XY51CqGs100R0YnNi511g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/meson: encoder_cvbs: switch to bridge with ATTACH_NO_CONNECTOR
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 4:11 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Drop the local connector and move all callback to bridge funcs in order
> to leverage the generic CVBS display connector.
>
> This will also permit adding custom cvbs connectors for ADC based HPD
> detection on some Amlogic SoC based boards.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
