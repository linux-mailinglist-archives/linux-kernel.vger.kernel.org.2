Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0683D6DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhG0ErB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhG0ErA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:47:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D2C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:46:59 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso2407167pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ti5+nTjIMGmJGpw/z6LqKbHFp/KaMX3fxXfNJ8H49/4=;
        b=diXZU81t4iyvnv/18XGbkyNKsHyeTT9MhBeINHDsCaFjhj3nWJ+Rjt3mLI+jjXblu/
         MsWhavsHPf+L3BrTp4KG1nB9DENFuRXtgIl7F+eti+sB7higo79QsJAGV3StfU/AOJwI
         1LQjVuXldV3S5ZFqCm+iiqPFuli0bfz7aGmUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ti5+nTjIMGmJGpw/z6LqKbHFp/KaMX3fxXfNJ8H49/4=;
        b=bcfT1J/Jz+x3F5ECkmcLeiB3L0zSJJ+OS7M9m7MoUaPgu6iCSmgvqfIsoONdZPYGcR
         K3AeWJviAa1cATrYZs/5KNDf9p+fvArRSzW9ukrvy6mRircXEGX4A86gGUeYaj0m5+HR
         sJvNkEQFiLAXr+LwhDjaCAN3heaeW3SbDNcICgdzP0f+7rO6/JI7rrPOA0djISfd57jS
         CXqAr12XpOGkP6a572BJ15H5EIjbt7ENPy8wjKKaB7UlswqY4fb7RWP6q+2kW50zm8aV
         kTpStm75pqOamEPeIdGFeIJfYecKqxE2GDXNfPWOtSiFgeNqe+/l20+e5u/aD5PbvVYN
         HG2A==
X-Gm-Message-State: AOAM532RytnwHuz6XDJ97k8ncsXsZ6He5yikqY7oftopJiaAkTLVjgVv
        Gto6RGcbYx9VvmYXKQ+9od9cRTUoTtpIjymIB9WA6g==
X-Google-Smtp-Source: ABdhPJzNMWhPWVTRIcWwCN3GmAc9IllPsC7xBOZ11CfMOfTT+kPcwdmug6nzk8s57FDGJfS0aOZkGmjiKvm8+NzOl8s=
X-Received: by 2002:a63:3601:: with SMTP id d1mr21382265pga.299.1627361219535;
 Mon, 26 Jul 2021 21:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-20-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-20-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:46:48 +0800
Message-ID: <CAATdQgD5EpUv-R7J8keHodbkBOeuQGxWQO-9HXsCFxDu4_916w@mail.gmail.com>
Subject: Re: [v14 19/21] clk: mediatek: Add MT8192 scp adsp clock support
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

On Mon, Jul 26, 2021 at 7:12 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 scp adsp clock provider
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
