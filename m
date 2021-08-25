Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A80C3F73EF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbhHYLBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbhHYLA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:00:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D11DC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:00:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq28so3628238lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMU+pM2QBZzK/mBgD18/2ldTcz6xSYAlm4VwhZW8Xds=;
        b=ZxFTXedcdzgllV0BdZVAIOcwxqUf0UzSNt0l9AgbF7OR686cjSpK+aNfAaHRtMelvk
         yUfJPVebJxXrzWgcVmO85ibd7OEJT1lw3qtrjt58s4CRZLvKL5IFje38BqnLzn3VxGbv
         eums4LevWEoHBjGmer+gWDYX6gm6FxLIvVpYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMU+pM2QBZzK/mBgD18/2ldTcz6xSYAlm4VwhZW8Xds=;
        b=WKB3Cf+ndCLDeI2d9PpUO3xao48sY/H6ysCV/aMcowSwCV+jfwbutgfLqRxOqrRVKd
         C/H4hrK21KYGFqy+onQgM1YjrxlI6Tl+cOUcQy2nLAqjzjYOrVKIp1gBsvPuYEG1PthP
         L98uDPlwGY8ugaeVoHvjwtPAqO5X+nUGr8JvFm6Iqn+Nmzc/FrvfTW5aSHq/i1Vqyz7S
         zgKA4qy31eWaKI2CNE40n4lh9FbFdwAkltxu5sAVrbLYevn89MituNeX4jK2B2NIIXoN
         snmFcSFTwn4tVjqS7IfIwbhj1BsQGfpW0MGoWv1pFkhBv7MA2ugWbNxO5L3NM769/RXw
         JrIw==
X-Gm-Message-State: AOAM5321jC++Sq6xCnCYetYPNW9wl6IAGGo9RUI28c6ZC2p0fTSX0iiH
        61/8fVuIZtIno/N1HRWhHr4+rqtJzklyV7xYGWwyIw==
X-Google-Smtp-Source: ABdhPJz0Tnwq+6r0A94ST8UOV01W0Dny2Y9nLZLBesdNACuORbZBRKjlyxU3vEMbYXzhNU3c/9h+wD8v+Hnzoymsh68=
X-Received: by 2002:a19:ca09:: with SMTP id a9mr17326764lfg.342.1629889211438;
 Wed, 25 Aug 2021 04:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-22-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-22-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 25 Aug 2021 19:00:00 +0800
Message-ID: <CAGXv+5G6wKOZhBRq9J-Jesd1_vHn7Tt4eYo3acTK8-wK8-KjVw@mail.gmail.com>
Subject: Re: [v2 21/24] clk: mediatek: Add MT8195 vppsys1 clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 7:33 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vppsys1 clock controller which provides clock gate
> controller for Video Processor Pipe.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
