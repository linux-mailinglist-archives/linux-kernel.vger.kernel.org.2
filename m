Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305BA3D6D98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhG0En0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhG0EnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:43:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9CC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:43:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2340995pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OgNNI/ZkkFCiDWQYC06fGQinvIGcARtCC3HkxPSNzA=;
        b=Q5D2/AyVMa1IWbGsysocOoq8QjOGrae5n6e9Q199iOQUX9WzJoez34mv9P/teNkYEt
         klKGHnai2cbH8VssVKLVQ+IhLy040E1J7bVziAzCleY+Getjb1NHun5CHSeiMYDlqzXe
         6Y8FaVfsMd70FaCepmZ0ibonK1bObtcY8uP+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OgNNI/ZkkFCiDWQYC06fGQinvIGcARtCC3HkxPSNzA=;
        b=Dg1CqwThHrABcEjV9HotQrnfyfAWGq0I2T1ILwLbRweYCTQhelIVGNDCO0wQfT+qLe
         QJXr6uXmAP2mVm4DCXN0k3TKr/2+dPq0Jkxnj7rAV5Y3TqFdVCwdD93ZAB2sqrsT8c4a
         qSX4pSbPoiZPE2zJWMq21CHKxEX0Pczh8pPPNh+L0hJ3gTwz12AeQb+T1CUBEvgnE2i1
         nmuqzeeCO+SqSclVsE86JDTqyfmXTZJ5ls5aqKtUBHBXFB426W8E8X6p/XwudBooI8Oo
         8Tx/dpEYO0N/adlE/WZqBS2cnNm25JB6L48UhfOB6DIGui12WbEGIOR09dUfkYXwbvtr
         0gsQ==
X-Gm-Message-State: AOAM530tVV91KceI/LwOhCs53gbRQS58UDW1gXeMlTNSjIn42ciRLTds
        6gD5AcDbO6KTCfadHE+FKsJ2pd2aDxx02VaXc5VumQ==
X-Google-Smtp-Source: ABdhPJxoc5CSpPY3vQh7WBrophJ46+dx+Oemf64p8gEZ/MeteoctC+j1XOB9bhr65cib2vxfEoicD6FmTXf3GIPsuds=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr2306339pjn.112.1627361005167;
 Mon, 26 Jul 2021 21:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-15-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-15-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:43:14 +0800
Message-ID: <CAATdQgBkdst+fVnQhoYzJgO8meaef+YCjcPgEMTLbECTxRC6tQ@mail.gmail.com>
Subject: Re: [v14 14/21] clk: mediatek: Add MT8192 ipesys clock support
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

On Mon, Jul 26, 2021 at 7:02 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 ipesys clock provider
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
