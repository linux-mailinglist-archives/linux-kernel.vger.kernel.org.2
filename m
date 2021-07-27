Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11E53D6D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhG0Eoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbhG0Eof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:44:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB5C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:44:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso3188024pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Upw3Kqn05tBN6OFp46vi1aIozZmbzcynjmLNKwgK9po=;
        b=gmugk18f4PMAnQoxaFPvxBgivCKZbUuZkqcDUby/i98d7b9mBsBeFnXnEp/X9Tiieu
         JckgJXJSmLdT/PVRLt3m5n5MomEp6aMIzhfofL7ilEqv0xRd5YsKE8AEWqX+B0TLgYHJ
         ijecndFTtmrZ/kGQEV0mzd+c9Q/bvjRHqDfEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Upw3Kqn05tBN6OFp46vi1aIozZmbzcynjmLNKwgK9po=;
        b=M5wibTJpbklB4z55dO6K3T1Y1hZCoTDa79DN9I+NxSgtk/7iS+3Vj0QEgxeAYty/Dx
         /jbfbRx2Ky7cv17NhTaO+tnsC35cSAhl559TEEohj9L4qAZwLKw7xZhs+S24SLXejCrC
         93fF9qBYbUmS8obsN9IC5pJJeTsATLOoQbTyPo2O1tMiQU/JVJhEzy4BkDJb3oASUycV
         Xb/NBSMmZ0w2jOVj3t3Ylo1jmqey+OMBVoonHAG7x2wQ4sXxhISc8kxtZMYq/KrQgR1T
         94rU0o9ICGi4p5Oz8Pckf+SRSH30QZBYOk76Bx1TbRfwFfrVdkzf3/mfCV2lmuo6p38E
         UidA==
X-Gm-Message-State: AOAM532qShSemGYWwNzLCyAWnFZBKxX+CN8cR9u7RMSatiQcCKGF4CKS
        IFSrUYKWxjfpn468BS3TcNR51AXTxLpZBkiwJCPxVg==
X-Google-Smtp-Source: ABdhPJyZyDPgsADtQXma5p4ApMONsh5r1xW3sEcgGcnCFWSzk3ZBPkyUa/IuSLHWVrLfUjjrIU8rcRz6q4kHA6Sc2g8=
X-Received: by 2002:a63:8f04:: with SMTP id n4mr21092441pgd.317.1627361074754;
 Mon, 26 Jul 2021 21:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-17-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-17-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:44:24 +0800
Message-ID: <CAATdQgDwQtqbYyUXo1c7sufwchGqZ7CntB1eHhksNVfSZ68hmg@mail.gmail.com>
Subject: Re: [v14 16/21] clk: mediatek: Add MT8192 mfgcfg clock support
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

On Mon, Jul 26, 2021 at 7:09 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 mfgcfg clock provider
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
