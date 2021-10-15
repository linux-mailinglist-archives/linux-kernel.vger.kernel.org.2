Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215D442FDC3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbhJOWDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhJOWDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:03:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4EDC061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:01:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d9so43070603edh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdArxZN7JWq/GtMisAnVnOhcFRIyl27YGTGhWESz1Mo=;
        b=AP7PoE3eVj1rJ3LwTKXMtVjphKGuZDmojGn687G2JyiWjbUZ38mpygQ81X1Ccga0nB
         uw5SbwsTU0VeQ4dTnrMVjIT3dX1ImpV+ZhYfAfe2VsfxVgYOD6fceMzt08fuDcj+9oUt
         BNVrXhhT0hZphbEBNJQZp8RbW7uoluOLWX6/2EORr41YfYJNGWhGPsMKE0LqopJl6/8j
         Qm/M10AuIt/LBjaEKdCYEahKpJJpw7ywrJtmarX1XtLBetjKViPaq2ufVe7i1VUFQiMQ
         3E23NkJYGcoW4dx1p0EoomFAlYBoR4RdvYaI8gxWE7Zs6tMOdRFSXOIsKiQW0b3zmWqW
         C5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdArxZN7JWq/GtMisAnVnOhcFRIyl27YGTGhWESz1Mo=;
        b=Fou6fyNy1xJMFCmoPpXoU6DWZkgxNq4yh215WAgW36uAR1qfz1XhIdN62xsax8/ib+
         8WKvYQLB4fnXieIckCIgFyCBH2Fqj6l8IxHoCFvH6M/X+BJtFSEwNkyLOyJM/Egf+yD9
         s2TjetuYIfREvlaX1Jpeq03v9Eye44f8s7gqxnMNxRL72JAP/nBBX2wVjTwmuHgC7hux
         o2XFFfLGV3k4f31QxGpBW/4/MYFvtpNOPKA0sJ1zFPB6BFWx1sYhJ6e3fF9bF3doF9l6
         5SIfP2i45uV0K5YEIDAo67HEWkOXt0Zx1ME/pNnyKCJIwQhBvPsufnUDJppEse5jve2J
         Up7Q==
X-Gm-Message-State: AOAM5321WRNPgLFIFoVRcWJnxHcU77OTvXhbZnr3aZzcZ784BaRqJtws
        aOaTrtcfolGqK6gyT1zeBH12TQgmEWOPD0jmolsdXXvVaGU=
X-Google-Smtp-Source: ABdhPJyNzRTtu3SHzdokxlvf3m2rFKEjdlgvWFQNN8uNikRTK52xQUEX9H3Fr68f+iA1J0yFdfk/EEwLH3H1aa51FtA=
X-Received: by 2002:a17:907:2d28:: with SMTP id gs40mr10145552ejc.203.1634335293007;
 Fri, 15 Oct 2021 15:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211015141107.2430800-1-narmstrong@baylibre.com> <20211015141107.2430800-4-narmstrong@baylibre.com>
In-Reply-To: <20211015141107.2430800-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Oct 2021 00:01:22 +0200
Message-ID: <CAFBinCAo4-shmtpN=nNMEwTSu-cZJrqX+0+mctM0Vn57ZS=ytw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/meson: split out encoder from meson_dw_hdmi
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Oct 15, 2021 at 4:11 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This moves all the non-DW-HDMI code where it should be:
> an encoder in the drm/meson core driver.
>
> The bridge functions are copied as-is, except:
> - the encoder init uses the simple kms helper
> - the mode_set has been moved to atomic_enable()
> - debug prints are converted to dev_debg()
>
> For now the bridge attach flags is 0, DRM_BRIDGE_ATTACH_NO_CONNECTOR
> will be handled later.
>
> The meson dw-hdmi glue is slighly fixed to live without the
typo: slightly

> encoder in the same driver.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
apart from that typo (please fix it up when applying the patch) this
is some great work!
it helps me a lot with HDMI support on the 32-bit SoCs
with that said:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
