Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19D31B7C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhBOLDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhBOLDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:03:44 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D844BC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:02:54 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id v19so2946964qvl.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 03:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDr1BuifwzyoWRoQ5nTu2V5InpMPwBH2+c3dV1Auu2Y=;
        b=mzvkliDYbed4+nr/rjo8zg7Gmfo0Loo0KQ7bdyau7Mjqdg3DvYoiS7DLuoJ+Ri1eeM
         d7ARkBgG+yK4SurA/oGmmhBnRlrWEwcWD3L0/7jOL0L2frn+h3kdnIebuLG9QSUBgEay
         qU/OIurKpGeneRALDa98hQR1H8KBc5FJfDtYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDr1BuifwzyoWRoQ5nTu2V5InpMPwBH2+c3dV1Auu2Y=;
        b=nuyX+A+rXYgGoOH0Am/wCPcaElT9Lv67bAtcGIJGM71RhV7kcfXurAIfvGNPVjaqMK
         sjj6NdXX4TSorLyuaZMdesY/zrRFplmyzPN1jXMD50A+yPgG74WO5Ws6+d38YumQEsxQ
         QEFp8MG1VFpXeee1+qs2orS9tzzbyNbTK6EwAOMRRh25KpVWz0GjGgTX+PYvFlt6i4rv
         MiH20cSvNhAxsaaQ8PXdNTDetgYrILzmgIrrwwW8lAotlZbBUXNVaLOoW4W9wNq/nzOv
         +nj0aZoJiyUMcCGdBVvwOquFDnJdKmCGxpqBLSDE2xWFRyJ/No1ncil5g7TY5TT9GYMs
         9+Cw==
X-Gm-Message-State: AOAM532tLUluGLQhSMxtLWTV17ZRI1HTYJmfbxVDFvsBWbwUpirjg31F
        5PSwE0I6MVSAmFqjsk6lyOIEPhX/r+B1ncK+6HS4/8CBaMk=
X-Google-Smtp-Source: ABdhPJx9+wmhXo0mXHnYKLqCbR8F1hlaIryUeMf/Uz2k++l/gnfo6Z/UBu4p2PLLEaPnDfkI1CP2aZ5JiRRPprUUMyY=
X-Received: by 2002:a0c:fc44:: with SMTP id w4mr12910155qvp.55.1613386973823;
 Mon, 15 Feb 2021 03:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20210211052206.2955988-1-daniel@0x0f.com> <20210211052206.2955988-5-daniel@0x0f.com>
 <161333570036.1254594.12678747655338761485@swboyd.mtv.corp.google.com>
In-Reply-To: <161333570036.1254594.12678747655338761485@swboyd.mtv.corp.google.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 15 Feb 2021 20:04:00 +0900
Message-ID: <CAFr9PXkEz-pOck7M5Q2a9FqXxN7vO0D_E7B=OYLCaqWiKijhBw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] clk: mstar: MStar/SigmaStar MPLL driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, linux-clk@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, 15 Feb 2021 at 05:48, Stephen Boyd <sboyd@kernel.org> wrote:
> BTW, it would be nice to expose this driver to compile testing instead
> of putting it behind ARCH_MSTARTV7. Can we have this patch?

I like that idea. I'll send a patch.

Thanks,

Daniel
