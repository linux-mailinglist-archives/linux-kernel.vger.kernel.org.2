Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E193D6D74
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhG0E1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbhG0E1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:27:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF1C061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:27:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a20so14569967plm.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXQhLU0KIJvDHX5sb6jl1W+wgDKUS1guQrE0JC7Yn3Y=;
        b=RKYTKymblzDOhbLv7PWiW7eSUaUlTkIvosw0kwN52o4QZ13MQ+pI3E3f9BLAXyxuRV
         zPgtVU+DORJ+W+MTaB1FlAT1p+dCRv1YFYa0QtARGTVKNCLUmTgFRwX+xdOLhdU6CXa8
         Qz56OKEZVFeHnr8rYzXRXJ5//xYDcWaG6H1Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXQhLU0KIJvDHX5sb6jl1W+wgDKUS1guQrE0JC7Yn3Y=;
        b=aNRd5pjiKyc9QkvFJ429W5MRwBwyt6/JMnnHGXdjTbxaijWipC9dbCJYnkgVDdmju0
         xVLYpl4BTIJMD/RmtxjlUiEyOzOriik7TmZfETqwCuMCgmXcbg3ssFZzTfG+qrJrMmOV
         YvUdjEk5e28oO03IzEhg+/BIHkqS4d9+GnyKckVsZenU4L1lWXQBH+aEpCD8xShEXIqv
         6c1txvI0HsFW1VingHBUWhhu/MJy/6qiZDy9wNM6B+E6yGENJuVie0o8QLtaZ5s3BC0x
         1ms0vtkd+aCMPP9SeD/CeTiDYBirlVisZQoL0gq1snzqtmXK8mEtuw34w1hauw05AySP
         X8bQ==
X-Gm-Message-State: AOAM533z8QbCrxzXfUNKw8K5QyCYQlGykjjWVbvqDTLlkPOz774FL2Ik
        I7+C0WK8HgYo4EHfMmvBy4uBgv4lk93J2QlG5nNpjA==
X-Google-Smtp-Source: ABdhPJxkczvv9x68Kqa5d1aZDdqcHw3Asoy9mySgxuq7/MfpZdsYtC1IRV3W3oHxZjYYhlcYOpCkAF6RuR5x8MDB0sg=
X-Received: by 2002:a17:902:b788:b029:12c:2888:9589 with SMTP id
 e8-20020a170902b788b029012c28889589mr6345723pls.60.1627360058151; Mon, 26 Jul
 2021 21:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210706061920.16013-1-chun-jie.chen@mediatek.com> <20210706061920.16013-9-chun-jie.chen@mediatek.com>
In-Reply-To: <20210706061920.16013-9-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:27:27 +0800
Message-ID: <CAATdQgCb5WxE3MjFzWsB5s-rjtTMGF7a3bNbrO8OmRiFrOLEGg@mail.gmail.com>
Subject: Re: [v13 08/21] clk: mediatek: Add mtk_clk_simple_probe() to simplify
 clock providers
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 6, 2021 at 2:28 PM Chun-Jie Chen <chun-jie.chen@mediatek.com> wrote:
>
> Most of subsystem clock providers only need to register clock gates
> in their probe() function.
> To reduce the duplicated code by add a generic function.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
