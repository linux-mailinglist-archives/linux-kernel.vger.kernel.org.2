Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5D3F7280
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhHYKCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbhHYKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:02:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D715FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:02:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq28so3310108lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BLc57R1jmVv2+4BFp7I8z0ChmYrPPOFg02Jifxxp1A=;
        b=keYALr+Zc+ROEUmiXyoah2aXbhowuAA12nyjWIW8pBb4wwgY8Y4ckCZXQFl9VIUcMK
         PAF54xsMLQWU19AwOezJWM8pLKNAy60nIAtfEz/tduA92uSejOQ2lQ6B+GSTtKcso6rv
         6XvK+DCiRsEgn19MMxMDeZlJYP8upE8+Y7xpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BLc57R1jmVv2+4BFp7I8z0ChmYrPPOFg02Jifxxp1A=;
        b=qP/yLUCN8ykxGD/M637xYqOMVaSLhDoixCtp+4qGkV5oXr7FoSqU5IU1WwWSjpG7tj
         rBkvpjG9rOymEjMzfu8EXf0rdCjqkZ8bPnDRgb66O5aCbKbPT7Lr1fQ8FnvLKdtN/iyF
         JUl26vzJMhGhd6mpfZd5HIvDLbiSPWi5dxcrO5HwBqu69M+YDjC+9q6LjA70uFtwX205
         vLJrn2IKvtDb6m8AqEz+/hzvBfQ72SmBQ0td7CWg9zVEOYvk+qbc14SWgONEY+PEleGi
         AtAJKHmfgWZKLUiXhiuohFy10Kbwi7XEiqYujB7g1ccWMyT5WKCHFc9k5Lhppca44nfL
         t5NA==
X-Gm-Message-State: AOAM5320uQVlCTveeJeGYTJrlLmGD7jl7z+pZSSPGGhtO4EzNTM4neFB
        M1ZbMGPS7F2UsqhmNoOP5f2bW/uonDTJlwF8Bx3JQg==
X-Google-Smtp-Source: ABdhPJzKTnl3fWad8MROrCNiC1jtRvD+05kAasVUOQbRROg0Vttga1mRrsRv2jvrfGgKTaG0sLnaZ7IXx0RGNuN9rDg=
X-Received: by 2002:ac2:51dc:: with SMTP id u28mr31772178lfm.444.1629885722273;
 Wed, 25 Aug 2021 03:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210823092353.3502-1-chun-jie.chen@mediatek.com> <20210823092353.3502-6-chun-jie.chen@mediatek.com>
In-Reply-To: <20210823092353.3502-6-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 25 Aug 2021 18:01:51 +0800
Message-ID: <CAGXv+5GxzgHGo87xWbENSA=g+vRLJFbMGTw0u5bAyEc0qLT64Q@mail.gmail.com>
Subject: Re: [v4 5/5] soc: mediatek: pm-domains: Add support for mt8195
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 5:26 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add domain control data including bus protection data size
> change due to more protection steps in mt8195.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
