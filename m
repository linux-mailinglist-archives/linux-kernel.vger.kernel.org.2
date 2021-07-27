Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8923D6D92
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhG0Ely (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbhG0Elw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:41:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB307C061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:41:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso3181055pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 21:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NnMeB9D1PDCqqXeMDn2tfizMDoghceb94CgirmLY5WE=;
        b=VDvbmJN73quQ8KOcHSbPXKWh4VmvtbZMrn8SdG88fNaYeJ8kGSDow9TKlVVkjkhlku
         iJshHr6RjwPTAYMNYMM2dLditJtDIzQMmBubUwgEr2i5SXxECyPiZsUChPQ5XaUTr293
         +5SNoKR3V4zVZOpMpfvC7fSOGqE6z0D+FUQPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NnMeB9D1PDCqqXeMDn2tfizMDoghceb94CgirmLY5WE=;
        b=uFAqWPQEjsJzTjin1+wGKoVOu39JGohUVFx86sIJQe0xhtKCdHp/DQDgh4R/1JLDr0
         hiQ+j2RFAhzm0wLchrkVad8qmkffNZ7LYyiwLCHZ7TN3rkvxdMmPf2hzgIGh14zerhHZ
         iltdxvJDL89U6qPNzZpW2Wv72RPI0U8JyyvIMRsfk/WIyuYpQWNPB0ZCnRZ0nAVyDAYp
         280i91o4QSR0HQC5zse1+EvUyBJDxKzh+bU5JCGABxvWOQ7gDrTFlYprQuakeY1sh7D6
         JsOfFqlJT6igLEwBa/HDDU0WWeuQk6S1Sm8wWfsbwZY+xWrgZXNkVg54Kpl43j0mfE7e
         YPBQ==
X-Gm-Message-State: AOAM531R57dzvFegWbCCXg6XNkgBOx0TWys9zLTTubQE8FLDovVCf6Nm
        10uYPjkFsvhbzR5twS00x1esaazfGO46EHvubmYAWg==
X-Google-Smtp-Source: ABdhPJxZcyF8BWfebyjk7/Qh5DO6KidriFsLda2+2nQq0/LmRyIGrEeAG4AVJ6dYzM1CxThGnf699L4x+q6Hfo+gEkw=
X-Received: by 2002:a17:90a:f3cb:: with SMTP id ha11mr2394863pjb.144.1627360912409;
 Mon, 26 Jul 2021 21:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-13-chun-jie.chen@mediatek.com>
In-Reply-To: <20210726105719.15793-13-chun-jie.chen@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 27 Jul 2021 12:41:41 +0800
Message-ID: <CAATdQgCJVjd2avYd-h4aQK02tNMKFJFbmfaE_waPVJHr=aJNhw@mail.gmail.com>
Subject: Re: [v14 12/21] clk: mediatek: Add MT8192 imgsys clock support
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

On Mon, Jul 26, 2021 at 7:12 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8192 imgsys and imgsys2 clock providers
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

(snip)
