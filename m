Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C693F40A513
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhINECZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhINECY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:02:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89975C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:01:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so25739570lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iqV90RnceA3yUtnO20ku1+cBNKzKF42y3vDyfuFCg6I=;
        b=aymb2xNw9MWDQ5r1YExaL02R2WTT4y3lbBNUJ8uNopNlkPEkkjyy256PCafoeS7q7y
         UKpbxQcBXuQddeingdXPXg3aneXtL4WsuplQpEQZA1tHOcs+YufO5uCYTpjrRq27gWL5
         BG0InFWVu3lKlC/PopTnD3xQ1A5NdkHpqMkC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iqV90RnceA3yUtnO20ku1+cBNKzKF42y3vDyfuFCg6I=;
        b=ar6s//6FIqsby258SRgYi22Pn8xfUx0MPFoha6BDnB+FQlnzBS1WlS1jLJRdjxpHbK
         1S7ANtIMI/3YasHyuWSqjj/rvfwxtRsHRLd4sSsa3DGRDghLhmFphhpwmLt6VAE8cWF8
         Qm6Ypr6oSct2Rvz8fjkochOcn6LEFRjWX+oYjaYgpVEF3b8XKpe6QpUT+BRdChmBSSu2
         KujxgTT0NsK/QTN0cESqvTbjOWb2ADi//uUOQJRUasB/IhPDwBSs5t7GJ4P1IX+oq8gB
         OlkYNbX3HREL94qUWTWT1EGmCXtRfc4RqUxDkB3H2+dBQimNL7G4pO0VT9zRCgrr6i6i
         UmtQ==
X-Gm-Message-State: AOAM532yr/juGmyG3QNjbJbVLOMFi5iYVGkhoFSu/G56FziDgz9Ddev/
        4l4xEVvu46vwdf/+0EdAu2Z278gQxGcoNRSEAy3smHmfjOthUA==
X-Google-Smtp-Source: ABdhPJyXt6wQvXH4+CYasTSE55XYxX4nwPX+R/D4dbFHy4B3qEDKTJWWK07WS8HP4DQqmeU2wX22v89UmPkH5YLwkHw=
X-Received: by 2002:ac2:5d71:: with SMTP id h17mr11277423lft.670.1631592065978;
 Mon, 13 Sep 2021 21:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-19-chun-jie.chen@mediatek.com>
In-Reply-To: <20210914021633.26377-19-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 14 Sep 2021 12:00:55 +0800
Message-ID: <CAGXv+5HWT=9EzdhMvmHOS8Y+CpLyn5WZht_KP_YxzKG+x85AtQ@mail.gmail.com>
Subject: Re: [v3 18/24] clk: mediatek: Add MT8195 vdosys1 clock support
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

On Tue, Sep 14, 2021 at 10:18 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vdosys1 clock controller which provides clock gate
> control in video system. This is integrated with mtk-mmsys
> driver which will populate device by platform_device_register_data
> to start vdosys clock driver.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
