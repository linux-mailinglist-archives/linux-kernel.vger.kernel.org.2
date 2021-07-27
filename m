Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6993D6D87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhG0EjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhG0EjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:39:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449BC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:39:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c16so8783124plh.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXqkOOR1pOtYMzsgwXDzf42bCaKreSWxIwhWwvEeqtI=;
        b=AG59QGBYG2d8MJl+DmYb3WwVZKqVqgzyq3bnKbAV3gdhJeC91VtLz4113YUwJCoQO2
         Ct39sGCQGldasZApaM/KRIgysBJ9pVrgbJOVYVEgnlU1m/CalsRwAnIXsQNVX/lFkB+N
         bLBfyxvcMlkA0M8Dq7eyk8XbnByWU0n/wYTRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXqkOOR1pOtYMzsgwXDzf42bCaKreSWxIwhWwvEeqtI=;
        b=lsetBfy2nXgfOSLu2SYNmnKav6vkM0BzidPOos5GA3AM/cPBOfr7kBnc22P/wLMsGI
         GSib25TJQeXp6c9hWFqJOW7PtmMGFnPH+ErKtjj9+KLxNgJNTSqhw33dizKuPo/GXYgl
         pUPMaM0CpY/xMJFqtvLxzi7h6yjbGTxL2pftWfbgqlmlcPax0un2JqqLMRc4r5cIQi8B
         6Jo/BfdNAZbI2JENvPTtn5CjQoGUONk3TQPu6hpfOLacIp+UlcnMLiiZlTdmGunf1sBa
         ILpVxL0uiv8Tff4/2bDUxpvSryuVHTSNQmuWTf8/36S7vIEDea1K+OYV1Eo3to4XyN/7
         6+1Q==
X-Gm-Message-State: AOAM5329b9SrCK5uEnul/1SPGQmL+VHbs4roerZvkQJc5qR3AGMLFEqk
        JMd3zTcBp9i8y98lIrCmRMVzGYkZ83CnJmZipczh2g==
X-Google-Smtp-Source: ABdhPJzk2XckOwQ6RCK2+Om3VQvLRLUz2rIVS0DubiOZfADOQ28pfm6zggkraLwAfixhBtKFGDUi7GmMyCICb0wLD1U=
X-Received: by 2002:a63:8f04:: with SMTP id n4mr21076455pgd.317.1627360756729;
 Mon, 26 Jul 2021 21:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-10-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-10-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:39:05 +0800
Message-ID: <CAATdQgAGEqDyPJ7bnPsCow+BAFYJMdOs_mk8XCkz5Yy66x07mw@mail.gmail.com>
Subject: Re: [v14 09/21] clk: mediatek: Add MT8192 basic clocks support
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

On Mon, Jul 26, 2021 at 7:03 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 basic clock providers, include topckgen, apmixedsys,
> infracfg and pericfg.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
