Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC33BC823
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhGFIz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGFIzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:55:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614AC061760
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 01:53:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y42so1751760lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/E4OXQ1yUpcqpJdsE6nCWBhoSFlkIPmfOxX8aPkV7w=;
        b=DTYiCFTiGgpyS+RK6tZKJbgUa+7mHga1RvVfVrk1e4Ldm1sbFpIZhGm7tIjGiHqEBn
         H+WdoNqqVTu5IzizCAHi0g5LLOV97JSXDujw598jH/XTyT3VvYHCoQTQm9f18n/Vv80G
         C7r4OLiRmY0K+sUaaxK0lUtNlsNlneXYi41RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/E4OXQ1yUpcqpJdsE6nCWBhoSFlkIPmfOxX8aPkV7w=;
        b=Yb5r0thIEtFUKfx1aGSiJ0rlAwPrA+yPPM3x+9ZcjojGMx8i/T7HhmyrM4Px6Zk/4d
         RCot118pi1tJuMUoDpLR4fStCQymtVSxqfE5+trd6djdBfhTEs9X09cIEaRUBLKgbflp
         A+YhmSKRN8c381zXG3UnAt/dSysqdUMJ4IlidFM7WODBO6ijDiAOA0ZOFtBOp9/fmmIK
         wv2ulQSwyq5e/mGO5aNGIRlFS25XprF0Y5Pg16igFU1pAijpAg4pFZ4LPGfhmkEkln+9
         ZBo36fbhVttg9mYNFex/gcGs+U7RWc9LKTmI5f0T/ib4f5SMMRa0C5TcfJGtnPLEGRf0
         dtQw==
X-Gm-Message-State: AOAM530cwfrLcS0M4eiVAOveo70d6uJz8JjJ5XVTz6Yr0n9ukQDrR8Ry
        6pL0JPO/bLr3lHgGYGa2d2+BmmJS2klOlAi9FJ75jw==
X-Google-Smtp-Source: ABdhPJyN89wCwWKtKG3ZEK4xjbWdeK9ZZ/vgy3TxGsAGRi1r3BmzHgL8UfUr/Cu2Yy+9OcrWcEyzkdPQuOSJqRgs2VM=
X-Received: by 2002:a05:6512:3f13:: with SMTP id y19mr13831825lfa.444.1625561595053;
 Tue, 06 Jul 2021 01:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com> <20210616224743.5109-8-chun-jie.chen@mediatek.com>
In-Reply-To: <20210616224743.5109-8-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 6 Jul 2021 16:53:04 +0800
Message-ID: <CAGXv+5H9d48uZgQPNk6pnwgeduzq6Ov6aRXoNnmKpFDuPL1dew@mail.gmail.com>
Subject: Re: [PATCH 07/22] clk: mediatek: Add MT8195 camsys clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 7:04 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 camsys clock providers
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
