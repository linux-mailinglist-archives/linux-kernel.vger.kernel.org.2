Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07AA36529E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhDTGwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 02:52:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59793 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhDTGwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 02:52:50 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYkF7-0005b2-OL
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 06:52:17 +0000
Received: by mail-ed1-f71.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso12567991edl.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 23:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1PGlFqGKikJO8z0lD8lXj0af4Bf8i36wqtsVcNsaxY=;
        b=QpDbhmKxQjXpn5FEml1WsxBXJmvotE8KpNutiXo4cIa+56aLaJD8xROV/22Pva98Mb
         chwxlr0T9AUQCUrFpiz4IlaaiO4j0B7TfUzWAS1+GC7Jhuw0cCVDcYi5qXwOlaHAuuKw
         fVQnJ+OWaF27eZVXYu3Yzsb5yswb4LFWCL7qpiiiFfY1qe+FPt/XnGSGB7z3CjiwOo7u
         BCprExRfZ+jP5Wwm1+ON/kr9YDBEs8JkAQzFMQomF1HAFkWT7UbLFg/985iIQi4LIrP6
         5fyLmpAh6SyQlCavRimSSCXJ19hVJQR/+aO5gByecNbDtGfD5/FamoEsNZSb3LeUYOcI
         a+xA==
X-Gm-Message-State: AOAM533TSOsvR2W7rBlv5sfBvDEegJRbFczIoBr/cgXAgbkwiDtnociW
        i3t/gNgAxspfR5wJQsvttiNOV1gGd98wv6rGLizWGoRxVgT3FyPYXW7HVZ00ouA3Yl/7v2mqa6b
        qxTfsBy+41c79gAWG/KS5N1ybDSIF3q6ir3ekKoKZ/Qmw5oGHcbbdUeMxKg==
X-Received: by 2002:a17:906:dc92:: with SMTP id cs18mr26604224ejc.27.1618901537483;
        Mon, 19 Apr 2021 23:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPmpfM8eOEJS4rNHtsnpZr74Ds25XYl77S+to6BTJGlDIYnIAMsIXABdzM4aZ2fcwaE9A8kv+s/P3C8NzZfSU=
X-Received: by 2002:a17:906:dc92:: with SMTP id cs18mr26604211ejc.27.1618901537323;
 Mon, 19 Apr 2021 23:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <1618459535-8141-1-git-send-email-dillon.minfei@gmail.com>
 <1618459535-8141-5-git-send-email-dillon.minfei@gmail.com> <CAL9mu0LmZO38CvmRfBMvgJm6310eMY64tgTRw8kWKCPuGJReoA@mail.gmail.com>
In-Reply-To: <CAL9mu0LmZO38CvmRfBMvgJm6310eMY64tgTRw8kWKCPuGJReoA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Tue, 20 Apr 2021 08:52:06 +0200
Message-ID: <CA+Eumj4M5k50Vv+5tzsY943yp2CVvXFxnf-W0nBf=Bj5M-1AQg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] media: i2c: ov2659: Use clk_{prepare_enable,disable_unprepare}()
 to set xvclk on/off
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        krzk@kernel.org, linux@rempel-privat.de, s.riedmueller@phytec.de,
        matthias.schiffer@ew.tq-group.com, leoyang.li@nxp.com,
        arnd@arndb.de, olof@lixom.net,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        festevam@gmail.com, prabhakar.csengg@gmail.com, mchehab@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-imx@nxp.com, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 at 08:46, dillon min <dillon.minfei@gmail.com> wrote:
>
> Hi All,
>
> Just a gentle ping, hope some expert could take a look, thanks.

Don't ping people after 5 days. It's not gentle.

Best regards,
Krzysztof
