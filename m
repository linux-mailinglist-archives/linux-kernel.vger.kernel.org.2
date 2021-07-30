Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD25D3DB6E3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbhG3KJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhG3KJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:09:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E804C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:09:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b21so11567307ljo.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y94AS1a4tgcxQc2L0kh6j5VjagWiBRlRk4u/cyvCoVU=;
        b=pS2qOeCk80eD/BMpuN5dXb5bTNKtlSpIaCfiWdI+qPNjl1R45VwIGQw54/4Y9rgtA7
         iAYycg5XAiIqXZdwDHnnnE3js5uKU9iHMRDSLdlenW0yUiNU91J+rWvnGbUhfYoinbfF
         rcOtQWMoKlx/VxtRJXwlRivLsk4YcXF6EbkbsEI1dn2DckwGNMGv3g4Ggm+EpA10s9+F
         YHLazzOlFq7r9iiQFB5BYWXou94owue9Q6xgTiklotLJAKisQ45YUS2IaLsjwdT/17GK
         o4ksvBGSTkD1koeb+cXiXv+fk4+yygNMVaPZVhF55s4VjYL21+ZlQt0geFhRnTtfl6jN
         UE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y94AS1a4tgcxQc2L0kh6j5VjagWiBRlRk4u/cyvCoVU=;
        b=OPcMTiy46na766BIDbsYKykkb8vD3I90GrJvQ8auX8ax9L/UQS3vN6D0r6IMGpPCSA
         2NLcAImp5ZzBZ+bqLSQgu+OaDIIRQ1PVzss8KfNg/SDv0vVSWOZ035R/WMzCU/655XbG
         3PZ6IF2D51psUPHqbFIYdXASHVi9afMAQq9hG08MVEB36VDcaylQEdV81L+8qd++HVcI
         CyG5VxOFAMIGC2Ja2ftIF/+QpAxrZVUOZtO3b0Wl7hkWqBs7iFuJPHt0qYkZT5Cfx7vd
         NVORkkWHISm35Acc2oR5RnqjrZQl+aPeEYKBwxu1/F3yrPLuighB8Agm31xnqbKaALSn
         6msA==
X-Gm-Message-State: AOAM532Ehwvh48wthKwZf0M3QaIBUpKtpbq3r92+gxGN7krp6gF5pip4
        CInJqiDUvuOWIXhKdAkLFPIoZxuJ4Ox3n8AFX7wR7Q==
X-Google-Smtp-Source: ABdhPJzVjgWXqTgHyZbv2lVU9vzv7i9WW1NqGB6fiIcC01+HU4UnLS/z4U9BLgmRjBtOAw5Yy6SQ4S4AT93kaAjOplM=
X-Received: by 2002:a2e:908d:: with SMTP id l13mr1108495ljg.467.1627639769426;
 Fri, 30 Jul 2021 03:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210717045627.1739959-1-daniel@0x0f.com> <20210717045627.1739959-2-daniel@0x0f.com>
In-Reply-To: <20210717045627.1739959-2-daniel@0x0f.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 12:09:18 +0200
Message-ID: <CACRpkda2DFC-u3R=bQjb6XhDUg8iCO=mSHEidcGDFcxv_X0ZEw@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: gpio: msc313: Add compatible for ssd20xd
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 6:56 AM Daniel Palmer <daniel@0x0f.com> wrote:

> Add a compatible string for "ssd20xd" for the SigmaStar SSD201
> and SSD202D chips. These chips are the same die with different
> memory bonded so they don't need their own strings.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
