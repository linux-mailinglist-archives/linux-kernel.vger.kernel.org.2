Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9362944A5CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242512AbhKIEgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 23:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbhKIEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 23:36:41 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720D4C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 20:33:56 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso10123341ote.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 20:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WRwsngrge7fmdoOfN9Md08igk+lRKVSK1l4OA42oOw=;
        b=c14AeYQSYyNoJ/X8O/oY3juyFM+0e/+PxbjTzHxi1svD6/4Hs+3wfEKckzuDZP03ie
         s8oZA44J106tazC1gCbx2sEE8WQhoZshuA/VzsHMlXI7CL3owpEe3jC2sj7Oymns/4tw
         7F+NuWfTcG5rRJnRB8PRM16fqrk8zJFKePQaVLlUG3hxeprySR2j3dKr91dWtwhU7XNH
         Rqc60GkhvcBEK98upKXvkY+MZgCAkcBj2fd6Ebv8p1AqGFjWJGR6sLSQdlR1QTsVWZlb
         LLFraP8B9Q2ifqLkfYYJ5BkIb/LgggG644lNIXoIcyuEvWqEyds2EcATSAxx8IGYFLKd
         2DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WRwsngrge7fmdoOfN9Md08igk+lRKVSK1l4OA42oOw=;
        b=pxScdyuMtNOERy4aUhOIG8RPPk/+3XfyCeGHQFymaUpPgHaExDZusqhl64R4Cvf/eH
         rBdwoZaZKQk4SCAtjr2UQ98nqhQRLqogi9Og05ltVbkHrIfxPZ3hBDl5sDEqcd3D4455
         OYr9wUBPJTHNJ7fO2qXx0IW67h/gWwPTsargd4Ji0G1j5nVSt0yePV40xcDhH2LzYuog
         FYlC3zXUqeleB7saZ+1h5WutBif/0mIBj0zmUslSvli9eRHXHkMXUvOnAFiTzM5gkzyh
         RKqA+c/Y6iimAN30BF7txye4v9ngFpOX2GU9nfaH7Vyk2WV/qCTyhZftXcXcs6OZUn6r
         6CHA==
X-Gm-Message-State: AOAM5322lq6hsUTRT3py1Lo46+tu99SwNorIFlNLo2Ab0xQyS6urDXuP
        0HedOTvgyBkztTHim0ZqnG0IQuGNMNb3hA02O2FIdA==
X-Google-Smtp-Source: ABdhPJx7oxsXZm7o+spmLGHlFCGcx1koPGWLS85Vcj/WaABroEvxDBCn2W8JQAMvGpWL2/fxXqLcLNmRwl/MOg+ah0I=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr3583295otk.179.1636432435886;
 Mon, 08 Nov 2021 20:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20211027134509.5036-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211027134509.5036-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211027134509.5036-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 05:33:44 +0100
Message-ID: <CACRpkdYDoT5ChWcrZDOs1koN8cpMW_OhhkRZ2pUvaYwz_5njXw@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pincfg-node: Add "output-impedance-ohms" property
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 3:45 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> On RZ/G2L SoC for Group-B pins, output impedance can be configured. This
> patch documents "output-impedance-ohms" property in pincfg-node.yaml so
> that other platforms requiring such feature can make use of this property.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
