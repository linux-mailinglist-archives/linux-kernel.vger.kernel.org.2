Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E0E3D6DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhG0Er7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhG0Er4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:47:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A854CC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:47:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso2409792pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGG7RdUKVnT/omOvzH3kep9Wm/lxv7TRThq47QpIc6U=;
        b=fPBwG3J8Gj98l4Fltb9Yei/aEYXt+b+10cEkqeUH2qfJlKpIYVmENKFdDMnfCmjMzc
         WZR0jfwmpiuDcihSVapgx48UBxugPpFm2BaibyPCX/L8pXurh8eN5TadhNDjTF0mrbT9
         B6IFMynY5O6UZIG80/lsQLdkaNZEMsFtS5v4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGG7RdUKVnT/omOvzH3kep9Wm/lxv7TRThq47QpIc6U=;
        b=SH4mIR+OU7RwlOIfEUo94mVKkdh4gTxqU0HF1vtt6D0Sb0xjPcyXx22mjCyBrKHFWL
         qvxRIljdfJDPYl0pPOYZd4tlAP/eVCsNEyEz8aEIZ5eYFOd6zlLxmQmjmyoerGfn8sRN
         Y/LVl5NUOBR14pQZLuMaBMbLbj+5J87DlC2QvR7x2RnftW8vwrTE/UpuxhW2O4n3JFh3
         9yTtticOv3Lx7eZ4Hpmbh8B69TfXg5M/MX5EotJMrOF+up8tysDnmAYZr/sHPsWJoHv6
         mZsMVyKcIyyIxdOqZ0Ef3lknz9J8j8sYVIvbfHLjrzKtBRxlev11iL+3QPCBuFgaUGmB
         nFUw==
X-Gm-Message-State: AOAM5326Rr/xS3CaGEkCIOzOnR45xwruX9mqBgSmV500abcLgjgg0uJK
        gjOoAlYwugQO1MOmC3DTDRWKbYm1A8r2wUbpWGWx8A==
X-Google-Smtp-Source: ABdhPJySJP+/ZQoBEHFro/AzJ188fCTnIOO/lwuwj0nJAUhz+aPHfYkIzGrffavFmHSBLICxTeAXj4op7J6mUDK/CV8=
X-Received: by 2002:a17:90b:2251:: with SMTP id hk17mr2401217pjb.126.1627361276245;
 Mon, 26 Jul 2021 21:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-22-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-22-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:47:45 +0800
Message-ID: <CAATdQgDhiG_Omph14o-Wu79+4W1AVyC70o5Rdq3Q37T4cJ+xnA@mail.gmail.com>
Subject: Re: [v14 21/21] clk: mediatek: Add MT8192 vencsys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 7:03 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 vencsys clock provider
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
