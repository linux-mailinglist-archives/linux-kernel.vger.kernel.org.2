Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39FE3E3E40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 05:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhHIDYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 23:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhHIDYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:24:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1172EC061757
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 20:23:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y7so10647528ljp.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 20:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DeHqVi50CBdFqd2+LMixauUxIiHfce3Yzl/5XSJiGW4=;
        b=udwP6An1CopsSJoND9TlRMg9C+2um44ZaVmKGf2a64xc4zfU4B+ba9JQrNJi7MAs8M
         TYEk25w2jsN0FflqKdIu+nBRbjdZX+LZiiFcR+9C+rPscQrfWRvUbTHVO73bRfAtJgCy
         xy3oLjEh4rLObEK2Lh+uFTsJBKhqqcJzPmrWpmjkjL8Ut9li5azzrDc9cYodoVsM9r1l
         61bL4/j+xEgq3dG5qbFQuOy+c2KRplm2ID2KeD3hrVxRWz5+6coq92wN9tfRVx1ktKCH
         TSA4/f1IBPIOMagR2QvkrAo5oXxfJKHihMqLSfevR2stW/TMZFnJuoxCdMvlBPrlhMnC
         1dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeHqVi50CBdFqd2+LMixauUxIiHfce3Yzl/5XSJiGW4=;
        b=uHByNHOvLeOQrhYH11ER68OBhcgHAaJg4a88iLNrFrGLA4aMZO/De4ackAuGuCLUp2
         LDL93bpFcDgtfbF5buDmofgkQmb4R7r2EXt+X2CyUj2MjZ2KqoHdR1AhjgZ9k8YpRdaI
         7Jd8h/FcBKg3azC1WHqXY/ZMTOK1e7v60+ad7zrwDySsJ+fUSRp5/uFqK9X4J383QV8X
         Sh9Om7ivZ5JIW6ac0RfW1HLqnYVNYE3ufJ5qV5KYqIEQiQmqPjzndRRXCk4QCpfa53I2
         a7eKzDUOWMNi9SkmSJPXII9OUwHSb3nQline5MPij6yhX1gnvBDBYKkWAGWrWNycb8wU
         wdfw==
X-Gm-Message-State: AOAM532KN7zm5uCkqDPAjoWmmKAF7zW5w8/kciWTXiruJJD4c9eULzYp
        Xipi3VohuKKVjt+ZXKJBXJkzZaMVBlRVlMlUgxKw+w==
X-Google-Smtp-Source: ABdhPJzWrze6pAE8SouLNWKvQSYVzPjq/X4MfGn/t6RZQRfJMwb3DGCw0Pw2Pt5DPOfM3ZweoUmSdCNVONUnlfB2Cpo=
X-Received: by 2002:a2e:9e0b:: with SMTP id e11mr14181716ljk.423.1628479435239;
 Sun, 08 Aug 2021 20:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210802121215.703023-1-eizan@chromium.org> <20210802220943.v6.2.Ie6d1e6e39cf9b5d6b2108ae1096af34c3d55880b@changeid>
 <0aff1abb-734f-c714-6ecc-c906862255c3@collabora.com>
In-Reply-To: <0aff1abb-734f-c714-6ecc-c906862255c3@collabora.com>
From:   Eizan Miyamoto <eizan@google.com>
Date:   Mon, 9 Aug 2021 13:23:37 +1000
Message-ID: <CAOak1e8n6JpNKODfM57OTtbCNz8UBbj+wefwipVWP_Ep6SHmHA@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] mtk-mdp: add driver to probe mdp components
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-kernel@vger.kernel.org, wenst@chromium.org,
        houlong.wei@mediatek.com, yong.wu@mediatek.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        chunkuang.hu@kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On Thu, Aug 5, 2021 at 4:40 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
> > +int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev)
>
> This function can be static

If it's all the same to you, are you okay for me to make this change either:
- If upstream requests changes be made to this series, I will include
this suggestion
- If the series is accepted as-is, I will make a follow-up patch

This is to reduce workload on reviewers having to re-ack changes for
(what I hope you agree is) a nit.

If you don't agree, I will happily oblige and make the change and
upload a new version of the series.

> >       for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
> >               comp->clk[i] = of_clk_get(node, i);
>
> that iteration can be replaced with clk_bulk_get

As per Enric's suggestion in response to "propagate errors from
clock_on" in this series, are you okay for me to make the change in a
follow-up patch?

Thanks again for your review,

Eizan
