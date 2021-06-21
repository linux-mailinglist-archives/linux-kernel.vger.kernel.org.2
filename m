Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA13AE653
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFUJrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:47:04 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83517C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:44:50 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p66so14970491iod.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1TJ7i7KgvD4fdVHGJRMyrwZBOAJHAbvbRMumj5+UHU=;
        b=oEH8oXFU370Br9g3znCrw/jxIio1QtFBa5A6CP3kUeuS19QSTY3vKt9nrCSZuKBVTi
         5brliEyrr6r8ljXgjJMpyq43ews7qe56KFUuDJxzbJcL9WSPWymyu7oXKRvhk4GiAZ+3
         bLG9WD/aVpzce5J7dH9/+j18PKYirkUpWvUcEIhoSXGcnRXKncDUz+2KoxSQHajjMtrh
         Lj2MfwxZGzKGt4KClbBqfBPz1ThE/6Od+9F61Wqk66CGQnRf+k+tV6cvO/iQ8cWlxUWf
         12ef7wufrr92vtA4YaUgHSigOr78dB94tlRU6ur0x/lc4ColXAz8QnaAIRXtcVd4jLQd
         Knbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1TJ7i7KgvD4fdVHGJRMyrwZBOAJHAbvbRMumj5+UHU=;
        b=PVYLXur0Jf2boR+oD39DLv36nfvpbmNyuTvrN44NHQSfCX261ZFR56JnkA0xxpGFei
         5EZiSIyh0C6aBqJ0vUXbY9nVLy54tTnMJWmlUF7WaF7l6BExQDC4cWokYOnK7aIKs2A2
         hG8tGZpF1Bvohd1XZUhWUPQBA59ocLFaWISQGpSrlltNNqGlsl/mxVA4pW8zSIuUMxul
         keH9o8PGMiobvTsu+MNLDMcPUkYFf3RSI5z0pRLKPNqwakxJ7fqtBw/KTKHNEp0b7m/z
         OCdpjGiRkAupi8kWKaKK+fj0s22Lh1JT6r6itaxRpCmnFIppDZSXRiJ3JeteVPsFux49
         LtXw==
X-Gm-Message-State: AOAM533MzyPLyOna3zRQRACsFtomaWiPDS6Z10OYGgoouxq7tCoTCXGT
        68tRyrX6VI3lTatf1FjjeZLK1ML4X2tXYbxYAmM49Q==
X-Google-Smtp-Source: ABdhPJy2/hr3Yxo3hr85EvZD23OIDokym52uhxrGItyfkdlVu4ZgoBws3YJE2JUHydA3ekG2826MMN/wIxMICXR4ifo=
X-Received: by 2002:a6b:5908:: with SMTP id n8mr1139742iob.185.1624268689710;
 Mon, 21 Jun 2021 02:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <1624266114-21539-1-git-send-email-kewei.xu@mediatek.com> <1624266114-21539-4-git-send-email-kewei.xu@mediatek.com>
In-Reply-To: <1624266114-21539-4-git-send-email-kewei.xu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 21 Jun 2021 17:44:38 +0800
Message-ID: <CA+Px+wXx8eyh2QFRHbkf3ESdXzBw8LNqP=jMihju+jV0TpQvhw@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] i2c: mediatek: Isolate speed setting via dts for
 special devices
To:     kewei.xu@mediatek.com
Cc:     bbrezillon@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        qii.wang@mediatek.com, liguo.zhang@mediatek.com,
        xinping.qian@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 5:03 PM <kewei.xu@mediatek.com> wrote:
> @@ -1293,8 +1355,8 @@ static int mtk_i2c_parse_dt(struct device_node *np, struct mtk_i2c *i2c)
>         i2c->have_pmic = of_property_read_bool(np, "mediatek,have-pmic");
>         i2c->use_push_pull =
>                 of_property_read_bool(np, "mediatek,use-push-pull");
> -
> -       i2c_parse_fw_timings(i2c->dev, &i2c->timing_info, true);
Looks like the patch removes the line accidentally.
