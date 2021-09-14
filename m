Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BFF40A501
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbhIND6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbhIND6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:58:41 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DD4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:57:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y6so21214420lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Icmlo36/WeDJHtaQFlCSDhUmVMRzwC9n0IjehX7KX8s=;
        b=Q+Stt1KegkfalX84XgzXINRwOGd0RpR+6QUTPx0SZHBmm4C5qOIaMMChUxb/bvCa/q
         N+DnQnqm6E/I1cAep4msngrWAuY/dX3dTkfMWmKokV1THByzRpZo7loo3t9Et69P1DBW
         dYZRLPWhY699/X9g0RM5J+LuCSKCWqELM3ITE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Icmlo36/WeDJHtaQFlCSDhUmVMRzwC9n0IjehX7KX8s=;
        b=5eWii2pcpuGOxPLvRQPWhtMNsJdBVuVkCm/N7E/25qFpH5AZAv5DIIK6yznHUUmorH
         TKy+V2yjG03OQhdGu11p1AKKC3s/scbxSczVTJDlstNUWEICGGl6XbEhVqefe2N3Qm5A
         MIp8QmMx/phSZXr+kpcsRplARKNwjRzxVnV+qpSBUxCFHC1dcOtKKeA4Bx/NaVVJfgh5
         iATMmbCa70DVXQFNRuANka5/Zuv4IkKRPq5TM4vw+yrmJ9U4hVfr1yB3oe66wSfCsr+D
         s0BhbPlxSnUjqoFsNGtqVQFYUVsDORPYkZQDKIIHQN5Ao8MzFkKQ719gl1X+0jpERG3J
         /pHQ==
X-Gm-Message-State: AOAM533EYQLEKpa8rLE1amDauuefJAHomBCI6jfO0xiAn6gr5wJnJBCk
        ldULDGvlAnY/JMrFCUSnfx22Ks9/qbFjVhzojEpJjg==
X-Google-Smtp-Source: ABdhPJwVMLw+Xt7TAjoKUbHM819dKKR5E2dhZV4AvzPSxkF4HY0R4Bdi6S4aV7q+wxGbdhSIIgrROZ0tkvu1zHQV7/k=
X-Received: by 2002:a2e:b52d:: with SMTP id z13mr13262840ljm.376.1631591842613;
 Mon, 13 Sep 2021 20:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-10-chun-jie.chen@mediatek.com>
In-Reply-To: <20210914021633.26377-10-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 14 Sep 2021 11:57:11 +0800
Message-ID: <CAGXv+5EeaodgMroPF==9ov3nNKNHs1WWHk3DqNWDRmb=Du+-Bg@mail.gmail.com>
Subject: Re: [v3 09/24] clk: mediatek: Add MT8195 infrastructure clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:17 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 infrastructure clock controller which provides
> clock gate control for basic IP like pwm, uart, spi and so on.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
