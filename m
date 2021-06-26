Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB503B4F6A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 18:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFZQQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFZQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 12:16:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F53C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 09:14:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gn32so20434728ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hei0V6wT99GLvsAxKSgNLrGQxmkr107H5QExI+On0gg=;
        b=DrZ5yA6bp+fkrI6C8+9cVZb+q1vSbMNZktUXsgYgqWVjSq4v1gOouJfZxh61JJ/dd6
         dviKn9g1yu+xqeNfJvc/kmJNzbiXECFkBPSNIZfq3rev3P8pqgOMwy+JkIPaLcvetGgr
         sCGuBWRQpoKL3Vx6xiRzcfo1z4z3VHDw0zq3BM5ZkqKmMC5/1bWjWok82rIPkIHtdcY9
         umVBr+3TOOe4Stccfsi2wwTQg0+U56icOzz/G0++D3q6kXWHnPHCY8gjawsVcxAhgthC
         G7x6XRVF5eBUK8zAiqsXbsB+Rc/FprZSNw4XTgoA9cX1QuJFJeX1Yo3pfF2RhEXG/OSV
         0vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hei0V6wT99GLvsAxKSgNLrGQxmkr107H5QExI+On0gg=;
        b=E7rtwy4BguOS/ZwwZWWLhumA2Ukpnv/UYZ8mp3+cGPynZd3cP0APhZZFqohN4V707t
         6GpaMTsL4qVLluLsdoCSFBqavXtCxDNcwX3SIWSF0esvZXY3e93Q4QQMZBap64MdHqZm
         01yCjisrCpUdMnRq06JSBZytFYINNdJZK9fJtvrnxoVMFbPYwF03fNXUeEfUrjHJSJxR
         HcA64X82nwz6Xg44saG4Rv/jwOOuRndwZhl9f2N1UKCM6c61inkLftN/DE2U74QTaGCx
         BKnNpid7aihshia2Wl3QiMEEATYisRe6pV8V36ri9NU3vkk4Bs0mz/BB/gNc7vACcva0
         lhQg==
X-Gm-Message-State: AOAM530abmB1z1Gb5b/04R6IPJeBUDWhdRWzgyTyQJU1wvuKhdPbLr35
        mb69W9hNsmwDIcOvUns/6073HOEvPcdh35G/EKfu1Q==
X-Google-Smtp-Source: ABdhPJxG+8w5JRFzXvl9u4N6VewdeznVF2wDKF5bH24xwpqmM14Nd1ixJkkPvnlHNi/3WoalV4ImmVNHPatstERs5mk=
X-Received: by 2002:a17:906:dbf2:: with SMTP id yd18mr16327188ejb.406.1624724051083;
 Sat, 26 Jun 2021 09:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <1624723112-26653-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1624723112-26653-1-git-send-email-u0084500@gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Sun, 27 Jun 2021 00:13:35 +0800
Message-ID: <CAFRkauDT6px6JTRMhXPqbUNdDyHjvfQdfWC9WA2VtDFSC6pbiA@mail.gmail.com>
Subject: Re: [PATCH] regulator: rtmv20: Fix wrong mask for strobe-polarity-high
To:     cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cy_huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=8826=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8811:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Fix wrong mask for strobe-polarity-high.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
